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
#include <pthread.h>
#include <pthreadUtils.h>
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
  bit_vector_cast_to_bit_vector (0, &(a), &((*__pa)));
  __declare_bit_vector (b, 16);
  bit_vector_cast_to_bit_vector (0, &(b), &((*__pb)));
  __declare_bit_vector (c, 16);
  __declare_bit_vector (I, 16);
//      I := b
//  file BranchBlock.aa, line 8
  bit_vector_cast_to_bit_vector (0, &(I), &(b));
  __declare_bit_vector (sexp__s, 16);
  {
// implicit declarations for phi statement:  file BranchBlock.aa, line 11
    __declare_bit_vector (s1, 16);
    __declare_bit_vector (s, 16);
// merge:  file BranchBlock.aa, line 10
    uint8_t merge_stmt_10_entry_flag;
    merge_stmt_10_entry_flag = 1;
    uint8_t loopback_9_flag = 0;
    goto merge_stmt_10_run;
  loopback_9:loopback_9_flag = 1;
    goto merge_stmt_10_run;

  merge_stmt_10_run:;
//                      $phi s1 :=                        ($bitcast ($uint<16>) 0  ) $on $entry                   s $on loopback // type of target is $uint<16>
//  file BranchBlock.aa, line 11
    __declare_bit_vector (konst_13, 16);
    __declare_bit_vector (type_cast_14, 16);
    if (loopback_9_flag)
      {
	bit_vector_cast_to_bit_vector (0, &(s1), &(s));
      }
    else
      {
	bit_vector_cast_to_bit_vector (0, &(s1), &(type_cast_14));
      }
    loopback_9_flag = 0;
    merge_stmt_10_entry_flag = 0;
//              s := (s1 + a)
//  file BranchBlock.aa, line 13
    __declare_bit_vector (ADD_u16_u16_20, 16);
    bit_vector_plus (&(s1), &(a), &(ADD_u16_u16_20));
    bit_vector_cast_to_bit_vector (0, &(s), &(ADD_u16_u16_20));
//              I := (I - 1 )
//  file BranchBlock.aa, line 14
    __declare_bit_vector (konst_24, 16);
    __declare_bit_vector (SUB_u16_u16_25, 16);
    bit_vector_clear (&konst_24);
    konst_24.val.byte_array[0] = 1;
    bit_vector_minus (&(I), &(konst_24), &(SUB_u16_u16_25));
    bit_vector_cast_to_bit_vector (0, &(I), &(SUB_u16_u16_25));
// switch statement 
//  file BranchBlock.aa, line 15
    __declare_bit_vector (konst_29, 16);
    __declare_bit_vector (UGT_u16_u1_30, 1);
    bit_vector_clear (&konst_29);
    bit_vector_greater (0, &(I), &(konst_29), &(UGT_u16_u1_30));
    __declare_bit_vector (konst_32, 1);
    bit_vector_clear (&konst_32);
    konst_32.val.byte_array[0] = 1;
    switch (bit_vector_to_uint64 (0, &UGT_u16_u1_30))
      {
      case 1:
	goto loopback_9;
	break;
      default:
	;
	break;
      }
    bit_vector_cast_to_bit_vector (0, &(sexp__s), &(s));
  }
//      c := sexp
//  file BranchBlock.aa, line 17
  bit_vector_cast_to_bit_vector (0, &(c), &(sexp__s));
// output side transfers...
  bit_vector_cast_to_bit_vector (0, &((*__pc)), &(c));
}

void
start_daemons ()
{
  __init_aa_globals__ ();
}

void
stop_daemons ()
{
}
