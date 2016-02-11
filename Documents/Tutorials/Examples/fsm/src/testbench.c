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
uint8_t sent_values[ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Sender()
{
	int idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		uint32_t r = rand();
		sent_values[idx] = r & 0x1;
	}
	write_uint8_n("in_data",sent_values,ORDER);
}

DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	uint8_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	
	read_uint8_n("out_data",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %x, Sent = %x.\n", result[idx],sent_values[idx]);
	}
	PTHREAD_CANCEL(Sender);
	return(0);
}
