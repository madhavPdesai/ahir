#include <SocketLib.h>
#include <Vhpi.h>
#include <vhdlCStubs.h>
#include <pthread.h>
#include <signal.h>

#define N 10
void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}



void *main__(void* fargs)
{
   main_();
}



int main(int argc, char* argv[])
{
	int inputs[N];
	int outputs[N];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

		
	fprintf(stderr, "specify ten numbers\n");
	int i;
	int n;
	for(i = 0; i < N; i++)
	{
		fscanf(stdin,"%d", &n);
		inputs[i] = n;
	}

	pthread_t main_t;


	pthread_create(&main_t,NULL,&main__,NULL);

	for(i = 0; i < N; i++)
		write_uint32("inpipe",inputs[i]);

	for(i = 0; i < N; i++)
		outputs[i] = read_uint32("outpipe");

	pthread_join(main_t,NULL);

	for(i=0; i< N; i++)
	{
		fprintf(stdout,"%d\n",outputs[i]);
	}

	return(0);
}
