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

bit_vector O1;
bit_vector O2;
bit_vector O4;
bit_vector O8;
bit_vector Z1;
bit_vector Z2;
bit_vector Z4;
bit_vector Z8;
void
__init_aa_globals__ ()
{
  init_bit_vector (&(O1), 1);
  bit_vector_clear (&O1);
  O1.val.byte_array[0] = 1;
  init_bit_vector (&(O2), 2);
  bit_vector_clear (&O2);
  O2.val.byte_array[0] = 3;
  init_bit_vector (&(O4), 4);
  bit_vector_clear (&O4);
  O4.val.byte_array[0] = 15;
  init_bit_vector (&(O8), 8);
  bit_vector_clear (&O8);
  O8.val.byte_array[0] = 255;
  init_bit_vector (&(Z1), 1);
  bit_vector_clear (&Z1);
  init_bit_vector (&(Z2), 2);
  bit_vector_clear (&Z2);
  init_bit_vector (&(Z4), 4);
  bit_vector_clear (&Z4);
  init_bit_vector (&(Z8), 8);
  bit_vector_clear (&Z8);
}

void
_Test_ (bit_vector * __pret_val)
{
  MUTEX_DECL (_Test_series_block_stmt_38_c_mutex_);
  MUTEX_LOCK (_Test_series_block_stmt_38_c_mutex_);
  _Test_inner_inarg_prep_macro__;
//      cval := ((((Z1 && O1) && Z2) && (O2 && Z4)) && ((O4 && Z8) && (O8 && Z2)))
  _Test_assign_stmt_59_c_macro_;
//      u1 := ( $slice cval 31 31 ) 
  _Test_assign_stmt_71_c_macro_;
//      u2 := ( $slice cval 30 30 ) 
  _Test_assign_stmt_74_c_macro_;
//      u3 := ( $slice cval 29 28 ) 
  _Test_assign_stmt_77_c_macro_;
//      u4 := ( $slice cval 27 26 ) 
  _Test_assign_stmt_80_c_macro_;
//      u5 := ( $slice cval 25 22 ) 
  _Test_assign_stmt_83_c_macro_;
//      u6 := ( $slice cval 21 18 ) 
  _Test_assign_stmt_86_c_macro_;
//      u7 := ( $slice cval 17 10 ) 
  _Test_assign_stmt_89_c_macro_;
//      u8 := ( $slice cval 9 2 ) 
  _Test_assign_stmt_92_c_macro_;
//      u9 := ( $slice cval 1 0 ) 
  _Test_assign_stmt_95_c_macro_;
//  $volatile   $call cc (u1 u2 ) (uu ) 
  _Test_call_stmt_99_c_macro_;
//      ret_val := (((uu && u3) && (u4 && u5)) && ((u6 && u7) && (u8 && u9)))
  _Test_assign_stmt_116_c_macro_;
  _Test_inner_outarg_prep_macro__;
  MUTEX_UNLOCK (_Test_series_block_stmt_38_c_mutex_);
}

void
Test (uint32_t * ret_val)
{
  _Test_outer_arg_decl_macro__;
  _Test_ (&__ret_val);
  _Test_outer_op_xfer_macro__;
}


void
_cc_ (bit_vector * __pu1, bit_vector * __pu2, bit_vector * __pcu)
{
  MUTEX_DECL (_cc_series_block_stmt_28_c_mutex_);
  MUTEX_LOCK (_cc_series_block_stmt_28_c_mutex_);
  _cc_inner_inarg_prep_macro__;
//      cu := (u1 && u2)
  _cc_assign_stmt_36_c_macro_;
  _cc_inner_outarg_prep_macro__;
  MUTEX_UNLOCK (_cc_series_block_stmt_28_c_mutex_);
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
