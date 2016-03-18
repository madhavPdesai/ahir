#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"

#ifndef SW
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif


void streamAlu()
{

	while(1)
	{
#ifndef SW
		__loop_pipelining_on__(63,2,1);
#endif
                uint8_t op = read_uint8("op_pipe");
		float x = read_float32("x_pipe");
                float y = read_float32("y_pipe");
		float z;

		z = 0.0;

		if(op == 0)
		{
			z = x+y;
		}
		else if(op == 1)
		{
			z  = x-y;
		}
		else if(op == 2)
		{
			z = x*y;
		}
		write_float32("z_pipe",z);
	}
}

