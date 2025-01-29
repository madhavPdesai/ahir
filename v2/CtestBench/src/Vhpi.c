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
// author: Madhav P. Desai
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <SocketLib.h>
#include <Vhpi.h>

#define LOG_FILE "vhpi.log"



#define z32__ "00000000000000000000000000000000"

#define APPEND(lst,lnk) if(lst.tail)\
      {\
	lst.tail->next = lnk;\
	lnk->prev = lst.tail;\
	lnk->next = NULL;\
	lst.tail = lnk;\
      }\
    else\
      {\
	lst.head = lnk;\
	lst.tail = lnk;\
	lnk->prev = NULL;\
	lnk->next = NULL;\
      }

#define REMOVE(lst,lnk) if((lst.head == lnk) && (lst.tail == lnk))	\
    {\
      lst.head = NULL;\
      lst.tail = NULL;\
      lnk->next = lnk->prev = NULL;\
    }\
  else if(lst.head == lnk)\
    {\
      lst.head = lnk->next;\
      lnk->next->prev = NULL;\
      lnk->next = lnk->prev = NULL;\
    }\
  else if(lst.tail == lnk)\
    {\
      lst.tail = lnk->prev;\
      lnk->prev->next = NULL;\
      lnk->prev = lnk->next = NULL;\
    }\
  else\
    {\
      lnk->prev->next = lnk->next;\
      lnk->next->prev = lnk->prev;\
      lnk->prev = lnk->next = NULL;\
    }

////////////////////////////////  global variables /////////////////////////////////////////////////
FILE *log_file = NULL;

// cycle count;
int vhpi_cycle_count = 0;

// free job index
int64_t free_job_index = 0;

// server socket
int server_socket_id = -1;

// joblist.
JobList new_jobs;
JobList active_jobs;
JobList finished_jobs;

// protected by mutex.
MUTEX_DECL(__global_variable_mutex__);

///////////////////////////////////////////////////////////////////////////////////////////////
// some utility functions.
///////////////////////////////////////////////////////////////////////////////////////////////
JobLink* allocateJobLink()
{
	JobLink* rv = (JobLink*) malloc (sizeof(JobLink));
	memset((void*) rv, 0, sizeof(JobLink));
	return(rv);
}

char* allocateString(int size)
{
	char* rv = (char*) malloc (size * sizeof(char));
	memset((void*) rv, 0, size);
	return(rv);
}

Port* allocatePort()
{
	Port* rv = (Port*) malloc (sizeof(Port));
	memset((void*) rv, 0, sizeof(Port));
	return(rv);
}

PortLink* allocatePortLink()
{
	PortLink* rv = (PortLink*) malloc (sizeof(PortLink));
	memset((void*) rv, 0, sizeof(PortLink));
	return(rv);
}

// convert 32 character string pointed to by a to an 
// unsigned.
unsigned Bit_Vector_To_Unsigned(char* a)
{
  unsigned ret_val = 0;
  int index;
  if(a != NULL)
    {
      for(index = 31; index >= 0; index--)
	{
	  if(a[index] == 1)	
	    ret_val = ret_val + (1 << (31-index));
	}
    }
  return(ret_val);
}

// pack unsigned x into 32 character string pointed
// to by x.
void Unsigned_To_Bit_Vector(unsigned x, char* a)
{
  int index;
  if(a != NULL)
    {
      for(index = 31; index >= 0; index--)
	{
	  if(x & (1 << (31-index)))
	    a[index] = 1;
	  else
	    a[index] = 0;
	}
    }
}

int Copy_Value(char* dest, char* src, int width)
{

  int ret_val = 0;

  char src_buf[MAX_BUF_SIZE];
  int src_width = 0;

  // skip spaces
  while(*src == ' ')
    src++;

  while(1)
    {
      if(src[src_width] == '1' || src[src_width] == '0')
	{
	  src_buf[src_width] = src[src_width];
	  src_width++;
	}
      else
	break;
    }
  src_buf[src_width] = 0; // null-terminate

  ret_val = src_width - width;

  dest[width] = 0;
  int i;
  for(i = 1; i <= width; i++)
    {
      if(i <= src_width)
	dest[width-i] = src[src_width-i];
      else
	dest[width-i] = '0'; // pad with 0.
    }

  return(ret_val);
}


