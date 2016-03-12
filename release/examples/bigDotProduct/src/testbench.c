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

#define ORDER 1024
uint32_t result[ORDER];
float expected_result[ORDER];
float A[ORDER];
float B[ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Sender()
{
	int idx;
	
	for (idx = 0; idx < ORDER; idx++)
	{
		A[idx] = drand48();
		B[idx] = drand48();
		expected_result[idx] = A[idx] * B[idx];
		write_uint32("in_data",*((uint32_t*) &A[idx]));
	}

	for (idx = 0; idx < ORDER; idx++)
	{
		write_uint32("in_data",*((uint32_t*) &B[idx]));
	}
}


DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
	signal(SIGTERM, Exit);
	int idx;
	int expected, diff;
	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	for(idx = 0; idx < ORDER; idx++)
	{
		result[idx] = read_uint32("out_data");
		expected = *((uint32_t*) &expected_result[idx]);
		diff = result[idx] - expected;
		fprintf(stdout,"Result = %x, expected = %x, diff = %d.\n", result[idx], expected,diff);

	}

	PTHREAD_CANCEL(Sender);

	return(0);
}
