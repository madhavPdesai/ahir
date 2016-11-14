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
#include <Pipes.h>
#include <aa_c_model.h>
void
__init_aa_globals__ ()
{
}

void
sum_mod (uint16_t a, uint16_t b, uint16_t c, uint16_t d, uint16_t * result)
{
  __declare_bit_vector (__a, 16);
  bit_vector_assign_uint64 (0, &__a, a);
  __declare_bit_vector (__b, 16);
  bit_vector_assign_uint64 (0, &__b, b);
  __declare_bit_vector (__c, 16);
  bit_vector_assign_uint64 (0, &__c, c);
  __declare_bit_vector (__d, 16);
  bit_vector_assign_uint64 (0, &__d, d);
  __declare_bit_vector (__result, 16);
  _sum_mod_ (&__a, &__b, &__c, &__d, &__result);
  *result = bit_vector_to_uint64 (0, &__result);
}


void
_sum_mod_ (bit_vector * __pa, bit_vector * __pb, bit_vector * __pc,
	   bit_vector * __pd, bit_vector * __presult)
{
  __declare_bit_vector (a, 16);
  bit_vector_assign_bit_vector (0, &((*__pa)), &(a));
  __declare_bit_vector (b, 16);
  bit_vector_assign_bit_vector (0, &((*__pb)), &(b));
  __declare_bit_vector (c, 16);
  bit_vector_assign_bit_vector (0, &((*__pc)), &(c));
  __declare_bit_vector (d, 16);
  bit_vector_assign_bit_vector (0, &((*__pd)), &(d));
  __declare_bit_vector (result, 16);
  __declare_bit_vector (q__q, 16);
  __declare_bit_vector (r__r, 16);
  {
// implicit declarations for assignment:  file ParallelBlock.aa, line 8
    __declare_bit_vector (q, 16);
// implicit declarations for assignment:  file ParallelBlock.aa, line 9
    __declare_bit_vector (r, 16);
//              q := (a + b)
//  file ParallelBlock.aa, line 8
    __declare_bit_vector (ADD_u16_u16_11, 16);
    bit_vector_plus (&(a), &(b), &(ADD_u16_u16_11));
    bit_vector_assign_bit_vector (0, &(ADD_u16_u16_11), &(q));
//              r := (c + d)
//  file ParallelBlock.aa, line 9
    __declare_bit_vector (ADD_u16_u16_16, 16);
    bit_vector_plus (&(c), &(d), &(ADD_u16_u16_16));
    bit_vector_assign_bit_vector (0, &(ADD_u16_u16_16), &(r));
    bit_vector_assign_bit_vector (0, &(q), &(q__q));
    bit_vector_assign_bit_vector (0, &(r), &(r__r));
  }
//      result := (q + r)
//  file ParallelBlock.aa, line 11
  __declare_bit_vector (ADD_u16_u16_22, 16);
  bit_vector_plus (&(q__q), &(r__r), &(ADD_u16_u16_22));
  bit_vector_assign_bit_vector (0, &(ADD_u16_u16_22), &(result));
// output side transfers...
  bit_vector_assign_bit_vector (0, &(result), &((*__presult)));
}
