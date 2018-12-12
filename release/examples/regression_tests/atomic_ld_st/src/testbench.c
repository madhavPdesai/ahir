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

#define ORDER 256

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}
	
int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint16_t idx;
	uint16_t result[ORDER];
	

	read_uint16_n("out_data", result, ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"%d. Result = 0%x\n", idx, result[idx]);
	}
	return(0);
}
