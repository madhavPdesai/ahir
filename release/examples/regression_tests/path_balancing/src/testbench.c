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
	
void Sender()
{
	int idx;
	uint32_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = idx;
	}
	write_uint32_n("in_data",val,ORDER);
}
DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	uint32_t result[ORDER];
	

	read_uint32_n("out_data", result, ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"%d. Result = %x, expected %x\n", idx, result[idx], (7*idx) + 2);
	}
	PTHREAD_CANCEL(Sender);
	return(0);
}
