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
#include <stdint.h>

typedef struct PipeRec_ PipeRec;
struct PipeRec_
{
  char* pipe_name;
  int pipe_depth;
  int pipe_width;

  int read_pointer;
  int write_pointer;
  int number_of_entries;

  int lifo_mode;
  int is_input;
  int is_port;
  int is_pulse;

  PipeRec* next;
  union
  {
    uint8_t* ptr8;
    uint16_t* ptr16;
    uint32_t* ptr32;
    uint64_t* ptr64;
  } buffer;

  uint8_t is_written_into;
  uint8_t is_read_from;
};

typedef struct _PipeJob PipeJob;
struct _PipeJob
{
  char* pipe_name;
  PipeRec* pipe_record;
  int word_length;
  int words_requested;
  int words_served;

  int socket_id;
  uint64_t index;
  PipeJob* next;
  PipeJob* prev;
  union
  {
    uint8_t* ptr8;
    uint16_t* ptr16;
    uint32_t* ptr32;
    uint64_t* ptr64;
  } buffer;

  uint8_t read_write_bar; // 1 if read, 0 if write.
  uint8_t is_burst_access;
};

typedef struct _PipeJobList PipeJobList;
struct _PipeJobList
{
  PipeJob* head;
  PipeJob* tail;
};

// Pipe_Handler can be used to manage pipes 
// in a SW application..  It creates a server
// and listens for pipe requests until kingdom
// come.  Also keeps tracks of pipes..
void pipeHandler();
void killPipeHandler();

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

#define __EMPTY(p) (p->number_of_entries == 0)
#define __FULL(p) (p->number_of_entries ==  p->pipe_depth)
#define INCR(x,p) x = ((x == (p->pipe_depth-1)) ? 0 : x+1)
#define POP(p,x,n) {\
			if(p->is_port) {\
				*x = p->buffer.ptr##n[0];\
                        }\
			else if(p->number_of_entries > 0) {\
				*x = p->buffer.ptr##n[p->read_pointer];\
				if(!p->lifo_mode)\
				 	INCR(p->read_pointer,p);\
				else\
				{\
					p->write_pointer -= 1;\
					if(p->write_pointer > 0)\
						p->read_pointer = p->write_pointer - 1;\
					else\
						p->read_pointer =  0;\
				}\
				p->number_of_entries -= 1;\
		    	}\
                   }

#define PUSH(p,x,n) {\
		if(p->is_port) {\
			p->buffer.ptr##n[0] = x;\
                }\
		else if(p->number_of_entries < p->pipe_width) {\
			p->number_of_entries += 1;\
			p->buffer.ptr##n[p->write_pointer] = x;\
			INCR(p->write_pointer,p); \
			if(p->lifo_mode)\
			{\
				p->read_pointer = p->write_pointer - 1;\
			}\
		 } }


uint8_t pop8(PipeRec* p);
uint16_t pop16(PipeRec* p);
uint32_t pop32(PipeRec* p);
uint64_t pop64(PipeRec* p);

void push8(PipeRec* p, uint8_t x);
void push16(PipeRec* p, uint16_t x);
void push32(PipeRec* p, uint32_t x);
void push64(PipeRec* p, uint64_t x);

void set_pipe_is_written_into(char* pipe_name);
void set_pipe_is_read_from(char* pipe_name);
// return number of dangling pipes.
// (those that are either not written into or not read from or both)
int  check_for_dangling_pipes();
// flush fp and acquire the lock... return
// a sequence id.. useful for serialization
// of a concurrent trace.
uint32_t get_file_print_lock(FILE* fp);
// flush fp and release the lock.
void release_file_print_lock(FILE* fp);
#endif
