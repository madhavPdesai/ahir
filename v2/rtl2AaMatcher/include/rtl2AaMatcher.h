#ifndef rtl2AaMatcher_h__
#define rtl2AaMatcher_h__
#include <BitVectors.h>

typedef enum
{
	_IDLE,
	_ACCESS,
	_DONE
} PipeMatcherState;;

typedef struct _PipeMatcherRec PipeMatcherRec;
struct _PipeMatcherRec
{
	
	bit_vector* _value;

	char*  _pipe_name;
	pthread_mutex_t _lock_mutex;


	PipeMatcherState  _state;

	PipeMatcherRec* _next;
};
PipeMatcherRec* makePipeMatcher(const char* pipe_name, int pipe_width);

typedef struct _SignalMatcherRec SignalMatcherRec;
struct _SignalMatcherRec
{
	
	bit_vector* _value;
	char*  _signal_name;

	pthread_mutex_t _lock_mutex;


	SignalMatcherRec* _next;
};
SignalMatcherRec* makeSignalMatcher(const char* signal_name, int signal_width);

void setNext(PipeMatcherRec* mrec, PipeMatcherRec* next);
PipeMatcherRec* getNext(PipeMatcherRec* mrec);


//   if(state == IDLE)
//   {
//      if(req == 1) 
//      {
//          ack = false. 
//          set state = BUSY  (pipe-access started with write-data).
//      }
//   }
//   else if(state == BUSY)
//   {
//      ack = false
//   }
//     (set state = DONE when pipe-access finished).
//   else if(state == DONE)
//   {
//      ack = true;
//      state = IDLE.
//   }  
void probeMatcher(PipeMatcherRec* mrec, char write_flag, char req, char* ack, bit_vector* write_val);


void setState(PipeMatcherRec* mrec, PipeMatcherState s);
PipeMatcherState getState(PipeMatcherRec* mrec);

void assignValue(PipeMatcherRec* mrec, bit_vector* v);


bit_vector* getValue(PipeMatcherRec* mrec);
void fetchFromPipe(PipeMatcherRec* mrec);
void sendToPipe(PipeMatcherRec* mrec);
char* getPipeName(PipeMatcherRec* mrec);

void Aa2RtlPipeTransferMatcher(void* mrec);
void Rtl2AaPipeTransferMatcher(void* mrec);

void setNextSignal(SignalMatcherRec* mrec, SignalMatcherRec* next);
SignalMatcherRec* getNextSignal(SignalMatcherRec* mrec);
void assignValueS(SignalMatcherRec* mrec, bit_vector* v);
bit_vector* getSignalValue(SignalMatcherRec* mrec);
void fetchFromSignal(SignalMatcherRec* mrec);
void sendToSignal(SignalMatcherRec* mrec);
char* getSignalName(SignalMatcherRec* mrec);

void Aa2RtlSignalTransferMatcher(void* sig_val);
void Rtl2AaSignalTransferMatcher(void* sig_val);


#endif
