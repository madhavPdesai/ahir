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
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>


// note: initialized value..
uint32_t sum1 = 23;
uint32_t sum2 = 39;

// note: no problems with pointers :-)
uint32_t* tgt[2] = {&sum1, &sum2};

uint32_t get_sum(uint32_t idx)
{
    return(*(tgt[idx]));
}

void accumulate()
{
    int i = 0;
    while(1)
    {
	int nxt = read_uint32("in_data");
#ifdef SW
	printf("read %u\n", nxt);
#endif
	// ugly, but this is just a demo!
	*(tgt[i])= ((*tgt[i]) + nxt);

	write_uint32("out_data",*(tgt[i]));
#ifdef SW
	printf("wrote %u\n", *(tgt[i]));
#endif
	i = 1 - i;
    }
}

