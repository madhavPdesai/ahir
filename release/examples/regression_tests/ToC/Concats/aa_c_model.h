#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
void _set_trace_file (FILE * fp);
// object initialization 
void __init_aa_globals__ ();
void Test (uint32_t *);
void _Test_ (bit_vector *);

#define _Test_inner_inarg_prep_macro__ __declare_static_bit_vector(ret_val,32);\
__declare_static_bit_vector(cval,32);\
bit_vector_clear(&cval);\
cval.val.byte_array[0] = 252;\
cval.val.byte_array[1] = 3;\
cval.val.byte_array[2] = 60;\
cval.val.byte_array[3] = 76;\
__declare_static_bit_vector(u1,1);\
bit_vector_clear(&u1);\
__declare_static_bit_vector(u2,1);\
bit_vector_clear(&u2);\
u2.val.byte_array[0] = 1;\
__declare_static_bit_vector(u3,2);\
bit_vector_clear(&u3);\
__declare_static_bit_vector(u4,2);\
bit_vector_clear(&u4);\
u4.val.byte_array[0] = 3;\
__declare_static_bit_vector(u5,4);\
bit_vector_clear(&u5);\
__declare_static_bit_vector(u6,4);\
bit_vector_clear(&u6);\
u6.val.byte_array[0] = 15;\
__declare_static_bit_vector(u7,8);\
bit_vector_clear(&u7);\
__declare_static_bit_vector(u8,8);\
bit_vector_clear(&u8);\
u8.val.byte_array[0] = 255;\
__declare_static_bit_vector(u9,2);\
bit_vector_clear(&u9);\
__declare_static_bit_vector(uu,2);\

#define _Test_assign_stmt_59_c_macro_ __declare_static_bit_vector(CONCAT_u1_u2_51,2);\
bit_vector_clear(&CONCAT_u1_u2_51);\
CONCAT_u1_u2_51.val.byte_array[0] = 1;\
__declare_static_bit_vector(CONCAT_u2_u4_52,4);\
bit_vector_clear(&CONCAT_u2_u4_52);\
CONCAT_u2_u4_52.val.byte_array[0] = 4;\
__declare_static_bit_vector(CONCAT_u2_u6_53,6);\
bit_vector_clear(&CONCAT_u2_u6_53);\
CONCAT_u2_u6_53.val.byte_array[0] = 48;\
__declare_static_bit_vector(CONCAT_u4_u10_54,10);\
bit_vector_clear(&CONCAT_u4_u10_54);\
CONCAT_u4_u10_54.val.byte_array[0] = 48;\
CONCAT_u4_u10_54.val.byte_array[1] = 1;\
__declare_static_bit_vector(CONCAT_u4_u12_55,12);\
bit_vector_clear(&CONCAT_u4_u12_55);\
CONCAT_u4_u12_55.val.byte_array[1] = 15;\
__declare_static_bit_vector(CONCAT_u8_u10_56,10);\
bit_vector_clear(&CONCAT_u8_u10_56);\
CONCAT_u8_u10_56.val.byte_array[0] = 252;\
CONCAT_u8_u10_56.val.byte_array[1] = 3;\
__declare_static_bit_vector(CONCAT_u12_u22_57,22);\
bit_vector_clear(&CONCAT_u12_u22_57);\
CONCAT_u12_u22_57.val.byte_array[0] = 252;\
CONCAT_u12_u22_57.val.byte_array[1] = 3;\
CONCAT_u12_u22_57.val.byte_array[2] = 60;\
__declare_static_bit_vector(CONCAT_u10_u32_58,32);\
bit_vector_clear(&CONCAT_u10_u32_58);\
CONCAT_u10_u32_58.val.byte_array[0] = 252;\
CONCAT_u10_u32_58.val.byte_array[1] = 3;\
CONCAT_u10_u32_58.val.byte_array[2] = 60;\
CONCAT_u10_u32_58.val.byte_array[3] = 76;\
bit_vector_concatenate( &(Z1), &(O1), &(CONCAT_u1_u2_51));\
bit_vector_concatenate( &(CONCAT_u1_u2_51), &(Z2), &(CONCAT_u2_u4_52));\
bit_vector_concatenate( &(O2), &(Z4), &(CONCAT_u2_u6_53));\
bit_vector_concatenate( &(CONCAT_u2_u4_52), &(CONCAT_u2_u6_53), &(CONCAT_u4_u10_54));\
bit_vector_concatenate( &(O4), &(Z8), &(CONCAT_u4_u12_55));\
bit_vector_concatenate( &(O8), &(Z2), &(CONCAT_u8_u10_56));\
bit_vector_concatenate( &(CONCAT_u4_u12_55), &(CONCAT_u8_u10_56), &(CONCAT_u12_u22_57));\
bit_vector_concatenate( &(CONCAT_u4_u10_54), &(CONCAT_u12_u22_57), &(CONCAT_u10_u32_58));\
bit_vector_cast_to_bit_vector(0, &(cval), &(CONCAT_u10_u32_58));\
;

