#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
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

	
void Sender()
{
	while(1)
	{
		write_uint8("a",0);
		write_uint8("b",0);
		usleep(1000);
		write_uint8("a",0);
		write_uint8("b",1);
		usleep(1000);
		write_uint8("a",1);
		write_uint8("b",1);
		usleep(1000);
		write_uint8("a",1);
		write_uint8("b",0);
	}
}

#ifdef SW
DEFINE_THREAD(mullerCElement)
#endif
DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	register_port("a",8,1);
	register_port("b",8,1);
	register_port("q",8,0);
	PTHREAD_DECL(mullerCElement);
	PTHREAD_CREATE(mullerCElement);
#endif
	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	uint8_t idx;
	
	for(idx = 0; idx < 100; idx++)
	{
		uint8_t X = read_uint8("q");
		fprintf(stdout,"Result = %d\n", X);
		usleep(100);
	}
	PTHREAD_CANCEL(Sender);
#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(mullerCElement);
#endif
	return(0);
}
