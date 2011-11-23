#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include "vhdlCStubs.h"
void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *counter_(void* fargs)
{
   counter();
}

void *write_pipe_(void* a)
{
	write_uint8_n("in_data",(uint8_t*)a, 4);
}

void *read_pipe_(void* a)
{
	read_uint8_n("out_data", (uint8_t*)a, 4);
}


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint8_t pipe_in[4], pipe_out[4];
        int i;

	pipe_in[0] = 0;
        for(i = 1; i < 4; i++)
		pipe_in[i] = 1;

	// in parallel, start foo and bar.
	pthread_t counter_t, wpipe_t, rpipe_t, rpipe_valid_t;

	//
	// No need to start counter... it is an auto-run
	// module..
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)pipe_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)pipe_out);


	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);


 	fprintf(stdout,"from out_data, we read ");
        for(i = 0; i < 4; i++) 
 	   fprintf(stdout," %d\n ",  pipe_out[i]);
	fprintf(stdout,"\n");

}
