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
	uint32_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint8_t I;
	for(I = 0; I < 255; I++)
	{
		write_uint8("input_data", I);
		write_uint8("input_data", I + 1);

		uint8_t J = read_uint8("output_data");
		if(J != (uint8_t) (I + I + 1))
		{
			fprintf(stderr,"Error: saw %d, expected %d\n", J, (uint8_t) (I + I + 1));
		}
	}
	fprintf(stderr,"Done!\n");
	return(0);
}
