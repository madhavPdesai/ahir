#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <signal.h>
#ifdef USE_GNUPTH
#include <pth.h>
#include <GnuPthUtils.h>
#else
#include <pthread.h>
#include <pthreadUtils.h>
#endif
#include <pipeHandler.h>

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

MUTEX_DECL(__file_print_mutex__);
uint32_t get_file_print_lock(FILE* fp)
{
	static uint32_t __print_counter__ = 0;
	MUTEX_LOCK(__file_print_mutex__);
	__print_counter__++;
	return(__print_counter__);
}
void release_file_print_lock(FILE* fp)
{
	MUTEX_UNLOCK(__file_print_mutex__);
}

MUTEX_DECL(handler_mutex);
#define ___LOCK___  MUTEX_LOCK(handler_mutex);
#define ___UNLOCK___  MUTEX_UNLOCK(handler_mutex);

MUTEX_DECL(ph_log_mutex);
#define __LOCKLOG__  MUTEX_LOCK(ph_log_mutex);
#define __UNLOCKLOG__  MUTEX_UNLOCK(ph_log_mutex);

int is_lifo_mode(PipeRec* p)
{
	return(p->pipe_mode == PIPE_LIFO_MODE);
}

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

void set_pipe_is_written_into(char* pipe_name)
{
  PipeRec* p;
  p = find_pipe(pipe_name); // this also uses the lock.
  if(p)
    p->is_written_into = 1;
}

void set_pipe_is_read_from(char* pipe_name)
{
  PipeRec* p;
  p = find_pipe(pipe_name); // this also uses the lock.
  if(p)
    p->is_read_from = 1;
}

// iterate through all pipes are report the
// number of dangling pipes.
int check_for_dangling_pipes()
{
  ___LOCK___
  PipeRec* p;
  int ret_val = 0;
  for(p = pipes; p != NULL; p = p->next)
  {
     int err = 0;
     if(!p->is_written_into)
     {
        err = 1;
        fprintf(stderr, "pipe %s is not written into.\n", p->pipe_name);
     }
     if(!p->is_read_from)
     {
	err = 1;
        fprintf(stderr, "pipe %s is not read from.\n", p->pipe_name);
     }
     ret_val += err;
  }
  ___UNLOCK___  
  return(ret_val);
}

// return 0 on success, 1 on error.
uint32_t register_pipe(char* pipe_name, int pipe_depth, int pipe_width, int pipe_mode)
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
	if(p->pipe_depth != pipe_depth)
        {
	      fprintf(stderr,"\nError: pipeHandler: redefinition of pipe %s with conflicting depths (%d or %d?)\n", pipe_name, p->pipe_depth, pipe_depth);
		return(1);
        }
	if(p->pipe_mode != pipe_mode)
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
  new_p->buffer.ptr8 = (uint8_t*) calloc(1, ((pipe_depth*pipe_width)/8)*sizeof(uint8_t));
  new_p->pipe_mode = pipe_mode;

#ifdef USE_GNUPTH
  pth_mutex_init(&(new_p->pm));
#else
  pthread_mutex_init (&(new_p->pm), NULL);
#endif


  ___LOCK___
  new_p->next = pipes;
  pipes = new_p;
  ___UNLOCK___

  if(log_file != NULL)
  {
    __LOCKLOG__
    fprintf(log_file,"\nAdded: %s depth %d width %d pipe_mode %d.", pipe_name,pipe_depth,pipe_width, pipe_mode);
    fflush(log_file);
    __UNLOCKLOG__
  }
  return(0);
}

uint32_t register_port(char* id, int pipe_width, int is_input)
{
	register_signal(id, pipe_width);
}

uint32_t register_signal(char* id, int pipe_width)
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
	if(!p->is_signal)
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
  new_p->buffer.ptr8 = (uint8_t*) calloc(1, ((pipe_width)/8)*sizeof(uint8_t));
  new_p->is_signal = 1;

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

//
// if pipe mode is NOBLOCK, then either send back the
// full chunk of data or send back all zeros.
//
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

  MUTEX_LOCK(p->pm);
  if(p->is_signal)
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

  if((p->pipe_mode == PIPE_FIFO_NON_BLOCK_READ) && (ret_val < number_of_words_requested))
  {
	ret_val = number_of_words_requested;
	bzero(burst_payload, number_of_words_requested*width/8);
  }
  else if(ret_val > 0)
  {
	  uint32_t idx;
	  uint8_t* ptr = (uint8_t*) burst_payload;
	  for (idx = 0; idx < ret_val; idx++)
	  {
		  ___POP(p,ptr,width);	
		  ptr = ptr + (width/8);
	  }
  }
  MUTEX_UNLOCK(p->pm);

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

	MUTEX_LOCK(p->pm);
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
	MUTEX_UNLOCK(p->pm);

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
