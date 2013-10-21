#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"

#ifndef SW
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif


void vectorSum()
{
#ifdef ALT
#endif
	while(1)
	{
#ifndef SW
		__loop_pipelining_on__(63,2,1);
#endif
		float x = read_float32("in_data_pipe");
		float y, z;
#ifdef ALT
		if(x > 0.5)
		{
			y = fpadd32(x,x);
			z = fpmul32(x,y);
		}
		else
		{
#endif
			y = x + x;
			z = x * y;
#ifdef ALT
		}
#endif
		write_float32("out_data_pipe",z);
	}
}

