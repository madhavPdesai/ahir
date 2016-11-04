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
#ifdef RUN
#include <stdio.h>
#endif

void global_storage_initializer_();
float sqroot (float number)
{
	int i;
	float ulimit = 0, llimit = 0, mid = 0, temp = 0;
	float eps = 0.0001;

/*	ulimit = number;
	llimit = 0.0;
*/
	global_storage_initializer_();

        if(number > 1.0)
	{
		ulimit = number;
		llimit = 0;
	}
	else
	{
		ulimit = 1.0;
		llimit = number;
	}
	
	for( i=0; i<13 ;i++)
	{
		mid = (ulimit + llimit) * 0.5;
		temp = mid*mid;
		if(temp < number)
		{	
			llimit = mid;
		}
		else
		{
			ulimit = mid;
		}
	}

	return mid;
}

int main()
{
	float sq=3.0;
	
	sq = sqroot(sq);

#ifdef RUN
	printf("%f  %x\n",sq, *((int*)(&sq)));
#endif 
	return 0;
}
