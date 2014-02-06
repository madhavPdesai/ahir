#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <signal.h>
#include <pipeHandler.h>
#include <pthread.h>
#define ___POP(p,ptr,width) {switch(width) { case 8: POP(p,ptr,8); break;\
						case 16: POP(p,ptr,16); break;\
						case 32: POP(p,ptr,32); break;\
						case 64: POP(p,ptr,64); break;\
						default: break; }} 
#define ___PUSH(p,ptr,width) {switch(width) { case 8: PUSH(p,ptr,8); break;\
						case 16: PUSH(p,ptr,16); break;\
						case 32: PUSH(p,ptr,32); break;\
						case 64: PUSH(p,ptr,64); break;\
						default: break; }} 
static FILE* log_file = NULL;
static PipeRec* pipes = NULL;

static pthread_mutex_t handler_mutex = PTHREAD_MUTEX_INITIALIZER;
#define ___LOCK___  pthread_mutex_lock(&handler_mutex);
#define ___UNLOCK___  pthread_mutex_unlock(&handler_mutex);

static pthread_mutex_t log_mutex = PTHREAD_MUTEX_INITIALIZER;
#define __LOCKLOG__  pthread_mutex_lock(&log_mutex);
#define __UNLOCKLOG__  pthread_mutex_unlock(&log_mutex);


void print_buffer(FILE* lfile, uint8_t* burst_payload,int count)
{
	int i;
	for (i=0; i < count; i++)
	{
		fprintf(lfile,"%0x ", burst_payload[i]);
	}
}

void init_pipe_handler()
{
	init_pipe_handler_with_log(NULL);
}

void init_pipe_handler_with_log(char* log_file_name)
{
	pipes = NULL;
	if(log_file_name != NULL)
   		log_file = fopen("pipeHandler.log","a");

	if(log_file != NULL)
        	fprintf(log_file,"\n******* NEW RUN *********\n");
}


void close_pipe_handler()
{
	if(log_file != NULL)
 	{
		fclose(log_file);
		log_file = NULL;
	}
}

PipeRec* find_pipe(char* pipe_name)
{
  PipeRec* p = NULL;
  PipeRec* r = NULL;
  // use a lock.. 
  ___LOCK___
  for(p = pipes; p != NULL; p = p->next)
  {
      if(strcmp(p->pipe_name,pipe_name)== 0)
      {
	r = p;
	break;
      }
  }
  ___UNLOCK___
  return(r);
}

uint32_t register_pipe(char* pipe_name, int pipe_depth, int pipe_width, int lifo_mode)
{
  PipeRec* p;
  p = find_pipe(pipe_name); // this also uses the lock.
  if(p != NULL)
  {
	if(p->pipe_width != pipe_width)
        {
	      fprintf(stderr,"\nError: pipeHandler: redefinition of pipe %s with conflicting widths (%d or %d?)\n", pipe_name, p->pipe_width, pipe_width);
		return(1);
        }
	if(p->lifo_mode != lifo_mode)
	{
	      fprintf(stderr,"\nError: pipeHandler: redefinition of pipe %s with conflicting modes (FIFO or LIFO?)\n", pipe_name);
		return(1);
	}
	return(0);
  }

  PipeRec* new_p = (PipeRec*) calloc(1,sizeof(PipeRec));
  new_p->pipe_name = strdup(pipe_name);
  new_p->pipe_width = pipe_width;
  new_p->pipe_depth = pipe_depth;
  new_p->number_of_entries = 0;
  new_p->write_pointer = 0;
  new_p->read_pointer = 0;
  new_p->buffer.ptr8 = (uint8_t*) malloc(((pipe_depth*pipe_width)/8)*sizeof(uint8_t));
  new_p->lifo_mode = lifo_mode;

  ___LOCK___
  new_p->next = pipes;
  pipes = new_p;
  ___UNLOCK___

  if(log_file != NULL)
  {
    __LOCKLOG__
    fprintf(log_file,"\nAdded: %s depth %d width %d lifo_mode %d.", pipe_name,pipe_depth,pipe_width, lifo_mode);
    fflush(log_file);
    __UNLOCKLOG__
  }
  return(0);
}

