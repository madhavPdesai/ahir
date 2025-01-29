#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <_Top.h>

#define ORDER 16

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
void Sender()
{
	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		write_uint32("A",idx);
	}
}

DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	uint32_t result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	_start_daemons(stderr,0);
#endif
	PTHREAD_DECL_AND_CREATE(Sender);

	read_uint32_n("B",result,ORDER);

	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %u, expected = %u.\n", result[idx],idx);
	}
	PTHREAD_CANCEL(Sender);
#ifdef SW
	close_pipe_handler();
	_stop_daemons();
#endif
	return(0);
}
