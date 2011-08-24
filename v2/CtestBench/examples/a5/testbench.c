#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
//
// the next two inclusions are
// to be used in the software version
//  
#include <iolib.h>
#include "prog.h"
//
//
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

	// in parallel, start foo and bar.
	pthread_t main_t;
	pthread_create(&main_t,NULL,&main_inner_,NULL);

	uint32_t R1 = read_uint32("outpipe");
	uint32_t R2 = read_uint32("outpipe");
	uint32_t R3 = read_uint32("outpipe");
	uint32_t out_stream = read_uint32("outpipe");
	

	pthread_join(main_t,NULL);

   	fprintf(stdout," R1=%u, R2=%u, R3=%u, stream=%u \n", R1,R2,R3,out_stream);

	return(0);
}
