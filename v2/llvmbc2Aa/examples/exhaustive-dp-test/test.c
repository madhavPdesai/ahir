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

int int_x[6];
int int_y[6];

int int_arith[3];
unsigned int_cmp[6];
int int_shift[2];

unsigned short short_x[6];
unsigned short short_y[6];

unsigned short short_arith[3];
unsigned short short_cmp[6];
unsigned short short_shift[2];

float float_x[6];
float float_y[6];

float float_arith[3];
unsigned float_cmp[6];

int test_ints()
{
  unsigned int cmp_vector = 0;
  int result = 0;
  int i;
  
  int_arith[0] = int_x[0] + int_y[0];
  int_arith[1] = int_x[1] - int_y[1];
  int_arith[2] = int_x[2] * int_y[2];

  int_cmp[0] = int_x[0] > int_y[0];
  int_cmp[1] = int_x[1] >= int_y[1];
  int_cmp[2] = int_x[2] < int_y[2];
  int_cmp[3] = int_x[3] <= int_y[3];
  int_cmp[4] = int_x[4] == int_y[4];
  int_cmp[5] = int_x[5] != int_y[5];

  for (i = 0; i < 6; i++)
    cmp_vector = cmp_vector & (int_cmp[i] << (i << 2));

  int_shift[0] = int_x[0] >> 4;
  int_shift[1] = int_y[0] << 4;

  result = int_arith[0];
  result &= int_arith[1];
  result |= int_arith[2];
  
  result ^= int_shift[0];
  result ^= int_shift[1];

  result += cmp_vector;

#ifdef RUN
  printf("%x\n", result);
#endif
  return result;
}

short test_shorts()
{
  short cmp_vector = 0;
  short result = 0;
  int i;
  
  short_arith[0] = short_x[0] + short_y[0];
  short_arith[1] = short_x[1] - short_y[1];
  short_arith[2] = short_x[2] * short_y[2];

  short_cmp[0] = short_x[0] > short_y[0];
  short_cmp[1] = short_x[1] >= short_y[1];
  short_cmp[2] = short_x[2] < short_y[2];
  short_cmp[3] = short_x[3] <= short_y[3];
  short_cmp[4] = short_x[4] == short_y[4];
  short_cmp[5] = short_x[5] != short_y[5];

  for (i = 0; i < 6; i++)
    cmp_vector = cmp_vector & (short_cmp[i] << (i << 2));

  short_shift[0] = short_x[0] >> 4;
  short_shift[1] = short_y[0] << 4;

  result = short_arith[0];
  result &= short_arith[1];
  result |= short_arith[2];
  
  result ^= short_shift[0];
  result ^= short_shift[1];

  result += cmp_vector;

#ifdef RUN
  printf("%x\n", result);
#endif
  return result;
}

float test_floats()
{
  unsigned cmp_vector = 0;
  float result = 0;
  int i;
  
  float_arith[0] = float_x[0] + float_y[0];
  float_arith[1] = float_x[1] - float_y[1];
  float_arith[2] = float_x[2] * float_y[2];

  float_cmp[0] = float_x[0] > float_y[0];
  float_cmp[1] = float_x[1] >= float_y[1];
  float_cmp[2] = float_x[2] < float_y[2];
  float_cmp[3] = float_x[3] <= float_y[3];
  float_cmp[4] = float_x[4] == float_y[4];
  float_cmp[5] = float_x[5] != float_y[5];

  for (i = 0; i < 6; i++)
    cmp_vector = cmp_vector & (float_cmp[i] << (i << 2));

  result = float_arith[0];
  result += float_arith[1];
  result -= float_arith[2];
  
  result += cmp_vector;

#ifdef RUN
  printf("%f\n", result);
#endif
  return result;
}

#define next(x) ((x & 0x00100000) >> 20) ^ ((x & 0x00000100) >> 8) | (x << 1)

int start (void)
{
  int i;
  unsigned int reg = 0x5B5AB714;
  
  for (i = 0; i < 6; i++) {
    reg = next(reg);
    int_x[i] = reg;
    
    reg = next(reg);
    int_y[i] = reg;
  }

  for (i = 0; i < 6; i++) {
    reg = next(reg);
    short_x[i] = reg;
    
    reg = next(reg);
    short_y[i] = reg;
  }

  i = 0;
  float_x[i++] = 0.055237;
  float_x[i++] = 0.615051;
  float_x[i++] = -1.964783;
  float_x[i++] = 0.054016;
  float_x[i++] = 0.800354;
  float_x[i++] = 1.106262;

  i = 0;
  float_y[i++] = -0.324402;
  float_y[i++] = -1.755798;
  float_y[i++] = 1.130188;
  float_y[i++] = -0.162537;
  float_y[i++] = 0.073059;
  float_y[i++] = 0.309631;

  return test_ints() ^ (int)test_floats() ^ test_shorts();
}

int main(void)
{
   int tval = start();
#ifdef RUN
  printf("%x\n", tval);
#endif
  return(tval);
}
