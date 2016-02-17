#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif

#define ORDER 16

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}
	
void Sender_1()
{
	int idx;
	uint8_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = (2*idx)+1;
	}
	write_uint8_n("in_data_1",val,ORDER);
}
DEFINE_THREAD(Sender_1)

void Sender_2()
{
	int idx;
	uint8_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = (2*idx)+1;
	}
	write_uint8_n("in_data_2",val,ORDER);
}
DEFINE_THREAD(Sender_2)

void Sender_3()
{
	int idx;
	uint8_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = (2*idx)+1;
	}
	write_uint8_n("in_data_3",val,ORDER);
}
DEFINE_THREAD(Sender_3)

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender_1);
	PTHREAD_CREATE(Sender_1);
	PTHREAD_DECL(Sender_2);
	PTHREAD_CREATE(Sender_2);
	PTHREAD_DECL(Sender_3);
	PTHREAD_CREATE(Sender_3);

	uint8_t idx;
	

	for(idx = 0; idx < ORDER; idx++)
	{
		uint8_t rv = read_uint8("out_data");
		fprintf(stdout,"%d. Result = %x,\n", idx, rv);
	}
	PTHREAD_CANCEL(Sender_1);
	PTHREAD_CANCEL(Sender_2);
	PTHREAD_CANCEL(Sender_3);
	return(0);
}
