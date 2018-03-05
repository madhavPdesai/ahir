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

	
float expected_result[ORDER];
void Sender()
{
	int idx;
	float val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = drand48();
		expected_result[idx] = (val[idx])*(val[idx] + 1.0);
	}
	write_float32_n("a_pipe",val,ORDER);
}

#ifdef SW
DEFINE_THREAD(vectorSum)
#endif
DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	float result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(vectorSum);
	PTHREAD_CREATE(vectorSum);
#endif
	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	
	read_float32_n("result_pipe",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %f, expected = %f.\n", result[idx],expected_result[idx]);
	}
	PTHREAD_CANCEL(Sender);
#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(vectorSum);
#endif
	return(0);
}
