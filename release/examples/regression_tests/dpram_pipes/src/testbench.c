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

	
void Sender()
{
	int idx;
	uint32_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		uint32_t r = rand();
		val[idx] = r;
		expected_result[idx] = r;
	}
	write_uint32_n("in_data",val,ORDER);
}

DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	uint32_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	uint8_t err = 0;
	
	read_uint32_n("out_data",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		if(result[idx] != expected_result[idx])
		{
			err = 1;
			fprintf(stdout,"Error:Result = %x, expected = %x.\n", result[idx],expected_result[idx]);
		}
		else
			fprintf(stdout,"Result = %x, expected = %x.\n", result[idx],expected_result[idx]);
	}

	for(idx = 0; idx < ORDER; idx++)
	{
		write_uint32("in_data", expected_result[idx]);
		usleep (1000);
		uint32_t rval = read_uint32("out_data");
		if(rval != expected_result[idx])
		{
			err = 1;
			fprintf(stdout,"Error: Result = %x, expected = %x.\n", rval,expected_result[idx]);
		}
		else
			fprintf(stdout,"Result = %x, expected = %x.\n", rval,expected_result[idx]);

	}
	
	PTHREAD_CANCEL(Sender);

	if(err)
		fprintf(stdout,"FAILURE :-(\n");
	else
		fprintf(stdout,"SUCCESS :-)\n");

	return(0);

}
