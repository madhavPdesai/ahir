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
#include <stdio.h>

#ifdef SW
#include "prog.h"
#else
#include "vhdlCStubs.h"
#endif

int main()
{
	float a, b, c, d;
	float res1, res2, res3;
	double res4, res5, res6;
	printf("Enter 2 floats and two doubles \n");
	scanf("%f %f", &a, &b);
	scanf("%f %f", &c, &d);

	res1 = doubleDiv(a, b);
	printf("**********************************FLOAT OPERATIONS**************************\n");
	printf("%f / %f = %0.10f \n", a, b, res1);
	res2 = doubleSqrt(a);
	printf("sqrt of %f is %0.10f\n", a, res2);
	res3 = doubleSqrt(b);
	printf("sqrt of %f is %0.10f\n", b, res3);

	printf("**********************************DOUBLE OPERATIONS**************************\n");
	res4 = doubleDiv(c, d);
	printf("%f / %f = %0.10f\n", c, d, res4);
	res5 = doubleSqrt(c);
	printf("sqrt of %f is %0.10f\n", c, res5);
	res6 = doubleSqrt(d);
	printf("sqrt of %f is %0.10f\n", d, res6);



	return 0;
}
