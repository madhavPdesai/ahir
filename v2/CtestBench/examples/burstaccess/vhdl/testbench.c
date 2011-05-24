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
	write_uint32_n("foo_in",(uint32_t*)a, 10);
}

void *read_pipe_(void* a)
{
	read_uint32_n("foo_out", (uint32_t*)a, 10);
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint32_t pipe_in[10], pipe_out[10];
        int i;

        for(i = 0; i < 10; i++)
		pipe_in[i] = i;

	// in parallel, start foo and bar.
	pthread_t io_module_t, wpipe_t, rpipe_t;

	pthread_create(&io_module_t,NULL,&io_module_,NULL);
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)pipe_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)pipe_out);


	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);


 	fprintf(stdout,"from foo_out, we read ");
        for(i = 0; i < 10; i++) 
 	   fprintf(stdout," %d ", pipe_out[i]);
	fprintf(stdout,"\n");

	pthread_cancel(io_module_t);
}
