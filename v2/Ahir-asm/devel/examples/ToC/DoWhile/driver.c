#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include "aa_c_model.h"

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
DEFINE_THREAD(Daemon)

int main(int argc, char* argv[])
{
	uint32_t idx;

	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	init_pipe_handler();

	PTHREAD_DECL(Daemon);
	PTHREAD_CREATE(Daemon);

	for(idx = 0; idx < 8; idx++)
	{
		write_uint32("in_data", idx);
		uint32_t jdx = read_uint32("out_data");
		fprintf(stdout,"Result = %u, expected = %u.\n", jdx, (idx*idx));
	}
	PTHREAD_CANCEL(Daemon);
	close_pipe_handler();
	return(0);
}
