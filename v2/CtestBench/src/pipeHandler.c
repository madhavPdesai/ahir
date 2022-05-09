//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <SocketLib.h>
#include <pipeHandler.h>
#include <pthread.h>
#include <pthreadUtils.h>

FILE* log_file;
PipeRec* pipes = NULL;
PipeJobList active_jobs;
PipeJobList finished_jobs;

uint8_t global_kill_flag = 0;
uint64_t free_job_index = 0;

uint8_t pop8(PipeRec* p)
{
  uint8_t rval; 
  POP(p,&rval,8);
  return(rval);
}
uint16_t pop16(PipeRec* p)
{
  uint16_t rval; 
  POP(p,&rval,16);
  return(rval);
}
uint32_t pop32(PipeRec* p)
{
  uint32_t rval; 
  POP(p,&rval,32);
  return(rval);
}
uint64_t pop64(PipeRec* p)
{
  uint64_t rval; 
  POP(p,&rval,64);
  return(rval);
}
void push8(PipeRec* p, uint8_t x)
{
  PUSH(p,x,8);
}
void push16(PipeRec* p, uint16_t x)
{
  PUSH(p,x,16);
}
void push32(PipeRec* p, uint32_t x)
{
  PUSH(p,x,32);
}
void push64(PipeRec* p, uint64_t x)
{
  PUSH(p,x,64);
}

void delete_job(PipeJob* job)
{
  if(job == NULL)
    return;

  free(job->buffer.ptr8);
  free(job->pipe_name);
}


int start_server()
{
  int server_socket_id = -1;
  int try_limit = 10;
  while(try_limit > 0)
    {

      server_socket_id = create_server(DEFAULT_SERVER_PORT,DEFAULT_MAX_CONNECTIONS);
      if(server_socket_id > 0)
	{
	  fprintf(stderr,"\nInfo: success: started the pipeHandler server on port %d\n",
		  DEFAULT_SERVER_PORT);
          set_non_blocking(server_socket_id);
	  break;
	}
      else
	fprintf(stderr,"\nInfo: could not start the pipeHandler server on port %d, will try again\n",
		DEFAULT_SERVER_PORT);

      usleep(1000);

      try_limit--;

      if(try_limit == 0)
	{
	  fprintf(stderr,"\nError: tried to start the pipeHandler server on port %d, failed.. giving up\n",
		  DEFAULT_SERVER_PORT);
	  exit(1);
	  // return(-1);
	}
    }
  return(server_socket_id);
}

PipeRec* find_pipe(char* pipe_name)
{
  PipeRec* p;
  for(p = pipes; p != NULL; p = p->next)
  {
      if(strcmp(p->pipe_name,pipe_name)== 0)
	return(p);
  }
  return(NULL);
}

PipeRec* add_pipe(char* pipe_name, int pipe_depth, int pipe_width, int lifo_mode)
{
  PipeRec* p;
  p = find_pipe(pipe_name);
  if(p != NULL)
  {
	if(p->pipe_width != pipe_width)
        {
	      fprintf(stderr,"Error: pipeHandler: redefinition of pipe %s with conflicting widths (%d or %d?)\n", pipe_name, p->pipe_width, pipe_width);
		return(NULL);
        }
	if(p->lifo_mode != lifo_mode)
	{
	      fprintf(stderr,"Error: pipeHandler: redefinition of pipe %s with conflicting modes (FIFO or LIFO?)\n", pipe_name);
		return(NULL);
	}

	return(p);
  }

  PipeRec* new_p = (PipeRec*) malloc(sizeof(PipeRec));
  memset(new_p, 0, sizeof(PipeRec));

  new_p->pipe_name = strdup(pipe_name);
  new_p->pipe_width = pipe_width;
  new_p->pipe_depth = pipe_depth;
  new_p->buffer.ptr8 = (uint8_t*) malloc(((pipe_depth*pipe_width)/8)*sizeof(uint8_t));
  new_p->lifo_mode = lifo_mode;
  new_p->next = pipes;
  pipes = new_p;

  fprintf(log_file,"Info: added pipe %s depth %d width %d lifo_mode %d\n", pipe_name,pipe_depth,pipe_width, lifo_mode);
  fflush(log_file);
  return(new_p);
}


