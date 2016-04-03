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
	uint16_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = idx;
	}
	write_uint16_n("in_data",val,ORDER);
}

DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	uint16_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	
	read_uint16_n("out_data",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result[%d] = %x.\n", idx, result[idx]);
	}
	PTHREAD_CANCEL(Sender);
	PTHREAD_CANCEL(Sender);
	return(0);
}
