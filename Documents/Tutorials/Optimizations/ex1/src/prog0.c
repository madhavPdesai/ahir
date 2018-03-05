#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

uint32_t doSum(uint32_t*, uint32_t);
uint32_t A, B, C[10];
void vectorSum()
{
	uint32_t D;
	A = read_uint32("in_data");
	B = read_uint32("in_data");

	uint32_t ret_val = (A+B);

	C[0] = read_uint32("in_data");
	D = read_uint32("in_data");

	uint32_t* ptr = &(C[0]);
	ret_val = doSum(ptr, ret_val);

	ptr = &D;
	ret_val = doSum(ptr, ret_val);

	write_uint32("out_data", ret_val);
}


