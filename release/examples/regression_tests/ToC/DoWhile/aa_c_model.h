#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
// object initialization 
void __init_aa_globals__ ();
void Daemon ();
void _Daemon_ ();

#define _Daemon_outer_arg_decl_macro__ ;

#define _Daemon_outer_op_xfer_macro__ ;

#define _Daemon_inner_inarg_prep_macro__
#define _Daemon_branch_block_stmt_6_c_export_decl_macro_ __declare_bit_vector(I,8);\
__declare_bit_vector(gflag,1);\
__declare_bit_vector(NI,8);\


#define _Daemon_merge_stmt_8_c_preamble_macro_ uint8_t merge_stmt_8_entry_flag;\
merge_stmt_8_entry_flag = do_while_entry_flag;\
goto merge_stmt_8_run;\
merge_stmt_8_run: ;\

#define _Daemon_phi_stmt_9_c_macro_ __declare_bit_vector(konst_12,8);\
__declare_bit_vector(type_cast_13,8);\
if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(I), &(NI));\
}\
else {\
__declare_bit_vector(konst_12,8);\
__declare_bit_vector(type_cast_13,8);\
bit_vector_clear(&konst_12);\
bit_vector_bitcast_to_bit_vector( &(type_cast_13), &(konst_12));\
bit_vector_cast_to_bit_vector(0, &(I), &(type_cast_13));\
}\
;
;

#define _Daemon_merge_stmt_8_c_postamble_macro_ merge_stmt_8_entry_flag = 0;

#define _Daemon_assign_stmt_20_c_macro_ __declare_bit_vector(RPIPE_in_data_19,32);\
bit_vector_assign_uint64(0, &RPIPE_in_data_19, read_uint32("in_data")); \
bit_vector_cast_to_bit_vector(0, &((T[bit_vector_to_uint64(0, &I)][bit_vector_to_uint64(0, &I)])), &(RPIPE_in_data_19));\
;

#define _Daemon_assign_stmt_26_c_macro_ __declare_bit_vector(konst_23,8);\
__declare_bit_vector(UGE_u8_u1_24,1);\
bit_vector_clear(&konst_23);\
bit_vector_greater_equal(0, &(I), &(konst_23), &(UGE_u8_u1_24));\
bit_vector_cast_to_bit_vector(0, &(gflag), &(UGE_u8_u1_24));\
;

#define _Daemon_assign_stmt_35_c_macro_ if (has_undefined_bit(&gflag)) {fprintf(stderr, "Error: variable gflag has undefined value at test point.\n");assert(0);} \
__declare_bit_vector(MUL_u32_u32_34,32);\
if (bit_vector_to_uint64(0, &gflag)) {\
bit_vector_mul( &((T[bit_vector_to_uint64(0, &I)][bit_vector_to_uint64(0, &I)])), &((T[bit_vector_to_uint64(0, &I)][bit_vector_to_uint64(0, &I)])), &(MUL_u32_u32_34));\
{ \
uint32_t __tmp;__tmp = bit_vector_to_uint64(0, &MUL_u32_u32_34);\
write_uint32("out_data", __tmp); \
}\
}
;

#define _Daemon_assign_stmt_41_c_macro_ __declare_bit_vector(konst_39,8);\
__declare_bit_vector(ADD_u8_u8_40,8);\
bit_vector_clear(&konst_39);\
konst_39.val.byte_array[0] = 1;\
bit_vector_plus( &(I), &(konst_39), &(ADD_u8_u8_40));\
bit_vector_cast_to_bit_vector(0, &(NI), &(ADD_u8_u8_40));\
;
;

#define _Daemon_branch_block_stmt_6_c_export_apply_macro_ ;

#define _Daemon_inner_outarg_prep_macro__ ;
void start_daemons (FILE * fp);
void stop_daemons ();
