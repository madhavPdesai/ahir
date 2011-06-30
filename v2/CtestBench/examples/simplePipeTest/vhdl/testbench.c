#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <vhdlCStubs.h>
//
//
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
	write_uint64("foo_in",*((uint64_t*)a));
}

void *read_pipe_(void* a)
{
	*((uint64_t*)a) = read_uint64("foo_out");
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint8_t buf_in[8], buf_out[8];
        int i;

        for(i = 0; i < 8; i++)
		buf_in[i] = i;

	// in parallel, start foo and bar.
	pthread_t io_module_t, wpipe_t, rpipe_t;

	// pthread_create(&io_module_t,NULL,&io_module_,NULL);
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)&buf_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)&buf_out);


	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);


 	fprintf(stdout,"from foo_out, we read ");
        for(i = 0; i < 8; i++) 
 	   fprintf(stdout," %x ", buf_out[i]);
	fprintf(stdout,"\n");
 	fprintf(stdout," %llx \n", *((uint64_t*) buf_out));
// 
	// pthread_cancel(io_module_t);
}
