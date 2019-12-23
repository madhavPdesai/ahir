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
#include <stdio.h>
#include <pipeHandler.h>
#include <pthreadUtils.h>
#ifdef AA2C
#include <aa_c_model.h>
#include <Pipes.h>
#else
#include <SocketLib.h>
#include <SockPipes.h>
#include <vhdlCStubs.h>
#endif

int test_smul(int16_t a, int16_t b)
{
	int err = 0;
	int16_t r, er;

	er = a*b;
#ifdef AA2C
	smul (a,b,&r);
#else
	r = smul (a,b);
#endif
	if(r != er)
	{
		fprintf(stderr,"Error:smul: %d*%d=%d, expected %d\n", a,b,r,er);
		err = 1;
	}

	return(err);
}

#if 0
int test_sdiv(int16_t a, int16_t b)
{
	int err = 0;
	int16_t r, er;
	er = a/b;
#ifdef AA2C
	sdiv (a,b,&r);
#else
	r = sdiv (a,b);
#endif
	if(r != er)
	{
		fprintf(stderr,"Error:sdiv: %d/%d=%d, expected %d\n", a,b,r,er);
		err = 1;
	}
	return(err);
}
#endif

int testdotp(int8_t a, int8_t b)
{
	int err = 0;
	int32_t er = ((int32_t)a)*((int32_t)b)*128;
	int32_t r;
#ifdef AA2C
	fdotP (a,b,&r);
#else
	r = fdotP (a,b);
#endif
	if(r != er)
	{
		err = 1;
		fprintf(stderr,"Error:fdotP(%d,%d)=%d, expected %d\n", a,b,r,er);
	}
	return(err);
}



// the main program which calls the shift register
int main(int argc, char* argv[])
{
	int NSAMPLES=1000;
	if(argc > 1)
		NSAMPLES = atoi(argv[1]);

#ifdef AA2C
	_set_trace_file(stdout);
#endif
	int err = 0;
	int I = 0;

	err = test_smul(0x7fff, 0x7fff) || err;
	err = test_smul(0x7fff, -0x7fff) || err;



	srand (1);
	for(I=0; I < NSAMPLES; I++)
	{
		int16_t a = rand();
		int16_t b = rand();


		err = test_smul(a,b) || err;
		err = test_smul(-a,b) || err;
		err = test_smul(a,-b) || err;
		err = test_smul(-a,-b) || err;
		
#if 0
		if(b != 0)
		{
			err = test_sdiv (a,b) || err;
			err = test_sdiv (-a,b) || err;
			err = test_sdiv (a,-b) || err;
			err = test_sdiv (-a,-b) || err;
		}
#endif

		err = testdotp (a,b) | err;
	}

	if(err)
		fprintf(stderr,"FAILURE :-(\n");
	else
		fprintf(stderr,"SUCCESS!\n");

	return(err);
}



