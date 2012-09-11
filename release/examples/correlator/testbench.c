#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

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
DEFINE_THREAD(master);
DEFINE_THREAD(correlater_0);
DEFINE_THREAD(correlater_1);
DEFINE_THREAD(correlater_2);
DEFINE_THREAD(correlater_3);
DEFINE_THREAD(result_counter);
#endif


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	float best_corr = 0.0;

#ifdef SW
	init_pipe_handler();

	PTHREAD_DECL(master);
	PTHREAD_DECL(correlater_0);
	PTHREAD_DECL(correlater_1);
	PTHREAD_DECL(correlater_2);
	PTHREAD_DECL(correlater_3);
	PTHREAD_DECL(result_counter);

	PTHREAD_CREATE(master);
	PTHREAD_CREATE(correlater_0);
	PTHREAD_CREATE(correlater_1);
	PTHREAD_CREATE(correlater_2);
	PTHREAD_CREATE(correlater_3);
	PTHREAD_CREATE(result_counter);
#endif
	uint32_t idx;	
	for(idx = 0; idx < ORDER; idx++)
	{
		// the same value is passed to both arrays.
		write_float32("data_in", (float) idx);
		write_float32("data_in", (float) idx);

		best_corr += ((float) idx)*((float) idx);
	}


        float corr = read_float32("best_correlation");
	uint32_t offs = read_uint32("best_offset");
  	fprintf(stdout," best correlation=%f, expected %f.\n ", corr, best_corr);
  	fprintf(stdout," best offset=%d, expected 0.\n ", offs);

#ifdef SW
	PTHREAD_CANCEL(master);
	PTHREAD_CANCEL(correlater_0);
	PTHREAD_CANCEL(correlater_1);
	PTHREAD_CANCEL(correlater_2);
	PTHREAD_CANCEL(correlater_3);
	PTHREAD_CANCEL(result_counter);
	close_pipe_handler();
#endif

							
}
   