void Delete_Port(Port* port)
{
  if(port != NULL)
    {
      if(port->port_value)
      {
	free(port->port_value);
	port->port_value = NULL;
      }
      
      free(port);
    }
}

void Delete_JobLink(JobLink* top)
{

  Delete_Port(top->req_port);
  top->req_port = NULL;

  Delete_Port(top->ack_port);
  top->ack_port = NULL;
  



  PortLink* nextplink = NULL;
  PortLink* plink = top->inports.head;
  while(plink != NULL)
    {
      nextplink = plink->next;
      Delete_Port(plink->port);
      plink->port = NULL;
      free(plink);
      
      plink = nextplink;
    }
  top->inports.head = top->inports.tail = NULL;


  plink = top->outports.head;
  while(plink != NULL)
    {
      nextplink = plink->next;
      Delete_Port(plink->port);
      plink->port = NULL;
      free(plink);
      
      plink = nextplink;
    }
  top->outports.head = top->outports.tail = NULL;

  if(top->name)
  {
    free(top->name);
    top->name = NULL;
  }
  else
	assert(0);

  free(top);
}

int Payload_Length(JobLink* j)
{
  return(j->number_of_words_requested * j->word_length/8);
}



////////////////////////////////////////////
///////////////////////////////////////////////////
// network-related stuff.
///////////////////////////////////////////////////////////////////////////////////////////////

