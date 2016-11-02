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
#include <Aa2C.h>
typedef struct sum_mod_State__
{
  uint_10 a;
  uint_10 b;
  uint_10 c;
  uint_10 d;
  uint_10 result;
  struct _p__
  {
    unsigned int p_entry:1;
    unsigned int p_exit:1;
    unsigned int p_in_progress:1;
    struct _s1__
    {
      unsigned int s1_entry:1;
      unsigned int s1_exit:1;
      unsigned int s1_in_progress:1;
      unsigned int _assign_line_8_entry:1;
      unsigned int _assign_line_8_in_progress:1;
      unsigned int _assign_line_8_exit:1;
      uint_10 q;
    } s1;
    struct _s2__
    {
      unsigned int s2_entry:1;
      unsigned int s2_exit:1;
      unsigned int s2_in_progress:1;
      unsigned int _assign_line_9_entry:1;
      unsigned int _assign_line_9_in_progress:1;
      unsigned int _assign_line_9_exit:1;
      uint_10 r;
    } s2;
    unsigned int _join_line_11_entry:1;
    unsigned int _join_line_11_exit:1;
    unsigned int _join_line_11_in_progress:1;
    unsigned int _assign_line_12_entry:1;
    unsigned int _assign_line_12_in_progress:1;
    unsigned int _assign_line_12_exit:1;
    uint_10 s;
    unsigned int _assign_line_13_entry:1;
    unsigned int _assign_line_13_in_progress:1;
    unsigned int _assign_line_13_exit:1;
    uint_10 t;
  } p;
  unsigned int _assign_line_16_entry:1;
  unsigned int _assign_line_16_in_progress:1;
  unsigned int _assign_line_16_exit:1;
  unsigned sum_mod_entry:1;
  unsigned sum_mod_in_progress:1;
  unsigned sum_mod_exit:1;
} sum_mod_State;
sum_mod_State *sum_mod_ (sum_mod_State *);
int sum_mod (uint_10, uint_10, uint_10, uint_10, uint_10 *);
