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
#ifdef USE_GNUPTH
#include <pth.h>
#include <GnuPthUtils.h>
#else
#include <pthread.h>
#include <pthreadUtils.h>
#endif
#include <pipeHandler.h>

char __pipe_handler_debug_string_buffer__[4096];

#define ___POP(p,ptr,width) {switch(width) { case 8: POP(p,ptr,8); break;\
						case 16: POP(p,ptr,16); break;\
						case 32: POP(p,ptr,32); break;\
						case 64: POP(p,ptr,64); break;\
						default: break; }} 
#define ___POPANDRESTORE(p,ptr,width) {switch(width) { case 8: POPANDRESTORE(p,ptr,8); break;\
						case 16: POPANDRESTORE(p,ptr,16); break;\
						case 32: POPANDRESTORE(p,ptr,32); break;\
						case 64: POPANDRESTORE(p,ptr,64); break;\
						default: break; }} 
#define ___PUSH(p,ptr,width) {switch(width) { case 8: PUSH(p,ptr,8); break;\
						case 16: PUSH(p,ptr,16); break;\
						case 32: PUSH(p,ptr,32); break;\
						case 64: PUSH(p,ptr,64); break;\
						default: break; }} 
static FILE* log_file = NULL;
static PipeRec* pipes = NULL;
static strict_mode = 0;


