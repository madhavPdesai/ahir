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


int main(int argc, char* argv[])
{
	float result;
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	init();
	fprintf(stdout,"init completed.\n");

#ifdef EXPERIMENTAL
	result = dotp_experimental();	
	fprintf(stdout,"experimental result = %f.\n", result);
#endif

#ifdef PIPELINEDUNROLLED
	fprintf(stdout,"calling dot_pipelined_unrolled.\n");
	result = dotp_pipelined_unrolled();	
	fprintf(stdout,"pipelined-unrolled result = %f.\n", result);
#endif

#ifdef PIPELINED
	result = dotp_pipelined();	
	fprintf(stdout,"pipelined result = %f.\n", result);
#endif

#ifdef NONPIPELINEDUNROLLED
	result = dotp_nonpipelined_unrolled();	
	fprintf(stdout,"nonpipelined-unrolled result = %f.\n", result);
#endif

#ifdef NONPIPELINED
	result = dotp_nonpipelined();	
	fprintf(stdout,"nonpipelined result = %f.\n", result);
#endif

	return(0);
}
