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
#ifndef Pipe_Handler_h__
#define Pipe_Handler_h__

#include <stdlib.h>
#include <stdio.h>  // FILE
#include <stdint.h>
#ifdef USE_GNUPTH
#include <pth.h>
#else
#include <pthread.h>
#endif

#define PIPE_FIFO_MODE  0
#define PIPE_LIFO_MODE  1
#define PIPE_FIFO_NON_BLOCK_READ 2


typedef struct PipeRec_ PipeRec;
struct PipeRec_
{
  char* pipe_name;
  int pipe_depth;
  int pipe_width;
  int watermark;

  int read_pointer;
  int write_pointer;
  int number_of_entries;

  int pipe_mode;
  int is_signal;

  // to check for dangling pipes
  int is_written_into;
  int is_read_from;
#ifdef USE_GNUPTH
  pth_mutex_t pm;
#else
  pthread_mutex_t pm;
#endif
  PipeRec* next;
  union
  {
    uint8_t* ptr8;
    uint16_t* ptr16;
    uint32_t* ptr32;
    uint64_t* ptr64;
  } buffer;

};

int is_lifo_mode(PipeRec* p);

#define __APPEND(lst,lnk) if(lst.tail)		\
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

#define __REMOVE(lst,lnk) if((lst.head == lnk) && (lst.tail == lnk))	\
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


#define __EMPTY(p) (p->is_signal ? 0 : (p->number_of_entries == 0))
#define __FULL(p) (p->is_signal ? 0 : (p->number_of_entries ==  p->pipe_depth))
#define __AVAILABLE(p) (p->is_signal ? p->pipe_depth : (p->pipe_depth  - p->number_of_entries))
#define INCR(x,p) x = ((x == (p->pipe_depth-1)) ? 0 : x+1)
#define DECR(x,p) x = ((x == 0) ? (p->pipe_depth - 1) : x-1)
#define POP(p,x,n) {\
			if(p->is_signal) {\
				*((uint##n##_t *)x) = p->buffer.ptr##n[0];\
			}\
			else if(p->number_of_entries > 0) {\
				*((uint##n##_t *)x) = p->buffer.ptr##n[p->read_pointer];\
				if(!is_lifo_mode(p))\
				 	INCR(p->read_pointer,p);\
				else\
				{\
					p->write_pointer = p->read_pointer;\
				  	DECR(p->read_pointer,p);\
				}\
				p->number_of_entries -= 1;\
		    	}\
                   }

#define POPANDRESTORE(p,x,n) {\
			int old_rp = p->read_pointer;\
			int old_wp  = p ->write_pointer;\
			int old_ne = p->number_of_entries;\
			if(p->is_signal) {\
				*((uint##n##_t *)x) = p->buffer.ptr##n[0];\
			}\
			else if(p->number_of_entries > 0) {\
				*((uint##n##_t *)x) = p->buffer.ptr##n[p->read_pointer];\
				if(!is_lifo_mode(p))\
				 	INCR(p->read_pointer,p);\
				else\
				{\
					p->write_pointer = p->read_pointer;\
				  	DECR(p->read_pointer,p);\
				}\
				p->number_of_entries -= 1;\
		    	}\
			p->read_pointer = old_rp;\
			p->write_pointer = old_rp;\
			p->number_of_entries = old_ne;\
                   }

#define POP_SIGNAL_TO_BUFFER(p,x,n,m) {\
			if(p->is_signal) {\
				int i;\
				for(i=0; i < m; i++) {\
					*(((uint##n##_t *)x) + i) = p->buffer.ptr##n[i];\
				}\
			}\
			else {\
				assert(0);\
			}\
                   }

#define PUSH(p,x,n) {\
                if(p->is_signal) {\
			p->buffer.ptr##n[0] = *((uint##n##_t *) x);\
		}\
		else if(p->number_of_entries < p->pipe_depth) {\
			p->number_of_entries += 1;\
			p->buffer.ptr##n[p->write_pointer] = *((uint##n##_t *) x);\
			if(is_lifo_mode(p))\
			{\
				p->read_pointer = p->write_pointer;\
			}\
			INCR(p->write_pointer,p); \
		 } }

#define PUSH_SIGNAL_FROM_BUFFER(p,x,n,m) {\
			if(p->is_signal) {\
				int i;\
				for(i=0; i < m; i++) {\
					p->buffer.ptr##n[i] = *(((uint##n##_t *)x) + i);\
				}\
			}\
			else\
			{\
				assert(0);\
			}\
		}

// init must be called before using pipehandler
void init_pipe_handler();

// init with log-file
void init_pipe_handler_with_log(char* log_file);

// in strict mode, will assert on strange situations.
void set_pipe_handler_in_strict_mode();

// close after your app finishes using the pipehandler
void close_pipe_handler();

// returns 0 on success, 1 if something went wrong..
//   pipe-modes: 
//      PIPE_FIFO_MODE  0
//      PIPE_LIFO_MODE  1
//      PIPE_FIFO_NON_BLOCK_READ 2
uint32_t register_pipe(char* pipe_name, int pipe_depth, int pipe_width, int pipe_mode);

// set watermark..   if exceeded, emit a warning.
void set_watermark (char* pipe_name, int wmark);

// set pipe status.. this tells the pipe-handler that the pipe
// will be written into or read from 
void set_pipe_is_written_into(char* pipe_name);
void set_pipe_is_read_from(char* pipe_name);
// in a well constructed system, all pipes must
// be written into as well as read from..  
// if not, it is a dangling pipe.
// return the number of dangling pipes.
int  check_for_dangling_pipes();
// return 0 on success, 1 if something went wrong.
// the next two are identical, in register_port, is_input is ignored.
// so you could use either form to register a signal flag.
// (note: reads and writes to signals will always succeed and the
//   last written value is read back).
uint32_t register_port(char* id, int pipe_width, int is_input);
uint32_t register_signal(char* id, int pipe_width);
// returns the number of words successfully read from the pipe into burst_payload.
uint32_t read_from_pipe(char* pipe_name, int width, int number_of_words_requested, void* burst_payload);
// returns the number of words successfully written to the pipe from burst_payload.
uint32_t write_to_pipe(char* pipe_name, int width, int number_of_words_requested, void* burst_payload);
//
// useful to lock/unlock printing across several
// threads. 
//
// flush fp and acquire the lock... return
// a sequence id.. useful for serialization
// of a concurrent trace.
uint32_t get_file_print_lock(FILE* fp);
// flush fp and release the lock.
void release_file_print_lock(FILE* fp);

// generate a string for the value of the pipe.
//  useful for debugging.  The string is allocated
//  inside the function (memory leak alert).
char* pipe_value_to_string(const char* id);

#endif