// dang! parsing with strtok again!
void Append_To_JobList(char* receive_buffer,int socket_id, char* payload, int payload_length)
{

#ifdef DEBUG
  fprintf(log_file,"Info: appending message %s (payload of %d bytes) to JobList in cycle %d\n",receive_buffer , vhpi_cycle_count,payload_length);
  fflush(log_file);
#endif 
  char err_flag = 0;

  JobLink* new_job = NULL;

  new_job = allocateJobLink(); 
  new_job->socket_id = socket_id;
  new_job->index = free_job_index;
  free_job_index++;
  
  // format:  "piperead.single/pipewrite.single/call  name  num-inp (value)* num-op (width)* 
  // OR
  //       :  "piperead.burst/pipewrite.burst name data_width num_words [buffer]"
  char* save_ptr;
  char* type_of_request = strtok_r(receive_buffer," ",&save_ptr);
  
  // what type of request is it?
  if(strcmp(type_of_request,"piperead.single") == 0)
    {
#ifdef DEBUG
      fprintf(log_file,"Info: pipe-read in cycle %d\n", vhpi_cycle_count);
      fflush(log_file);
#endif 
      new_job->is_pipe_read_access = 1;
    }
  else if(strcmp(type_of_request,"piperead.burst") == 0)
    {
#ifdef DEBUG
      fprintf(log_file,"Info: burst-pipe-read in cycle %d\n", vhpi_cycle_count);
      fflush(log_file);
#endif 
      new_job->is_pipe_read_access = 1;
      new_job->is_burst_access = 1;
    }
  else if(strcmp(type_of_request,"pipewrite.single") == 0)
    {
#ifdef DEBUG
      fprintf(log_file,"Info: pipe-write in cycle %d\n", vhpi_cycle_count);
      fflush(log_file);
#endif 
      new_job->is_pipe_write_access = 1;
    }
  else if(strcmp(type_of_request,"pipewrite.burst") == 0)
    {
#ifdef DEBUG
      fprintf(log_file,"Info: burst-pipe-write in cycle %d\n", vhpi_cycle_count);
      fflush(log_file);
#endif 
      new_job->is_pipe_write_access = 1;
      new_job->is_burst_access = 1;

    }
  else if(strcmp(type_of_request,"call") == 0)
    {
#ifdef DEBUG
  fprintf(log_file,"Info: function-call in cycle %d\n", vhpi_cycle_count);
  fflush(log_file);
#endif 
      new_job->is_module_access = 1;
    }
  else
    {
      fprintf(stderr,"Error: unknown request type : %s\n", type_of_request);
      Delete_JobLink(new_job);
      return;
    }
  
  
  char* name = strtok_r(NULL," ",&save_ptr);
  assert(name != NULL);

  new_job->name = strdup(name);
#ifdef DEBUG
  fprintf(log_file,"Info: job-name %s, in cycle %d\n", new_job->name, vhpi_cycle_count);
  fflush(log_file);
#endif 
  
  // every job has a request and acknowledge port.
  new_job->req_port = allocatePort();
  new_job->req_port->index = 0;
  new_job->req_port->width = 1;
  new_job->req_port->port_value = allocateString(2);
#ifdef DEBUG
  fprintf(log_file,"Info: job-name %s request set to 1 in cycle %d\n", new_job->name, vhpi_cycle_count);
  fflush(log_file);
#endif 
  sprintf(new_job->req_port->port_value,"1");
  
  new_job->ack_port = allocatePort();
  new_job->ack_port->index = 0;
  new_job->ack_port->width = 1;
  new_job->ack_port->port_value = allocateString(2);
  sprintf(new_job->ack_port->port_value,"0");


  // if burst access, the fields are a bit different..
  if(new_job->is_burst_access)
    {
      // get the data_width.
      char* data_width_str = strtok_r(NULL," ", &save_ptr);
      if(data_width_str == NULL)
	{
	  fprintf(stderr,"Error: data width in burst access not specified\n");
	  MUTEX_LOCK(__global_variable_mutex__);
	  Delete_JobLink(new_job);
	  MUTEX_UNLOCK(__global_variable_mutex__);
	  return;	  
	}
      new_job->word_length = atoi(data_width_str);

      char* number_of_data_objects_str = strtok_r(NULL," ",&save_ptr);
      if(number_of_data_objects_str == NULL)
	{
	  fprintf(stderr,"Error: number of data objects in burst access not specified\n");
	  MUTEX_LOCK(__global_variable_mutex__);
	  Delete_JobLink(new_job);
	  MUTEX_UNLOCK(__global_variable_mutex__);
	  return;	  
	}      

      new_job->number_of_words_requested = atoi(number_of_data_objects_str);

      if(new_job->is_pipe_write_access)
	{
	  if(payload_length != Payload_Length(new_job))
	    {
	      fprintf(stderr,"Error: payload string did not have %d bytes\n", Payload_Length(new_job));
	      MUTEX_LOCK(__global_variable_mutex__);
	      Delete_JobLink(new_job);
	      MUTEX_UNLOCK(__global_variable_mutex__);
	      return;
	    }
	  bcopy(payload,new_job->payload,Payload_Length(new_job));
	}

#ifdef DEBUG
      fprintf(log_file,"Info: %s access on pipe %s data-width %d number-of-words %d in cycle %d\n", 
	      type_of_request,
	      new_job->name,
	      new_job->word_length, 
	      new_job->number_of_words_requested,
	      vhpi_cycle_count);
      if(payload_length > 0)
	print_payload(log_file,new_job->payload,new_job->word_length,new_job->number_of_words_requested);
      fflush(log_file);
#endif 
    }
  else
    {
      // the number of inputs?
      char* num_inputs = strtok_r(NULL," ",&save_ptr);
      assert(num_inputs != NULL);
      int ninp = atoi(num_inputs);
      
      // read each input value..
      int idx;
      for(idx = 0; idx < ninp; idx++)
	{
	  char* ip_value = strtok_r(NULL," ",&save_ptr);
	  assert(ip_value != NULL);
	  
	  // each input is  a port.
	  Port* p = allocatePort();
	  p->index = idx;
	  p->width = strlen(ip_value);
	  p->port_value = strdup(ip_value);
#ifdef DEBUG
	  fprintf(log_file,"Info: job-name %s inport %d set to %s in cycle %d\n", new_job->name,idx,p->port_value,vhpi_cycle_count);
	  fflush(log_file);
#endif 
	  
	  PortLink* plink = allocatePortLink();
	  plink->port = p;

	  APPEND(new_job->inports, plink);
	}
      
      // the number of outputs?
      char* num_outputs = strtok_r(NULL," ",&save_ptr);
      assert(num_outputs != NULL);
      int nops = atoi(num_outputs);
      
      // get the output widths.
      for(idx = 0; idx < nops; idx++)
	{
	  char* ip_width = strtok_r(NULL," ",&save_ptr);
	  assert(ip_width != NULL);
	  
	  int iw = atoi(ip_width);
	  
	  // new port for each output.
	  Port* p = allocatePort();
	  p->index = idx;
	  p->width = iw;
	  p->port_value = allocateString(iw + 2); 
#ifdef DEBUG
	  fprintf(log_file,"Info: job-name %s outport %d width set to %d in cycle %d\n", new_job->name,idx,p->width,vhpi_cycle_count);
	  fflush(log_file);
#endif 
	  
	  PortLink* plink = allocatePortLink();
	  plink->port = p;
	  
	  APPEND(new_job->outports, plink);
	}
    }

  // append the job.
  MUTEX_LOCK(__global_variable_mutex__);
  APPEND(new_jobs, new_job);
  MUTEX_UNLOCK(__global_variable_mutex__);

#ifdef DEBUG
  fprintf(log_file,"Info: finished appending job %s to JobList in cycle %d\n", new_job->name, vhpi_cycle_count);
  fflush(log_file);
#endif 

}

