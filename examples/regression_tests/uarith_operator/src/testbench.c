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
#include <uarith32.h>


uint64_t mul_check(uint32_t);
uint32_t shift_check(uint32_t);
uint32_t add_check(uint32_t);


void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	int ORDER = 10;
	if(argc > 1)
	{
		ORDER = atoi(argv[1]);
	}
	srand(ORDER);

	int idx;

	for(idx = 0; idx < ORDER; idx++)
	{
		uint32_t X = rand();
		uint64_t X64 = X;
		uint64_t Y = mul_check(X);
		uint64_t YEXP = X64*X64;

		if(Y==YEXP)
			fprintf(stderr,"%x*%x = %llx, expected=%llx\n", X, X, Y, YEXP);
		else
			fprintf(stderr,"ERROR: %x*%x = %llx, expected=%llx\n", X, X, Y, YEXP);


		uint32_t S = shift_check(X);
		uint32_t SEXP = ((X >> 1) ^ (((int32_t) X) >> 1) ^ (X << 1));
		if(S == SEXP)
			fprintf(stderr,"shift_check(%x) = %x, expected=%x\n", X, S, SEXP);
		else
			fprintf(stderr,"ERROR: shift_check(%x) = %x, expected=%x\n", X, S, SEXP);

		uint32_t T = add_check(X);
		uint32_t TEXP = ((X + 1) ^ (X - 1) ^ (X + 2) ^ (X - 2));
		if (T == TEXP)
			fprintf(stderr,"add_check(%x) = %x, expected=%x\n", X, T, TEXP);
		else
			fprintf(stderr,"ERROR: add_check(%x) = %x, expected=%x\n", X, T, TEXP);
	}

	return(0);
}
