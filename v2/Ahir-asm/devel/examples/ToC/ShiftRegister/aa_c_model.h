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

#define _stage_0_merge_stmt_7_c_postamble_macro_ loopback_6_flag = 0;\
merge_stmt_7_entry_flag = 0;

#define _stage_0_call_stmt_9_c_macro_ __declare_bit_vector(WPIPE_inpipe_8,16);uint16_t __WPIPE_inpipe_8;\
Read( &__WPIPE_inpipe_8);\
bit_vector_assign_uint64(0, &WPIPE_inpipe_8, __WPIPE_inpipe_8);{ uint16_t __tmp;__tmp = bit_vector_to_uint64(0, &WPIPE_inpipe_8);write_uint16("inpipe", __tmp); };

#define _stage_0_branch_block_stmt_6_c_export_apply_macro_

#define _stage_0_inner_outarg_prep_macro__ ;
void stage_1 ();
void _stage_1_ ();

#define _stage_1_outer_arg_decl_macro__ ;

#define _stage_1_outer_op_xfer_macro__ ;

#define _stage_1_inner_inarg_prep_macro__
#define _stage_1_branch_block_stmt_14_c_export_decl_macro_

#define _stage_1_merge_stmt_15_c_preamble_macro_ uint8_t merge_stmt_15_entry_flag;\
merge_stmt_15_entry_flag = 1;\
uint8_t loopback_14_flag = 0;\
goto merge_stmt_15_run;\
loopback_14: loopback_14_flag = 1;\
goto merge_stmt_15_run;\
merge_stmt_15_run: ;\

#define _stage_1_merge_stmt_15_c_postamble_macro_ loopback_14_flag = 0;\
merge_stmt_15_entry_flag = 0;

#define _stage_1_assign_stmt_19_c_macro_ __declare_bit_vector(RPIPE_inpipe_17,16);__declare_bit_vector(type_cast_18,20);bit_vector_assign_uint64(0, &RPIPE_inpipe_17, read_uint16("inpipe")); bit_vector_bitcast_to_bit_vector( &(type_cast_18), &(RPIPE_inpipe_17));write_uint8_n("midpipe", type_cast_18.val.byte_array,type_cast_18.val.array_size);
#define _stage_1_branch_block_stmt_14_c_export_apply_macro_

#define _stage_1_inner_outarg_prep_macro__ ;
void stage_2 ();
void _stage_2_ ();

#define _stage_2_outer_arg_decl_macro__ ;

#define _stage_2_outer_op_xfer_macro__ ;

#define _stage_2_inner_inarg_prep_macro__
#define _stage_2_branch_block_stmt_24_c_export_decl_macro_

#define _stage_2_merge_stmt_25_c_preamble_macro_ uint8_t merge_stmt_25_entry_flag;\
merge_stmt_25_entry_flag = 1;\
uint8_t loopback_24_flag = 0;\
goto merge_stmt_25_run;\
loopback_24: loopback_24_flag = 1;\
goto merge_stmt_25_run;\
merge_stmt_25_run: ;\

#define _stage_2_merge_stmt_25_c_postamble_macro_ loopback_24_flag = 0;\
merge_stmt_25_entry_flag = 0;

#define _stage_2_assign_stmt_29_c_macro_ __declare_bit_vector(RPIPE_midpipe_27,20);__declare_bit_vector(type_cast_28,16);read_uint8_n("midpipe", RPIPE_midpipe_27.val.byte_array,RPIPE_midpipe_27.val.array_size);bit_vector_bitcast_to_bit_vector( &(type_cast_28), &(RPIPE_midpipe_27));{ uint16_t __tmp;__tmp = bit_vector_to_uint64(0, &type_cast_28);write_uint16("outpipe", __tmp); }
#define _stage_2_branch_block_stmt_24_c_export_apply_macro_

#define _stage_2_inner_outarg_prep_macro__ ;
void stage_3 ();
void _stage_3_ ();

#define _stage_3_outer_arg_decl_macro__ ;

#define _stage_3_outer_op_xfer_macro__ ;

#define _stage_3_inner_inarg_prep_macro__
#define _stage_3_branch_block_stmt_34_c_export_decl_macro_

#define _stage_3_merge_stmt_35_c_preamble_macro_ uint8_t merge_stmt_35_entry_flag;\
merge_stmt_35_entry_flag = 1;\
goto merge_stmt_35_run;\
merge_stmt_35_run: ;\

#define _stage_3_merge_stmt_35_c_postamble_macro_ merge_stmt_35_entry_flag = 0;

#define _stage_3_merge_stmt_37_c_preamble_macro_ uint8_t merge_stmt_37_entry_flag;\
merge_stmt_37_entry_flag = do_while_entry_flag;\
goto merge_stmt_37_run;\
merge_stmt_37_run: ;\

#define _stage_3_merge_stmt_37_c_postamble_macro_ merge_stmt_37_entry_flag = 0;

#define _stage_3_call_stmt_39_c_macro_ __declare_bit_vector(RPIPE_outpipe_38,16);bit_vector_assign_uint64(0, &RPIPE_outpipe_38, read_uint16("outpipe")); uint16_t __RPIPE_outpipe_38;\
Print(bit_vector_to_uint64(0, &RPIPE_outpipe_38));\
;

#define _stage_3_branch_block_stmt_34_c_export_apply_macro_

#define _stage_3_inner_outarg_prep_macro__ ;
void start_daemons ();
void stop_daemons ();
