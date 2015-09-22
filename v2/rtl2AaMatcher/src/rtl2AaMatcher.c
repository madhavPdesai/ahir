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

void setRequest(PipeMatcherRec* mrec, char v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	mrec->_request = v;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

void setRequestAndAssignValue(PipeMatcherRec* mrec, char v, bit_vector* val)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	mrec->_request = v;
	if(v)
	{
		bit_vector_bitcast_to_bit_vector(mrec->_value, val);
	}
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

int getAck(PipeMatcherRec* mrec)
{
	return(mrec->_ack);
}

void assignValue(PipeMatcherRec* mrec, bit_vector* v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	bit_vector_bitcast_to_bit_vector(mrec->_value, v);
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

int  testAndClearRequest(PipeMatcherRec* mrec)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	int ret_val = mrec->_request;
	if(ret_val)
		mrec->_request = 0;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
	return(ret_val);
}
int  testAndClearAck(PipeMatcherRec* mrec)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	int ret_val = mrec->_ack;
	if(ret_val)
		mrec->_ack = 0;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
	return(ret_val);
}

int  testAndClearAckAndUpdateData(PipeMatcherRec* mrec, bit_vector* v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	int ret_val = mrec->_ack;
	if(ret_val)
	{
		mrec->_ack = 0;
		bit_vector_bitcast_to_bit_vector(v,mrec->_value);
	}
	MUTEX_UNLOCK(mrec->_lock_mutex);	
	return(ret_val);
}


bit_vector* getValue(PipeMatcherRec* mrec)
{
	return(mrec->_value);
}

void fetchFromPipe(PipeMatcherRec* mrec)
{
	read_bit_vector_from_pipe(mrec->_pipe_name, mrec->_value);
}

void sendToPipe(PipeMatcherRec* mrec)
{
	write_bit_vector_to_pipe(mrec->_pipe_name, mrec->_value);
}

char* getPipeName(PipeMatcherRec* mrec)
{
	return(mrec->_pipe_name);
}

//
//  When the RTL side wants to read, it sets the req.
//
//  The matcher checks the req and if asserted,
//  the pipe is accessed, and the ack is set
//  by the matcher.  The matcher then waits
//  until the ack is cleared before checking
//  the req once again.
//
//  Thus, the matcher will not start a new transfer until
//  the current transfer has completed.
//
void Aa2RtlPipeTransferMatcher(void* vmrec)
{
	PipeMatcherRec* mrec = (PipeMatcherRec*) vmrec;
	fprintf(stderr,"Aa->RTL matcher for pipe %s started.\n", mrec->_pipe_name);
	while(1)
	{
		if(testAndClearRequest(mrec))
		{
			fprintf(stderr,"read-request to pipe %s started.\n", mrec->_pipe_name);
			fetchFromPipe(mrec);
			fprintf(stderr,"read-request to pipe %s done (data = %s).\n", mrec->_pipe_name,
					to_string(mrec->_value));
			setAck(mrec,1);
			
			// wait until Ack goes low.
			while(1)
			{
				if(getAck(mrec) == 0)
					break;
				else
					pthread_yield(NULL);
			}
			fprintf(stderr,"read-request to pipe %s cycle completed.\n", mrec->_pipe_name);
		}
		pthread_yield(NULL);
	}
}

//
// When Rtl wants to write, it updates the mrec->_value
// field and sets the req flag.
// The matcher tests the req flag.  If true, 
// it attempts to write to the pipe and
// on completion, sets the ack flag.  The ack flag
// must be cleared by the Rtl side in order
// to restart the cycle.
//
// (Note: this ensures that even if the Rtl side
//        maintains the req to high, the matcher
//        will not initiate a new pipe request until
//        the entire pipe access cycle has completed).
//
void Rtl2AaPipeTransferMatcher(void* vmrec)
{
	PipeMatcherRec* mrec = (PipeMatcherRec*) vmrec;
	fprintf(stderr,"RTL->Aa matcher for pipe %s started.\n", mrec->_pipe_name);
	while(1)
	{
		if(testAndClearRequest(mrec))
		{
			fprintf(stderr,"write-request to pipe %s started (data = %s).\n", mrec->_pipe_name,to_string(mrec->_value));
			sendToPipe(mrec);
			fprintf(stderr,"write-request to pipe %s done.\n", mrec->_pipe_name);
			setAck(mrec,1);

			while(1)
			{
				if(getAck(mrec) == 0)
					break;
				else
					pthread_yield(NULL);
			}
			fprintf(stderr,"write-request to pipe %s cycle completed.\n", mrec->_pipe_name);
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
