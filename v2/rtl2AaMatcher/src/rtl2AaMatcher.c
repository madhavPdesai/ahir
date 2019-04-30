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
#include <pthread.h>
#include <rtl2AaMatcher.h>
#ifdef USE_GNUPTH
#include <GnuPthUtils.h>
#else
#include <pthreadUtils.h>
#endif
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



void getValue(PipeMatcherRec* mrec, bit_vector* dest)
{
	MUTEX_LOCK(mrec->_lock_mutex);
	bit_vector_bitcast_to_bit_vector(dest, mrec->_value);
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

void fetchFromPipe(PipeMatcherRec* mrec)
{
	bit_vector tmp_val;
	init_bit_vector(&tmp_val, mrec->_value->width);
	
	read_bit_vector_from_pipe(mrec->_pipe_name, &tmp_val);
	assignValue(mrec, &tmp_val);
}

void sendToPipe(PipeMatcherRec* mrec)
{
	bit_vector tmp_val;
	init_bit_vector(&tmp_val, mrec->_value->width);

	getValue(mrec, &tmp_val);
	write_bit_vector_to_pipe(mrec->_pipe_name, &tmp_val);
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
		PTHREAD_YIELD();
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
		PTHREAD_YIELD();
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
				getValue(mrec, access_val);
#ifdef DEBUG
			fprintf(stderr,"probeMatcher: finished pipe-access %s %s %s\n", (write_flag ? "write" : "read"), mrec->_pipe_name, 
								(write_flag ? to_string(access_val) : to_string(mrec->_value)));
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

void getSignalValue(SignalMatcherRec* mrec, bit_vector* dest)
{
	
	MUTEX_LOCK(mrec->_lock_mutex);
	bit_vector_bitcast_to_bit_vector(dest, mrec->_value);
	MUTEX_UNLOCK(mrec->_lock_mutex);	
}

char* getSignalName(SignalMatcherRec* mrec)
{
	return(mrec->_signal_name);
}


// signal to be communicated..
void Aa2RtlSignalTransferMatcher(void* sig_val)
{
	SignalMatcherRec* mrec = (SignalMatcherRec*) sig_val;
	bit_vector tmp_val;
	init_bit_vector(&tmp_val, mrec->_value->width);

	while(1)
	{
	
		read_bit_vector_from_pipe(mrec->_signal_name, &tmp_val);
		assignSignalValue(mrec, &tmp_val);
		PTHREAD_YIELD();
	}
}

void Rtl2AaSignalTransferMatcher(void* sig_val)
{
	SignalMatcherRec* mrec = (SignalMatcherRec*) sig_val;
	bit_vector tmp_val;
	init_bit_vector(&tmp_val, mrec->_value->width);

	while(1)
	{
		getSignalValue(mrec, &tmp_val);
		write_bit_vector_to_pipe(mrec->_signal_name, &tmp_val);
		PTHREAD_YIELD();
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

