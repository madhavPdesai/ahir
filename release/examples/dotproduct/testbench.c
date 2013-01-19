#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include "vhdlCStubs.h"

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void init();
float dotp_pipelined();
float dotp_nonpipelined();
float dotp_pipelined_unrolled();
float dotp_nonpipelined_unrolled();

int main(int argc, char* argv[])
{
	float result;
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	init();

	result = dotp_pipelined_unrolled();	
	fprintf(stdout,"pipelined-unrolled result = %f.\n", result);

	result = dotp_pipelined();	
	fprintf(stdout,"pipelined result = %f.\n", result);

	result = dotp_nonpipelined_unrolled();	
	fprintf(stdout,"nonpipelined-unrolled result = %f.\n", result);

	result = dotp_nonpipelined();	
	fprintf(stdout,"nonpipelined result = %f.\n", result);

	return(0);
}
