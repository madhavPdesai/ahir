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
	
void Sender1()
{
	int idx;
	uint8_t op_val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		op_val[idx] = idx;
	}
	write_uint8_n("in_op",op_val,ORDER);
}
DEFINE_THREAD(Sender1)

void Sender2()
{
	int idx;
	uint32_t data[ORDER];
	for(idx = 0; idx < ORDER/2; idx++)
	{
		data[idx] = idx;
	}
	write_uint32_n("in_data",data,ORDER/2);
}
DEFINE_THREAD(Sender2)

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender2);
	PTHREAD_CREATE(Sender2);

	PTHREAD_DECL(Sender1);
	PTHREAD_CREATE(Sender1);

	uint8_t idx;
	uint32_t result[ORDER];
	

	read_uint32_n("out_data", result, ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"%d. Result = 0x%x\n", idx, result[idx]);
	}
	PTHREAD_JOIN(Sender2);
	PTHREAD_JOIN(Sender1);
	return(0);
}