void add_job(char* pipe_name, int read_write_bar, int width, int number_of_words_requested, void* burst_payload, 
		char* single_binary_payload, int socket_id, int burst_access)
{
  PipeRec* p = find_pipe(pipe_name);
  if(p == NULL)
  {
	fprintf(stderr,"Error: pipeHandler:add_job: job used unregistered pipe %s\n", pipe_name);
	return;
  }

  PipeJob* new_job = (PipeJob*) malloc(sizeof(PipeJob));
  memset(new_job, 0, sizeof(PipeJob));

  new_job->pipe_name = strdup(pipe_name);
  new_job->pipe_record = p;
  new_job->word_length = width;
  new_job->words_requested = number_of_words_requested;
  new_job->read_write_bar = read_write_bar;
  new_job->socket_id = socket_id;
  new_job->index = free_job_index; free_job_index++;
  new_job->words_served = 0;
  new_job->is_burst_access = burst_access;

  char* ss = NULL;
  switch(width)
    {
    case 8: 
      new_job->buffer.ptr8 = (uint8_t*) malloc(number_of_words_requested*sizeof(uint8_t)); 
      if(!burst_access && (single_binary_payload != NULL))
		*(new_job->buffer.ptr8) = get_uint8_t(single_binary_payload,&ss);
      else if(burst_access && (burst_payload != NULL))
	bcopy(burst_payload, new_job->buffer.ptr8,(number_of_words_requested*width)/8);
      break;
    case 16: 
      new_job->buffer.ptr16 = (uint16_t*) malloc(number_of_words_requested*sizeof(uint16_t)); 
      if(!burst_access && (single_binary_payload != NULL))
	*(new_job->buffer.ptr16) = get_uint16_t(single_binary_payload,&ss);
      else if(burst_access && (burst_payload != NULL))
	bcopy(burst_payload, new_job->buffer.ptr16,(number_of_words_requested*width)/8);
      break;
    case 32: 
      new_job->buffer.ptr32 = (uint32_t*) malloc(number_of_words_requested*sizeof(uint32_t)); 
      if(!burst_access && (single_binary_payload != NULL))
	*(new_job->buffer.ptr32) = get_uint32_t(single_binary_payload,&ss);
      else if(burst_access && (burst_payload != NULL))
	bcopy(burst_payload, new_job->buffer.ptr32,(number_of_words_requested*width)/8);
      break;
    case 64:
      new_job->buffer.ptr64 = (uint64_t*) malloc(number_of_words_requested*sizeof(uint64_t)); 

      if(!burst_access && (single_binary_payload != NULL))
	*(new_job->buffer.ptr64) = get_uint64_t(single_binary_payload,&ss);
      else if(burst_access && (burst_payload != NULL))
	bcopy(burst_payload, new_job->buffer.ptr64,(number_of_words_requested*width)/8);
      break;
    default: assert(0);
    }
  __APPEND(active_jobs,new_job);
#ifdef DEBUG
  fprintf(log_file,"\nInfo: added job read-write-bar=%d pipe=%s width=%d number-of-words=%d, burst-mode=%d\n", 
			read_write_bar, pipe_name, width, number_of_words_requested, burst_access);
#endif
}