void set_pipe_handler_in_strict_mode()
{
	strict_mode  = 1;
}

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

  if(pipe_depth <= 0)
  {
	  fprintf(stderr,"\nWarning: pipeHandler: pipe %s with declared depth %d set to depth=1.\n", pipe_name,
				 pipe_depth);
	  pipe_depth = 1;
  }

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
  new_p->watermark = pipe_depth + 1;
  new_p->number_of_entries = 0;
  new_p->write_pointer = 0;
  new_p->read_pointer = 0;
  new_p->buffer.ptr8 = (uint8_t*) calloc(1, ((pipe_depth*pipe_width)/8)*sizeof(uint8_t));
  new_p->pipe_mode = pipe_mode;
  new_p->next = NULL;

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

  // if pipe width is not a standard c-width, then the pipe
  // is organized as an array of bytes.
  int corrected_pipe_width, corrected_pipe_depth;
  if((pipe_width == 8) || (pipe_width == 16) || (pipe_width == 32) || (pipe_width == 64))
	  corrected_pipe_width = pipe_width;
  else
	  corrected_pipe_width = 8;

  int nwords = (pipe_width/corrected_pipe_width);
  nwords = ((pipe_width % corrected_pipe_width) ? nwords + 1 : nwords);
  int nbytes = ((corrected_pipe_width == 8) ? nwords : (pipe_width/8));

  if(p != NULL)
  {
	  if(p->pipe_width != corrected_pipe_width)
	  {
		  fprintf(stderr,"\nError: pipeHandler: redefinition of pipe %s with conflicting widths (%d or %d?)\n", id, p->pipe_width, corrected_pipe_width);
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
  new_p->pipe_width = corrected_pipe_width;
  new_p->pipe_depth = nwords;
  new_p->number_of_entries = 0;
  new_p->write_pointer = 0;
  new_p->read_pointer = 0;
  new_p->buffer.ptr8 = (uint8_t*) calloc(1, nbytes*sizeof(uint8_t));
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



uint32_t read_from_pipe_base(int pop_flag, const char* pipe_name, int width, int number_of_words_requested, void* burst_payload)
{
	if(pop_flag && (log_file != NULL))
	{
		__LOCKLOG__
			fprintf(log_file,"\nInfo: read-request %d word(s) of width %d from pipe %s.\n", number_of_words_requested,width, pipe_name);
		__UNLOCKLOG__
	}


	uint32_t ret_val = 0;
	PipeRec* p = find_pipe((char*) pipe_name);
	if(p == NULL)
	{
		fprintf(stderr,"\nError: pipeHandler:read_from_pipe: job used unregistered pipe %s, will register it as a FIFO with depth 1.\n", pipe_name);

		if(strict_mode)
			assert(0);

		register_pipe((char*) pipe_name,1,width,0);
		p = find_pipe((char*) pipe_name);
	}

	if(p->pipe_width != width)
	{
		fprintf(stderr,"\nError: pipeHandler:read_from_pipe: width mismatch in pipe %s (declared %d, requested %d)\n", 
				pipe_name, p->pipe_width, width);
		return 0;
	}

	MUTEX_LOCK(p->pm);
	if(p->is_signal)
	{
		ret_val = p->pipe_depth;
		if(ret_val >= number_of_words_requested)
			ret_val = number_of_words_requested;
	}
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
		if(p->is_signal && (p->pipe_depth > 1))
		{
			assert(p->pipe_depth == number_of_words_requested);
			if(width == 8)
			{
				POP_SIGNAL_TO_BUFFER(p,burst_payload,8,number_of_words_requested);
			}
			else if(width == 16)
			{
				POP_SIGNAL_TO_BUFFER(p,burst_payload,16,number_of_words_requested);
			}
			else if(width == 32)
			{
				POP_SIGNAL_TO_BUFFER(p,burst_payload,32,number_of_words_requested);
			}
			else if(width == 64)
			{
				POP_SIGNAL_TO_BUFFER(p,burst_payload,64,number_of_words_requested);
			}
			else
			{
				assert(0);
			}
		}
		else 
		{
			uint32_t idx;
			uint8_t* ptr = (uint8_t*) burst_payload;
			for (idx = 0; idx < ret_val; idx++)
			{
				if(pop_flag)
				{
					___POP(p,ptr,width);	
				}
				else
				{
					___POPANDRESTORE(p,ptr,width);	
				}
				ptr = ptr + (width/8);
			}
		}
	}
	MUTEX_UNLOCK(p->pm);

	if(ret_val > 0)
	{
		if(pop_flag && (log_file != NULL))
		{
			__LOCKLOG__
				fprintf(log_file,"\nRead: %s %d word(s) of width %d: ", pipe_name, ret_val,width);
			print_buffer(log_file,(uint8_t*) burst_payload,ret_val*width/8);  
			__UNLOCKLOG__
		}
	}
	else
	{
		// yield.  so the writer may get a look in.
		PTHREAD_YIELD();
	}
	return(ret_val);
}

char* pipe_value_to_string(const char* pipe_name)
{
	char* str_buf = (char*) __pipe_handler_debug_string_buffer__;

	uint8_t ret_buffer[1024];
	PipeRec* p = find_pipe((char*) pipe_name);
	if(p != NULL)
	{
		int n = ((p->pipe_width/8) +1)*sizeof(uint8_t);

		read_from_pipe_base(0, pipe_name, p->pipe_width, 1, (void*) ret_buffer);

		int I = 0;
		int J;
		for(J = 0; J < n; J++)
		{
			int K;
			for(K=0; K < 8; K++)
			{
				if((ret_buffer[J] >> (7-K)) & 0x1)
					str_buf[I] = '1';
				else
					str_buf[I] = '0';

				I++;

				if(I == p->pipe_width)
					break;
			}
			if(I == p->pipe_width)
				break;
		}
		str_buf[I] = 0;
	}
	return(str_buf);
}

//
// if pipe mode is NOBLOCK, then either send back the
// full chunk of data or send back all zeros.
//
uint32_t read_from_pipe(char* pipe_name, int width, int number_of_words_requested, void* burst_payload)
{
	// first argument is pop flag
	uint32_t ret_val = read_from_pipe_base(1, pipe_name, width, number_of_words_requested, burst_payload);
	return(ret_val);
}

void set_watermark (char* pipe_name,  int wmark)
{
	PipeRec* p = find_pipe(pipe_name);
	if(p != NULL)
	{
		p->watermark = wmark;
	}
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
		fprintf(stderr,"\nError: pipeHandler:write_to_pipe: job used unregistered pipe %s, will register it as a FIFO with depth 1.\n", pipe_name);

		if(strict_mode)
			assert(0);

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
		if(p->is_signal && (p->pipe_depth > 1))
		{
			assert(p->pipe_depth == number_of_words_requested);
			if(width == 8)
			{
				PUSH_SIGNAL_FROM_BUFFER(p,burst_payload,8,number_of_words_requested);
			}
			else if(width == 16)
			{
				PUSH_SIGNAL_FROM_BUFFER(p,burst_payload,16,number_of_words_requested);
			}
			else if(width == 32)
			{
				PUSH_SIGNAL_FROM_BUFFER(p,burst_payload,32,number_of_words_requested);
			}
			else if(width == 64)
			{
				PUSH_SIGNAL_FROM_BUFFER(p,burst_payload,64,number_of_words_requested);
			}
			else
			{
				assert(0);
			}
		}
		else
		{
			uint32_t idx;
			uint8_t* ptr = (uint8_t*) burst_payload;
			for (idx = 0; idx < ret_val; idx++)
			{
				___PUSH(p,ptr,width);	
				ptr = ptr + (width/8);
			}
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
		if(!p->is_signal && (p->number_of_entries >= p->watermark))
		{
			fprintf(stderr,"\nInfo:pipeHandler: watermark on pipe %s reached.\n", pipe_name);
		}
	}
	else
	{
		// yield.  so the reader may get a look in.
		PTHREAD_YIELD();
	}



	return(ret_val);
}
