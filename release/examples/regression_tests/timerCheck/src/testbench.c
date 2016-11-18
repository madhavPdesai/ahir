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
uint32_t expected_result[ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint8_t idx;
	

	for(idx = 0; idx < ORDER; idx++)
	{
		write_uint32 ("in_data", idx);
		uint32_t result = read_uint32("out_data");
		fprintf(stdout,"Result = %x, expected = %x.\n", result, idx);
	}
	return(0);
}
