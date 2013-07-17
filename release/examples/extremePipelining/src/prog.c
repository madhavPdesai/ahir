#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

#ifndef SW
void loop_pipelining_on(uint32_t val, uint32_t buf);
#endif


void vectorSum()
{
	while(1)
	{
#ifndef SW
		loop_pipelining_on(16,32);
#endif
		float x = read_float32("in_data_pipe");
		float y = x + x;
		write_float32("out_data_pipe",y);
	}
}

