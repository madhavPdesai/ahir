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
  __declare_bit_vector (sexp, 16);
  __declare_bit_vector (texp, 16);
  {
// implicit declarations for assignment:  file ForkBlock.aa, line 12
    __declare_bit_vector (s_27, 16);
// implicit declarations for assignment:  file ForkBlock.aa, line 13
    __declare_bit_vector (t_32, 16);
    __declare_bit_vector (qexp, 16);
    {
// implicit declarations for assignment:  file ForkBlock.aa, line 8
      __declare_bit_vector (q_13, 16);
//                      q := (a * d)
//  file ForkBlock.aa, line 8
      __declare_bit_vector (MUL_u16_u16_12, 16);
      bit_vector_mul (&(a), &(d), &(MUL_u16_u16_12));
      bit_vector_assign_bit_vector (0, &(MUL_u16_u16_12), &(q_13));
    }
    __declare_bit_vector (rexp, 16);
    {
// implicit declarations for assignment:  file ForkBlock.aa, line 9
      __declare_bit_vector (r_20, 16);
//                      r := (b * c)
//  file ForkBlock.aa, line 9
      __declare_bit_vector (MUL_u16_u16_19, 16);
      bit_vector_mul (&(b), &(c), &(MUL_u16_u16_19));
      bit_vector_assign_bit_vector (0, &(MUL_u16_u16_19), &(r_20));
    }
// join-fork statement :  file ForkBlock.aa, line 11
//              s := (qexp - rexp)
//  file ForkBlock.aa, line 12
    __declare_bit_vector (SUB_u16_u16_26, 16);
    bit_vector_minus (&(qexp_13), &(rexp_20), &(SUB_u16_u16_26));
    bit_vector_assign_bit_vector (0, &(SUB_u16_u16_26), &(s_27));
//              t := (qexp + rexp)
//  file ForkBlock.aa, line 13
    __declare_bit_vector (ADD_u16_u16_31, 16);
    bit_vector_plus (&(qexp_13), &(rexp_20), &(ADD_u16_u16_31));
    bit_vector_assign_bit_vector (0, &(ADD_u16_u16_31), &(t_32));
  }
//      result := (sexp + texp)
//  file ForkBlock.aa, line 18
  __declare_bit_vector (ADD_u16_u16_38, 16);
  bit_vector_plus (&(sexp_27), &(texp_32), &(ADD_u16_u16_38));
  bit_vector_assign_bit_vector (0, &(ADD_u16_u16_38), &(result));
// output side transfers...
  bit_vector_assign_bit_vector (0, &(result), &((*__presult)));
}
