#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

#ifdef SW
void __loop_pipelining_on__(int A,int B,int C) {}
#else
void __loop_pipelining_on__(int A,int B,int C);
#endif

float a[16];
float b[16];
float c[16];

void vectorSum()
{
	while(1)
	{
		int I;
		// read the numbers
		for(I = 0; I < 16; I++)
		{
			__loop_pipelining_on__(4,1,0);
			a[I] = read_float32("in_data_pipe");
			b[I] = read_float32("in_data_pipe");
		}
	
		for(I = 0; I  < 16; I++)
		{
			__loop_pipelining_on__(4,1,0);
			c[I] = a[I] + b[I];
			write_float32("out_data_pipe", c[I]);
		}
	}
}

