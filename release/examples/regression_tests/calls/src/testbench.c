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
uint32_t expected_result_1[ORDER];
uint32_t expected_result_2[ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Sender_1()
{
	int idx;
	uint32_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = (2*idx)+1;
		expected_result_1[idx] = val[idx];
	}
	write_uint32_n("in_data_1",val,ORDER);
}

DEFINE_THREAD(Sender_1)

void Sender_2()
{
	int idx;
	uint32_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = (2*idx);
		expected_result_2[idx] = val[idx];
	}
	write_uint32_n("in_data_2",val,ORDER);
}

DEFINE_THREAD(Sender_2)

int main(int argc, char* argv[])
{
	uint32_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender_1);
	PTHREAD_DECL(Sender_2);

	PTHREAD_CREATE(Sender_1);
	PTHREAD_CREATE(Sender_2);

	uint8_t idx;
	
	read_uint32_n("out_data_1",result,ORDER);
	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %x, expected = %x.\n", result[idx],expected_result_1[idx]);
	}
	read_uint32_n("out_data_2",result,ORDER);
	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %x, expected = %x.\n", result[idx],expected_result_2[idx]);
	}

	PTHREAD_CANCEL(Sender_1);
	PTHREAD_CANCEL(Sender_2);
	return(0);
}
