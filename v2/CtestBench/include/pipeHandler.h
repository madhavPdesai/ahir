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

  int top_pointer;
  int bottom_pointer;
  int number_of_entries;

  PipeRec* next;
  union
  {
    uint8_t* ptr8;
    uint16_t* ptr16;
    uint32_t* ptr32;
    uint64_t* ptr64;
  } buffer;
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

#define INCR(x,p) { ((x == (p->pipe_depth-1)) ? 0 : x+1); }
#define POP(p,x,n) {*x = p->buffer.ptr##n[p->top_pointer]; INCR(p->top_pointer,p);  p->number_of_entries -= 1;}
#define PUSH(p,x,n) {p->buffer.ptr##n[p->bottom_pointer] = x; INCR(p->bottom_pointer,p); p->number_of_entries += 1; }
#define __EMPTY(p) (p->number_of_entries == 0)
#define __FULL(p) (p->number_of_entries ==  p->pipe_depth)

uint8_t pop8(PipeRec* p);
uint16_t pop16(PipeRec* p);
uint32_t pop32(PipeRec* p);
uint64_t pop64(PipeRec* p);

void push8(PipeRec* p, uint8_t x);
void push16(PipeRec* p, uint16_t x);
void push32(PipeRec* p, uint32_t x);
void push64(PipeRec* p, uint64_t x);

#endif
