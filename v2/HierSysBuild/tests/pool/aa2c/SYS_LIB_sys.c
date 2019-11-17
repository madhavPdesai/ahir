#include <string.h>
#include <pipeHandler.h>
#include <pthreadUtils.h>
#include <rtl2AaMatcher.h>
#include <SYS_LIB_sys.h>
void SYS_LIB_start_daemons(FILE* fp, int trace_on) {
 register_pipe("DATA_OUT", 1, 8, 0);
set_pipe_is_read_from("DATA_OUT");
 register_pipe("E1_IN", 1, 8, 0);
set_pipe_is_written_into("E1_IN");
set_pipe_is_read_from("E1_IN");
 register_pipe("E1_OUT", 1, 8, 0);
set_pipe_is_written_into("E1_OUT");
set_pipe_is_read_from("E1_OUT");
 register_pipe("E2_IN", 1, 8, 0);
set_pipe_is_written_into("E2_IN");
set_pipe_is_read_from("E2_IN");
 register_pipe("E2_OUT", 1, 8, 0);
set_pipe_is_written_into("E2_OUT");
set_pipe_is_read_from("E2_OUT");
 register_pipe("DATA_IN", 1, 8, 0);
set_pipe_is_written_into("DATA_IN");
SYS_LIB_sys_e1_start_daemons(fp,trace_on);
SYS_LIB_sys_e2_start_daemons(fp,trace_on);
SYS_LIB_sys_c_start_daemons(fp,trace_on);
}
void SYS_LIB_stop_daemons() {
SYS_LIB_sys_e1_stop_daemons();
SYS_LIB_sys_e2_stop_daemons();
SYS_LIB_sys_c_stop_daemons();
}
