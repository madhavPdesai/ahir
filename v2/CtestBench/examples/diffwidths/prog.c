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
#include <iolib.h>
#include <stdio.h>

#include "prog.h"

void reverse(uint8_t* buf8, uint32_t len)
{
	int t = len-1;
        int imax = len >> 1;
        int i;
	uint8_t tmp;

	for(i = 0; i <= imax ; i++)
	{
		tmp = buf8[i];
		buf8[i] = buf8[t-i];	
		buf8[t-i] = tmp;	
	}
}

void io_module()
{
    uint8_t buf8[4096];
    while(1)
    {

	// number of bytes to be read..
       	uint32_t len8 = read_uint32("inpipe");

	// read the uint32_t's and stuff them into buf.
	int i;
	for(i=0; i < len8; i=i+4)
		*((uint32_t*)(buf8 + i)) = read_uint32("inpipe");

	// reverse bytes.
	reverse(buf8,len8);
			
 
	// send the packet as uint8_t's..
	// first the length.
	uint8_t* lenptr = (uint8_t*) (&len8);
	// least-significant byte first.
	for(i=0; i < 4; i++)
		write_uint8("outpipe",lenptr[i]);

	// then the packet.
	for(i=0; i < len8; i++)
		write_uint8("outpipe", buf8[i]);

    }
}