char process_job(PipeJob* job)
{
  char ret_flag = 0;
  if(job == NULL)
    return (ret_flag);
#ifdef DEBUG
  fprintf(log_file,"Info: started processing job read-write-bar=%d pipe=%s words-requested=%d words-served=%d\n",
			job->read_write_bar, job->pipe_name, job->words_requested, job->words_served);
#endif

  if(job->words_served < job->words_requested)
    {
      switch(job->word_length)
	{
	case 8:
	  if(job->read_write_bar) // a read.
	    {
	      while((job->words_served < job->words_requested) && !__EMPTY(job->pipe_record))
		{
		  uint8_t val = pop8(job->pipe_record);
		  (job->buffer.ptr8[job->words_served]) = val;
		  job->words_served += 1;
		  ret_flag = 1;
		  fprintf(log_file,"read %2x from %s\n", val, job->pipe_name);
		}
	    }
	  else
	    {
	      while((job->words_served < job->words_requested) && !__FULL(job->pipe_record))
		{
		  uint8_t val = job->buffer.ptr8[job->words_served];
		  push8(job->pipe_record, (job->buffer.ptr8[job->words_served]));
		  job->words_served += 1;
		  ret_flag = 1;
		  fprintf(log_file,"wrote %2x to %s\n", val, job->pipe_name);
		}
	    }
	  break;
	case 16:
	  if(job->read_write_bar) // a read.
	    {
	      while((job->words_served < job->words_requested) && !__EMPTY(job->pipe_record))
		{
		  uint16_t val = pop16(job->pipe_record);
		  (job->buffer.ptr16[job->words_served]) = val;
		  job->words_served += 1;
		  ret_flag = 1;
		  fprintf(log_file,"read %4x from %s\n", val, job->pipe_name);
		}
	    }
	  else
	    {
	      while((job->words_served < job->words_requested) && !__FULL(job->pipe_record))
		{
		  uint16_t val = job->buffer.ptr16[job->words_served];	
		  push16(job->pipe_record, val);
		  job->words_served += 1;
		  ret_flag = 1;
		  fprintf(log_file,"wrote %4x to %s\n", val, job->pipe_name);
		}
	    }
	  break;
	case 32:
	  if(job->read_write_bar) // a read.
	    {
	      while((job->words_served < job->words_requested) && !__EMPTY(job->pipe_record))
		{
		  uint32_t val = pop32(job->pipe_record);
		  (job->buffer.ptr32[job->words_served]) = val;
		  job->words_served += 1;
		  ret_flag = 1;
		  fprintf(log_file,"read %8x from %s\n", val, job->pipe_name);
		}
	    }
	  else
	    {
	      while((job->words_served < job->words_requested) && !__FULL(job->pipe_record))
		{
		  uint32_t val = job->buffer.ptr32[job->words_served];	
		  push32(job->pipe_record, val);
		  job->words_served += 1;
		  ret_flag = 1;
		  fprintf(log_file,"wrote %8x to %s\n", val, job->pipe_name);
		}
	    }
	  break;
	case 64:
	  if(job->read_write_bar)
	    {
	      while((job->words_served < job->words_requested) && !__EMPTY(job->pipe_record))
		{
		  uint64_t val = pop64(job->pipe_record);
		  (job->buffer.ptr64[job->words_served]) = val;
		  job->words_served += 1;
		  ret_flag = 1;
		  fprintf(log_file,"read %llx from %s\n", val, job->pipe_name);
		}
	    }
	  else
	    {
	      while((job->words_served < job->words_requested) && !__FULL(job->pipe_record))
		{
		  uint64_t val = job->buffer.ptr64[job->words_served];	
		  push64(job->pipe_record, (job->buffer.ptr64[job->words_served]));
		  job->words_served += 1;
		  ret_flag = 1;
		  fprintf(log_file,"wrote %llx to %s\n", val, job->pipe_name);
		}
	    }
	  break;
	default:
	  assert(0);
	}
    }
#ifdef DEBUG
  fprintf(log_file,"Info: started processing job read-write-bar=%d pipe=%s words-requested=%d words-served=%d\n",
			job->read_write_bar, job->pipe_name, job->words_requested, job->words_served);
#endif

  return(ret_flag);
}

void execute_jobs()
{
  PipeJob* job;
  char event_flag; 
  while(1)
  {
	event_flag = 0;
  	for(job = active_jobs.head; job != NULL; job = job->next)
    	{
		char pflag = process_job(job);
      		event_flag = event_flag | pflag;
    	}

	job = active_jobs.head;
	while(job != NULL)
    	{
		PipeJob* next_job = job->next;
      		if(job->words_served == job->words_requested)
		{
	  		__REMOVE(active_jobs,job);
	  		__APPEND(finished_jobs,job);
		}
		job = next_job;
    	}

	if(!event_flag)
		break;
  }
}

void send_and_close_connection(char* send_buffer, int message_length, int client_sock)
{
  send(client_sock,send_buffer,message_length,0);
  close(client_sock);
}

void ack_and_close_connection(int client_sock,int status)
{
  char send_buffer[2];
  sprintf(send_buffer,"%s", (status ? "1" : "0"));
  send_and_close_connection(send_buffer, 2, client_sock);
}

void send_job_response(PipeJob* job)
{
  char send_buffer[MAX_BUF_SIZE];
  int message_length;
#ifdef DEBUG
  fprintf(log_file,"Info: started sending response for job read-write-bar=%d pipe=%s words-requested=%d words-served=%d\n",
			job->read_write_bar, job->pipe_name, job->words_requested, job->words_served);
#endif
  if(!(job->read_write_bar))
    {
      ack_and_close_connection(job->socket_id, 1);
    }
  else
    {// for a read, need to send back the result..
      if(!job->is_burst_access)
	{
	  switch(job->word_length)
	    {
	    case 8: 
	      append_uint8_t(send_buffer,*(job->buffer.ptr8));
	      break;
	    case 16: 
	      append_uint16_t(send_buffer,*(job->buffer.ptr16));
	      break;
	    case 32: 
	      append_uint32_t(send_buffer,*(job->buffer.ptr32));
	      break;
	    case 64: 
	      append_uint64_t(send_buffer,*(job->buffer.ptr64));
	      break;
	    }
	  message_length = strlen(send_buffer)+1;
	}
      else
	{
	  message_length = job->word_length*job->words_requested;
	  bcopy(job->buffer.ptr8,send_buffer,message_length);
	}
      send_and_close_connection(send_buffer,message_length,job->socket_id);
    }
#ifdef DEBUG
  fprintf(log_file,"Info: finished sending response for job read-write-bar=%d pipe=%s words-requested=%d words-served=%d\n",
			job->read_write_bar, job->pipe_name, job->words_requested, job->words_served);
#endif
}


