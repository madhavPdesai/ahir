#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include "vhdlCStubs.h"

#define ORDER 16
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
		uint32_t X [ORDER];
		for(idx = 0; idx < ORDER; idx++)
			X[idx] = lrand48();
		write_uint32_n("input_port_0", X, ORDER);
	}
}

void Sender_1()
{
	int idx;

	while(1)
	{
		uint32_t X [ORDER];
		for(idx = 0; idx < ORDER; idx++)
			X[idx] = lrand48();
		write_uint32_n("input_port_1", X, ORDER);
	}
}

void Receiver_0()
{
	int idx;
	uint32_t X [ORDER];
	read_uint32_n("output_port_0", X, ORDER);
	for(idx = 0; idx < ORDER; idx++)
	{
		uint32_t rval = X[idx];
		fprintf(stdout,"output_port_0:  received %x\n", rval);
	}
}

void Receiver_1()
{
	int idx;
	uint32_t X [ORDER];
	read_uint32_n("output_port_1", X, ORDER);
	for(idx = 0; idx < ORDER; idx++)
	{
		uint32_t rval = X[idx];
		fprintf(stdout,"output_port_1:  received %x\n", rval);
	}
}

DEFINE_THREAD(Sender_0)
DEFINE_THREAD(Sender_1)
DEFINE_THREAD(Receiver_0)
DEFINE_THREAD(Receiver_1)

int main(int argc, char* argv[])
{
	float result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);


	PTHREAD_DECL(Sender_0);
	PTHREAD_CREATE(Sender_0);
	PTHREAD_DECL(Sender_1);
	PTHREAD_CREATE(Sender_1);
	PTHREAD_DECL(Receiver_0);
	PTHREAD_CREATE(Receiver_0);
	PTHREAD_DECL(Receiver_1);
	PTHREAD_CREATE(Receiver_1);

	
	PTHREAD_JOIN(Receiver_0)
	PTHREAD_JOIN(Receiver_1)

	return(0);
}
