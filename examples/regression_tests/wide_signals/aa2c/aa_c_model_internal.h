#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
#include <pipeHandler.h>
// object initialization 

#define _global_storage_initializer__inner_inarg_prep_macro__ 
#define _global_storage_initializer__inner_outarg_prep_macro__ ;

#define _global_storage_initializer__outer_arg_decl_macro__ ;

#define _global_storage_initializer__outer_op_xfer_macro__ ;

#define _p2p_check_daemon_inner_inarg_prep_macro__ 
#define _p2p_check_daemon_branch_block_stmt_9_c_export_decl_macro_ __declare_static_bit_vector(CMD,32);\
__declare_static_bit_vector(ws,128);\
__declare_static_bit_vector(rs,128);\
__declare_static_bit_vector(w0,32);\
__declare_static_bit_vector(w1,32);\
__declare_static_bit_vector(w2,32);\
__declare_static_bit_vector(w3,32);\
__declare_static_bit_vector(d,32);\


#define _p2p_check_daemon_merge_stmt_11_c_preamble_macro_ uint8_t merge_stmt_11_entry_flag;\
merge_stmt_11_entry_flag = do_while_entry_flag;\
goto merge_stmt_11_run;\
merge_stmt_11_run: ;\
;

#define _p2p_check_daemon_merge_stmt_11_c_postamble_macro_ merge_stmt_11_entry_flag = 0;

#define _p2p_check_daemon_assign_stmt_14_c_macro_ __declare_static_bit_vector(RPIPE_in_data_13,32);\
read_bit_vector_from_pipe("in_data",&(RPIPE_in_data_13));\
bit_vector_cast_to_bit_vector(0, &(CMD), &(RPIPE_in_data_13));\
;

#define _p2p_check_daemon_assign_stmt_23_c_macro_ __declare_static_bit_vector(CONCAT_u32_u64_18,64);\
__declare_static_bit_vector(CONCAT_u32_u64_21,64);\
__declare_static_bit_vector(CONCAT_u64_u128_22,128);\
bit_vector_concatenate( &(CMD), &(CMD), &(CONCAT_u32_u64_18));\
bit_vector_concatenate( &(CMD), &(CMD), &(CONCAT_u32_u64_21));\
bit_vector_concatenate( &(CONCAT_u32_u64_18), &(CONCAT_u32_u64_21), &(CONCAT_u64_u128_22));\
bit_vector_cast_to_bit_vector(0, &(ws), &(CONCAT_u64_u128_22));\
;

#define _p2p_check_daemon_assign_stmt_26_c_macro_ write_bit_vector_to_pipe("wide_signal",&(ws));\
;

#define _p2p_check_daemon_assign_stmt_29_c_macro_ __declare_static_bit_vector(RPIPE_wide_signal_28,128);\
read_bit_vector_from_pipe("wide_signal",&(RPIPE_wide_signal_28));\
bit_vector_cast_to_bit_vector(0, &(rs), &(RPIPE_wide_signal_28));\
;

#define _p2p_check_daemon_stmt_33_c_macro_ uint32_t _p2p_check_daemon_stmt_33_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]p2p>\t%s\n",_p2p_check_daemon_stmt_33_c_macro___print_counter,"wide_signal_status");__declare_static_bit_vector(RPIPE_wide_signal_30,128);\
read_bit_vector_from_pipe("wide_signal",&(RPIPE_wide_signal_30));\
if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]p2p>\t\t%s\t\t",_p2p_check_daemon_stmt_33_c_macro___print_counter,"wide_signal");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(RPIPE_wide_signal_30)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]p2p>\t\t%s\t\t",_p2p_check_daemon_stmt_33_c_macro___print_counter,"ws");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(ws)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]p2p>\t\t%s\t\t",_p2p_check_daemon_stmt_33_c_macro___print_counter,"rs");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(rs)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;

#define _p2p_check_daemon_assign_stmt_37_c_macro_ __declare_static_bit_vector(slice_36,32);\
bit_vector_slice(&(rs), &(slice_36), 96);\
bit_vector_cast_to_bit_vector(0, &(w0), &(slice_36));\
;

#define _p2p_check_daemon_assign_stmt_41_c_macro_ __declare_static_bit_vector(slice_40,32);\
bit_vector_slice(&(rs), &(slice_40), 64);\
bit_vector_cast_to_bit_vector(0, &(w1), &(slice_40));\
;

#define _p2p_check_daemon_assign_stmt_45_c_macro_ __declare_static_bit_vector(slice_44,32);\
bit_vector_slice(&(rs), &(slice_44), 32);\
bit_vector_cast_to_bit_vector(0, &(w2), &(slice_44));\
;

#define _p2p_check_daemon_assign_stmt_49_c_macro_ __declare_static_bit_vector(slice_48,32);\
bit_vector_slice(&(rs), &(slice_48), 0);\
bit_vector_cast_to_bit_vector(0, &(w3), &(slice_48));\
;

#define _p2p_check_daemon_assign_stmt_58_c_macro_ __declare_static_bit_vector(OR_u32_u32_53,32);\
__declare_static_bit_vector(OR_u32_u32_56,32);\
__declare_static_bit_vector(OR_u32_u32_57,32);\
bit_vector_or(&(w0), &(w1), &(OR_u32_u32_53));\
bit_vector_or(&(w2), &(w3), &(OR_u32_u32_56));\
bit_vector_or(&(OR_u32_u32_53), &(OR_u32_u32_56), &(OR_u32_u32_57));\
bit_vector_cast_to_bit_vector(0, &(d), &(OR_u32_u32_57));\
;

#define _p2p_check_daemon_assign_stmt_61_c_macro_ write_bit_vector_to_pipe("out_data",&(d));\
;
;

#define _p2p_check_daemon_branch_block_stmt_9_c_export_apply_macro_ ;

#define _p2p_check_daemon_inner_outarg_prep_macro__ ;

#define _p2p_check_daemon_outer_arg_decl_macro__ ;

#define _p2p_check_daemon_outer_op_xfer_macro__ ;