static void Vhpi_Exit(int sig)
{
  fprintf(stderr, "*** Break! ***\n");
  fprintf(stderr,"Info: Stopping the simulation \n");
  Vhpi_Close();
  exit(0);
}

///////////////////////////////////////////////////////////////////////////////////////////////
// The main Vhpi functions.
///////////////////////////////////////////////////////////////////////////////////////////////
void  Vhpi_Initialize()
{
  fprintf(stderr, "*** Vhpi_Initialize ***\n");
  log_file = fopen("vhpi.log","a");
  fprintf(log_file, "*** New Run ***\n");


  signal(SIGINT,  Vhpi_Exit);
  signal(SIGTERM, Vhpi_Exit);

  MUTEX_LOCK(__global_variable_mutex__);

  new_jobs.head = NULL;
  new_jobs.tail = NULL;
  
  active_jobs.head = NULL;
  active_jobs.tail = NULL;

  finished_jobs.head = NULL;
  finished_jobs.tail = NULL;


  int try_limit = 100;

  // open the socket. and start listening. 
  while(try_limit > 0)
    {

      
      server_socket_id = create_server(DEFAULT_SERVER_PORT,DEFAULT_MAX_CONNECTIONS);
      if(server_socket_id > 0)
	{
	  fprintf(stderr,"Info: success: started the server on port %d\n",
		  DEFAULT_SERVER_PORT);
          set_non_blocking(server_socket_id);
	  break;
	}
      else
	fprintf(stderr,"Info: could not start server on port %d, will try again\n",
		DEFAULT_SERVER_PORT);

      usleep(1000);

      try_limit--;

      if(try_limit == 0)
	{
	  fprintf(stderr,"Error: tried to start server on port %d, failed.. giving up\n",
		  DEFAULT_SERVER_PORT);
	  exit(1);
	  //return;
	}
    }

  MUTEX_UNLOCK(__global_variable_mutex__);
}

void  Vhpi_Close()
{
  // close all connections and the socket.
  fprintf(stderr,"Info: closing VHPI link\n");
  fclose(log_file);
  MUTEX_LOCK(__global_variable_mutex__);
  close(server_socket_id);
  MUTEX_UNLOCK(__global_variable_mutex__);
}


