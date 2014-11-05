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

	

float x[ORDER], y[ORDER], expected_result[ORDER];
uint8_t op[ORDER];

#define __SEND__(u,p,T) write_ ## T ## _n(p,u,ORDER);

void sendX()
{
	__SEND__(x,"x_pipe", float32)
}
void sendY()
{
	__SEND__(y,"y_pipe", float32)
}
void sendOp()
{
	__SEND__(op,"op_pipe",uint8)
}


#ifdef SW
DEFINE_THREAD(streamProcessor)
#endif
DEFINE_THREAD(sendX)
DEFINE_THREAD(sendY)
DEFINE_THREAD(sendOp)

float expectedResult(uint8_t _op, float _x, float _y)
{
	float ret_val = 0;		
	if(_op == 0)
		ret_val = _x*_y;
	else if(_op == 1)
		ret_val = _x+_y;
	else if(_op == 2)
		ret_val = (_x*_x) - (_y*_y);
	else if(_op == 3)
		ret_val = (_x + _y) * (_x + _y);

	return(ret_val);
}

int main(int argc, char* argv[])
{
	float result[ORDER];
	signal(SIGINT,  Exit);
	signal(SIGTERM, Exit);

	uint8_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		op[idx] = idx % 4;
		x[idx] = drand48();
		y[idx] = drand48();
	}
#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(streamProcessor);
	PTHREAD_CREATE(streamProcessor);
#endif
	PTHREAD_DECL(sendX);
	PTHREAD_CREATE(sendX);
	PTHREAD_DECL(sendY);
	PTHREAD_CREATE(sendY);
	PTHREAD_DECL(sendOp);
	PTHREAD_CREATE(sendOp);



	read_float32_n("z_pipe",result,ORDER);

	for(idx = 0; idx < ORDER; idx++)
	{
		fprintf(stdout,"Result = %f, expected = %f.\n", result[idx],expectedResult(op[idx], x[idx], y[idx]));
	}
#ifdef SW
	close_pipe_handler();
	PTHREAD_CANCEL(streamProcessor);
#endif
	return(0);
}
