#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

#ifdef SW
#include <Pipes.h>
#include <pipeHandler.h>
#include <pthreadUtils.h>
#else
#include "vhdlCStubs.h"
#endif

#include "prog.h"

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

#ifdef SW
DEFINE_THREAD(dispatcher);
DEFINE_THREAD(dC00);
DEFINE_THREAD(dC01);
DEFINE_THREAD(dC02);
DEFINE_THREAD(dC03);
DEFINE_THREAD(dC11);
DEFINE_THREAD(dC12);
DEFINE_THREAD(dC13);
DEFINE_THREAD(dC22);
DEFINE_THREAD(dC23);
DEFINE_THREAD(dC33);
#endif


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
	signal(SIGTERM, Exit);


	srand48(NUM_VECS);


#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(dispatcher);
	PTHREAD_DECL(dC00);
	PTHREAD_DECL(dC01);
	PTHREAD_DECL(dC02);
	PTHREAD_DECL(dC03);
	PTHREAD_DECL(dC11);
	PTHREAD_DECL(dC12);
	PTHREAD_DECL(dC13);
	PTHREAD_DECL(dC22);
	PTHREAD_DECL(dC23);
	PTHREAD_DECL(dC33);

	PTHREAD_CREATE(dispatcher);
	PTHREAD_CREATE(dC00);
	PTHREAD_CREATE(dC01);
	PTHREAD_CREATE(dC02);
	PTHREAD_CREATE(dC03);
	PTHREAD_CREATE(dC11);
	PTHREAD_CREATE(dC12);
	PTHREAD_CREATE(dC13);
	PTHREAD_CREATE(dC22);
	PTHREAD_CREATE(dC23);
	PTHREAD_CREATE(dC33);
#endif



	uint32_t idx;	
	// generate and write out the values to the "hardware"
	for(idx = 0; idx < NUM_VECS*VEC_SIZE; idx++)
	{
		write_float32("input_data_pipe", drand48());
	}

	fprintf(stderr,"Info:testbench: wrote the vector arrays to the hardware.\n");


	uint32_t distance = read_uint32("final_result_pipe");
	fprintf(stdout," linearity measure=%d.\n ", distance);

#ifdef SW
	PTHREAD_CANCEL(dispatcher);
	PTHREAD_CANCEL(dC00);
	PTHREAD_CANCEL(dC01);
	PTHREAD_CANCEL(dC02);
	PTHREAD_CANCEL(dC03);
	PTHREAD_CANCEL(dC11);
	PTHREAD_CANCEL(dC12);
	PTHREAD_CANCEL(dC13);
	PTHREAD_CANCEL(dC22);
	PTHREAD_CANCEL(dC23);
	PTHREAD_CANCEL(dC33);
	close_pipe_handler();
#endif

}

