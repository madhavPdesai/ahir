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
float expected_result[ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void gSender()
{
	int idx;
	uint8_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = 1;
	}
	write_uint8_n("guard_pipe",val,ORDER);
}

DEFINE_THREAD(gSender)

	
void Sender()
{
	int idx;
	float val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		float r = drand48();
		val[idx] = r;
		float w = (r + r);
		float x = w*w;
		expected_result[idx] = (x + (x*x));
	}
	write_float32_n("in_data",val,ORDER);
}

DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	float result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);
	PTHREAD_DECL(gSender);
	PTHREAD_CREATE(gSender);

	uint8_t idx;
	
	read_float32_n("out_data",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %f, expected = %f.\n", result[idx],expected_result[idx]);
	}
	PTHREAD_CANCEL(Sender);
	PTHREAD_CANCEL(gSender);
	return(0);
}
