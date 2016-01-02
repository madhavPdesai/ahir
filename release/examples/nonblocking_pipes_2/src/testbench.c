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

	
void Write_Sender()
{
	uint8_t SA [ORDER];
	int idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		SA[idx] = (2*idx) + 1;
	}
	write_uint8_n("write_command",SA, ORDER);
}

void Read_Sender()
{
	int idx;
	uint8_t SA [ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		SA[idx] = 1;
	}
	write_uint8_n("read_command",SA, ORDER);
}


DEFINE_THREAD(Write_Sender)
DEFINE_THREAD(Read_Sender)

int main(int argc, char* argv[])
{
	uint8_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Write_Sender);
	PTHREAD_CREATE(Write_Sender);
	PTHREAD_DECL(Read_Sender);
	PTHREAD_CREATE(Read_Sender);

	uint8_t idx;
	
	read_uint8_n("read_response",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %x, expected = %x.\n", result[idx],idx);
	}
	PTHREAD_CANCEL(Write_Sender);
	PTHREAD_CANCEL(Read_Sender);
	return(0);
}
