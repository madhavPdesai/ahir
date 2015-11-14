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
#define HORDER 8
uint32_t expected_result[ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Sender_1()
{
	int idx;
	uint16_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = idx;
	}
	write_uint16_n("i_data_1",val,ORDER);
}

void Sender_2()
{
	int idx;
	uint16_t val[HORDER];
	for(idx = 0; idx < HORDER; idx++)
	{
		val[idx] = idx;
	}
	write_uint16_n("i_data_2",val,HORDER);
}

DEFINE_THREAD(Sender_1)
DEFINE_THREAD(Sender_2)

int main(int argc, char* argv[])
{
	uint32_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender_1);
	PTHREAD_CREATE(Sender_1);
	PTHREAD_DECL(Sender_2);
	PTHREAD_CREATE(Sender_2);

	uint8_t idx;
	
	read_uint32_n("o_data",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %x.\n", result[idx]);
	}
	PTHREAD_CANCEL(Sender_1);
	PTHREAD_CANCEL(Sender_2);
	return(0);
}
