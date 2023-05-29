#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
#include <pipeHandler.h>
// object initialization 

#define shift_reg_lib_shift_reg_4_sright_sright__global_storage_initializer__inner_inarg_prep_macro__ 
#define shift_reg_lib_shift_reg_4_sright_sright__global_storage_initializer__inner_outarg_prep_macro__ ;

#define shift_reg_lib_shift_reg_4_sright_sright__global_storage_initializer__outer_arg_decl_macro__ ;

#define shift_reg_lib_shift_reg_4_sright_sright__global_storage_initializer__outer_op_xfer_macro__ ;

#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_inner_inarg_prep_macro__ 
#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_branch_block_stmt_7_c_export_decl_macro_ __declare_static_bit_vector(X,32);\


#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_merge_stmt_8_c_preamble_macro_ uint8_t merge_stmt_8_entry_flag;\
merge_stmt_8_entry_flag = 1;\
uint8_t loopback_7_flag = 0;\
goto merge_stmt_8_run;\
loopback_7: loopback_7_flag = 1;\
goto merge_stmt_8_run;\
merge_stmt_8_run: ;\
;

#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_merge_stmt_8_c_postamble_macro_ loopback_7_flag = 0;\
merge_stmt_8_entry_flag = 0;

#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_assign_stmt_11_c_macro_ __declare_static_bit_vector(RPIPE_in_data_10,32);\
read_bit_vector_from_pipe("shift_reg_4_sright_mid_data",&(RPIPE_in_data_10));\
bit_vector_cast_to_bit_vector(0, &(X), &(RPIPE_in_data_10));\
;

#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_assign_stmt_14_c_macro_ write_bit_vector_to_pipe("out_data",&(X));\
;
;

#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_branch_block_stmt_7_c_export_apply_macro_ ;

#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_inner_outarg_prep_macro__ ;

#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_outer_arg_decl_macro__ ;

#define shift_reg_lib_shift_reg_4_sright_sright__shift_reg_1_daemon_outer_op_xfer_macro__ ;
