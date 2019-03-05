#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"


float fpincr(float x)
{
	return(x + 1.0);
}

#ifdef SW
float fpmul(float x, float y)
{
	return(x*y);
}

float fpadd(float x, float y)
{
	return(x+y);
}

float fpsub(float x, float y)
{
	return(x-y);
}
#endif 

float dotProduct(float x0, float y0, float x1, float y1, float x2, float y2, float x3, float y3)
{

	float p0 = fpmul(x0,y0);
	float p1 = fpmul(x1,y1);
	float p2 = fpmul(x2,y2);
	float p3 = fpmul(x3,y3);

	float result = fpadd(fpadd(p0 , p1) , fpadd(p2 , p3));
	return(result);
}

uint8_t fpcmplt(float x, float y)
{
	return(x < y);
}

uint8_t fpcmpgt(float x, float y)
{
	return(x > y);
}

uint8_t fpcmpeq(float x, float y)
{
	return(x == y);
}

#ifdef SW
uint32_t concat(uint8_t a, uint8_t b, uint8_t c, uint8_t d)
{
	uint32_t result = a;
	result = (result << 8) | b;
	result = (result << 8) | c;
	result = (result << 8) | d;
	return(result);
}


uint8_t pmux(uint8_t a, uint8_t b, uint8_t c, uint8_t d, uint8_t e)
{
	if(a)
		return(b);
	else if(c) 
		return d;
	else
		return(e);
}
#endif
