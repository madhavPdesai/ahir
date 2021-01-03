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

uint32_t expected_result;

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Sender()
{
	int idx;
	uint32_t val[ORDER];
	expected_result = 0;
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = idx;
		expected_result += idx*idx;
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
	
	uint32_t result = read_uint32("out_data");
	fprintf(stdout,"Result = 0x%x, expected = 0x%x.\n", result,expected_result);
	PTHREAD_CANCEL(Sender);
	return(0);
}
