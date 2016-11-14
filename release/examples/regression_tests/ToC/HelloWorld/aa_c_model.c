#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <aa_c_model.h>
FILE *__report_log_file__ = NULL;
void
_set_trace_file (FILE * fp)
{
  __report_log_file__ = fp;
}

bit_vector M;
void
__init_aa_globals__ ()
{
  init_bit_vector (&(M), 20);
  register_pipe ("TM", 1, 32, 0);
}

void
_sum_mod_ (bit_vector * __pa, bit_vector * __pb, bit_vector * __pc)
{
  MUTEX_DECL (_sum_mod_series_block_stmt_33_c_mutex_);
  MUTEX_LOCK (_sum_mod_series_block_stmt_33_c_mutex_);
  _sum_mod_inner_inarg_prep_macro__;
  _sum_mod_parallel_block_stmt_37_c_export_decl_macro_;
  {
//              q := (a + b)
    _sum_mod_assign_stmt_42_c_macro_;
//              r := (q + b)
    _sum_mod_assign_stmt_47_c_macro_;
    _sum_mod_parallel_block_stmt_37_c_export_apply_macro_;
  }
// $report (sum_mod interim_report       a a     b b     q q     r r )
  _sum_mod_stmt_53_c_macro_;
//      TM := ($bitcast ($uint<32>) (r && b) )
  _sum_mod_assign_stmt_59_c_macro_;
//      M := ($bitcast ($uint<20>) TM )
  _sum_mod_assign_stmt_63_c_macro_;
//      c := M
  _sum_mod_assign_stmt_66_c_macro_;
  _sum_mod_inner_outarg_prep_macro__;
  MUTEX_UNLOCK (_sum_mod_series_block_stmt_33_c_mutex_);
}

void
_sum_mod_wrap_ (bit_vector * __pa, bit_vector * __pb, bit_vector * __pc)
{
  MUTEX_DECL (_sum_mod_wrap_series_block_stmt_4_c_mutex_);
  MUTEX_LOCK (_sum_mod_wrap_series_block_stmt_4_c_mutex_);
  _sum_mod_wrap_inner_inarg_prep_macro__;
//      aaa[0 ] := ($bitcast ($uint<10>) a )
  _sum_mod_wrap_assign_stmt_16_c_macro_;
//      aaa[1 ] := ($bitcast ($uint<10>) b )
  _sum_mod_wrap_assign_stmt_21_c_macro_;
//      $call sum_mod (aaa[0 ] aaa[1 ] ) (c20 ) 
  _sum_mod_wrap_call_stmt_27_c_macro_;
//      c := ($bitcast ($uint<32>) c20 )
  _sum_mod_wrap_assign_stmt_31_c_macro_;
  _sum_mod_wrap_inner_outarg_prep_macro__;
  MUTEX_UNLOCK (_sum_mod_wrap_series_block_stmt_4_c_mutex_);
}

void
sum_mod_wrap (uint16_t a, uint16_t b, uint32_t * c)
{
  _sum_mod_wrap_outer_arg_decl_macro__;
  _sum_mod_wrap_ (&__a, &__b, &__c);
  _sum_mod_wrap_outer_op_xfer_macro__;
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
