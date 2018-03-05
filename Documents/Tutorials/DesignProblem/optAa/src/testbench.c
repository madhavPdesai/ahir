#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#else
#include "aa_c_model.h"
#endif

#define ORDER 8

void sender ()
{
	float buffer[2*ORDER];
	int i;
	for(i = 0; i < 2*ORDER; i++)
		buffer[i] = 1.0;
	write_float32_n ("in_data", buffer, 2*ORDER);
}
DEFINE_THREAD(sender);

int main(int argc, char* argv[])
{
#ifdef SW
	init_pipe_handler_with_log("pipelog.txt");
	start_daemons (stdout,0);
#endif
	int i;

	// write the taps.
	float tap_val  = 1.0/ORDER;
	for(i = 0; i < ORDER; i++)
	{
		write_float32 ("in_data", tap_val);
		fprintf(stderr,"Tap %d = %f, sent\n", i, tap_val);
	}

	// start the sender
	PTHREAD_DECL (sender);
	PTHREAD_CREATE (sender);

	// receive 2*ORDER results
	for (i = 0; i < 2*ORDER; i++)
	{
		float recv_data = read_float32 ("out_data");
		fprintf(stdout,"Result[%d] = %f.\n", i, recv_data);
	}
	return(0);
}