// go down the list of finished jobs and send
// out the resulting port values..
void  Vhpi_Send()
{

#ifdef DEBUG
  fprintf(log_file,"Info: sending in cycle %d\n", vhpi_cycle_count);
  fflush(log_file);
#endif 

  char send_buffer[MAX_BUF_SIZE];
  char spacer_string[2];
  sprintf(spacer_string, " ");
  JobLink* top, *next;


  MUTEX_LOCK(__global_variable_mutex__);

  // first look at all active jobs and see if they
  // can be moved to completed status.
  top = active_jobs.head;
  while (top != NULL)
    {
      if(*(top->ack_port->port_value) == '1') 
	{
      
#ifdef DEBUG
	    if(top->is_burst_access)
	    {
	      fprintf(log_file,"Info: active_word_count of  %s is %d (words requested = %d) in cycle %d\n", top->name,
			top->active_word_count, top->number_of_words_requested, vhpi_cycle_count);
	      fflush(log_file);
	    }
#endif 
	  if(!top->is_burst_access ||
	     (top->active_word_count == top->number_of_words_requested))
	    {
#ifdef DEBUG
	      fprintf(log_file,"Info: job %s finished in cycle %d\n", top->name, vhpi_cycle_count);
	      fflush(log_file);
#endif 
	      next = top->next;
	      
	      REMOVE(active_jobs,top);
	      
#ifdef LOGON
	      fprintf(log_file,"cycle %d finished job %s(%d)\n",
		      vhpi_cycle_count,
		      top->name,
		      (int) top->index);
#endif
	      
	      APPEND(finished_jobs,top);
	      top = next;
	    }
	  else
	    top = top->next;
	}
      else
	{
	  top = top->next;
	}
    }

  // look at all completed jobs and send 
  // the data..
  top = finished_jobs.head;
  while(top != NULL)
    {
      if(can_write_to_socket(top->socket_id))
	{
#ifdef DEBUG
          fprintf(log_file,"Info: sending message that job %s has finished in cycle %d\n", top->name, vhpi_cycle_count);
  fflush(log_file);
#endif 
	  if(top->is_pipe_read_access) 
	    {
	      if(!top->is_burst_access)
		sprintf(send_buffer,"%s",top->outports.head->port->port_value);
	      else
		bcopy(top->payload,send_buffer,Payload_Length(top));
	    }
	  else if( top->is_pipe_write_access)
	    {
	      sprintf(send_buffer,"1");
	    }
	  else if(top->is_module_access)
	    {
	      send_buffer[0] = 0;
	      PortLink* oplink;
	      for(oplink = top->outports.head; oplink != NULL; oplink = oplink->next)
		{
		  strcat(send_buffer,oplink->port->port_value);
		  strcat(send_buffer,spacer_string);
		}
	    }
	  
#ifdef DEBUG
	  fprintf(log_file,"Info: trying to send message %s in  %d\n", send_buffer, vhpi_cycle_count);
	  fflush(log_file);
#endif 
	  
	  if(top->is_pipe_read_access && top->is_burst_access)
	    {
	      send(top->socket_id,send_buffer,Payload_Length(top),0);
	    }
	  else
	    send(top->socket_id,send_buffer,strlen(send_buffer)+1,0);

#ifdef DEBUG
	  if(top->is_pipe_read_access && top->is_burst_access)
	    {
	      fprintf(log_file, "Info: successfully sent burst-read response (data-width %d number-of-words %d) ",
		      top->word_length, top->number_of_words_requested);
	      print_payload(log_file,send_buffer,top->word_length,top->number_of_words_requested);
	    }
	  else
	    fprintf(log_file,"Info: successfully sent message %s in  %d\n", send_buffer, vhpi_cycle_count);

	  fflush(log_file);
#endif 

	  next = top->next;

  	  close(top->socket_id);
	  REMOVE(finished_jobs,top);
	  Delete_JobLink(top);
	  
	  top = next;
	}
      else
	{
	  top = top->next;
	}
    }

  MUTEX_UNLOCK(__global_variable_mutex__);
}

