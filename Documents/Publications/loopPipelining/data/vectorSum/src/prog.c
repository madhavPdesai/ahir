#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

float A[ORDER];
float B[ORDER];
float C[ORDER];

#ifndef SW
void loop_pipelining_on();
#endif

void getData()
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

void sendResult()
{
	int idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		float val = C[idx];
		write_float32("out_data_pipe",val);
#ifdef SW
		fprintf(stderr,"Info: wrote %f to out_data_pipe.\n",val);
#endif
	}
}

void vectorSum()
{
	while(1)
	{
		getData();
		_vectorSum_();
		sendResult();
	}
}

#ifdef UNROLL 

void _vectorSum_()
{
	uint8_t I;
	for(I=0; I < ORDER; I += 8)
	{
#ifndef SW
		loop_pipelining_on();
#endif
		uint8_t I1 = I+1; 
		uint8_t I2 = I+2; 
		uint8_t I3 = I+3; 
		uint8_t I4 = I+4; 
		uint8_t I5 = I+5; 
		uint8_t I6 = I+6; 
		uint8_t I7 = I+7; 

		float c0  = A[I]+B[I];
		float c1 = A[I1]+B[I1];
		float c2 = A[I2]+B[I2];
		float c3 = A[I3]+B[I3];
		float c4 = A[I4]+B[I4];
		float c5 = A[I5]+B[I5];
		float c6 = A[I6]+B[I6];
		float c7 = A[I7]+B[I7];

		C[I]  = c0;
		C[I1] = c1;
		C[I2] = c2;
		C[I3] = c3;
		C[I4] = c4;
		C[I5] = c5;
		C[I6] = c6;
		C[I7] = c7;
	}

}

#else

void _vectorSum_()
{
	uint8_t I;
	float result = 0.0;
	for(I=0; I < ORDER; I ++)
	{
		C[I] = A[I]+B[I];
	}
}

#endif
