#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#ifdef USE_GNUPTH
#include <pth.h>
#include <GnuPthUtils.h>
#else
#include <pthread.h>
#include <pthreadUtils.h>
#endif 
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
		expected_result[idx] = (val[idx] + 1);
	}
	write_uint64_n("in_data", ((uint64_t*) val),ORDER/2);
}

#ifdef SW
DEFINE_THREAD(conversionTest)
#endif
DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	float result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
#ifdef USE_GNUPTH
	pth_init();
#endif
	init_pipe_handler();
	PTHREAD_DECL(conversionTest);
	PTHREAD_CREATE(conversionTest);
#endif
	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	


	read_uint64_n("out_data",((uint64_t*) result),ORDER/2);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %f, expected = %f.\n", result[idx],expected_result[idx]);
	}
	PTHREAD_CANCEL(Sender);
#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(conversionTest);
#endif
	return(0);
}