uint32_t register_port(char* id, int pipe_width, int is_input)
{
  PipeRec* p;
  p = find_pipe(id); // this also uses the lock.
  if(p != NULL)
  {
	if(p->pipe_width != pipe_width)
        {
	      fprintf(stderr,"\nError: pipeHandler: redefinition of pipe %s with conflicting widths (%d or %d?)\n", id, p->pipe_width, pipe_width);
		return(1);
        }
	if(!p->is_port)
	{
	      fprintf(stderr,"\nError: pipeHandler: redefinition of pipe %s with conflicting Port-status )\n", id);
		return(1);
	}
	return(0);
  }

  PipeRec* new_p = (PipeRec*) calloc(1,sizeof(PipeRec));
  new_p->pipe_name = strdup(id);
  new_p->pipe_width = pipe_width;
  new_p->pipe_depth = 1;
  new_p->number_of_entries = 0;
  new_p->write_pointer = 0;
  new_p->read_pointer = 0;
  new_p->buffer.ptr8 = (uint8_t*) malloc(((pipe_width)/8)*sizeof(uint8_t));
  new_p->is_port = 1;

  ___LOCK___
  new_p->next = pipes;
  pipes = new_p;
  ___UNLOCK___

  if(log_file != NULL)
  {
    __LOCKLOG__
    fprintf(log_file,"\nAdded: %s width %d (port).", id, pipe_width);
    fflush(log_file);
    __UNLOCKLOG__
  }
  return(0);
}

uint32_t read_from_pipe(char* pipe_name, int width, int number_of_words_requested, void* burst_payload)
{
  if(log_file != NULL)
  {
    __LOCKLOG__
   fprintf(log_file,"\nInfo: read-request %d word(s) of width %d from pipe %s.\n", number_of_words_requested,width, pipe_name);
    __UNLOCKLOG__
  }


  uint32_t ret_val = 0;
  PipeRec* p = find_pipe(pipe_name);
  if(p == NULL)
  {
	fprintf(stderr,"\nWarning: pipeHandler:read_from_pipe: job used unregistered pipe %s, will register it as a FIFO with depth 1.\n", pipe_name);
	register_pipe(pipe_name,1,width,0);
	p = find_pipe(pipe_name);
  }
  
  if(p->pipe_width != width)
  {
	fprintf(stderr,"\nError: pipeHandler:read_from_pipe: width mismatch in pipe %s (declared %d, requested %d)\n", 
					pipe_name, p->pipe_width, width);
	return 0;
  }

  ___LOCK___
  if(p->is_port)
	ret_val = 1;
  else
  {
	  if(p->number_of_entries >= number_of_words_requested)
	  {
		  ret_val = number_of_words_requested;
	  }
	  else if(p->number_of_entries > 0)
	  {
		  ret_val = p->number_of_entries;
	  }
  }

  if(ret_val > 0)
  {
	  uint32_t idx;
	  uint8_t* ptr = (uint8_t*) burst_payload;
	  for (idx = 0; idx < ret_val; idx++)
	  {
		  ___POP(p,ptr,width);	
		  ptr = ptr + (width/8);
	  }
  }
  ___UNLOCK___

	  if(ret_val > 0)
	  {
		  if(log_file != NULL)
		  {
			  __LOCKLOG__
				  fprintf(log_file,"\nRead: %s %d word(s) of width %d: ", pipe_name, ret_val,width);
			  print_buffer(log_file,(uint8_t*) burst_payload,ret_val*width/8);  
			  __UNLOCKLOG__
		  }
	  }
  return(ret_val);
}

uint32_t write_to_pipe(char* pipe_name, int width, int number_of_words_requested, void* burst_payload)
{
	if(log_file != NULL)
	{
		__LOCKLOG__
			fprintf(log_file,"\nInfo: write-request %d word(s) of width %d to pipe %s.\n", number_of_words_requested,width, pipe_name);
		__UNLOCKLOG__
	}


	uint32_t ret_val = 0;
	PipeRec* p = find_pipe(pipe_name);
	if(p == NULL)
	{
		fprintf(stderr,"\nWarning: pipeHandler:write_to_pipe: job used unregistered pipe %s, will register it as a FIFO with depth 1.\n", pipe_name);
		register_pipe(pipe_name,1,width,0);
		p = find_pipe(pipe_name);
	}

	if(p->pipe_width != width)
	{
		fprintf(stderr,"\nError: pipeHandler:write_to_pipe: width mismatch in pipe %s (declared %d, requested %d)\n", 
				pipe_name, p->pipe_width, width);
		return 0;
	}

	___LOCK___
		int available = __AVAILABLE(p);
	if(available >= number_of_words_requested)
	{
		ret_val = number_of_words_requested;
	}
	else if(available > 0)
	{
		ret_val = available;
	}

	if(ret_val > 0)
	{
		uint32_t idx;
		uint8_t* ptr = (uint8_t*) burst_payload;
		for (idx = 0; idx < ret_val; idx++)
		{
			___PUSH(p,ptr,width);	
			ptr = ptr + (width/8);
		}
	}
	___UNLOCK___

		if(ret_val > 0)
		{
			if(log_file != NULL)
			{
				__LOCKLOG__
					fprintf(log_file,"\nWrote: %s %d word(s) of width %d: ", pipe_name,ret_val,width);
				print_buffer(log_file,(uint8_t*) burst_payload,ret_val*width/8);
				__UNLOCKLOG__
			}
		}

	return(ret_val);
}
