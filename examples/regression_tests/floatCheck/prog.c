#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#ifdef SW
#include <math.h>
#include <Pipes.h>
#include <fpu.h>
#endif


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


#ifdef SW
float fpsqrt(float x)
{
	return(pow(x,0.5));
}
#endif

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

double fpaddd(double x, double y)
{
	return(x+y);
}

double fpsubd(double x, double y)
{
	return(x-y);
}


double fpmuld (double x, double y)
{
	return(x*y);
}

int32_t fpd2int(double x)
{
	return((int32_t) x);
}

uint32_t fpd2uint(double x)
{
	return((uint32_t) x);
}

float int2float(int32_t x)
{
  return((float) x);
}

double int2double(int32_t x)
{
  return((double) x);
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


uint32_t double_to_int(double x)
{
	return((uint32_t) x);
}

uint32_t float_to_int(float x)
{
	return((uint32_t) x);
}
