#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <aa_c_model_internal.h>
#include <aa_c_model.h>
FILE* __report_log_file__ = NULL;
int __trace_on__ = 0;
void _set_trace_file(FILE* fp) {
__report_log_file__ = fp;
}
void __init_aa_globals__() 
{
register_pipe("in_data", 2, 32, 0);\
register_pipe("out_data", 2, 32, 0);\
register_signal("wide_signal", 128);\
}
void _global_storage_initializer__()
{
MUTEX_DECL(_global_storage_initializer__series_block_stmt_5_c_mutex_);
MUTEX_LOCK(_global_storage_initializer__series_block_stmt_5_c_mutex_);
_global_storage_initializer__inner_inarg_prep_macro__; 
/* null */ ;
_global_storage_initializer__inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_global_storage_initializer__series_block_stmt_5_c_mutex_);
}
void global_storage_initializer_()
{
_global_storage_initializer__outer_arg_decl_macro__;
_global_storage_initializer__();
_global_storage_initializer__outer_op_xfer_macro__;
}


void _p2p_check_daemon_()
{
MUTEX_DECL(_p2p_check_daemon_series_block_stmt_8_c_mutex_);
MUTEX_LOCK(_p2p_check_daemon_series_block_stmt_8_c_mutex_);
_p2p_check_daemon_inner_inarg_prep_macro__; 
_p2p_check_daemon_branch_block_stmt_9_c_export_decl_macro_; 
{
{
// do-while:   file prog.linked.opt.aa, line 21
__declare_static_bit_vector(konst_63,1);\
bit_vector_clear(&konst_63);\
konst_63.val.byte_array[0] = 1;\
uint8_t do_while_entry_flag;
do_while_entry_flag = 1;
uint8_t do_while_loopback_flag;
do_while_loopback_flag = 0;
while(1) {
// merge  file prog.linked.opt.aa, line 23
_p2p_check_daemon_merge_stmt_11_c_preamble_macro_; 
_p2p_check_daemon_merge_stmt_11_c_postamble_macro_; 
// 			CMD := in_data $buffering 1// bits of buffering = 32. 
_p2p_check_daemon_assign_stmt_14_c_macro_; 
// 			$volatile ws := ((CMD && CMD) && (CMD && CMD)) $buffering 1
_p2p_check_daemon_assign_stmt_23_c_macro_; 
// 			wide_signal := ws $buffering 1 $mark WSM // bits of buffering = 128. 
_p2p_check_daemon_assign_stmt_26_c_macro_; 
// 			rs := wide_signal $buffering 1// bits of buffering = 128. 
_p2p_check_daemon_assign_stmt_29_c_macro_; 
// $report (p2p wide_signal_status 			 wide_signal wide_signal 			 ws ws 			 rs rs )
_p2p_check_daemon_stmt_33_c_macro_; 
// 			w0 := ( $slice rs 127 96 )  $buffering 1// bits of buffering = 32. 
_p2p_check_daemon_assign_stmt_37_c_macro_; 
// 			w1 := ( $slice rs 95 64 )  $buffering 1// bits of buffering = 32. 
_p2p_check_daemon_assign_stmt_41_c_macro_; 
// 			w2 := ( $slice rs 63 32 )  $buffering 1// bits of buffering = 32. 
_p2p_check_daemon_assign_stmt_45_c_macro_; 
// 			w3 := ( $slice rs 31 0 )  $buffering 1// bits of buffering = 32. 
_p2p_check_daemon_assign_stmt_49_c_macro_; 
// 			$volatile d := ((w0 | w1) | (w2 | w3)) $buffering 1
_p2p_check_daemon_assign_stmt_58_c_macro_; 
// 			out_data := d $buffering 1 $synch ( $update WSM )  // bits of buffering = 32. 
_p2p_check_daemon_assign_stmt_61_c_macro_; 
do_while_entry_flag = 0;
do_while_loopback_flag = 1;
bit_vector_clear(&konst_63);\
konst_63.val.byte_array[0] = 1;\
if (!bit_vector_to_uint64(0, &konst_63)) break;
} 
}
_p2p_check_daemon_branch_block_stmt_9_c_export_apply_macro_;
}
_p2p_check_daemon_inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_p2p_check_daemon_series_block_stmt_8_c_mutex_);
}
void p2p_check_daemon()
{
_p2p_check_daemon_outer_arg_decl_macro__;
_p2p_check_daemon_();
_p2p_check_daemon_outer_op_xfer_macro__;
}


DEFINE_THREAD(p2p_check_daemon);
PTHREAD_DECL(p2p_check_daemon);
void start_daemons(FILE* fp, int trace_on) {
__report_log_file__ = fp;
__trace_on__ = trace_on;
__init_aa_globals__(); 
PTHREAD_CREATE(p2p_check_daemon);
}
void stop_daemons() {
PTHREAD_CANCEL(p2p_check_daemon);
}
