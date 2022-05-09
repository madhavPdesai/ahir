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
void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}


int testOp (uint32_t op, uint32_t A, uint32_t B)
{
	int err = 0;
	uint32_t cmd = (op << 30) | ((A & 0x7fff) << 15) | (B & 0x7fff);
	write_uint32("in_data", cmd);

	uint16_t result = 0x7fff & read_uint16("out_data");

	uint16_t sum  = (A + B) & 0x7fff;
	uint16_t diff = (A - B) & 0x7fff;
	uint16_t prod = (A * B) & 0x7fff;
	uint16_t xor  = (A ^ B) & 0x7fff;

	if(op == 0)
		err = (result != sum);
	else if (op == 1)
		err = (result != diff);
	else if (op == 2)
		err = (result != prod);
	else if (op == 3)
		err = (result != xor);

	if(err)
	{
		fprintf(stderr,"Error: op=%d, A=0x%x, B = 0x%x, result=0x%x\n", op, A, B, result);
	}
	return(err);
}


	



int main(int argc, char* argv[])
{
	int err = 0;
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);
	
	uint32_t A, B;
	for(A = 0; A < 16; A++)
	{
		for(B = 0; B < 16; B++)
		{
			uint32_t op;
			for(op = 0; op < 4; op++)
			{
				err = testOp(op, A, B) || err;
			}
		}
	}

	if(err)
		fprintf(stderr,"FAILURE :-(n");
	else
		fprintf(stderr,"SUCCESS :-)\n");

	return(0);
}
