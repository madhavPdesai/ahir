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
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(vectorSum);
	PTHREAD_CREATE(vectorSum);
#endif


	write_uint32("in_data",1);
	write_uint32("in_data",2);
	write_uint32("in_data",3);
	write_uint32("in_data",4);

	uint32_t rval = read_uint32("out_data");
	fprintf(stdout,"Result = %d.\n", rval);

#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(vectorSum);
#endif
	return(0);
}
