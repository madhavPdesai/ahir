#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include "prog.h"
#ifndef SW
#include "vhdlCStubs.h"
#endif

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void Sender_0()
{
	int idx;
	
	while(1)
	{
		uint32_t rval = lrand48();
		write_uint32("input_port_0",rval);
		fprintf(stdout,"input_port_0:  sent %x\n", rval);
	}
}

void Sender_1()
{
	int idx;
	
	while(1)
	{
		uint32_t rval = lrand48();
		write_uint32("input_port_1",rval);
		fprintf(stdout,"input_port_1:  sent %x\n", rval);
	}
}

void Receiver_0()
{
	int idx;
	
	while(1)
	{
		uint32_t rval = read_uint32("output_port_0");
		fprintf(stdout,"output_port_0:  received %x\n", rval);
	}
}

void Receiver_1()
{
	int idx;
	
	while(1)
	{
		uint32_t rval = read_uint32("output_port_1");
		fprintf(stdout,"output_port_1:  received %x\n", rval);
	}
}

#ifdef SW
DEFINE_THREAD(inputPort_0)
DEFINE_THREAD(inputPort_1)
#endif
DEFINE_THREAD(Sender_0)
DEFINE_THREAD(Sender_1)
DEFINE_THREAD(Receiver_0)
DEFINE_THREAD(Receiver_1)

int main(int argc, char* argv[])
{
	float result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);


#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(inputPort_0);
	PTHREAD_CREATE(inputPort_0);
	PTHREAD_DECL(inputPort_1);
	PTHREAD_CREATE(inputPort_1);
#endif
	PTHREAD_DECL(Sender_0);
	PTHREAD_CREATE(Sender_0);
	PTHREAD_DECL(Sender_1);
	PTHREAD_CREATE(Sender_1);
	PTHREAD_DECL(Receiver_0);
	PTHREAD_CREATE(Receiver_0);
	PTHREAD_DECL(Receiver_1);
	PTHREAD_CREATE(Receiver_1);

	uint8_t c = getchar();
	
	PTHREAD_CANCEL(Sender_0);
	PTHREAD_CANCEL(Sender_1);
	PTHREAD_CANCEL(Receiver_0)
	PTHREAD_CANCEL(Receiver_1)
#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(inputPort_0);
	PTHREAD_CANCEL(inputPort_1);
#endif
	return(0);
}
