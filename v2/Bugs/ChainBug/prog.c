#include <stdio.h>
#include <stdint.h>

uint64_t checkMux(uint8_t a, uint8_t b)
{
	uint64_t tmp = 0xA;
	uint64_t res = 0xB;

	res = (((a!= 0) && (b!=0)) ? tmp : res);

	//if( (a!=0) && (b!=0))
	//	res = tmp;

	return res;
}
