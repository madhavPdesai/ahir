#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include "prog.h"
#ifndef SW
#include "vhdlCStubs.h"
#endif

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
uint32_t expected_result[ORDER/2];
void Sender()
{
	int idx, J;
	uint32_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = idx;
		if(idx & 0x1)
		{
			J = idx/2;
			expected_result[J] = val[idx] + val[idx-1];
			fprintf(stderr,"Sender:expected_result[%d] = 0x%x\n", J,
							expected_result[J]);
		
		}
	}
	write_uint32_n("in_data_pipe",val,ORDER);
}

#ifdef SW
DEFINE_THREAD(fetchDaemon)
DEFINE_THREAD(coprocessorDaemonOne)
DEFINE_THREAD(coprocessorDaemonTwo)
#endif

DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	uint32_t result[ORDER/2];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL_AND_CREATE(fetchDaemon);
	PTHREAD_DECL_AND_CREATE(coprocessorDaemonOne);
	PTHREAD_DECL_AND_CREATE(coprocessorDaemonTwo);
#endif
	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint32_t idx;
	read_uint32_n("out_data_pipe",result,ORDER/2);

	for(idx = 0; idx < ORDER/2; idx++)
	{
		fprintf(stdout,"Result = 0x%x, expected = 0x%x.\n", result[idx],expected_result[idx]);
	}
	PTHREAD_CANCEL(Sender);
#ifdef SW
	close_pipe_handler();

	PTHREAD_CANCEL(fetchDaemon);
	PTHREAD_CANCEL(coprocessorDaemonOne);
	PTHREAD_CANCEL(coprocessorDaemonTwo);
#endif
	return(0);
}
