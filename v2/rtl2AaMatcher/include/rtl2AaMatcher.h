#ifndef rtl2AaMatcher_h__
#define rtl2AaMatcher_h__
#include <BitVectors.h>

typedef struct _PipeMatcherRec PipeMatcherRec;
struct _PipeMatcherRec
{
	
	char	   _request;
	bit_vector* _value;
	char	   _ack;
	

	char*  _pipe_name;
	pthread_mutex_t _lock_mutex;


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
void setRequest(PipeMatcherRec* mrec, char v);
void setRequestAndAssignValue(PipeMatcherRec* mrec, char v, bit_vector* val);
void setAck(PipeMatcherRec* mrec, char v);
int  getAck(PipeMatcherRec* mrec);
void assignValue(PipeMatcherRec* mrec, bit_vector* v);

int  testAndClearRequest(PipeMatcherRec* mrec);
int  testAndClearAck(PipeMatcherRec* mrec);
int  testAndClearAckAndUpdateData(PipeMatcherRec* mrec, bit_vector* v);

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
