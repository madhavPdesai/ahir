//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
/*
 * test.c
 *
 *  Created on: Apr 1, 2014
 *      Author: sarath
 */

#include <stdio.h>
#include <stdint.h>

uint64_t getSlice64(uint64_t reg, uint8_t h, uint8_t l)
{
	reg = reg << (63 - h);
	reg = reg >> (63 - h + l);
	return reg;
}

uint8_t getBit64(uint64_t reg, uint8_t pos)
{
	return getSlice64(reg, pos, pos);
}

uint64_t setSlice64(uint64_t reg, uint8_t h, uint8_t l, uint64_t value)
{
	uint64_t mask = -1;
	mask = mask >> (63 - h + l);
	value = value & mask;
	value = value << l;

	mask = mask << l;
	reg = reg & ~mask;
	reg = reg | value;
	return reg;
}

uint64_t setBit64(uint64_t reg, uint8_t pos, uint8_t value)
{
	return setSlice64(reg, pos, pos, value);
}



double doubleDivInner(double a, double b)
{
	uint64_t n = *((uint64_t*) &a);
	uint64_t d = *((uint64_t*) &b);

	uint64_t n_val = getSlice64(n, 62, 0);
	uint64_t d_val = getSlice64(d, 62, 0);

	uint8_t s_n = getBit64(n, 63);
	uint8_t s_d = getBit64(d, 63);

	uint16_t e1 = getSlice64(n, 62, 52);
	uint16_t e2 = getSlice64(d, 62, 52);

	uint16_t e1_new = (n_val == 0) ? 0 : (e1 - e2 + 1022);
	uint16_t e2_new = 1022;

	uint64_t n1 = setSlice64(n, 62, 52, e1_new);
	uint64_t d1 = setSlice64(d, 62, 52, e2_new);

	uint64_t n_new = setBit64(n1, 63, 0);
	uint64_t d_new = setBit64(d1, 63, 0);

	double a_new = *((double*) &n_new);
	double b_new = *((double*) &d_new);

	double x0 = 2.8235294818878173828125 - 1.88235294818878173828125 * b_new;

	int i;

	//for(i = 0; i < 4; i++)
	//{
	//	x = x * (2 - b_new * x);
	//}

	double x1 = x0 * (2 - b_new * x0);
	double x2 = x1 * (2 - b_new * x1);
	double x3 = x2 * (2 - b_new * x2);
	double x4 = x3 * (2 - b_new * x3);

	/*uint64_t tmp = 0x7ff0000000000000;
	 uint64_t tmp1 = 0x7fffffffffffffff;

	 double inf = *((double*) &tmp);
	 double nan = *((double*) &tmp1);*/

	double res = 0;

	/*res = ((n_val == 0) && (d_val == 0)) ? nan : res;
	 res = ((n_val != 0) && (d_val == 0)) ? inf : res;*/

	res = ((n_val != 0) && (d_val != 0)) ? (a_new * x4) : res;

	//res = (s_n ^ s_d) ? -res : res;

	uint64_t res_uint = *((uint64_t*) &res);
	res_uint = setBit64(res_uint, 63, s_n ^ s_d);

	res = *((double*) &res_uint);

	return res;
}

double doubleDiv(double a, double b)
{
	return(doubleDivInner(a,b));
}

// Assumes that float is in the IEEE 754 double precision floating point format
double doubleSqrtApprox(uint64_t val_uint)
{
	/*
	 * To justify the following code, prove that
	 *
	 * ((((val_int / 2^m) - b) / 2) + b) * 2^m = ((val_int - 2^m) / 2) + ((b + 1) / 2) * 2^m)
	 *
	 * where
	 *
	 * b = exponent bias
	 * m = number of mantissa bits
	 *
	 * .
	 */

	val_uint -= (((uint64_t) 1) << 52); /* Subtract 2^m. */
	val_uint >>= 1; /* Divide by 2. */
	val_uint += (((uint64_t) 1) << 61); /* Add ((b + 1) / 2) * 2^m. */

	return *((double*) &val_uint); /* Interpret again as double */
}

double doubleSqrt(double a)
{
	uint64_t u = *((uint64_t*) &a);
	double x0 = doubleSqrtApprox(u);
	uint8_t s = getBit64(u, 63);
	uint64_t u_val = getSlice64(u, 62, 0);

	int i;

	//for(i = 0; i < 3; i++)
	//{
	//	x = 0.5 * (x + doubleDiv(a, x));
	//}
	double x1 = 0.5 * (x0 + doubleDivInner(a, x0));
	double x2 = 0.5 * (x1 + doubleDivInner(a, x1));
	double x3 = 0.5 * (x2 + doubleDivInner(a, x2));
	double x4 = 0.5 * (x3 + doubleDivInner(a, x3));

	//uint64_t tmp = 0xffffffffffffffff;
	//double nan = *((double*) &tmp);

	double res = 0;

	//res = (u_val && s ? nan : res);
	//res = (u_val && !s ? x3 : res);
	res = (u_val && !s ? x4 : res);

	return res;
}
