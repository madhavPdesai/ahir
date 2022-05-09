#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

typedef struct __Myrec {
	float A[ORDER][ORDER];
	float B[ORDER][ORDER][ORDER];
	float C[ORDER][ORDER][ORDER][ORDER];
	uint8_t flag;
} Myrec;

Myrec test_struct;

#ifndef SW
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif

void getData()
{
	int idx;
	test_struct.flag = 0;
	for(idx = 0; idx < ORDER; idx++)
	{
#ifndef SW
		__loop_pipelining_on__(16,2,1);
#endif 
		float val = read_float32("in_data_pipe");
#ifdef SW
		fprintf(stderr,"Info: read %f from in_data_pipe.\n",val);
#endif
		test_struct.flag += idx;
		test_struct.A[idx][idx] = val;
		test_struct.B[idx][idx][idx]= val;
	}
}

void sendResult()
{
	int idx;
	for(idx = 0; idx < ORDER; idx++)
	{
#ifndef SW
		__loop_pipelining_on__(16,2,1);
#endif 
		
		float val = test_struct.C[0][idx][1][idx];
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

void _vectorSum_()
{
	uint8_t I;
	for(I=0; I < ORDER; I++)
	{
#ifndef SW
		__loop_pipelining_on__(16,2,1);
#endif 
		test_struct.C[0][I][1][I]  = test_struct.A[I][I] + test_struct.B[I][I][I];
	}
}

