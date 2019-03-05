#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>


//
// check constants in double-precision..
//
double fpincrd (double x)
{
	return(x + 1.0);
}

double fpstod (float x)
{
	return((double) x);
}

float fpdtos(double x)
{
	return((float) x);
}
