#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif

void maxDaemon();

#ifdef SW
DEFINE_THREAD(maxDaemon)
#endif

int main(int argc, char* argv[])
{
#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(maxDaemon);   // declare the Daemon thread.
	PTHREAD_CREATE(maxDaemon); // start the Daemon..
#endif
	while(1)
	{
		uint32_t a, b;
		scanf("%d", &a);
		scanf("%d", &b);
		write_uint32("in_data",a);
		write_uint32("in_data",b);
		uint32_t c = read_uint32("out_data");
		fprintf(stdout,"Result = %d.\n", c);

		if(a == 0)
			break;
	}

#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(maxDaemon);
#endif
	return(0);
}

