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

#define ORDER 64
float expected_result[ORDER/4];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Sender()
{
	int idx;
	float val[ORDER];
	for(idx = 0; idx < ORDER; idx = idx + 4)
	{
		val[idx] = drand48();
		val[idx+1] = drand48();
		val[idx+2] = drand48();
		val[idx+3] = drand48();
		expected_result[idx/4] = 
			(val[idx]*val[idx]) + (val[idx+1]*val[idx+1]) + 
				(val[idx+2]*val[idx+2]) + (val[idx+3]*val[idx+3]);
	}
	write_float32_n("in_data",val,ORDER);
}

DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	float result[ORDER/4];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	
	read_float32_n("out_data",result,ORDER/4);

	for(idx = 0; idx < ORDER/4; idx++)
	{
		fprintf(stdout,"Result = %f, expected = %f.\n", result[idx],expected_result[idx]);
	}
	PTHREAD_CANCEL(Sender);
	return(0);
}
