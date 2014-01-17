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

#ifdef SW
DEFINE_THREAD(vectorSum)
#endif
	
int main(int argc, char* argv[])
{
	srand48(819);

	float expected_result[16];
	float result[16];
	float a[16], b[16];

	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(vectorSum);
	PTHREAD_CREATE(vectorSum);
#endif

	int idx;
	for(idx = 0; idx < 16; idx++)
	{
		a[idx] = drand48();
		b[idx] = drand48();
		expected_result[idx] = a[idx] + b[idx];
	}

	for(idx = 0; idx < 16; idx++)
	{
		write_float32("in_data_pipe", a[idx]);
		write_float32("in_data_pipe", b[idx]);
	}


	for(idx = 0; idx < 16; idx++)
	{
		result[idx] = read_float32("out_data_pipe");	
		fprintf(stdout,"Result = %f, expected = %f.\n", result[idx],expected_result[idx]);
	}

#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(vectorSum);
#endif
	return(0);
}
