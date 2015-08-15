#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
// object initialization 
void __init_aa_globals__ ();
void stage_0 ();
void _stage_0_ ();

#define _stage_0_outer_arg_decl_macro__ ;

#define _stage_0_outer_op_xfer_macro__ ;

#define _stage_0_inner_inarg_prep_macro__
#define _stage_0_branch_block_stmt_6_c_export_decl_macro_

#define _stage_0_merge_stmt_7_c_preamble_macro_ uint8_t merge_stmt_7_entry_flag;\
merge_stmt_7_entry_flag = 1;\
uint8_t loopback_6_flag = 0;\
goto merge_stmt_7_run;\
loopback_6: loopback_6_flag = 1;\
goto merge_stmt_7_run;\
merge_stmt_7_run: ;\
;

#define _stage_0_merge_stmt_7_c_postamble_macro_ loopback_6_flag = 0;\
merge_stmt_7_entry_flag = 0;

#define _stage_0_call_stmt_9_c_macro_ __declare_bit_vector(WPIPE_inpipe_8,16);\
uint16_t __WPIPE_inpipe_8;\
Read( &__WPIPE_inpipe_8);\
bit_vector_assign_uint64(0, &WPIPE_inpipe_8, __WPIPE_inpipe_8);\
{ \
uint16_t __tmp;__tmp = bit_vector_to_uint64(0, &WPIPE_inpipe_8);\
write_uint16("inpipe", __tmp); \
}\
;
;

#define _stage_0_branch_block_stmt_6_c_export_apply_macro_ ;

#define _stage_0_inner_outarg_prep_macro__ ;
void stage_1 ();
void _stage_1_ ();

#define _stage_1_outer_arg_decl_macro__ ;

#define _stage_1_outer_op_xfer_macro__ ;

#define _stage_1_inner_inarg_prep_macro__
#define _stage_1_branch_block_stmt_14_c_export_decl_macro_ __declare_bit_vector(tval,20);\


#define _stage_1_merge_stmt_15_c_preamble_macro_ uint8_t merge_stmt_15_entry_flag;\
merge_stmt_15_entry_flag = 1;\
uint8_t loopback_14_flag = 0;\
goto merge_stmt_15_run;\
loopback_14: loopback_14_flag = 1;\
goto merge_stmt_15_run;\
merge_stmt_15_run: ;\
;

#define _stage_1_merge_stmt_15_c_postamble_macro_ loopback_14_flag = 0;\
merge_stmt_15_entry_flag = 0;

#define _stage_1_assign_stmt_19_c_macro_ __declare_bit_vector(RPIPE_inpipe_17,16);\
__declare_bit_vector(type_cast_18,20);\
bit_vector_assign_uint64(0, &RPIPE_inpipe_17, read_uint16("inpipe")); \
bit_vector_bitcast_to_bit_vector( &(type_cast_18), &(RPIPE_inpipe_17));\
bit_vector_cast_to_bit_vector(0, &(tval), &(type_cast_18));\
;

#define _stage_1_assign_stmt_22_c_macro_ write_uint8_n("midpipe", tval.val.byte_array,tval.val.array_size);\
;

#define _stage_1_stmt_24_c_macro_ uint32_t _stage_1_stmt_24_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]stage_1>\t%s\n",_stage_1_stmt_24_c_macro___print_counter,"sent");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]stage_1>\t\t%s\t\t",_stage_1_stmt_24_c_macro___print_counter,"midpipe");fprintf(__report_log_file__, ":= %llx\n",bit_vector_to_uint64(0,&(tval)));}release_file_print_lock(__report_log_file__);;
;

#define _stage_1_branch_block_stmt_14_c_export_apply_macro_ ;

#define _stage_1_inner_outarg_prep_macro__ ;
void stage_2 ();
void _stage_2_ ();

#define _stage_2_outer_arg_decl_macro__ ;

#define _stage_2_outer_op_xfer_macro__ ;

#define _stage_2_inner_inarg_prep_macro__
#define _stage_2_branch_block_stmt_29_c_export_decl_macro_ __declare_bit_vector(tval,16);\


#define _stage_2_merge_stmt_30_c_preamble_macro_ uint8_t merge_stmt_30_entry_flag;\
merge_stmt_30_entry_flag = 1;\
uint8_t loopback_29_flag = 0;\
goto merge_stmt_30_run;\
loopback_29: loopback_29_flag = 1;\
goto merge_stmt_30_run;\
merge_stmt_30_run: ;\
;

#define _stage_2_merge_stmt_30_c_postamble_macro_ loopback_29_flag = 0;\
merge_stmt_30_entry_flag = 0;

#define _stage_2_assign_stmt_34_c_macro_ __declare_bit_vector(RPIPE_midpipe_32,20);\
__declare_bit_vector(type_cast_33,16);\
read_uint8_n("midpipe", RPIPE_midpipe_32.val.byte_array,RPIPE_midpipe_32.val.array_size);\
bit_vector_bitcast_to_bit_vector( &(type_cast_33), &(RPIPE_midpipe_32));\
bit_vector_cast_to_bit_vector(0, &(tval), &(type_cast_33));\
;

#define _stage_2_assign_stmt_37_c_macro_ { \
uint16_t __tmp;__tmp = bit_vector_to_uint64(0, &tval);\
write_uint16("outpipe", __tmp); \
}\
;

#define _stage_2_stmt_39_c_macro_ uint32_t _stage_2_stmt_39_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]stage_2>\t%s\n",_stage_2_stmt_39_c_macro___print_counter,"sent");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]stage_2>\t\t%s\t\t",_stage_2_stmt_39_c_macro___print_counter,"output");fprintf(__report_log_file__, ":= %llx\n",bit_vector_to_uint64(0,&(tval)));}release_file_print_lock(__report_log_file__);;
;

#define _stage_2_branch_block_stmt_29_c_export_apply_macro_ ;

#define _stage_2_inner_outarg_prep_macro__ ;
void stage_3 ();
void _stage_3_ ();

#define _stage_3_outer_arg_decl_macro__ ;

#define _stage_3_outer_op_xfer_macro__ ;

#define _stage_3_inner_inarg_prep_macro__
#define _stage_3_branch_block_stmt_44_c_export_decl_macro_

#define _stage_3_merge_stmt_45_c_preamble_macro_ uint8_t merge_stmt_45_entry_flag;\
merge_stmt_45_entry_flag = 1;\
goto merge_stmt_45_run;\
merge_stmt_45_run: ;\
;

#define _stage_3_merge_stmt_45_c_postamble_macro_ merge_stmt_45_entry_flag = 0;

#define _stage_3_merge_stmt_47_c_preamble_macro_ uint8_t merge_stmt_47_entry_flag;\
merge_stmt_47_entry_flag = do_while_entry_flag;\
goto merge_stmt_47_run;\
merge_stmt_47_run: ;\
;

#define _stage_3_merge_stmt_47_c_postamble_macro_ merge_stmt_47_entry_flag = 0;

#define _stage_3_call_stmt_49_c_macro_ __declare_bit_vector(RPIPE_outpipe_48,16);\
bit_vector_assign_uint64(0, &RPIPE_outpipe_48, read_uint16("outpipe")); \
uint16_t __RPIPE_outpipe_48;\
Print(bit_vector_to_uint64(0, &RPIPE_outpipe_48));\
;
;

#define _stage_3_branch_block_stmt_44_c_export_apply_macro_ ;

#define _stage_3_inner_outarg_prep_macro__ ;
void start_daemons (FILE * fp);
void stop_daemons ();
