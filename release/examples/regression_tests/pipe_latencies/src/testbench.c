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
	uint8_t err = 0;

	srand(48);
	
	for(idx = 0; idx < ORDER; idx++)
	{
		uint32_t val = rand();
		write_uint32("in_data",val);
		uint32_t result = read_uint32("out_data");

		if(result != val)
		{
			err = 1;
			fprintf(stdout,"Error:Result = %x, expected = %x.\n", result, val);
		}
		else
			fprintf(stdout,"Result = %x, expected = %x.\n", result, val);
	}

	if(err)
		fprintf(stdout,"FAILURE :-(\n");
	else
		fprintf(stdout,"SUCCESS :-)\n");

	return(0);

}
