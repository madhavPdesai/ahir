#include <rtl2AaMatcher.h>
#include <pthreadUtils.h>
#include <string.h>


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

void setAck(PipeMatcherRec* mrec, char v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	mrec->_ack = v;
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

void assignValue(PipeMatcherRec* mrec, bit_vector* v)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	bit_vector_bitcast_to_bit_vector(mrec->_value, v);
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

int  getRequest(PipeMatcherRec* mrec)
{
	int ret_val = mrec->_request;
	return(ret_val);
}
int  getAck(PipeMatcherRec* mrec)
{
	int ret_val = mrec->_ack;
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

// Transfer information from Aa to RTL
// This is done assuming that the RTL
// side initiates the read from Aa.
// If req is observed, then a blocking-read from
// the pipe is started (the req is cleared).  
// When the blocking-read has the ack is set 
// (to be cleared by RTL side).
void Aa2RTLPipeTransferMatcher(void* vmrec)
{
	PipeMatcherRec* mrec = (PipeMatcherRec*) vmrec;
	while(1)
	{
		if(getRequest(mrec))
		{
			//fprintf(stderr,"Aa2RTL: got request.\n");
			setRequest(mrec, 0);
			//fprintf(stderr,"Aa2RTL: cleared request.\n");
			read_bit_vector_from_pipe(mrec->_pipe_name, mrec->_value);	
			//fprintf(stderr,"Aa2RTL: received data.\n");
			setAck(mrec,1);
			//fprintf(stderr,"Aa2RTL: set ack.\n");
		}
		pthread_yield(NULL);
	}
}

//
// When RTL wants to write, it updates the mrec->_value
// field and sets the req flag.
// The matcher tests the req flag.  If true, it resets
// the req flag, attempts to write to the pipe and
// on completion, sets the ack flag.  The ack flag
// must be cleared by the RTL side.
//
void RTL2AaPipeTransferMatcher(void* vmrec)
{
	PipeMatcherRec* mrec = (PipeMatcherRec*) vmrec;
	while(1)
	{
		if(getRequest(mrec))
		{
			//fprintf(stderr,"RTL2Aa: got request.\n");
			setRequest(mrec, 0);
			//fprintf(stderr,"RTL2Aa: cleared request.\n");
			write_bit_vector_to_pipe(mrec->_pipe_name, mrec->_value);	
			//fprintf(stderr,"RTL2Aa: wrote data.\n");
			setAck(mrec,1);
			//fprintf(stderr,"RTL2Aa: set ack.\n");
		}
		pthread_yield(NULL);
	}
}
