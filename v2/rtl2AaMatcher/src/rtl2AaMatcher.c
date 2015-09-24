#include <rtl2AaMatcher.h>
#include <pthreadUtils.h>
#include <string.h>

////////////////////////////////////////// Pipe matching ///////////////////////////////////////////////////

PipeMatcherRec* makePipeMatcher(const char* pipe_name, int pipe_width)
{
	PipeMatcherRec* ret_val;
	ret_val = (PipeMatcherRec*) calloc(1,sizeof(PipeMatcherRec));
	__allocate_bit_vector( ret_val->_value,pipe_width);

	ret_val->_pipe_name  = strdup(pipe_name);
	pthread_mutex_init(&(ret_val->_lock_mutex), NULL);
	
	ret_val->_state = _IDLE;
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


void setState(PipeMatcherRec* mrec, PipeMatcherState s)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	mrec->_state = s;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

PipeMatcherState getState(PipeMatcherRec* mrec)
{
	return(mrec->_state);
}

void assignValue(PipeMatcherRec* mrec, bit_vector* v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	bit_vector_bitcast_to_bit_vector(mrec->_value, v);
	MUTEX_UNLOCK(mrec->_lock_mutex);	
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

void Aa2RtlPipeTransferMatcher(void* vmrec)
{
	PipeMatcherRec* mrec = (PipeMatcherRec*) vmrec;
#ifdef DEBUG
	fprintf(stderr,"Aa->RTL matcher for pipe %s started.\n", mrec->_pipe_name);
#endif
	while(1)
	{
		PipeMatcherState s = getState(mrec);
		if(s == _ACCESS)
		{
			fetchFromPipe(mrec);
#ifdef DEBUG
			fprintf(stderr,"Aa->RTL matcher for pipe %s read completed returns %s.\n", mrec->_pipe_name, to_string(mrec->_value));
#endif

			setState(mrec, _DONE);
		}
		pthread_yield(NULL);
	}
}

void Rtl2AaPipeTransferMatcher(void* vmrec)
{
	PipeMatcherRec* mrec = (PipeMatcherRec*) vmrec;
#ifdef DEBUG
	fprintf(stderr,"RTL->Aa matcher for pipe %s started.\n", mrec->_pipe_name);
#endif
	while(1)
	{
		PipeMatcherState s = getState(mrec);
		if(s == _ACCESS)
		{
			sendToPipe(mrec);
#ifdef DEBUG
			fprintf(stderr,"Aa->RTL matcher for pipe %s write of %s completed.\n", mrec->_pipe_name, to_string(mrec->_value));
#endif
			setState(mrec, _DONE);
		}
		pthread_yield(NULL);
	}
}


void probeMatcher(PipeMatcherRec* mrec, char write_flag, char req, char* ack, bit_vector* access_val)
{
	PipeMatcherState s = getState(mrec);
	if(s == _DONE)
	{
		if(req)
		{
			*ack = 1;	
			if(!write_flag)
				bit_vector_bitcast_to_bit_vector(access_val, getValue(mrec));
#ifdef DEBUG
			fprintf(stderr,"probeMatcher: finished pipe-access %s %s %s\n", (write_flag ? "write" : "read"), mrec->_pipe_name, 
								(write_flag ? to_string(access_val) : to_string(getValue(mrec))));
#endif

			setState(mrec, _IDLE);
		}
	}
	else if(s == _ACCESS)
	{
		*ack = 0;
	}
	else if(s == _IDLE)
	{
		if(req)
		{
			*ack = 0;
			if(write_flag)
				assignValue(mrec, access_val);
			setState(mrec, _ACCESS);	
		}
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
#ifdef DEBUG
	fprintf(stderr,"Signal %s assigned to %s\n", mrec->_signal_name, to_string(v));
#endif
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

SignalMatcherRec* makeSignalMatcher(const char* signal_name, int pipe_width)
{
	SignalMatcherRec* ret_val;
	ret_val = (SignalMatcherRec*) calloc(1,sizeof(SignalMatcherRec));
	__allocate_bit_vector( ret_val->_value,pipe_width);

	ret_val->_signal_name  = strdup(signal_name);
	pthread_mutex_init(&(ret_val->_lock_mutex), NULL);
	
	ret_val->_next = NULL;
}

