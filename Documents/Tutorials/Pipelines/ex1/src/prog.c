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

	while(1)
	{
#ifndef SW
		//  This is an indication to the AHIR C -> Aa compiler.
		//  The arguments are 
		//     1.  The number of iterations to be kept alive in the pipeline.
		//     2.  The amount of buffering assigned to an operator in the pipeline. 
		//     3.  Whether the pipeline is expected to be run at 1 iteration/cycle or not..
		__loop_pipelining_on__(63,2,1);
#endif
		//  read from a_pipe
		float a = read_float32("a_pipe");

		// add 1.0
		float ap1 = a + 1.0;

		// multiply by a
		float result = a*ap1;

		// send result..
		write_float32("result_pipe",result);
	}
}

