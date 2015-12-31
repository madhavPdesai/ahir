#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif

#define ORDER 16
uint32_t val_1[ORDER];
uint32_t val_0[ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Rx_1()
{
	read_uint32_n("out_data_1", val_1, ORDER);
}

void Rx_0()
{
	read_uint32_n("out_data_0", val_0, ORDER);
}


DEFINE_THREAD(Rx_0)
DEFINE_THREAD(Rx_1)

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Rx_0);
	PTHREAD_CREATE(Rx_0);
	PTHREAD_DECL(Rx_1);
	PTHREAD_CREATE(Rx_1);

	int idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		write_uint32("in_data",0);
		write_uint32("in_data", idx);
		write_uint32("in_data",1);
		write_uint32("in_data", 2*idx);
	}
	
	PTHREAD_JOIN(Rx_0);
	PTHREAD_JOIN(Rx_1);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stderr,"%d \t %d\n", val_1[idx], val_0[idx]);
	}
	return(0);
}
