#include <Pipes.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <aa_c_model.h>
void
__init_aa_globals__ ()
{
  register_pipe ("inpipe", 1, 16, 0);
  register_pipe ("midpipe", 3, 8, 0);
  register_pipe ("outpipe", 1, 16, 0);
}

void
stage_0 ()
{
  _stage_0_outer_arg_decl_macro__;
  _stage_0_ ();
  _stage_0_outer_op_xfer_macro__;
}


void
_stage_0_ ()
{
  _stage_0_inner_inarg_prep_macro__;
  _stage_0_branch_block_stmt_6_c_export_decl_macro_;
  {
// merge  file ShiftRegister.aa, line 14
    _stage_0_merge_stmt_7_c_preamble_macro_;
    _stage_0_merge_stmt_7_c_postamble_macro_;
//              $call Read () (inpipe ) 
    _stage_0_call_stmt_9_c_macro_;
/* 		$place[loopback]
*/ goto loopback_6;
    _stage_0_branch_block_stmt_6_c_export_apply_macro_;
  }
  _stage_0_inner_outarg_prep_macro__;
}

void
stage_1 ()
{
  _stage_1_outer_arg_decl_macro__;
  _stage_1_ ();
  _stage_1_outer_op_xfer_macro__;
}


void
_stage_1_ ()
{
  _stage_1_inner_inarg_prep_macro__;
  _stage_1_branch_block_stmt_14_c_export_decl_macro_;
  {
// merge  file ShiftRegister.aa, line 27
    _stage_1_merge_stmt_15_c_preamble_macro_;
    _stage_1_merge_stmt_15_c_postamble_macro_;
//              midpipe := ($bitcast ($uint<20>) inpipe )
    _stage_1_assign_stmt_19_c_macro_;
/* 		$place[loopback]
*/ goto loopback_14;
    _stage_1_branch_block_stmt_14_c_export_apply_macro_;
  }
  _stage_1_inner_outarg_prep_macro__;
}

void
stage_2 ()
{
  _stage_2_outer_arg_decl_macro__;
  _stage_2_ ();
  _stage_2_outer_op_xfer_macro__;
}


void
_stage_2_ ()
{
  _stage_2_inner_inarg_prep_macro__;
  _stage_2_branch_block_stmt_24_c_export_decl_macro_;
  {
// merge  file ShiftRegister.aa, line 39
    _stage_2_merge_stmt_25_c_preamble_macro_;
    _stage_2_merge_stmt_25_c_postamble_macro_;
//              outpipe := ($bitcast ($uint<16>) midpipe )
    _stage_2_assign_stmt_29_c_macro_;
/* 		$place[loopback]
*/ goto loopback_24;
    _stage_2_branch_block_stmt_24_c_export_apply_macro_;
  }
  _stage_2_inner_outarg_prep_macro__;
}

void
stage_3 ()
{
  _stage_3_outer_arg_decl_macro__;
  _stage_3_ ();
  _stage_3_outer_op_xfer_macro__;
}


void
_stage_3_ ()
{
  _stage_3_inner_inarg_prep_macro__;
  _stage_3_branch_block_stmt_34_c_export_decl_macro_;
  {
// merge  file ShiftRegister.aa, line 51
    _stage_3_merge_stmt_35_c_preamble_macro_;
    _stage_3_merge_stmt_35_c_postamble_macro_;
    {
// do-while:   file ShiftRegister.aa, line 53
      __declare_bit_vector (konst_41, 1);
      bit_vector_clear (&konst_41);
      konst_41.val.byte_array[0] = 1;
      uint8_t do_while_entry_flag;
      do_while_entry_flag = 1;
      uint8_t do_while_loopback_flag;
      do_while_loopback_flag = 0;
      do
	{
// merge  file ShiftRegister.aa, line 54
	  _stage_3_merge_stmt_37_c_preamble_macro_;
	  _stage_3_merge_stmt_37_c_postamble_macro_;
//                      $call Print (outpipe ) () 
	  _stage_3_call_stmt_39_c_macro_;
	  do_while_entry_flag = 0;
	  do_while_loopback_flag = 1;
	}
      while (bit_vector_to_uint64 (0, &konst_41));
    }
    _stage_3_branch_block_stmt_34_c_export_apply_macro_;
  }
  _stage_3_inner_outarg_prep_macro__;
}

DEFINE_THREAD (stage_0);
PTHREAD_DECL (stage_0);
DEFINE_THREAD (stage_1);
PTHREAD_DECL (stage_1);
DEFINE_THREAD (stage_2);
PTHREAD_DECL (stage_2);
DEFINE_THREAD (stage_3);
PTHREAD_DECL (stage_3);
void
start_daemons ()
{
  __init_aa_globals__ ();
  PTHREAD_CREATE (stage_0);
  PTHREAD_CREATE (stage_1);
  PTHREAD_CREATE (stage_2);
  PTHREAD_CREATE (stage_3);
}

void
stop_daemons ()
{
  PTHREAD_CANCEL (stage_0);
  PTHREAD_CANCEL (stage_1);
  PTHREAD_CANCEL (stage_2);
  PTHREAD_CANCEL (stage_3);
}
