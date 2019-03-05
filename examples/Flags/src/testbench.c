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

	

#ifdef SW
DEFINE_THREAD(Rx)
DEFINE_THREAD(Tx)
#endif

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(Rx);
	PTHREAD_CREATE(Rx);
	PTHREAD_DECL(Tx);
	PTHREAD_CREATE(Tx);
#endif

	write_uint8("env_rx_req",0);
	write_uint8("env_tx_ack",0);
	while(1)
	{
		uint8_t r = read_uint8("rx_env_ack");
		uint8_t t = read_uint8("tx_env_req");
		if(!r && !t)
			break;
	}
	fprintf(stderr,"Env synched.\n");
	int idx;
	for(idx = 0; idx < 100; idx++)
	{
		// signal rx and wait for tx
		write_uint8("env_rx_req",1);
		while(1)
		{
			uint8_t r = read_uint8("rx_env_ack");
			if(r)
				break;
			
		}
		
		write_uint8("env_rx_req",0);
		fprintf(stderr,"Env-Rx handshake half-done\n");

		while(1)
		{
			uint8_t r = read_uint8("rx_env_ack");
			if(!r)
				break;
		}
		fprintf(stderr,"Env-Rx handshake full-done\n");
			
		while(1)
		{
			uint8_t t = read_uint8("tx_env_req");
			if(t)
				break;
			
		}
		write_uint8("env_tx_ack",1);
		fprintf(stderr,"Env-Tx handshake half-done\n");

		while(1)
		{
			uint8_t t = read_uint8("tx_env_req");
			if(!t)
				break;
		}
		write_uint8("env_tx_ack",0);
		fprintf(stderr,"Env-Tx handshake full-done\n");

		fprintf(stderr,"Completed  %d.\n", idx);
		usleep(100);
	}
#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(Rx);
	PTHREAD_CANCEL(Tx);
#endif
	return(0);
}
