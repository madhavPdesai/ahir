#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>



float fpmul(float x, float y)
{
	return(x*y);
}

float fpadd(float x, float y)
{
	return(x+y);
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
