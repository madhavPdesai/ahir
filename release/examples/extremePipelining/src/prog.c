#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"

#ifndef SW
void loop_pipelining_on(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif


void vectorSum()
{
	while(1)
	{
#ifndef SW
		loop_pipelining_on(32,1,1);
#endif
		float x = read_float32("in_data_pipe");
		//float y = fpadd32(x,x);
		//float z = fpmul32(x,y);
		float y = x + x;
		float z = x * y;
		write_float32("out_data_pipe",z);
	}
}

