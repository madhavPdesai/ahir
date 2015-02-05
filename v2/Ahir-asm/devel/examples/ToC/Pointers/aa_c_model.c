#include <Pipes.h>
#include <aa_c_model.h>
bit_vector u;
bit_vector v;
void __init_aa_globals__() 
{
init_bit_vector(&u, 32);
init_bit_vector(&v, 32);
}
void increment(uint32_t incr_a , uint32_t*  incr_b )
{
__declare_bit_vector(__incr_a, 32);
bit_vector_assign_uint64(0, &__incr_a, incr_a);
__declare_bit_vector(__incr_b, 32);
_increment_( &__incr_a,  &__incr_b);
 *incr_b =  bit_vector_to_uint64(0, &__incr_b);
}


void _increment_(bit_vector* __pincr_a, bit_vector*  __pincr_b)
{
__declare_bit_vector(incr_a,32);
bit_vector_assign_bit_vector(0, &((*__pincr_a)), &(incr_a));
__declare_bit_vector(incr_b,32);
__declare_bit_vector(incr_temp,32);
// implicit declarations for assignment:  file Pointers.aa, line 11
bit_vector* incr_t1;
// 	incr_t1 := ($cast ($pointer< $uint<32> >) incr_a )
//  file Pointers.aa, line 11
bit_vector* type_cast_13;
type_cast_13 = (bit_vector**)  bit_vector_to_uint64(0, &(incr_a));
memcpy( &incr_t1, &type_cast_13, sizeof(incr_t1));
// 	incr_temp := ->(incr_t1)
//  file Pointers.aa, line 12
__declare_bit_vector(ptr_deref_17,32);
bit_vector_assign_bit_vector(0, &(*incr_t1), &(ptr_deref_17));
bit_vector_assign_bit_vector(0, &(ptr_deref_17), &(incr_temp));
// 	->(incr_t1) := (incr_temp + 1 )
//  file Pointers.aa, line 13
__declare_bit_vector(konst_22,32);
__declare_bit_vector(ADD_u32_u32_23,32);
konst_22.val.byte_array[0] = 1;
konst_22.val.byte_array[1] = 0;
konst_22.val.byte_array[2] = 0;
konst_22.val.byte_array[3] = 0;
bit_vector_plus( &(incr_temp), &(konst_22), &(ADD_u32_u32_23));
__declare_bit_vector(ptr_deref_20,32);
bit_vector_assign_bit_vector(0, &(ADD_u32_u32_23), &(ptr_deref_20));
// 	incr_b := ->(incr_t1)
//  file Pointers.aa, line 14
__declare_bit_vector(ptr_deref_27,32);
bit_vector_assign_bit_vector(0, &(*incr_t1), &(ptr_deref_27));
bit_vector_assign_bit_vector(0, &(ptr_deref_27), &(incr_b));
// output side transfers...
bit_vector_assign_bit_vector(0, &(incr_b), &((*__pincr_b)));
}
void passpointer(uint32_t a , uint32_t*  b )
{
__declare_bit_vector(__a, 32);
bit_vector_assign_uint64(0, &__a, a);
__declare_bit_vector(__b, 32);
_passpointer_( &__a,  &__b);
 *b =  bit_vector_to_uint64(0, &__b);
}


void _passpointer_(bit_vector* __pa, bit_vector*  __pb)
{
__declare_bit_vector(a,32);
bit_vector_assign_bit_vector(0, &((*__pa)), &(a));
__declare_bit_vector(b,32);
// implicit declarations for assignment:  file Pointers.aa, line 24
bit_vector* pu;
// implicit declarations for assignment:  file Pointers.aa, line 25
bit_vector* pv;
// implicit declarations for assignment:  file Pointers.aa, line 26
__declare_bit_vector(t,32);
// implicit declarations for assignment:  file Pointers.aa, line 27
__declare_bit_vector(s,32);
// implicit declarations for assignment:  file Pointers.aa, line 28
__declare_bit_vector(t1,32);
// implicit declarations for assignment:  file Pointers.aa, line 29
__declare_bit_vector(q,32);
// 	u := a
//  file Pointers.aa, line 22
bit_vector_assign_bit_vector(0, &(a), &(u));
// 	v := a
//  file Pointers.aa, line 23
bit_vector_assign_bit_vector(0, &(a), &(v));
// 	pu := @(u)
//  file Pointers.aa, line 24
bit_vector* addr_of_41;
bit_vector* addr_of_41;
addr_of_41 = &(u);
memcpy( &pu, &addr_of_41, sizeof(pu));
// 	pv := @(v)
//  file Pointers.aa, line 25
bit_vector* addr_of_45;
bit_vector* addr_of_45;
addr_of_45 = &(v);
memcpy( &pv, &addr_of_45, sizeof(pv));
// 	t := ->(pu)
//  file Pointers.aa, line 26
__declare_bit_vector(ptr_deref_49,32);
bit_vector_assign_bit_vector(0, &(*pu), &(ptr_deref_49));
bit_vector_assign_bit_vector(0, &(ptr_deref_49), &(t));
// 	s := ->(pv)
//  file Pointers.aa, line 27
__declare_bit_vector(ptr_deref_53,32);
bit_vector_assign_bit_vector(0, &(*pv), &(ptr_deref_53));
bit_vector_assign_bit_vector(0, &(ptr_deref_53), &(s));
// 	t1 := ( $mux (a > 0 ) s  t ) 
//  file Pointers.aa, line 28
__declare_bit_vector(konst_57,32);
__declare_bit_vector(UGT_u32_u1_58,1);
__declare_bit_vector(MUX_62,32);
konst_57.val.byte_array[0] = 0;
konst_57.val.byte_array[1] = 0;
konst_57.val.byte_array[2] = 0;
konst_57.val.byte_array[3] = 0;
bit_vector_greater(0, &(a), &(konst_57), &(UGT_u32_u1_58));
__declare_bit_vector(konst_57,32);
__declare_bit_vector(UGT_u32_u1_58,1);
__declare_bit_vector(MUX_62,32);
if(bit_vector_to_uint64(0,UGT_u32_u1_58){
bit_vector_assign_bit_vector(0, &(s), &(MUX_62));
}
else
{
bit_vector_assign_bit_vector(0, &(t), &(MUX_62));
}
bit_vector_assign_bit_vector(0, &(MUX_62), &(t1));
// 	q := ($cast ($uint<32>) t1 )
//  file Pointers.aa, line 29
__declare_bit_vector(type_cast_66,32);
bit_vector_assign_bit_vector(0, &(t1), &(type_cast_66));
bit_vector_assign_bit_vector(0, &(type_cast_66), &(q));
// 	$call increment (q ) (b ) 
//  file Pointers.aa, line 30
_increment_( &(q), &(b));  
// output side transfers...
bit_vector_assign_bit_vector(0, &(b), &((*__pb)));
}
