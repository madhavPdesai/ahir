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
	float result;
	float expected_result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(vectorSum);
	PTHREAD_CREATE(vectorSum);
#endif

	uint8_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		float val = drand48();
		expected_result[idx] = 2.0*val;
		write_float32("in_data_pipe",val);
	}


	for(idx = 0; idx < ORDER; idx++)
	{
		result = read_float32("out_data_pipe");
		fprintf(stdout,"Result = %f, expected = %f.\n", result,expected_result[idx]);
	}
#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(vectorSum);
	return(0);
#endif
}
