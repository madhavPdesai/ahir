#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>


int32_t fp2int(float x)
{
	return((int32_t) x);
}

uint32_t fp2uint(float x)
{
	return((uint32_t) x);
}

float fpincr(float x)
{
	return(x + 1.0);
}

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

float dotProduct(float x0, float y0, float x1, float y1, float x2, float y2, float x3, float y3)
{

	float p0 = x0*y0;
	float p1 = x1*y1;
	float p2 = x2*y2;
	float p3 = x3*y3;

	float result = ((p0 + p1) + (p2 + p3));
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


double fpmuld (double x, double y)
{
	return(x*y);
}

//
// check constants in double-precision..
//
double fpincrd (double x)
{
	return(x + 1.0);
}

// conversions.
double float_to_double (float x)
{
	return((double)x);
}


float double_to_float (double x)
{
	return((float)x);
}

