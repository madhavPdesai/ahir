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
#include <stdio.h>
int main(void)
#else
int start(void)
#endif
{
  int i;
  uint32_t apl;
  float ong;
  uint64_t apl64;
  uint16_t apl16;
  uint8_t apl8;
  void* ptr;
  double ong64;
  
  for (i = 0; i < 10; ++i) {
    apl64 = read_uint64("apples64");
    #ifdef RUN
    fprintf(stderr, "\n(%d.a) got a 64 bit apple: %llu..", i, apl64);
    #endif
    
    ong64 = (double)apl64;
    write_float64("oranges64", ong64);
    #ifdef RUN
    fprintf(stderr, "\nsent a (double) orange: %le.", ong64);
    #endif

    apl = read_uint32("apples32");
    #ifdef RUN
    fprintf(stderr, "\n(%d.b) got a 32-bit apple: %d.", i, apl);
    #endif
    
    ong = (float)apl;
    write_float32("oranges32", ong);
    #ifdef RUN
    fprintf(stderr, "\nsent a (float) orange: %f.", ong);
    #endif

    apl16 = read_uint16("apples16");
    #ifdef RUN
    fprintf(stderr, "\n(%d.c) got a 16-bit apple: %d.", i, apl16);
    #endif
    
    apl8 = (uint8_t)apl;
    write_uint8("oranges8", apl8);
    #ifdef RUN
    fprintf(stderr, "\nsent an 8-bit orange: %d.", apl8);
    #endif

    ptr = read_pointer("apples32");
    #ifdef RUN
    fprintf(stderr, "\n(%d.d) got a pointer apple: %d.", i, (unsigned int) ptr);
    #endif
    
    write_pointer("oranges32", ptr);
    #ifdef RUN
    fprintf(stderr, "\nsent a pointer orange: %d.", (unsigned int) ptr);
    #endif
  }

  #ifdef RUN
  fprintf(stderr, "\n");
  #endif
  return 0;
}
