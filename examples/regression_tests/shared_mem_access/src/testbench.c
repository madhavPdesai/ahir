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

#define ORDER 32

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}
	
void Sender()
{
	uint8_t idx;
	uint32_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		if(idx < ORDER/2)
		{
			val[idx] = (0 << 24) | (idx << 16) | idx;
		}
		else
		{
			val[idx] = (1 << 24) | ((idx - ORDER/2) << 16) | 0;
		}
	
	}
	write_uint32_n("in_data",val,ORDER);
}
DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	uint16_t result[ORDER];
	

	read_uint16_n("out_data", result, ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		if(idx > ORDER/2)
		{
			fprintf(stdout,"%d. Result = %x, expected %x\n", idx, result[idx], idx - ORDER/2);
		}
		else
		{
			fprintf(stdout,"%d. Result = %x, expected 0\n", idx, result[idx]);
		}
	}
	PTHREAD_CANCEL(Sender);
	return(0);
}
