#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#ifdef SW
#include <Pipes.h>
#include <pipeHandler.h>
#endif
#include "prog.h"

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *accumulate_(void* fargs)
{
   accumulate();
}

void *pipeHandler__(void* fargs)
{
	pipeHandler();
}


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

        int i;
	int32_t data;
	uint8_t op;

	if(argc > 11) 
	{
		fprintf(stderr,"Error: this toy accepts a maximum of 10 arguments\n");
		return(1);
	}

#ifdef SW

	// in the "software" case, we start a pipe-handler
	// to manage the pipes..  Earlier, we were using named
	// pipes, which were very flaky and difficult to debug.
	// the pipeHandler generates a log file (pipeHandler.log)
	// which is very useful for figuring out what happened.
	// one can also use gdb to trace activity.
	pthread_t phandler_t;
	pthread_create(&phandler_t,NULL,&pipeHandler__,NULL);

	usleep(100);
	
	// register FIFO
	register_pipe("in_data",10,32,0);

	// register FIFO..
	register_pipe("out_data",10,32,0);

	// stack 
	register_pipe("eval_stack",10,32,1);

	// operation
	register_pipe("in_op",10,8,0);

	pthread_t acc_t;
	pthread_create(&acc_t,NULL,&accumulate_,NULL);
#endif




	for(i=1; i < argc; i++)
	{
		if(strcmp(argv[i],"+") == 0)
		{
			write_uint8("in_op",_ADD);
			write_uint32("in_data",0);
		}
		else if(strcmp(argv[i],"-") == 0)
		{
			write_uint8("in_op",_SUB);
			write_uint32("in_data",0);
		}
		else if(strcmp(argv[i],"X") == 0)
		{
			write_uint8("in_op",_MUL);
			write_uint32("in_data",0);
		}
		else if(strcmp(argv[i],".") == 0)
		{
			write_uint8("in_op",_POP);
			write_uint32("in_data",0);
		}
		else
		{
			data = atoi(argv[i]);
			write_uint8("in_op",_PUSH);
			write_uint32("in_data",data);
		}
	}

	data = read_uint32("out_data");
	fprintf(stdout,"result: %d\n", data);

#ifdef SW
	pthread_cancel(acc_t);
	killPipeHandler();
#endif
}