void  Vhpi_Listen()
{
  char payload[MAX_BUF_SIZE];
  int payload_length;

  vhpi_cycle_count++;


#ifdef DEBUG
  fprintf(log_file,"Info: listening in cycle %d\n", vhpi_cycle_count);
  fflush(log_file);
#endif 

  int new_sock;
  while(1)
  {
  	if((new_sock = connect_to_client(server_socket_id)) > 0)
    	{
      		char receive_buffer[MAX_BUF_SIZE];
		
      		// if the client has connected "just now"
      		// it must send something!
#ifdef DEBUG
	  	fprintf(log_file,"Info: waiting for message from client %d\n", new_sock);
  fflush(log_file);
#endif
      		int n = receive_string(new_sock,receive_buffer,MAX_BUF_SIZE);
		
      		if(n > 0)
		{

		  payload_length = extract_payload(receive_buffer,payload,n);
#ifdef DEBUG
		  fprintf(log_file,"Info: received message from client %d: %s (payload-length=%d)\n", 
			  new_sock, receive_buffer,payload_length);
		  fflush(log_file);
#endif
		  Append_To_JobList(receive_buffer, new_sock,payload,payload_length);
		}
	}
	else
		break;
    }

#ifdef DEBUG
  fprintf(log_file,"Info: finished listening in cycle %d\n", vhpi_cycle_count);
  fflush(log_file);
#endif 
}



void   Vhpi_Set_Port_Value(char* port_name, char* port_value, int port_width)
{


  char* save_ptr;
  char* obj_name = strtok_r(port_name," ",&save_ptr);
  char* index_string = strtok_r(NULL," ",&save_ptr);
  assert((obj_name != NULL) && (index_string != NULL));
  int excess_bits;

  MUTEX_LOCK(__global_variable_mutex__);

  // look within jobs that are active.. 
  JobLink* jlink;
  for(jlink = active_jobs.head; jlink != NULL; jlink = jlink->next)
    {
      if(strcmp(jlink->name,obj_name) == 0)
	{
	  if(strcmp(index_string, "ack") == 0)
	    {
	      excess_bits = Copy_Value(jlink->ack_port->port_value, port_value,1);
#ifdef DEBUG
             fprintf(log_file,"Info: set %s ack to %s in cycle %d\n",port_name,jlink->ack_port->port_value, vhpi_cycle_count);
             fflush(log_file);
#endif 

	      if(*(jlink->ack_port->port_value) == '1') 
		{
		  char all_done = 0;
		  if(jlink->is_burst_access)
		    {
		      jlink->active_word_count++;
#ifdef DEBUG
             fprintf(log_file,"Info: set active_word_count of %s to %d in cycle %d\n",jlink->name, jlink->active_word_count, vhpi_cycle_count);

             fflush(log_file);
#endif 
		      if(jlink->active_word_count == jlink->number_of_words_requested)
			{
			  all_done = 1;
			}
		    }
		  else
		    all_done   = 1;

		   // req must be tied to 0
		  if(all_done)
                  {
		    sprintf(jlink->req_port->port_value, "0");
#ifdef DEBUG
             	    fprintf(log_file,"Info: set %s req  to 0 in cycle %d\n",jlink->name,vhpi_cycle_count);
                    fflush(log_file);
#endif
		  }
		}
	    }
	  else
	    {
	      if(!jlink->is_burst_access)
		{
		  int index = atoi(index_string);
		  PortLink* plink;
		  for(plink = jlink->outports.head; plink != NULL; plink = plink->next)
		    {
		      if(index == 0)
			{
			  excess_bits = Copy_Value(plink->port->port_value,
						   port_value,
						   port_width);
			  if(excess_bits > 0)
			    {
			      fprintf(stderr, "Error: %d higher bits lost in hardware -> software transfer (job %s)\n", 
				      excess_bits,
				      jlink->name);
			    }
			  else if (excess_bits < 0)
			    {
			      fprintf(stderr, "Error: added %d zero-padding high bits in hardware -> software transfer (job %s)\n", 
				      excess_bits,
				      jlink->name);
			    }

#ifdef DEBUG
			  fprintf(log_file,"Info: finished setting %s to %s in cycle %d\n",port_name,port_value, vhpi_cycle_count);
			  fflush(log_file);
#endif 
			  break;
			}
		      index--;
		    }
		}
	      else
		{
		  if(*(jlink->ack_port->port_value) == '1') 		  
		    {


		      excess_bits = port_width - jlink->word_length;
		      if(excess_bits > 0)
			{
			  fprintf(stderr, "Error: %d higher bits lost in hardware -> software transfer (job %s)\n", 
				  excess_bits,
				  jlink->name);
			}
		      else if(excess_bits < 0)
			{
			  fprintf(stderr, "Error: added %d zero-padding high bits in hardware -> software transfer (job %s)\n", 
				  excess_bits,
				  jlink->name);
			}


		      pack_value(jlink->payload,jlink->word_length, jlink->active_word_count-1, port_value);
#ifdef DEBUG
		      fprintf(log_file,"Info: finished setting %s word %d to %s in cycle %d\n",
				port_name, jlink->active_word_count-1, port_value, vhpi_cycle_count);
		      fflush(log_file);
#endif 
		    }
		}
	    }
	}
    }
  MUTEX_UNLOCK(__global_variable_mutex__);
}

