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
		expected_result[idx] = (2.0*val[idx])*val[idx];
		//expected_result[idx] = (2.0*val[idx]);
	}
	write_float32_n("in_data_pipe",val,ORDER);
}

#ifdef SW
DEFINE_THREAD(vectorSum)
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
	PTHREAD_DECL(vectorSum);
	PTHREAD_CREATE(vectorSum);
#endif
	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	


	read_float32_n("out_data_pipe",result,ORDER);

	int err_flag = 0;
	for(idx = 0; idx < ORDER; idx++)
	{
		// result[idx] = read_float32("out_data_pipe");

		uint32_t r = *((uint32_t*) &(result[idx]));
		uint32_t e = *((uint32_t*) &(expected_result[idx]));

		fprintf(stdout,"Result = %f (0x%x), expected = %f (0x%x)\n", result[idx],r,
									expected_result[idx],e);

		err_flag = (r != e) || err_flag;
	}
	PTHREAD_CANCEL(Sender);
#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(vectorSum);
#endif
	if(err_flag)
	{
		fprintf(stderr, "There were errors.\n");
	}
	else
	{
		fprintf(stderr, "There were no errors.\n");
	}
	return(0);
}
