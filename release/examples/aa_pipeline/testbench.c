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

void *io_module_(void* fargs)
{
   io_module();
}

void *write_pipe_(void* a)
{
	write_uint32_n("in_data",(uint32_t*)a, 100);
}

void *read_pipe_(void* a)
{
	read_uint32_n("out_data", (uint32_t*)a, 96);
}

void *read_valid_pipe_(void* a)
{
	read_uint8_n("out_valid", (uint8_t*)a, 96);
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint32_t pipe_in[100], pipe_out[100];
	uint8_t out_valid_pipe[100];
        int i;

        for(i = 0; i < 100; i++)
		pipe_in[i] = i;

	// in parallel, start foo and bar.
	pthread_t io_module_t, wpipe_t, rpipe_t, rpipe_valid_t;

	//
	// No need to start io_module... it is an auto-run
	// module..
	// pthread_create(&io_module_t,NULL,&io_module_,NULL);
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)pipe_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)pipe_out);
	pthread_create(&rpipe_valid_t,NULL,&read_valid_pipe_,(void*)out_valid_pipe);


	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);
	pthread_join(rpipe_valid_t,NULL);


 	fprintf(stdout,"from out_data, we read ");
        for(i = 0; i < 96; i++) 
 	   fprintf(stdout,"(%d):  %d\n ", out_valid_pipe[i],  pipe_out[i]);
	fprintf(stdout,"\n");

	// pthread_cancel(io_module_t);
}
