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
uint64_t expected_result[ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Sender()
{
	int idx;
	uint32_t val[ORDER];
	uint64_t T2 = 32;
	srand(49);
	for(idx = 0; idx < ORDER; idx++)
	{
		int32_t u = rand();

		val[idx] = u;

		int64_t u64 = u;
		int64_t pu64 = u64*u64;

		uint64_t upu64 = pu64;
		uint32_t upu32 = (upu64 & 0xffffffff);

		upu64 = (upu64 >> T2);


		uint64_t er  =  (upu32 << 1) + 1; 

		er = (er << 32) |  upu64;
		expected_result[idx] = er;

	}
	write_uint32_n("in_data",val,ORDER);
}

DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	uint64_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	
	read_uint64_n("out_data",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %llx, expected = %llx.\n", result[idx],expected_result[idx]);
	}
	PTHREAD_CANCEL(Sender);
	return(0);
}
