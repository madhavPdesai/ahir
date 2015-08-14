#include <Pipes.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <aa_c_model.h>
FILE *__report_log_file__ = NULL;
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
  MUTEX_DECL (_stage_0_series_block_stmt_5_c_mutex_);
  MUTEX_LOCK (_stage_0_series_block_stmt_5_c_mutex_);
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
  MUTEX_UNLOCK (_stage_0_series_block_stmt_5_c_mutex_);
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
  MUTEX_DECL (_stage_1_series_block_stmt_13_c_mutex_);
  MUTEX_LOCK (_stage_1_series_block_stmt_13_c_mutex_);
  _stage_1_inner_inarg_prep_macro__;
  _stage_1_branch_block_stmt_14_c_export_decl_macro_;
  {
// merge  file ShiftRegister.aa, line 27
    _stage_1_merge_stmt_15_c_preamble_macro_;
    _stage_1_merge_stmt_15_c_postamble_macro_;
//              tval := ($bitcast ($uint<20>) inpipe )
    _stage_1_assign_stmt_19_c_macro_;
//              midpipe := tval
    _stage_1_assign_stmt_22_c_macro_;
// $report (stage_1 sent                 midpipe tval )
    _stage_1_stmt_24_c_macro_;
/* 		$place[loopback]
*/ goto loopback_14;
    _stage_1_branch_block_stmt_14_c_export_apply_macro_;
  }
  _stage_1_inner_outarg_prep_macro__;
  MUTEX_UNLOCK (_stage_1_series_block_stmt_13_c_mutex_);
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
  MUTEX_DECL (_stage_2_series_block_stmt_28_c_mutex_);
  MUTEX_LOCK (_stage_2_series_block_stmt_28_c_mutex_);
  _stage_2_inner_inarg_prep_macro__;
  _stage_2_branch_block_stmt_29_c_export_decl_macro_;
  {
// merge  file ShiftRegister.aa, line 41
    _stage_2_merge_stmt_30_c_preamble_macro_;
    _stage_2_merge_stmt_30_c_postamble_macro_;
//              tval := ($bitcast ($uint<16>) midpipe )
    _stage_2_assign_stmt_34_c_macro_;
//              outpipe := tval
    _stage_2_assign_stmt_37_c_macro_;
// $report (stage_2 sent                 output tval )
    _stage_2_stmt_39_c_macro_;
/* 		$place[loopback]
*/ goto loopback_29;
    _stage_2_branch_block_stmt_29_c_export_apply_macro_;
  }
  _stage_2_inner_outarg_prep_macro__;
  MUTEX_UNLOCK (_stage_2_series_block_stmt_28_c_mutex_);
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
  MUTEX_DECL (_stage_3_series_block_stmt_43_c_mutex_);
  MUTEX_LOCK (_stage_3_series_block_stmt_43_c_mutex_);
  _stage_3_inner_inarg_prep_macro__;
  _stage_3_branch_block_stmt_44_c_export_decl_macro_;
  {
// merge  file ShiftRegister.aa, line 55
    _stage_3_merge_stmt_45_c_preamble_macro_;
    _stage_3_merge_stmt_45_c_postamble_macro_;
    {
// do-while:   file ShiftRegister.aa, line 57
      __declare_bit_vector (konst_51, 1);
      uint8_t do_while_entry_flag;
      do_while_entry_flag = 1;
      uint8_t do_while_loopback_flag;
      do_while_loopback_flag = 0;
      while (1)
	{
// merge  file ShiftRegister.aa, line 58
	  _stage_3_merge_stmt_47_c_preamble_macro_;
	  _stage_3_merge_stmt_47_c_postamble_macro_;
//                      $call Print (outpipe ) () 
	  _stage_3_call_stmt_49_c_macro_;
	  do_while_entry_flag = 0;
	  do_while_loopback_flag = 1;
	  bit_vector_clear (&konst_51);
	  konst_51.val.byte_array[0] = 1;
	  if (!bit_vector_to_uint64 (0, &konst_51))
	    break;
	}
    }
    _stage_3_branch_block_stmt_44_c_export_apply_macro_;
  }
  _stage_3_inner_outarg_prep_macro__;
  MUTEX_UNLOCK (_stage_3_series_block_stmt_43_c_mutex_);
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
start_daemons (FILE * fp)
{
  __report_log_file__ = fp;
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
