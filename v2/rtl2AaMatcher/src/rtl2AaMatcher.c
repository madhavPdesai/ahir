#include <rtl2AaMatcher.h>
#include <pthreadUtils.h>
#include <string.h>

////////////////////////////////////////// Pipe matching ///////////////////////////////////////////////////

PipeMatcherRec* makePipeMatcher(const char* pipe_name, int pipe_width)
{
	PipeMatcherRec* ret_val;
	ret_val = (PipeMatcherRec*) calloc(1,sizeof(PipeMatcherRec));
	ret_val->_request = 0;
	__allocate_bit_vector( ret_val->_value,pipe_width);
	ret_val->_ack = 0;

	ret_val->_pipe_name  = strdup(pipe_name);
	pthread_mutex_init(&(ret_val->_lock_mutex), NULL);
	
	ret_val->_next = NULL;
}


void setNext(PipeMatcherRec* mrec, PipeMatcherRec* next)
{
	mrec->_next = next;
}

PipeMatcherRec* getNext(PipeMatcherRec* mrec)
{
	return(mrec->_next);
}

// set if v=1, ignore if v=0.
void setRequest(PipeMatcherRec* mrec, char v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	if(v)
		mrec->_request = 1;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

// set if v=1, ignore if v=0.
void setAck(PipeMatcherRec* mrec, char v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	if(v)
		mrec->_ack = v;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

void assignValue(PipeMatcherRec* mrec, bit_vector* v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	bit_vector_bitcast_to_bit_vector(mrec->_value, v);
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

int  getAndClearRequest(PipeMatcherRec* mrec)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	int ret_val = mrec->_request;
	if(ret_val)
		mrec->_request = 0;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
	return(ret_val);
}
int  getAndClearAck(PipeMatcherRec* mrec)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	int ret_val = mrec->_ack;
	if(ret_val)
		mrec->_ack = 0;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
	return(ret_val);
}

bit_vector* getValue(PipeMatcherRec* mrec)
{
	return(mrec->_value);
}

void fetchFromPipe(PipeMatcherRec* mrec)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	read_bit_vector_from_pipe(mrec->_pipe_name, mrec->_value);
	MUTEX_UNLOCK(mrec->_lock_mutex);
}

void sendToPipe(PipeMatcherRec* mrec)
{
	write_bit_vector_to_pipe(mrec->_pipe_name, mrec->_value);
}

char* getPipeName(PipeMatcherRec* mrec)
{
	return(mrec->_pipe_name);
}

// Transfer information from Aa to Rtl
// This is done assuming that the Rtl
// side initiates the read from Aa.
// If req is observed, then a blocking-read from
// the pipe is started (the req is cleared).  
// When the blocking-read has the ack is set 
// (to be cleared by Rtl side).
void Aa2RtlPipeTransferMatcher(void* vmrec)
{
	PipeMatcherRec* mrec = (PipeMatcherRec*) vmrec;
	while(1)
	{
		if(getAndClearRequest(mrec))
		{
			//fprintf(stderr,"Aa2Rtl: cleared request.\n");
			fetchFromPipe(mrec);
			//fprintf(stderr,"Aa2Rtl: received data.\n");
			setAck(mrec,1);
			//fprintf(stderr,"Aa2Rtl: set ack.\n");
		}
		pthread_yield(NULL);
	}
}

//
// When Rtl wants to write, it updates the mrec->_value
// field and sets the req flag.
// The matcher tests the req flag.  If true, it resets
// the req flag, attempts to write to the pipe and
// on completion, sets the ack flag.  The ack flag
// must be cleared by the Rtl side.
//
void Rtl2AaPipeTransferMatcher(void* vmrec)
{
	PipeMatcherRec* mrec = (PipeMatcherRec*) vmrec;
	while(1)
	{
		if(getAndClearRequest(mrec))
		{
			//fprintf(stderr,"Rtl2Aa: cleared request.\n");
			sendToPipe(mrec);
			//fprintf(stderr,"Rtl2Aa: wrote data.\n");
			setAck(mrec,1);
			//fprintf(stderr,"Rtl2Aa: set ack.\n");
		}
		pthread_yield(NULL);
	}
}


/////////////////////////////////////////////////// Signal matching ///////////////////////////////////////////////////
SignalMatcherRec* SignalMatcher(const char* signal_name, int signal_width)
{
	SignalMatcherRec* ret_val;
	ret_val = (SignalMatcherRec*) calloc(1,sizeof(SignalMatcherRec));
	__allocate_bit_vector( ret_val->_value,signal_width);

	ret_val->_signal_name  = strdup(signal_name);
	pthread_mutex_init(&(ret_val->_lock_mutex), NULL);
	
	ret_val->_next = NULL;
}

void setNextSignal(SignalMatcherRec* mrec, SignalMatcherRec* next)
{
	mrec->_next = next;
}

SignalMatcherRec* getNextSignal(SignalMatcherRec* mrec)
{
	return(mrec->_next);
}

void assignSignalValue(SignalMatcherRec* mrec, bit_vector* v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	bit_vector_bitcast_to_bit_vector(mrec->_value, v);
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

bit_vector* getSignalValue(SignalMatcherRec* mrec)
{
	return(mrec->_value);
}

void fetchFromSignal(SignalMatcherRec* mrec)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	read_bit_vector_from_pipe(mrec->_signal_name, mrec->_value);
	MUTEX_UNLOCK(mrec->_lock_mutex);
}

void sendToSignal(SignalMatcherRec* mrec)
{
	write_bit_vector_to_pipe(mrec->_signal_name, mrec->_value);
}

char* getSignalName(SignalMatcherRec* mrec)
{
	return(mrec->_signal_name);
}


// signal to be communicated..
void Aa2RtlSignalTransferMatcher(void* sig_val)
{
	SignalMatcherRec* mrec = (SignalMatcherRec*) sig_val;

	while(1)
	{
		read_bit_vector_from_pipe(mrec->_signal_name, mrec->_value);
		pthread_yield(NULL);
	}
}

void Rtl2AaSignalTransferMatcher(void* sig_val)
{
	SignalMatcherRec* mrec = (SignalMatcherRec*) sig_val;

	while(1)
	{
		write_bit_vector_to_pipe(mrec->_signal_name, mrec->_value);
		pthread_yield(NULL);
	}
}
