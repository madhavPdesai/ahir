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

	

uint8_t op[ORDER];
float x[ORDER];
float y[ORDER];
float z[ORDER];
float expected_result[ORDER];

void writeOp()
{
	write_uint8_n("op_pipe",op, ORDER);
}


void writeX()
{
	write_float32_n("x_pipe",x, ORDER);
}

void writeY()
{
	write_float32_n("y_pipe",y, ORDER);
}

void readZ()
{
	read_float32_n("z_pipe", z, ORDER);		
}

void initData()
{
	int idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		x[idx] = drand48();
		y[idx] = drand48();

		uint8_t op_id = idx % 3;

		op[idx] = op_id;
		if(op_id == 0)
			expected_result[idx] = x[idx] + y[idx];
		else if(op_id == 1)
			expected_result[idx] = x[idx] - y[idx];
		else if(op_id == 2)
			expected_result[idx] = x[idx] * y[idx];
		else
			expected_result[idx] = 0.0;
		//expected_result[idx] = (2.0*val[idx]);
	}
}

#ifdef SW
DEFINE_THREAD(streamAlu)
#endif
DEFINE_THREAD(writeOp)
DEFINE_THREAD(writeX)
DEFINE_THREAD(writeY)
DEFINE_THREAD(readZ)

int main(int argc, char* argv[])
{
	float result[ORDER];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	initData();	

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(streamAlu);
	PTHREAD_CREATE(streamAlu);
#endif

	PTHREAD_DECL(writeOp);
	PTHREAD_CREATE(writeOp);
	PTHREAD_DECL(writeX);
	PTHREAD_CREATE(writeX);
	PTHREAD_DECL(writeY);
	PTHREAD_CREATE(writeY);
	PTHREAD_DECL(readZ);
	PTHREAD_CREATE(readZ);

	PTHREAD_JOIN(readZ);

	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %f, expected = %f.\n", z[idx],expected_result[idx]);
	}

#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(streamAlu);
#endif
	return(0);
}
