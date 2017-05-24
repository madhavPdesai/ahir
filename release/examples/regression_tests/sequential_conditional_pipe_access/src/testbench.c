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

	
void Sender_Ctrl()
{
	int idx;
	uint8_t ctrl[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		ctrl[idx] = idx;
	}
	write_uint8_n("control_pipe",ctrl,ORDER);
}

DEFINE_THREAD(Sender_Ctrl)

void Sender_Data()
{
	int idx;
	uint32_t data[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		data[idx] = idx + 1;
	}
	write_uint32_n("in_data",data,ORDER);
}

DEFINE_THREAD(Sender_Data)
int main(int argc, char* argv[])
{
	uint32_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender_Ctrl);
	PTHREAD_CREATE(Sender_Ctrl);
	PTHREAD_DECL(Sender_Data);
	PTHREAD_CREATE(Sender_Data);

	uint8_t idx;
	
	read_uint32_n("out_data",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %x, expected = %x.\n", result[idx], ((idx & 0x1) ? (idx+1)/2 : 0 ));
	}
	PTHREAD_CANCEL(Sender_Ctrl);
	PTHREAD_CANCEL(Sender_Data);
	return(0);
}
