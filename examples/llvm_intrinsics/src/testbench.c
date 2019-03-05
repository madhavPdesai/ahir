#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifdef SW
#include <pthreadUtils.h>
#else
#include "vhdlCStubs.h"
#endif

#ifdef SW
DEFINE_THREAD(runDaemon)
#endif

int main(int argc, char* argv[])
{

#ifdef SW
PTHREAD_DECL(runDaemon)
PTHREAD_CREATE(runDaemon)
#endif

	uint32_t idx;
	for(idx = 0; idx < 16; idx++)
	{
		write_uint32("in_pipe", idx);
	}

	fprintf(stderr, "Observed:\t");
	for(idx = 0; idx < 16; idx++)
	{
		uint32_t fidx = read_uint32("out_pipe");
		fprintf(stderr," %d", fidx);
	}
	fprintf(stderr,"\n");
	fprintf(stderr,"Expected:\t 4 5 6 7 4 5 6 8 9 9 10 11 10 11 0 0\n");

	return(0);
}

