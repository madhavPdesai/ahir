#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"

#ifndef SW
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif


void streamProcessor()
{
	while(1)
	{
#ifndef SW
#ifdef PIPELINE
		__loop_pipelining_on__(32,2,1);
#endif
#endif
		float x = read_float32("x_pipe");
		float y = read_float32("y_pipe");

		uint8_t op_code = read_uint8("op_pipe");

		float result = 0;
		if(op_code == 0)
			result = x*y;
		else if(op_code == 1)
			result = x+y;
		else if(op_code == 2)
			result = (x*x) - (y*y);
		else if(op_code == 3)
			result = (x + y) * (x + y);
		else
			result = 0;

		write_float32("z_pipe",result);
	}
}

