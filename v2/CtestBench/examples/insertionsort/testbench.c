#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <iolib.h>


#define N 10

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

typedef struct RWArgs_ RWArgs;
struct RWArgs_
{
	int n;
	int* list;
};

void *write_(void* fargs)
{
	RWArgs* u = (RWArgs*) fargs;
	int i;
	for(i = 0; i < u->n; i++)
	{
		write_uint32("inpipe",u->list[i]);
	}
}

void *read_(void* fargs)
{
	RWArgs* u = (RWArgs*) fargs;
	int i;
	for(i = 0; i < u->n; i++)
	{
		u->list[i]  = read_uint32("outpipe");
	}
}

void *start_(void* fargs)
{
  start(*((int*) fargs));
}



int main(int argc, char* argv[])
{

	int list_size = N;
	int inputs[N];
	int outputs[N];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	int pipe_in, pipe_out;
		
	int i;
	int n;

	fprintf(stderr,"Specify %d numbers\n", N);
	for(i = 0; i < N; i++)
	{
		fscanf(stdin,"%d", &(inputs[i]));
	}

	RWArgs in_args;
	in_args.n = N;
	in_args.list = inputs;

	RWArgs out_args;
	out_args.n = N;
	out_args.list = outputs;

	pthread_t start_t, write_t, read_t;


	pthread_create(&start_t,NULL,&start_,&list_size);
	pthread_create(&write_t,NULL,&write_,&in_args);
	pthread_create(&read_t,NULL,&read_,&out_args);

	pthread_join(start_t,NULL);
	pthread_join(write_t,NULL);
	pthread_join(read_t,NULL);

	for(i=0; i< N; i++)
	{
		fprintf(stdout,"%d\n",outputs[i]);
	}

	return(0);
}
