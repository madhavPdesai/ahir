#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <SocketLib.h>
#include "vhdlCStubs.h"

#define N 16

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}



typedef struct _FnArgs FnArgs;
struct _FnArgs
{
	int a;
	int* ret_val;
};

void *foo_(void* fargs)
{
   *(((FnArgs*)fargs)->ret_val) = foo(((FnArgs*)fargs)->a);
}

void *write_pipe_(void* a)
{
  write_uint32_n("inpipe",(uint32_t*)a, N);
}

void *read_pipe_(void* a)
{
  read_uint32_n("outpipe",(uint32_t*) a, N);
}


// starts foo, sends N numbers to inpipe and
// reads back N numbers from outpipe
int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);
	
	int i;

	uint32_t pipe_in[N];
	uint32_t pipe_out[N];

	int  seed, foo_ret;

        // some random number..
	seed = 593;

	for(i=0; i < N; i++)
	  {
	    pipe_in[i] = seed + i;
	  }

	// in parallel, start foo and bar.
	pthread_t foo_t, wpipe_t, rpipe_t;
	FnArgs foo_args;

	foo_args.a = seed;
	foo_args.ret_val = &foo_ret;

	pthread_create(&foo_t,NULL,&foo_,(void*)&foo_args);
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)&pipe_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)&pipe_out);


	pthread_join(foo_t,NULL);
	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);

	fprintf(stdout,"foo returns %d\n", foo_ret);
 	fprintf(stdout,"from outpipe, we read ");
	for(i = 0; i < N; i++)
	  fprintf(stdout," %d", pipe_out[i]);

	fprintf(stdout,"\n");
}
