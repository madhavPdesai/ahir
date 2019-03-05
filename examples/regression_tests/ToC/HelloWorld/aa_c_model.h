#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
void _set_trace_file (FILE * fp);
// object initialization 
void __init_aa_globals__ ();
void _sum_mod_ (bit_vector *, bit_vector *, bit_vector *);

#define _sum_mod_inner_inarg_prep_macro__ __declare_static_bit_vector(a,10);\
bit_vector_cast_to_bit_vector(0, &(a), &((*__pa)));\
__declare_static_bit_vector(b,10);\
bit_vector_cast_to_bit_vector(0, &(b), &((*__pb)));\
__declare_static_bit_vector(c,20);\

#define _sum_mod_parallel_block_stmt_37_c_export_decl_macro_ __declare_static_bit_vector(q__q,10);\
__declare_static_bit_vector(r__r,10);\
__declare_static_bit_vector(q,10);\
__declare_static_bit_vector(r,10);\


#define _sum_mod_assign_stmt_42_c_macro_ __declare_static_bit_vector(ADD_u10_u10_41,10);\
bit_vector_plus( &(a), &(b), &(ADD_u10_u10_41));\
bit_vector_cast_to_bit_vector(0, &(q), &(ADD_u10_u10_41));\
;

#define _sum_mod_assign_stmt_47_c_macro_ __declare_static_bit_vector(ADD_u10_u10_46,10);\
bit_vector_plus( &(q), &(b), &(ADD_u10_u10_46));\
bit_vector_cast_to_bit_vector(0, &(r), &(ADD_u10_u10_46));\
;
;

#define _sum_mod_parallel_block_stmt_37_c_export_apply_macro_ bit_vector_cast_to_bit_vector(0, &(q__q), &(q));\
bit_vector_cast_to_bit_vector(0, &(r__r), &(r));\
;

#define _sum_mod_stmt_53_c_macro_ uint32_t _sum_mod_stmt_53_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]sum_mod>\t%s\n",_sum_mod_stmt_53_c_macro___print_counter,"interim_report");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]sum_mod>\t\t%s\t\t",_sum_mod_stmt_53_c_macro___print_counter,"a");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(a)));}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]sum_mod>\t\t%s\t\t",_sum_mod_stmt_53_c_macro___print_counter,"b");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(b)));}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]sum_mod>\t\t%s\t\t",_sum_mod_stmt_53_c_macro___print_counter,"q");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(q__q)));}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]sum_mod>\t\t%s\t\t",_sum_mod_stmt_53_c_macro___print_counter,"r");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(r__r)));}release_file_print_lock(__report_log_file__);;

#define _sum_mod_assign_stmt_59_c_macro_ __declare_static_bit_vector(CONCAT_u10_u20_57,20);\
__declare_static_bit_vector(type_cast_58,32);\
bit_vector_concatenate( &(r__r), &(b), &(CONCAT_u10_u20_57));\
bit_vector_bitcast_to_bit_vector( &(type_cast_58), &(CONCAT_u10_u20_57));\
write_bit_vector_to_pipe("TM",&(type_cast_58));\
;

#define _sum_mod_assign_stmt_63_c_macro_ __declare_static_bit_vector(RPIPE_TM_61,32);\
__declare_static_bit_vector(type_cast_62,20);\
read_bit_vector_from_pipe("TM",&(RPIPE_TM_61));\
bit_vector_bitcast_to_bit_vector( &(type_cast_62), &(RPIPE_TM_61));\
bit_vector_cast_to_bit_vector(0, &(M), &(type_cast_62));\
;

#define _sum_mod_assign_stmt_66_c_macro_ bit_vector_cast_to_bit_vector(0, &(c), &(M));\
;

#define _sum_mod_inner_outarg_prep_macro__ bit_vector_cast_to_bit_vector(0, &((*__pc)), &(c));\
;
void sum_mod_wrap (uint16_t, uint16_t, uint32_t *);
void _sum_mod_wrap_ (bit_vector *, bit_vector *, bit_vector *);

#define _sum_mod_wrap_inner_inarg_prep_macro__ __declare_static_bit_vector(a,16);\
bit_vector_cast_to_bit_vector(0, &(a), &((*__pa)));\
__declare_static_bit_vector(b,16);\
bit_vector_cast_to_bit_vector(0, &(b), &((*__pb)));\
__declare_static_bit_vector(c,32);\
static bit_vector aaa[2];\
static char sum_mod_wrap_init_objects_flag = 1;\
if (sum_mod_wrap_init_objects_flag) {\
sum_mod_wrap_init_objects_flag= 0;\
init_bit_vector(&(aaa[0]), 10);\
init_bit_vector(&(aaa[1]), 10);\
 }\
__declare_static_bit_vector(c20,20);\

#define _sum_mod_wrap_assign_stmt_16_c_macro_ __declare_static_bit_vector(type_cast_15,10);\
bit_vector_bitcast_to_bit_vector( &(type_cast_15), &(a));\
__declare_static_bit_vector(konst_12,32);\
bit_vector_clear(&konst_12);\
bit_vector_cast_to_bit_vector(0, &((aaa[bit_vector_to_uint64(0, &konst_12)])), &(type_cast_15));\
;

#define _sum_mod_wrap_assign_stmt_21_c_macro_ __declare_static_bit_vector(type_cast_20,10);\
bit_vector_bitcast_to_bit_vector( &(type_cast_20), &(b));\
__declare_static_bit_vector(konst_17,32);\
bit_vector_clear(&konst_17);\
konst_17.val.byte_array[0] = 1;\
bit_vector_cast_to_bit_vector(0, &((aaa[bit_vector_to_uint64(0, &konst_17)])), &(type_cast_20));\
;

#define _sum_mod_wrap_call_stmt_27_c_macro_ __declare_static_bit_vector(konst_22,32);\
bit_vector_clear(&konst_22);\
__declare_static_bit_vector(konst_24,32);\
bit_vector_clear(&konst_24);\
konst_24.val.byte_array[0] = 1;\
bit_vector_clear(&konst_22);\
bit_vector_clear(&konst_24);\
konst_24.val.byte_array[0] = 1;\
_sum_mod_( &((aaa[bit_vector_to_uint64(0, &konst_22)])),  &((aaa[bit_vector_to_uint64(0, &konst_24)])), &(c20));\
;

#define _sum_mod_wrap_assign_stmt_31_c_macro_ __declare_static_bit_vector(type_cast_30,32);\
bit_vector_bitcast_to_bit_vector( &(type_cast_30), &(c20));\
bit_vector_cast_to_bit_vector(0, &(c), &(type_cast_30));\
;

#define _sum_mod_wrap_inner_outarg_prep_macro__ bit_vector_cast_to_bit_vector(0, &((*__pc)), &(c));\
;

#define _sum_mod_wrap_outer_arg_decl_macro__ __declare_bit_vector(__a, 16);\
bit_vector_assign_uint64(0, &__a, a);\
__declare_bit_vector(__b, 16);\
bit_vector_assign_uint64(0, &__b, b);\
__declare_bit_vector(__c, 32);\
;

#define _sum_mod_wrap_outer_op_xfer_macro__  *c =  bit_vector_to_uint64(0, &__c);\
;
void start_daemons (FILE * fp);
void stop_daemons ();
