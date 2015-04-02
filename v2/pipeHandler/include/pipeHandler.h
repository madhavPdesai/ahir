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
  int is_port;
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


#define __EMPTY(p) (p->is_port ? 0 : (p->number_of_entries == 0))
#define __FULL(p) (p->is_port ? 0 : (p->number_of_entries ==  p->pipe_depth))
#define __AVAILABLE(p) (p->is_port ? 1 : (p->pipe_depth  - p->number_of_entries))
#define INCR(x,p) x = ((x == (p->pipe_depth-1)) ? 0 : x+1)
#define DECR(x,p) x = ((x == 0) ? (p->pipe_depth - 1) : x-1)
#define POP(p,x,n) {\
			if(p->is_port) {\
				*((uint##n##_t *)x) = p->buffer.ptr##n[0];\
			}\
			else if(p->number_of_entries > 0) {\
				*((uint##n##_t *)x) = p->buffer.ptr##n[p->read_pointer];\
				if(!p->lifo_mode)\
				 	INCR(p->read_pointer,p);\
				else\
				{\
					p->write_pointer = p->read_pointer;\
				  	DECR(p->read_pointer,p);\
				}\
				p->number_of_entries -= 1;\
		    	}\
                   }

#define PUSH(p,x,n) {\
                if(p->is_port) {\
			p->buffer.ptr##n[0] = *((uint##n##_t *) x);\
		}\
		else if(p->number_of_entries < p->pipe_depth) {\
			p->number_of_entries += 1;\
			p->buffer.ptr##n[p->write_pointer] = *((uint##n##_t *) x);\
			if(p->lifo_mode)\
			{\
				p->read_pointer = p->write_pointer;\
			}\
			INCR(p->write_pointer,p); \
		 } }

// init must be called before using pipehandler
void init_pipe_handler();
// init with log-file
void init_pipe_handler_with_log(char* log_file);
// close after your app finishes using the pipehandler
void close_pipe_handler();
// returns 0 on success, 1 if something went wrong..
uint32_t register_pipe(char* pipe_name, int pipe_depth, int pipe_width, int lifo_mode);
// return 0 on success, 1 if something went wrong.
uint32_t register_port(char* id, int pipe_width, int is_input);
// returns the number of words successfully read from the pipe into burst_payload.
uint32_t read_from_pipe(char* pipe_name, int width, int number_of_words_requested, void* burst_payload);
// returns the number of words successfully written to the pipe from burst_payload.
uint32_t write_to_pipe(char* pipe_name, int width, int number_of_words_requested, void* burst_payload);

#endif