#define _Test_assign_stmt_71_c_macro_ __declare_static_bit_vector(slice_70,1);\
bit_vector_clear(&slice_70);\
bit_vector_slice(&(cval), &(slice_70), 31);\
bit_vector_cast_to_bit_vector(0, &(u1), &(slice_70));\
;

#define _Test_assign_stmt_74_c_macro_ __declare_static_bit_vector(slice_73,1);\
bit_vector_clear(&slice_73);\
slice_73.val.byte_array[0] = 1;\
bit_vector_slice(&(cval), &(slice_73), 30);\
bit_vector_cast_to_bit_vector(0, &(u2), &(slice_73));\
;

#define _Test_assign_stmt_77_c_macro_ __declare_static_bit_vector(slice_76,2);\
bit_vector_clear(&slice_76);\
bit_vector_slice(&(cval), &(slice_76), 28);\
bit_vector_cast_to_bit_vector(0, &(u3), &(slice_76));\
;

#define _Test_assign_stmt_80_c_macro_ __declare_static_bit_vector(slice_79,2);\
bit_vector_clear(&slice_79);\
slice_79.val.byte_array[0] = 3;\
bit_vector_slice(&(cval), &(slice_79), 26);\
bit_vector_cast_to_bit_vector(0, &(u4), &(slice_79));\
;

#define _Test_assign_stmt_83_c_macro_ __declare_static_bit_vector(slice_82,4);\
bit_vector_clear(&slice_82);\
bit_vector_slice(&(cval), &(slice_82), 22);\
bit_vector_cast_to_bit_vector(0, &(u5), &(slice_82));\
;

#define _Test_assign_stmt_86_c_macro_ __declare_static_bit_vector(slice_85,4);\
bit_vector_clear(&slice_85);\
slice_85.val.byte_array[0] = 15;\
bit_vector_slice(&(cval), &(slice_85), 18);\
bit_vector_cast_to_bit_vector(0, &(u6), &(slice_85));\
;

#define _Test_assign_stmt_89_c_macro_ __declare_static_bit_vector(slice_88,8);\
bit_vector_clear(&slice_88);\
bit_vector_slice(&(cval), &(slice_88), 10);\
bit_vector_cast_to_bit_vector(0, &(u7), &(slice_88));\
;

#define _Test_assign_stmt_92_c_macro_ __declare_static_bit_vector(slice_91,8);\
bit_vector_clear(&slice_91);\
slice_91.val.byte_array[0] = 255;\
bit_vector_slice(&(cval), &(slice_91), 2);\
bit_vector_cast_to_bit_vector(0, &(u8), &(slice_91));\
;

#define _Test_assign_stmt_95_c_macro_ __declare_static_bit_vector(slice_94,2);\
bit_vector_clear(&slice_94);\
bit_vector_slice(&(cval), &(slice_94), 0);\
bit_vector_cast_to_bit_vector(0, &(u9), &(slice_94));\
;

