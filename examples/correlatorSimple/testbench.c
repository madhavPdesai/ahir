#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include "prog.h"
//
// the next two inclusions are
// to be used in the software version
//  
#ifdef SW
#include <pipeHandler.h>
#include <Pipes.h>
#include <pthreadUtils.h>
#include "prog.h"
#else
#include "vhdlCStubs.h"
#endif

//
//
float ref_vector[ORDER], check_vectors[NUM_VECS][ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

#ifdef SW
DEFINE_THREAD(correlator);
DEFINE_THREAD(slave_0);
#ifdef USE2
DEFINE_THREAD(slave_1);
#endif
#endif

void write_matrices()
{
	uint32_t i,j;
        for(j = 0; j < ORDER; j++) 
	{
		write_float32("ref_vector_pipe", ref_vector[j]);
        	for(i = 0; i < NUM_VECS; i++) 
		{
			write_float32("check_vector_pipe",check_vectors[i][j]);
		}
	}
	fprintf(stderr,"Sent matrices..\n");
}

int bestSolution(float* best_correlation)
{
	int i,j;
	*best_correlation = 0;
	int ret_val = -1;
	for(i = 0; i < NUM_VECS; i++)
	{
		float this_corr = 0.0;
		for(j = 0; j < ORDER; j++)
		{
			this_corr += (ref_vector[j]*check_vectors[i][j]);
		}

		if(this_corr > *best_correlation)
		{
			*best_correlation = this_corr;
			ret_val = i;
		}
	}

	return(ret_val);
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);
  	signal(SIGSEGV, Exit);

        int i,j,k;

        srand48(100);

        for(j = 0; j < ORDER; j++)
	{
		ref_vector[j] = drand48();
        	for(i = 0; i < NUM_VECS; i++)
		{
			check_vectors[i][j] = drand48();
		}
	}

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(correlator);
	PTHREAD_CREATE(correlator);
	PTHREAD_DECL(slave_0);
	PTHREAD_CREATE(slave_0);
#ifdef USE2
	PTHREAD_DECL(slave_1);
	PTHREAD_CREATE(slave_1);
#endif
#endif

	write_matrices();

	float best_corr_from_sw;
	int best_index_from_sw =  bestSolution(&best_corr_from_sw);

	int best_index_from_hw  = read_uint32("best_index_pipe");
	float best_corr_from_hw = read_float32("best_correlation_pipe");


	fprintf(stdout,"results: best_corr = %f (hw), %f (sw).  best_index = %d (hw), %d (sw) \n ",
		best_corr_from_hw, best_corr_from_sw, best_index_from_hw, best_index_from_sw);
	fprintf(stdout,"done\n");

#ifdef SW
	PTHREAD_CANCEL(correlator);
	PTHREAD_CANCEL(slave_0);

#ifdef USE2
	PTHREAD_CANCEL(slave_1);
#endif
	close_pipe_handler();
#endif
}
