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
#include <stdint.h>
#include <rtl2AaMatcher.h>
#include <pipeHandler.h>
#ifdef USE_GNUPTH
#include <pth.h>
#include <GnuPthUtils.h>
#else
#include <pthreadUtils.h>
#endif

PipeMatcherRec* write_matcher;
PipeMatcherRec* read_matcher;
static int counter=0;

typedef struct RtlThreadState_ RtlThreadState;
struct RtlThreadState_
{
	char req;
	char ack;
	bit_vector*  value;	
	int _state;
	int _next_state;
};

void writer_thread_run(RtlThreadState* s, PipeMatcherRec* mrec)
{
	static int first_time = 1;
	static bit_vector counter_bv;
	

	s->_next_state = s->_state;

	if(first_time)
	{
		init_bit_vector(&counter_bv, 32);
		bit_vector_clear(&counter_bv);
		s->value = &(counter_bv);
		first_time = 0;
		s->_state = 0;
	}


	if(s->_state)
	{
		s->req = 1;
		probeMatcher(mrec, 1, 1, &(s->ack), s->value);
		if(s->ack)
		{
			fprintf(stderr,"Thread 1: wrote %llu to pipe %s.\n", 
				bit_vector_to_uint64(0, s->value),
				getPipeName(write_matcher));
			s->_next_state = 0;
		}
	}
	else
	{
		s->req = 0;
		bit_vector_increment(&counter_bv);
		s->_next_state = 1;
	}
}


int reader_thread_run(RtlThreadState* s, PipeMatcherRec* mrec)
{
	static bit_vector counter_bv;
	static int first_time = 1;
	int ret_val = 0;




	if(first_time)
	{
		init_bit_vector(&counter_bv, 32);
		bit_vector_clear(&counter_bv);
		first_time = 0;
		s->_state = 0;
		s->value = &(counter_bv);
	}



	ret_val = 0;

	s->req = 0;
	s->_next_state = s->_state;

	if(s->_state)
	{
		s->req = 1;
		probeMatcher(mrec, 0, 1, &(s->ack), s->value);
		if(s->ack)
		{
			fprintf(stderr,"Thread 2: read %llu from pipe %s.\n",
					bit_vector_to_uint64(0,s->value),
					getPipeName(read_matcher));

			s->_next_state = 0;
			ret_val = 1;
		}
	}
	else
	{
		s->req = 0;
		s->_next_state = 1;
	}
		

	return(ret_val);
}

void rtl_thread_tick(RtlThreadState* s)
{
	s->_state = s->_next_state;
}

void Ticker()
{

	int counter = 0;
	RtlThreadState* t1 = calloc(1, sizeof(RtlThreadState));
	RtlThreadState* t2 = calloc(1, sizeof(RtlThreadState));

	while(1)
	{
		int u = reader_thread_run(t2, read_matcher);
		counter += u;
		writer_thread_run(t1, write_matcher);

		rtl_thread_tick(t1);
		rtl_thread_tick(t2);

		if(counter == 16)
			break;

		PTHREAD_YIELD();
	}
}

	
DEFINE_THREAD(Ticker);
DEFINE_THREAD_WITH_ARG(Rtl2AaPipeTransferMatcher, wm);
DEFINE_THREAD_WITH_ARG(Aa2RtlPipeTransferMatcher, rm);


int main(int argc, char* argv[])
{
	
	write_matcher = makePipeMatcher("test_pipe",32);
	read_matcher  = makePipeMatcher("test_pipe",32);


#ifdef USE_GNUPTH
	pth_init();
#endif
	init_pipe_handler();
	PTHREAD_DECL(Ticker);
	PTHREAD_DECL(Rtl2AaPipeTransferMatcher);
	PTHREAD_DECL(Aa2RtlPipeTransferMatcher);

	PTHREAD_CREATE(Ticker);
	PTHREAD_CREATE_WITH_ARG(Rtl2AaPipeTransferMatcher, write_matcher);
	PTHREAD_CREATE_WITH_ARG(Aa2RtlPipeTransferMatcher, read_matcher);

	PTHREAD_JOIN(Ticker);
	close_pipe_handler();

	return(0);
}

