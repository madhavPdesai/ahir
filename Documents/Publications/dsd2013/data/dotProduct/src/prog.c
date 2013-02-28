#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

float A[ORDER];
float B[ORDER];

void init()
{
	int idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		float val = read_float32("in_data_pipe");
#ifdef SW
		fprintf(stderr,"Info: read %f from in_data_pipe.\n",val);
#endif
		A[idx] = val;
		B[idx] = val;
	}
}

void dotProduct()
{
	while(1)
	{
		init();
		float result = _dotProduct_();
#ifdef SW
		fprintf(stderr,"Info: wrote result %f to out_data_pipe.\n",result);
#endif
		write_float32("out_data_pipe",result);
	}
}

#ifdef UNROLL 

float _dotProduct_()
{
	uint8_t I;
	float result = 0.0;
	for(I=0; I < ORDER; I += 4)
	{
		uint8_t I1 = I+1; 
		uint8_t I2 = I+2; 
		uint8_t I3 = I+3; 
		float r0 = A[I]*B[I];
		float r1 = A[I1]*B[I1];
		float r2 = A[I2]*B[I2];
		float r3 = A[I3]*B[I3];
		result += ((r0+r1)+(r2+r3));
	}

	return(result);
}

#else

float _dotProduct_()
{
	uint8_t I;
	float result = 0.0;
	for(I=0; I < ORDER; I ++)
	{
		float r = A[I]*B[I];
		result += r;
	}

	return(result);
}

#endif