void send_responses()
{
  PipeJob* job = finished_jobs.head;
  while(job != NULL)
    {
      PipeJob* next_job = job->next;
      if(can_write_to_socket(job->socket_id))
	{
	  send_job_response(job);
	  __REMOVE(finished_jobs,job);
	  delete_job(job);
	}
      else
	{
		fprintf(stderr,"Warngin:  pipe-job cannot write to socket %d.\n", job->socket_id);
	}

      job = next_job;
    }
}

void parse_and_add_job(char* receive_buffer, int client_sock, char* payload, int payload_length)
{

#ifdef DEBUG
  fprintf(stderr,"\nInfo: pipeHandler: got job %s\n", receive_buffer);
  fprintf(log_file,"\nInfo: pipeHandler: got job %s\n", receive_buffer);
#endif

  // format:  "piperead.single/pipewrite.single/call  name  num-inp (value)* num-op (width)* .. this is redundant..
  //                   but we will support it...
  // OR
  //       :  "piperead.burst/pipewrite.burst name data_width num_words [buffer]"
  // OR
  //       :  "addpipe name depth width"
  char* save_ptr;
  char* type_of_request = strtok_r(receive_buffer," ",&save_ptr);
  char* pipe_name = strtok_r(NULL," ",&save_ptr);

  // what type of request is it?
  if(strcmp(type_of_request,"registerpipe.fifo") == 0)
    {
      char* depth_string = strtok_r(NULL," ",&save_ptr);
      assert(depth_string != NULL);
      int depth = atoi(depth_string);

      char* width_string = strtok_r(NULL," ",&save_ptr);
      assert(width_string != NULL);
      int width = atoi(width_string);

      PipeRec* p = add_pipe(pipe_name,depth,width,0);
      uint8_t status = (p != NULL);
      ack_and_close_connection(client_sock,status);
    }
  else if(strcmp(type_of_request,"registerpipe.lifo") == 0)
    {
      char* depth_string = strtok_r(NULL," ",&save_ptr);
      assert(depth_string != NULL);
      int depth = atoi(depth_string);

      char* width_string = strtok_r(NULL," ",&save_ptr);
      assert(width_string != NULL);
      int width = atoi(width_string);

      PipeRec* p = add_pipe(pipe_name,depth,width,1);
      uint8_t status = (p != NULL);
      ack_and_close_connection(client_sock,status);
    }
  else if(strcmp(type_of_request,"registerpipe.flag") == 0)
    {
      int depth = 1;

      char* width_string = strtok_r(NULL," ",&save_ptr);
      assert(width_string != NULL);
      int width = atoi(width_string);

      PipeRec* p = add_pipe(pipe_name,depth,width,0);
      uint8_t status = (p != NULL);

      p->is_port = 1;
      ack_and_close_connection(client_sock,status);
    }
  else if(strcmp(type_of_request,"piperead.single") == 0)
    {
      char* num_inputs = strtok_r(NULL, " ", &save_ptr);
      assert(num_inputs != NULL);
      assert(atoi(num_inputs) == 0);

      char* num_outputs = strtok_r(NULL, " ", &save_ptr);
      assert(num_outputs != NULL);
      assert(atoi(num_outputs) == 1);

      char* width_str = strtok_r(NULL, " ", &save_ptr);
      assert(width_str != NULL);
      int width = atoi(width_str);
      add_job(pipe_name, 1, width, 1, NULL,NULL,client_sock,0);
    }
  else if(strcmp(type_of_request,"piperead.burst") == 0)
    {
      // get the data_width.
      char* data_width_str = strtok_r(NULL," ", &save_ptr);
      assert(data_width_str != NULL);
      int word_length = atoi(data_width_str);

      char* number_of_data_objects_str = strtok_r(NULL," ",&save_ptr);
      assert(number_of_data_objects_str != NULL);
      int number_of_words_requested = atoi(number_of_data_objects_str);

      add_job(pipe_name,1,word_length,number_of_words_requested,NULL,NULL,client_sock,1);
    }
  else if(strcmp(type_of_request,"pipewrite.single") == 0)
    {
      char* num_inputs = strtok_r(NULL, " ", &save_ptr);
      assert(num_inputs != NULL);
      assert(atoi(num_inputs) == 1);

      char* ip_value_str = strtok_r(NULL," ", &save_ptr);
      assert(ip_value_str != NULL);
      
      char* num_outputs = strtok_r(NULL, " ", &save_ptr);
      assert(num_outputs != NULL);
      assert(atoi(num_outputs) == 0);

      char* width_str = strtok_r(NULL, " ", &save_ptr);
      assert(width_str != NULL);
      int width = atoi(width_str);

      add_job(pipe_name, 0, width, 1, NULL, ip_value_str, client_sock,0);
    }
  else if(strcmp(type_of_request,"pipewrite.burst") == 0)
    {
      // get the data_width.
      char* data_width_str = strtok_r(NULL," ", &save_ptr);
      assert(data_width_str != NULL);
      int word_length = atoi(data_width_str);

      char* number_of_data_objects_str = strtok_r(NULL," ",&save_ptr);
      assert(number_of_data_objects_str != NULL);
      int number_of_words_requested = atoi(number_of_data_objects_str);

      add_job(pipe_name,0,word_length,number_of_words_requested,payload,NULL,client_sock,1);
    }
   else if(strcmp(type_of_request,"killPipeHandler") == 0)
    {
      fprintf(stderr,"Info: pipeHandler: kill message received... will shutdown\n");
      ack_and_close_connection(client_sock,1);
      global_kill_flag = 1;
    }
}


