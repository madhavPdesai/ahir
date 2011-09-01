#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
//
//  
#include "vhdlCStubs.h" 
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
	write_uint64("foo_in",*((uint64_t*)a));
}

void *read_pipe_1_(void* a)
{
	*((uint64_t*)a) = read_uint64("dest1_pipe");
}

void *read_pipe_2_(void* a)
{
	*((uint64_t*)a) = read_uint64("dest2_pipe");
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint8_t buf_in[8], buf_out_1[8], buf_out_2[8];
        int i;

        for(i = 0; i < 8; i++)
		buf_in[i] = i;

	pthread_t io_module_t, wpipe_t, rpipe_1_t, rpipe_2_t;

	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)&buf_in);
	pthread_create(&rpipe_1_t,NULL,&read_pipe_1_,(void*)&buf_out_1);
	pthread_create(&rpipe_2_t,NULL,&read_pipe_2_,(void*)&buf_out_2);



	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_1_t,NULL);
	pthread_join(rpipe_2_t,NULL);


 	fprintf(stdout,"from dest1, we read ");
        for(i = 0; i < 8; i++) 
 	   fprintf(stdout," %x ", buf_out_1[i]);
	fprintf(stdout,"\n");
 	fprintf(stdout," %llx \n", *((uint64_t*) buf_out_1));

 	fprintf(stdout,"from dest2, we read ");
        for(i = 0; i < 8; i++) 
 	   fprintf(stdout," %x ", buf_out_2[i]);
	fprintf(stdout,"\n");
 	fprintf(stdout," %llx \n", *((uint64_t*) buf_out_2));

}
