#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"

#ifndef SW
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif


void conversionTest()
{
	uint64_t X;
	float A, B;
	uint32_t* Aptr = ((uint32_t*) &A);
	uint32_t* Bptr = ((uint32_t*) &B);

	while(1)
	{
		X = read_uint64("in_data");
		*Aptr = (X & 0xffffffff);
		*Bptr = (X >> 32);
	
		A = A+1.0;
		B = B+1.0;

		X = *Bptr;
		X = ((X << 32) | *Aptr);
		write_uint64("out_data", X); 	
	
	}
}

