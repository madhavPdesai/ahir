#ifndef _fpu_h__
#define _fpu_h__

#include <stdint.h>

#define ADD  0
#define SUB  1
#define MUL  2

float fpu32(float, float, uint8_t);
float fpmul32(float, float);
float fpadd32(float, float);
float fpsub32(float, float);

double fpu64  (double, double, uint8_t);
double fpmul64(double, double);
double fpadd64(double, double);
double fpsub64(double, double);

#endif
