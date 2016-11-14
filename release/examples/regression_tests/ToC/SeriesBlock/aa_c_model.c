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
sum_mod (uint16_t a, uint16_t b, uint16_t * c)
{
  __declare_bit_vector (__a, 16);
  bit_vector_assign_uint64 (0, &__a, a);
  __declare_bit_vector (__b, 16);
  bit_vector_assign_uint64 (0, &__b, b);
  __declare_bit_vector (__c, 16);
  _sum_mod_ (&__a, &__b, &__c);
  *c = bit_vector_to_uint64 (0, &__c);
}


void
_sum_mod_ (bit_vector * __pa, bit_vector * __pb, bit_vector * __pc)
{
  __declare_bit_vector (a, 16);
  bit_vector_assign_bit_vector (0, &((*__pa)), &(a));
  __declare_bit_vector (b, 16);
  bit_vector_assign_bit_vector (0, &((*__pb)), &(b));
  __declare_bit_vector (c, 16);
  __declare_bit_vector (x, 16);
//      x := (a + b)
//  file SeriesBlock.aa, line 9
  __declare_bit_vector (ADD_u16_u16_9, 16);
  bit_vector_plus (&(a), &(b), &(ADD_u16_u16_9));
  bit_vector_assign_bit_vector (0, &(ADD_u16_u16_9), &(x));
//      x := (x - b)
//  file SeriesBlock.aa, line 10
  __declare_bit_vector (SUB_u16_u16_14, 16);
  bit_vector_minus (&(x), &(b), &(SUB_u16_u16_14));
  bit_vector_assign_bit_vector (0, &(SUB_u16_u16_14), &(x));
//      x := (x * b)
//  file SeriesBlock.aa, line 11
  __declare_bit_vector (MUL_u16_u16_19, 16);
  bit_vector_mul (&(x), &(b), &(MUL_u16_u16_19));
  bit_vector_assign_bit_vector (0, &(MUL_u16_u16_19), &(x));
//      x := (x ~| b)
//  file SeriesBlock.aa, line 12
  __declare_bit_vector (NOR_u16_u16_24, 16);
  bit_vector_nor (&(x), &(b), &(NOR_u16_u16_24));
  bit_vector_assign_bit_vector (0, &(NOR_u16_u16_24), &(x));
//      x := (x ~& b)
//  file SeriesBlock.aa, line 13
  __declare_bit_vector (NAND_u16_u16_29, 16);
  bit_vector_nand (&(x), &(b), &(NAND_u16_u16_29));
  bit_vector_assign_bit_vector (0, &(NAND_u16_u16_29), &(x));
//      x := (x ~^ b)
//  file SeriesBlock.aa, line 14
  __declare_bit_vector (XOR_u16_u16_34, 16);
  bit_vector_xnor (&(x), &(b), &(XOR_u16_u16_34));
  bit_vector_assign_bit_vector (0, &(XOR_u16_u16_34), &(x));
//      x := (x ^ b)
//  file SeriesBlock.aa, line 15
  __declare_bit_vector (XOR_u16_u16_39, 16);
  bit_vector_xor (&(x), &(b), &(XOR_u16_u16_39));
  bit_vector_assign_bit_vector (0, &(XOR_u16_u16_39), &(x));
//      x := (x & b)
//  file SeriesBlock.aa, line 16
  __declare_bit_vector (AND_u16_u16_44, 16);
  bit_vector_and (&(x), &(b), &(AND_u16_u16_44));
  bit_vector_assign_bit_vector (0, &(AND_u16_u16_44), &(x));
//      x := (x | b)
//  file SeriesBlock.aa, line 17
  __declare_bit_vector (OR_u16_u16_49, 16);
  bit_vector_or (&(x), &(b), &(OR_u16_u16_49));
  bit_vector_assign_bit_vector (0, &(OR_u16_u16_49), &(x));
//      c := x
//  file SeriesBlock.aa, line 18
  bit_vector_assign_bit_vector (0, &(x), &(c));
// output side transfers...
  bit_vector_assign_bit_vector (0, &(c), &((*__pc)));
}