void  Vhpi_Get_Port_Value(char* port_name, char* port_value, int port_width)
{

  char found_one = 0;
  char* save_ptr;
  char* obj_name = strtok_r(port_name," ",&save_ptr);
  char* index_string = strtok_r(NULL," ",&save_ptr);
  assert((obj_name != NULL) && (index_string != NULL));
  
  int val_found = 0;
  int excess_bits = 0;

  MUTEX_LOCK(__global_variable_mutex__);
  // look within jobs that are active
  JobLink* jlink = NULL;
  for(jlink = active_jobs.head; jlink != NULL; jlink = jlink->next)
    {
      if(strcmp(jlink->name,obj_name) == 0)
	{
	  break;
	}
    }

  // if not found in active, look in the new jobs.
  // if a new job matches, then move the new job to 
  // the active list.
  if(jlink == NULL)
    {
      for(jlink = new_jobs.head; jlink != NULL; jlink = jlink->next)
	{
	  if(strcmp(jlink->name,obj_name) == 0)
	    {
	      REMOVE(new_jobs,jlink);
	      APPEND(active_jobs,jlink);

#ifdef LOGON
	      fprintf(log_file,"cycle %d started job %s(%d)\n",
		      vhpi_cycle_count,
		      jlink->name,
		      (int) jlink->index);
#endif

	      break;
	    }
	}
    }

  if(jlink != NULL)
    {
      if(strcmp(index_string, "req") == 0)
	{
	  Copy_Value(port_value,jlink->req_port->port_value,1);
	  found_one = 1;
	  if(jlink->is_module_access)
	    {
	      //
	      // reset the port value.. this makes
	      // it a pulse.
	      //
	      *(jlink->req_port->port_value) = '0';
	    }
	}
      else
	{
	  if(!jlink->is_burst_access)
	    {
	      int index = atoi(index_string);
	      PortLink* plink;
	      for(plink = jlink->inports.head; plink != NULL; plink = plink->next)
		{
		  if(index == 0)
		    {
		      excess_bits = Copy_Value(port_value, plink->port->port_value,
					       plink->port->width);
		      if(excess_bits > 0)
			{
			  fprintf(stderr, "Error: %d higher bits lost in software -> hardware transfer (job %s)\n", excess_bits,
				  jlink->name);
			}
		      else if(excess_bits < 0)
			{
			  fprintf(stderr, "Error: added %d  zero-padding higher bits in software -> hardware transfer (job %s)\n", 
				  excess_bits,
				  jlink->name);
			}

		      found_one = 1;
		      break;
		    }
		  index--;
		}
	    }
	  else
	    {
#ifdef DEBUG
        	fprintf(log_file,"Info: unpacking word %d of port %s in cycle %d\n", jlink->active_word_count,
			jlink->name, vhpi_cycle_count);
#endif
	      unpack_value(jlink->payload, jlink->word_length, jlink->active_word_count,port_value);
	      found_one = 1;
	    }
	}
    }
  
  if(found_one == 0)
    {
#ifdef DEBUG
       fprintf(log_file,"Info: did not find new or active job %s in cycle %d\n",port_name,vhpi_cycle_count);
       fflush(log_file);
#endif 
       // didnt find it, write zero into it..
       // this is needed only for the req port,
       // because it needs to be deasserted after 
       // completion of the job.
      if(strcmp(index_string, "req") == 0)
      {
	Copy_Value(port_value,"0",1);
      }
    }

 

#ifdef DEBUG
  if(found_one)
    fprintf(log_file,"Info: returning value of port %s (%s) as %s in cycle %d!\n", port_name, index_string, port_value,
		vhpi_cycle_count);
  else
    fprintf(log_file,"Info: port %s (%s) not active, returning %s in cycle %d\n", port_name, index_string, port_value, vhpi_cycle_count);
  
  fflush(log_file);
#endif
  MUTEX_UNLOCK(__global_variable_mutex__);
}

