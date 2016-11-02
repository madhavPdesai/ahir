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
#include "../iolib.h"
#define RUN

#ifdef RUN
#include <stdlib.h>
#include <stdio.h>

int main (void)
#else
int start (void)
#endif
{
  uint64_t apl64;
  uint32_t i, apl;
  uint16_t apl16;
  uint8_t apl8,my_apl8;
  void *sptr, *rptr;
  double ong64, my_ong64;
  float ong, my_ong;
  int failure = 0;

  i = 0;

  while (i < 10) {
    #ifdef RUN
    apl = rand();
    #else
    apl = i + 1;
    #endif
    my_ong = (float)apl;
    my_ong64 = (double)apl;
    apl64  = (uint64_t)apl;
    apl16  = (uint16_t)apl;
    my_apl8  = (uint8_t)apl16;
    
    write_uint64("apples64", apl64);
    #ifdef RUN
    fprintf(stderr, "\n(%d.a) sent a 64-bit apple: %llu..", i, apl64);
    #endif
    
    ong64 = read_float64("oranges64");

    #ifdef RUN
    fprintf(stderr, "\ngot a (double) orange: %le.", ong64);
    #endif

    failure |= (my_ong64 != ong64);

    write_uint32("apples32", apl);
    #ifdef RUN
    fprintf(stderr, "\n(%d.b) sent a 32-bit apple: %d.", i, apl);
    #endif

    ong = read_float32("oranges32");
    #ifdef RUN
    fprintf(stderr, "\ngot a (float) orange: %f.", ong);
    #endif
    
    failure |= (my_ong != ong);

    write_uint16("apples16", apl16);
    #ifdef RUN
    fprintf(stderr, "\n(%d.c) sent a 16-bit apple: %d.", i, apl16);
    #endif

    apl8 = read_uint8("oranges8");
    #ifdef RUN
    fprintf(stderr, "\ngot an 8-bit orange: %d.", apl8);
    #endif

    sptr = (void*) &apl;
    write_pointer("apples32", sptr);
    #ifdef RUN
    fprintf(stderr, "\n(%d.d) sent a pointer apple: %d.", i, (unsigned int)sptr);
    #endif

    rptr = read_pointer("oranges32");
    #ifdef RUN
    fprintf(stderr, "\ngot a pointer orange: %d.",(unsigned int) rptr);
    #endif
    
    failure |= (sptr != rptr);
    ++i;
  }

  #ifdef RUN
  if (failure == 0)
    fprintf(stderr, "\nAll conversions successful.\n");
  else
    fprintf(stderr, "\nSome conversion(s) failed.\n");
  #endif
    
  return failure;
}
