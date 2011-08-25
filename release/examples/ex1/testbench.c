#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef SW
#include <iolib.h>
#include "prog.h"
#else
#include "vhdlCStubs.h"
#endif

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *accumulate_(void* fargs)
{
   accumulate();
}

void *write_pipe_(void* a)
{
   write_uint32_n("in_data",(uint32_t*)a, 10);
}

void *read_pipe_(void* a)
{
   read_uint32_n("out_data",(uint32_t*)a, 10);
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint32_t data_in[10], data_out[10];
        int i;
	
	// initial value of sum.
	set_sum(1); 

        for(i = 0; i < 10; i++)
	{
		data_in[i] = i;
	}

	pthread_t acc_t, wpipe_t, rpipe_t;

#ifdef SW

	pthread_create(&acc_t,NULL,&accumulate_,NULL);
#endif
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)data_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)data_out);


	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);


 	fprintf(stdout,"from out_data, we read ");
	for(i=0; i < 10; i++)
 	  fprintf(stdout," %u ", data_out[i]);
	fprintf(stdout,"\n");
 	fprintf(stdout,"final sum is %u\n", get_sum());

#ifdef SW
	pthread_cancel(acc_t);
#endif
}