void Vhpi_Log(char* message_string)
{
  MUTEX_LOCK(__global_variable_mutex__);
	if(log_file != NULL)
		fprintf(log_file,"LogInfo: %s.\n", message_string);
  MUTEX_UNLOCK(__global_variable_mutex__);
  
}

#ifdef GHDL


int main(int argc, char **argv)
{
  int ret_val;
  signal(SIGINT,  Vhpi_Exit);
  signal(SIGTERM, Vhpi_Exit);
  ret_val = (ghdl_main(argc,argv));
  return(ret_val);
}

#endif


#ifdef MODELSIM

void   Modelsim_FLI_Initialize()
{
  Vhpi_Initialize();
}

void   Modelsim_FLI_Close()
{
  Vhpi_Close();
}
void   Modelsim_FLI_Listen()
{
  Vhpi_Listen();
}

void   Modelsim_FLI_Send()
{
  Vhpi_Send();
}

void Modelsim_FLI_Set_Port_Value(mtiVariableIdT reg_id, mtiVariableIdT reg_val_id, int reg_width)
{
  char name_buffer[4096];
  char val_buffer[MAX_BUF_SIZE];

  Modelsim_FLI_To_String(name_buffer,reg_id);
  Modelsim_FLI_To_String(val_buffer,reg_val_id);

  Vhpi_Set_Port_Value(name_buffer,val_buffer, reg_width);
}

void Modelsim_FLI_Get_Port_Value(mtiVariableIdT reg_id, mtiVariableIdT reg_val_id, int reg_width)
{
  char name_buffer[4096];
  char val_buffer[MAX_BUF_SIZE];
  
  Modelsim_FLI_To_String(name_buffer,reg_id);
 
  Vhpi_Get_Port_Value(name_buffer,val_buffer, reg_width);
  
  String_To_Modelsim_FLI(reg_val_id,val_buffer);
}


void Modelsim_FLI_To_String(char* ret_string, mtiVariableIdT vsim_str)
{
  mtiTypeIdT type;
  int len;

  mti_GetArrayVarValue(vsim_str, ret_string);

  type = mti_GetVarType(vsim_str);
  len = mti_TickLength(type);

  ret_string[len] = 0;
}


void String_To_Modelsim_FLI(mtiVariableIdT vsim_str, char* from_string)
{
  char* val = mti_GetArrayVarValue(vsim_str, NULL);
  int len = mti_TickLength(mti_GetVarType(vsim_str));

  int idx;

  assert(strlen(from_string) < len);
  for(idx = 0; idx < strlen(from_string); idx++)
    {
      val[idx] = from_string [idx];
    }
}

void Modelsim_FLI_Log(mtiVariableIdT vsim_str)
{
	char message_buffer[MAX_BUF_SIZE];
  	Modelsim_FLI_To_String(message_buffer,vsim_str);
	Vhpi_Log(message_buffer);
}

#endif

