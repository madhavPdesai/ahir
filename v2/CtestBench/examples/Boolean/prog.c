#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>


uint8_t xor2(uint8_t a, uint8_t b)
{
	uint8_t ret_val;
	ret_val = ~ ((a & b) | (~a & ~b));
	return(ret_val);
}

