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

void *main_inner_(void* fargs)
{
   main_inner();
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	pthread_t main_t;
	pthread_create(&main_t,NULL,&main_inner_,NULL);

	uint32_t R1 = read_uint32("outpipe");
	uint32_t R2 = read_uint32("outpipe");
	uint32_t R3 = read_uint32("outpipe");

   	fprintf(stdout,"post-init: R1=%u, R2=%u, R3=%u\n", R1,R2,R3);
        int I;

	//for(I=0; I < 32; I++)
	//{
		//uint32_t tmp = read_uint32("tmppipe");
   		//fprintf(stdout,"a5reg.%d = %u\n", I, tmp);
		//
	//}

	R1 = read_uint32("outpipe");
	R2 = read_uint32("outpipe");
	R3 = read_uint32("outpipe");
   	fprintf(stdout,"post-32-ticks: R1=%u, R2=%u, R3=%u\n", R1,R2,R3);

	uint32_t out_stream = read_uint32("outpipe");
   	fprintf(stdout,"stream=%u \n", out_stream);
	

	pthread_join(main_t,NULL);

	return(0);
}
