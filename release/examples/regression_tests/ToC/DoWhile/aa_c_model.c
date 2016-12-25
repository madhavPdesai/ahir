#include <Pipes.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <aa_c_model.h>
FILE *__report_log_file__ = NULL;
bit_vector T[4][4];
void
__init_aa_globals__ ()
{
  init_bit_vector (&(T[0][0]), 32);
  init_bit_vector (&(T[1][0]), 32);
  init_bit_vector (&(T[2][0]), 32);
  init_bit_vector (&(T[3][0]), 32);
  init_bit_vector (&(T[0][1]), 32);
  init_bit_vector (&(T[1][1]), 32);
  init_bit_vector (&(T[2][1]), 32);
  init_bit_vector (&(T[3][1]), 32);
  init_bit_vector (&(T[0][2]), 32);
  init_bit_vector (&(T[1][2]), 32);
  init_bit_vector (&(T[2][2]), 32);
  init_bit_vector (&(T[3][2]), 32);
  init_bit_vector (&(T[0][3]), 32);
  init_bit_vector (&(T[1][3]), 32);
  init_bit_vector (&(T[2][3]), 32);
  init_bit_vector (&(T[3][3]), 32);
  register_pipe ("in_data", 1, 32, 0);
  register_pipe ("out_data", 1, 32, 0);
}

void
Daemon ()
{
  _Daemon_outer_arg_decl_macro__;
  _Daemon_ ();
  _Daemon_outer_op_xfer_macro__;
}


void
_Daemon_ ()
{
  MUTEX_DECL (_Daemon_series_block_stmt_5_c_mutex_);
  MUTEX_LOCK (_Daemon_series_block_stmt_5_c_mutex_);
  _Daemon_inner_inarg_prep_macro__;
  _Daemon_branch_block_stmt_6_c_export_decl_macro_;
  {
    {
// do-while:   file DoWhile.aa, line 9
      __declare_bit_vector (konst_44, 8);
      __declare_bit_vector (ULT_u8_u1_45, 1);
      uint8_t do_while_entry_flag;
      do_while_entry_flag = 1;
      uint8_t do_while_loopback_flag;
      do_while_loopback_flag = 0;
      while (1)
	{
// merge  file DoWhile.aa, line 12
	  _Daemon_merge_stmt_8_c_preamble_macro_;
//                      $phi I :=                         ($bitcast ($uint<8>) 0  ) $on $entry                    NI $on $loopback // type of target is $uint<8>
	  _Daemon_phi_stmt_9_c_macro_;
	  _Daemon_merge_stmt_8_c_postamble_macro_;
//                      T[I][I] := in_data
	  _Daemon_assign_stmt_20_c_macro_;
//                      gflag := (I >= 0 )
	  _Daemon_assign_stmt_26_c_macro_;
//                      $guard (gflag) out_data := (T[I][I] * T[I][I])
	  _Daemon_assign_stmt_35_c_macro_;
//                      NI := (I + 1 )
	  _Daemon_assign_stmt_41_c_macro_;
	  do_while_entry_flag = 0;
	  do_while_loopback_flag = 1;
	  bit_vector_clear (&konst_44);
	  konst_44.val.byte_array[0] = 4;
	  bit_vector_less (0, &(NI), &(konst_44), &(ULT_u8_u1_45));
	  if (has_undefined_bit (&ULT_u8_u1_45))
	    {
	      fprintf (stderr,
		       "Error: variable ULT_u8_u1_45 has undefined value at test point.\n");
	      assert (0);
	    }

	  if (!bit_vector_to_uint64 (0, &ULT_u8_u1_45))
	    break;
	}
    }
    _Daemon_branch_block_stmt_6_c_export_apply_macro_;
  }
  _Daemon_inner_outarg_prep_macro__;
  MUTEX_UNLOCK (_Daemon_series_block_stmt_5_c_mutex_);
}

void
start_daemons (FILE * fp)
{
  __report_log_file__ = fp;
  __init_aa_globals__ ();
}

void
stop_daemons ()
{
}