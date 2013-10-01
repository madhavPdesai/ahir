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

	
void Sender()
{
	int idx;
	srand48(819);

	for(idx = 0; idx < 4*ORDER; idx++)
	{
		float val = drand48();
		write_float32("in_data_pipe",val);
	}
}

#ifdef SW
DEFINE_THREAD(fir)
DEFINE_THREAD(summer)
#endif
DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	float result;
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(fir);
	PTHREAD_CREATE(fir);
	PTHREAD_DECL(summer);
	PTHREAD_CREATE(summer);
#endif
	int I;
	for(I = 0; I < ORDER; I++)
		write_float32("coeff_pipe", 1.0);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	for(I = 0; I < 4*ORDER; I++)
	{
		result = read_float32("out_data_pipe");
		fprintf(stdout,"Result[%d] = %f.\n", I, result);
	}
	PTHREAD_CANCEL(Sender);
#ifdef SW
	PTHREAD_CANCEL(fir);
	PTHREAD_CANCEL(summer);
	close_pipe_handler();
	return(0);
#endif
}
