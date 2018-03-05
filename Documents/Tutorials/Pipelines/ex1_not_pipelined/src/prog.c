#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"

void vectorSum()
{

	while(1)
	// unpipelined loop!
	{

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

