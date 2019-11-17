#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifdef AA2C
#include <aa_c_model.h>
#else
#ifndef SW
#include "vhdlCStubs.h"
#endif
#endif

#define ORDER 2
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
		val[idx] = idx;
		expected_result[idx] = idx;
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

#ifdef AA2C
	init_pipe_handler_with_log("pipe_handler.log");
	start_daemons (stdout,0);	
#endif

	uint8_t idx;
	
	read_uint32_n("out_data",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %x, expected = %x.\n", result[idx],expected_result[idx]);
	}
	PTHREAD_CANCEL(Sender);
	return(0);
}
