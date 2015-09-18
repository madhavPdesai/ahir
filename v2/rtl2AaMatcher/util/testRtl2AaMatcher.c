#include <stdint.h>
#include <rtl2AaMatcher.h>
#include <pipeHandler.h>
#include <pthreadUtils.h>

PipeMatcherRec* write_matcher;
PipeMatcherRec* read_matcher;
static int counter=0;

typedef struct RtlThreadState_ RtlThreadState;
struct RtlThreadState_
{
	char req;
	char ack;
	int _state;
	int _next_state;
};

void writer_thread_run(RtlThreadState* s)
{
	static int first_time = 1;
	static bit_vector counter_bv;

	s->req = 0;

	if(first_time)
	{
		init_bit_vector(&counter_bv, 32);
		bit_vector_clear(&counter_bv);
		first_time =0;
	}


	if(s->_state)
	{
		
		if(s->ack)
		{
			s->_next_state = 0;
		}
	}
	else
	{
		assignValue(write_matcher,&counter_bv);
		s->req = 1;
		fprintf(stderr,"Thread 1: wrote %llu to pipe %s.\n", 
				bit_vector_to_uint64(0, &counter_bv),
				getPipeName(write_matcher));

		bit_vector_increment(&counter_bv);
		s->_next_state = 1;
	}
		
}


int reader_thread_run(RtlThreadState* s)
{
	static bit_vector counter_bv;
	static int first_time = 1;
	int ret_val = 0;



	s->req = 0;

	if(first_time)
	{
		init_bit_vector(&counter_bv, 32);
		bit_vector_clear(&counter_bv);
		first_time = 0;
	}



	ret_val = 0;
	if(s->_state)
	{
		if(s->ack)
		{
			fprintf(stderr,"Thread 2: read %llu from pipe %s.\n",
					bit_vector_to_uint64(0,getValue(read_matcher)),
					getPipeName(read_matcher));

			s->_next_state = 0;
			ret_val = 1;
		}
	}
	else
	{
		s->req = 1;
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
		t1->ack = getAndClearAck(write_matcher);
		writer_thread_run(t1);
		setRequest(write_matcher,t1->req);

		
		t2->ack = getAndClearAck(read_matcher);
		int u = reader_thread_run(t2);
		counter += u;
		setRequest(read_matcher,t2->req);

		rtl_thread_tick(t1);
		rtl_thread_tick(t2);

		if(counter == 16)
			break;

		pthread_yield();
	}
}

	
DEFINE_THREAD(Ticker);
DEFINE_THREAD_WITH_ARG(RTL2AaPipeTransferMatcher, wm);
DEFINE_THREAD_WITH_ARG(Aa2RTLPipeTransferMatcher, rm);


int main(int argc, char* argv[])
{
	
	write_matcher = makePipeMatcher("test_pipe",32);
	read_matcher  = makePipeMatcher("test_pipe",32);


	init_pipe_handler();
	PTHREAD_DECL(Ticker);
	PTHREAD_DECL(RTL2AaPipeTransferMatcher);
	PTHREAD_DECL(Aa2RTLPipeTransferMatcher);

	PTHREAD_CREATE(Ticker);
	PTHREAD_CREATE_WITH_ARG(RTL2AaPipeTransferMatcher, write_matcher);
	PTHREAD_CREATE_WITH_ARG(Aa2RTLPipeTransferMatcher, read_matcher);

	PTHREAD_JOIN(Ticker);
	close_pipe_handler();

	return(0);
}

