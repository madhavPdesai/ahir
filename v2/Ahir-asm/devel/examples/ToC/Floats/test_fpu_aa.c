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
#include <stdlib.h>
#include <math.h>
#include <aa_c_model.h>
#include <stdio.h>
#include <stdint.h>


//
// double precision checks.
//
int main (int argc, char* argv [])
{
	int I;

	srand48(1963);
	start_daemons();	

	for(I = 0; I < 100; I++)
	{
		double A = drand48();
		double B = drand48();

		double mul_result; 
		fpmul64(A,B, &mul_result);
		fprintf(stderr,"%le X %le = %le, expected %le\n", A,B, mul_result, A*B);

		double add_result;  
		fpadd64(A,B, &add_result);
		fprintf(stderr,"%le + %le = %le, expected %le\n", A,B, add_result, A+B);

		double sub_result;
	        fpsub64(A,B, &sub_result);
		fprintf(stderr,"%le - %le = %le, expected %le\n", A,B, sub_result, A-B);

		double div_result;
		fpdiv64(A,B,&div_result);
		fprintf(stderr,"%le / %le = %le, expected %le\n", A,B, div_result, A/B);

		double sqrt_result; 
		fpsqrt64(A,&sqrt_result);
		fprintf(stderr,"sqrt(%le) = %le, expected %le\n", A, sqrt_result, pow(A,0.5));
	}

	return(0);
}

