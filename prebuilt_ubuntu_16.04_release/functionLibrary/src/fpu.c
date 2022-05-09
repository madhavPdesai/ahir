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
#include <fpu.h>

#define _BITCAST_(Type,val) *((Type*)&val)
#define _GET_SLICE_(x,H,L,W) ((x << ((W-1)-H)) >> (((W-1)-H)+L))

#define _SET_SLICE_(oval, inval, h, l, value, Type, W) Type oval; {\
	Type mask = -1;\
	mask = mask >> ((W-1) - h + l);\
	oval = ((value & mask) << l);\
	mask = mask << l;\
	oval = ((inval & ~mask) | oval);}

float fpu32(float L, float R, uint8_t op_id) 
{
	switch(op_id)
	{
		case MUL__: 
			return (L*R); 
			break;
		case ADD__: 
			return (L+R); 
			break;
		case SUB__: 
			return (L-R); 
			break;
		default : 
			break;
	}

	return(0.0);
}
float fpmul32(float L, float R) {return (L*R); }
float fpadd32(float L, float R) {return (L+R); }
float fpsub32(float L, float R) {return (L-R); }
float fpdiv32(float L, float R) 
{
	return((float) fpdiv64((double)L, (double)R));
}
float fpsqrt32(float L)
{
	return((float) fpsqrt64((double)L));
}


double fpu64(double L, double R, uint8_t op_id) 
{
	switch(op_id)
	{
		case MUL__: 
			return (L*R); 
			break;
		case ADD__: 
			return (L+R); 
			break;
		case SUB__: 
			return (L-R); 
			break;
		default : 
			break;
	}

	return(0.0);
}
double fpmul64(double L, double R) {return (L*R); }
double fpadd64(double L, double R) {return (L+R); }
double fpsub64(double L, double R) {return (L-R); }

double fpdiv64(double a, double b)
{
	uint64_t n = _BITCAST_(uint64_t,a);
	uint64_t d = _BITCAST_(uint64_t,b);

	uint64_t n_val = _GET_SLICE_(n, 62, 0, 64);
	uint64_t d_val = _GET_SLICE_(d, 62, 0, 64);

	uint8_t s_n = _GET_SLICE_(n, 63,63,64);
	uint8_t s_d = _GET_SLICE_(d, 63,63,64);

	uint16_t e1 = _GET_SLICE_(n, 62, 52, 64);
	uint16_t e2 = _GET_SLICE_(d, 62, 52, 64);

	uint16_t e1_new = (n_val == 0) ? 0 : (e1 - e2 + 1022);
	uint16_t e2_new = 1022;

	

	_SET_SLICE_ (n1, n, 62, 52, e1_new, uint64_t,64 );
	_SET_SLICE_ (d1, d, 62, 52, e2_new, uint64_t,64 );
	_SET_SLICE_(n_new, n1, 63, 63, 0, uint64_t,64);
	_SET_SLICE_(d_new, d1, 63, 63, 0, uint64_t,64);

	double a_new = _BITCAST_(double,n_new);
	double b_new = _BITCAST_(double,d_new);

	double x = fpsub64(2.8235294818878173828125 , fpmul64(1.88235294818878173828125 , b_new));

	int i = 0;

	for(; i < 4; i++)
	{
		x = fpmul64(x , fpsub64(2 , fpmul64(b_new , x)));
	}

	//uint64_t tmp = 0x7ff0000000000000;
	//uint64_t tmp1 = 0x7fffffffffffffff;

	//double inf = _BITCAST_(double,tmp);
	//double nan = _BITCAST_(double,tmp1);

	double res = 0;

	//res = ((n_val == 0) && (d_val == 0)) ? nan : res;
	//res = ((n_val != 0) && (d_val == 0)) ? inf : res;

	res = ((n_val != 0) && (d_val != 0)) ? fpmul64(a_new , x) : res;

	//res = (s_n ^ s_d) ? -res : res; Working in s/w. Simulation very slow in AHIR. Provided work around as below.

	uint64_t res_uint_0 = _BITCAST_(uint64_t,res);
	_SET_SLICE_(res_uint,res_uint_0,63,63, s_n ^ s_d, uint64_t,64);

	res = _BITCAST_(double,res_uint);

	return res;
}


// Assumes that float is in the IEEE 754 double precision floating point format
double doubleSqrtApprox(uint64_t val_uint)
{
	 //To justify the following code, prove that
	 //((((val_int / 2^m) - b) / 2) + b) * 2^m = ((val_int - 2^m) / 2) + ((b + 1) / 2) * 2^m)
	 //where
	 //b = exponent bias
	 //m = number of mantissa bits

	val_uint -= (uint64_t) 1 << 52; // Subtract 2^m.
	val_uint >>= 1; // Divide by 2.
	val_uint += (uint64_t) 1 << 61; // Add ((b + 1) / 2) * 2^m.

	return _BITCAST_(double,val_uint); // Interpret again as double.
}

double fpsqrt64(double a)
{
	uint64_t u = _BITCAST_(uint64_t,a);
	double x = (a <= 0 ) ? 0 : doubleSqrtApprox(u);
	uint8_t s = _GET_SLICE_(u, 63, 63, 64);
	uint64_t u_val = _GET_SLICE_(u, 62, 0, 64);

	int i = 0;
	
	for(; (i < 3) && (x!=0) ; i++)
	{
		x = fpmul64(0.5 , fpadd64(x , fpdiv64(a, x)));
	}

	//uint64_t tmp = 0x7fffffffffffffff;
	//double nan = _BITCAST_(double,tmp);

	double res = 0;
	
	//res = (u_val && s ? nan : res);
	res = (u_val && !s ? x : res);

	return res;
}

