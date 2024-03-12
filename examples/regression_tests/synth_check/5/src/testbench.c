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
uint32_t expected_result[ORDER];

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
		expected_result[idx] = (idx == 0) ? 0 : (idx + expected_result[idx-1]);
	}
	write_uint32_n("input_data",val,ORDER);
}

DEFINE_THREAD(Sender)
	

int main(int argc, char* argv[])
{
	uint32_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	read_uint32_n("output_data",result,ORDER);

	int idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %x, expected = %x.\n", result[idx],expected_result[idx]);
	}
	PTHREAD_CANCEL(Sender);

	return(0);
}