#define _Test_call_stmt_99_c_macro_ _cc_( &(u1),  &(u2), &(uu));\
;

#define _Test_assign_stmt_116_c_macro_ __declare_static_bit_vector(CONCAT_u2_u4_109,4);\
__declare_static_bit_vector(CONCAT_u2_u6_110,6);\
bit_vector_clear(&CONCAT_u2_u6_110);\
CONCAT_u2_u6_110.val.byte_array[0] = 48;\
__declare_static_bit_vector(CONCAT_u4_u10_111,10);\
__declare_static_bit_vector(CONCAT_u4_u12_112,12);\
bit_vector_clear(&CONCAT_u4_u12_112);\
CONCAT_u4_u12_112.val.byte_array[1] = 15;\
__declare_static_bit_vector(CONCAT_u8_u10_113,10);\
bit_vector_clear(&CONCAT_u8_u10_113);\
CONCAT_u8_u10_113.val.byte_array[0] = 252;\
CONCAT_u8_u10_113.val.byte_array[1] = 3;\
__declare_static_bit_vector(CONCAT_u12_u22_114,22);\
bit_vector_clear(&CONCAT_u12_u22_114);\
CONCAT_u12_u22_114.val.byte_array[0] = 252;\
CONCAT_u12_u22_114.val.byte_array[1] = 3;\
CONCAT_u12_u22_114.val.byte_array[2] = 60;\
__declare_static_bit_vector(CONCAT_u10_u32_115,32);\
bit_vector_concatenate( &(uu), &(u3), &(CONCAT_u2_u4_109));\
bit_vector_concatenate( &(u4), &(u5), &(CONCAT_u2_u6_110));\
bit_vector_concatenate( &(CONCAT_u2_u4_109), &(CONCAT_u2_u6_110), &(CONCAT_u4_u10_111));\
bit_vector_concatenate( &(u6), &(u7), &(CONCAT_u4_u12_112));\
bit_vector_concatenate( &(u8), &(u9), &(CONCAT_u8_u10_113));\
bit_vector_concatenate( &(CONCAT_u4_u12_112), &(CONCAT_u8_u10_113), &(CONCAT_u12_u22_114));\
bit_vector_concatenate( &(CONCAT_u4_u10_111), &(CONCAT_u12_u22_114), &(CONCAT_u10_u32_115));\
bit_vector_cast_to_bit_vector(0, &(ret_val), &(CONCAT_u10_u32_115));\
;

#define _Test_inner_outarg_prep_macro__ bit_vector_cast_to_bit_vector(0, &((*__pret_val)), &(ret_val));\
;

#define _Test_outer_arg_decl_macro__ __declare_bit_vector(__ret_val, 32);\
;

#define _Test_outer_op_xfer_macro__  *ret_val =  bit_vector_to_uint64(0, &__ret_val);\
;
void _cc_ (bit_vector *, bit_vector *, bit_vector *);

#define _cc_inner_inarg_prep_macro__ __declare_static_bit_vector(u1,1);\
bit_vector_cast_to_bit_vector(0, &(u1), &((*__pu1)));\
__declare_static_bit_vector(u2,1);\
bit_vector_cast_to_bit_vector(0, &(u2), &((*__pu2)));\
__declare_static_bit_vector(cu,2);\

#define _cc_assign_stmt_36_c_macro_ __declare_static_bit_vector(CONCAT_u1_u2_35,2);\
bit_vector_concatenate( &(u1), &(u2), &(CONCAT_u1_u2_35));\
bit_vector_cast_to_bit_vector(0, &(cu), &(CONCAT_u1_u2_35));\
;

#define _cc_inner_outarg_prep_macro__ bit_vector_cast_to_bit_vector(0, &((*__pcu)), &(cu));\
;
void start_daemons (FILE * fp);
void stop_daemons ();