void start_listening(int server_socket_id)
{

  char payload[4096];
  int payload_length;
  int new_sock;

  while(1)
    {
      if((new_sock = connect_to_client(server_socket_id)) > 0)
	{
	  char receive_buffer[MAX_BUF_SIZE];
		
	  // if the client has connected "just now"
	  // it must send something!
#ifdef DEBUG
	  fprintf(log_file,"\nInfo: pipeHandler: waiting for message from client %d\n", new_sock);
	  fflush(log_file);
#endif
	  int n = receive_string(new_sock,receive_buffer, MAX_BUF_SIZE);
		
	  if(n > 0)
	    {

	      payload_length = extract_payload(receive_buffer,payload,n);
#ifdef DEBUG
	      fprintf(log_file,"\nInfo: pipeHandler: received message from client %d: %s (payload-length=%d)\n", 
		      new_sock, receive_buffer,payload_length);
	      fflush(log_file);
#endif
	      parse_and_add_job(receive_buffer, new_sock,payload,payload_length);
      	      execute_jobs();
	    }
	}

      send_responses();

      if(global_kill_flag)
	break;
    }
}

void set_pipe_is_written_into(char* pipe_name)
{
  PipeRec* p = find_pipe(pipe_name);
  if(p != NULL)
	p->is_written_into = 1;
}

void set_pipe_is_read_from(char* pipe_name)
{
  PipeRec* p = find_pipe(pipe_name);
  if(p != NULL)
	p->is_read_from = 1;
}

// return the number of dangling pipes.
int  check_for_dangling_pipes()
{
  int ret_val = 0;
  PipeRec* p;
  for(p = pipes; p != NULL; p = p->next)
  {
	if(!p->is_written_into || !p->is_read_from)
	{
		fprintf(stderr, "Error: pipe %s is_written_into = %d, is_read_from = %d\n",
				p->pipe_name, p->is_written_into, p->is_read_from);
		ret_val++;
	}
  }
  return(ret_val);
}

// flush fp and acquire the lock... return
// a sequence id.. useful for serialization
// of a concurrent trace.
MUTEX_DECL(__file_print_mutex__);
uint32_t get_file_print_lock(FILE* fp)
{
	static uint32_t __print_counter__ = 0;
	MUTEX_LOCK(__file_print_mutex__);
	__print_counter__++;
	return(__print_counter__);
}
// flush fp and release the lock.
void release_file_print_lock(FILE* fp)
{
	MUTEX_UNLOCK(__file_print_mutex__);
}

void pipeHandler()
{
  fprintf(stderr, "*** pipeHandler Initialize ***\n");
  log_file = fopen("pipeHandler.log","a");
  fprintf(log_file, "*** New Run ***\n");

  int try_limit = 100;

  // open the server socket..
  int server_socket_id = start_server();
  if(server_socket_id < 0)
    return;

  active_jobs.head = NULL; active_jobs.tail = NULL;
  finished_jobs.head = NULL; finished_jobs.tail = NULL;

  start_listening(server_socket_id);
  close(server_socket_id);
}

void killPipeHandler()
{
     char buffer[MAX_BUF_SIZE];
     sprintf(buffer,"killPipeHandler ");
     send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
}
