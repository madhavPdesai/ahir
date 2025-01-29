#include <string.h>
#include <pipeHandler.h>
#include <pthreadUtils.h>
#include <rtl2AaMatcher.h>
#include <_Top.h>
const char* replicateClock__state_names[] = {
"rst_state"
};
void __replicateClock_log__(__replicateClockState* incoming_state)
{
__replicateClockState* __sstate = incoming_state;
fprintf(stderr, "log: ------------------------------------ string %s  ---------------------------\n", __sstate->_string_name);
fprintf(stderr,"log:%s:[%d]  _state =  %s\n", __sstate->_string_name, __sstate->_tick_count, replicateClock__state_names[__sstate->_state]);
fprintf(stderr,"log:%s:[%d]  _next_state =  %s\n", __sstate->_string_name, __sstate->_tick_count, replicateClock__state_names[__sstate->_next_state]);
fprintf(stderr, "log:%s:[%d]  %s = %s\n", __sstate->_string_name, __sstate->_tick_count, "A",to_string(&(__sstate->A)));
fprintf(stderr, "log:%s:[%d]  %s = %s\n", __sstate->_string_name, __sstate->_tick_count, "B",to_string(&(__sstate->B)));
fprintf(stderr, "log: ------------------------------------ end-log-entry ---------------------------\n");
}
void __replicateClock__run__(__replicateClockState* incoming_state)
{
__replicateClockState* __sstate = incoming_state;
// default statements; 
// B :=  A

bit_vector_bitcast_to_bit_vector(&(__sstate->__next__B), &(__sstate->A));

if(__sstate->_state == __rst_state)
{
// default next-state 
__sstate->_next_state = __rst_state;
// label: rst_state
{
// $goto rst_state
__sstate->_next_state = __rst_state;
}
}
// immediate assignments 
}
void __replicateClock__tick__(__replicateClockState* incoming_state)
{
__replicateClockState* __sstate = incoming_state;
__sstate->_tick_count++;
__sstate->_state = __sstate->_next_state;
bit_vector_bitcast_to_bit_vector(&(__sstate->B), &(__sstate->__next__B));
{
// signal-access probe triggered by B
assignSignalValue(__sstate->__matcher_B, &(__sstate->B));
}
// tick assignments 
}
SignalMatcherRec* __EXTCLK__to__clkInst;
SignalMatcherRec* __clkInst__to__EXTCLK_REPEATED;
void __clkInst__matcher_allocator()
{
__EXTCLK__to__clkInst = makeSignalMatcher("EXTCLK", 1);
__clkInst__to__EXTCLK_REPEATED = makeSignalMatcher("EXTCLK_REPEATED", 1);
}
__replicateClockState* __clkInst__state = NULL;
void __clkInst__struct_allocator()
{
__clkInst__state = (__replicateClockState*) calloc(1,sizeof(__replicateClockState));
// standard name __sstate.
__replicateClockState* __sstate = __clkInst__state;
__sstate->_tick_count = 0;
__sstate->_string_name = strdup("clkInst");
__sstate->_state = __rst_state;
__sstate->_next_state = __rst_state;
init_bit_vector(&(__sstate->A), 1);
bit_vector_clear(&(__sstate->A));
init_bit_vector(&(__sstate->B), 1);
bit_vector_clear(&(__sstate->B));
init_bit_vector(&(__sstate->__next__B), 1);
bit_vector_clear(&(__sstate->__next__B));
__sstate->__matcher_A = __EXTCLK__to__clkInst;
__sstate->__matcher_B = __clkInst__to__EXTCLK_REPEATED;
}
void Top_String_Ticker()
{
__clkInst__struct_allocator();
while(1) { 
__replicateClock__run__(__clkInst__state);
__replicateClock__tick__(__clkInst__state);
}
}
DEFINE_THREAD(Top_String_Ticker);
void __EXTCLK__to__clkInst__match_daemon() 
{
Aa2RtlSignalTransferMatcher((void*) __EXTCLK__to__clkInst);
}
DEFINE_THREAD(__EXTCLK__to__clkInst__match_daemon);
void __clkInst__to__EXTCLK_REPEATED__match_daemon() 
{
Rtl2AaSignalTransferMatcher((void*) __clkInst__to__EXTCLK_REPEATED);
}
DEFINE_THREAD(__clkInst__to__EXTCLK_REPEATED__match_daemon);
void _start_daemons(FILE* fp, int trace_on) {
 register_pipe("A", 1, 32, 0);
 set_pipe_is_read_from("A");
 register_pipe("TMP", 1, 32, 0);
 set_pipe_is_written_into("TMP");
 register_pipe("TMP", 1, 32, 0);
 set_pipe_is_read_from("TMP");
 register_pipe("B", 1, 32, 0);
 set_pipe_is_written_into("B");
 register_pipe("A", 1, 32, 0);
 set_pipe_is_read_from("A");
 register_signal("EXTCLK", 8);
 set_pipe_is_read_from("EXTCLK");
 register_signal("EXTRESET", 8);
 set_pipe_is_read_from("EXTRESET");
 register_pipe("B", 1, 32, 0);
 set_pipe_is_written_into("B");
 register_signal("EXTCLK_REPEATED", 8);
 set_pipe_is_read_from("EXTCLK_REPEATED");
 set_pipe_is_written_into("EXTCLK_REPEATED");
 register_pipe("TMP", 1, 32, 0);
 set_pipe_is_read_from("TMP");
 set_pipe_is_written_into("TMP");
S1_Stage1_start_daemons(fp, trace_on);
S2_Stage2_start_daemons(fp, trace_on);
// allocate match structs for system Top
__clkInst__matcher_allocator();
// match daemons for system Top
PTHREAD_DECL(__EXTCLK__to__clkInst__match_daemon);
PTHREAD_CREATE(__EXTCLK__to__clkInst__match_daemon);
PTHREAD_DECL(__clkInst__to__EXTCLK_REPEATED__match_daemon);
PTHREAD_CREATE(__clkInst__to__EXTCLK_REPEATED__match_daemon);
PTHREAD_DECL(Top_String_Ticker);
PTHREAD_CREATE(Top_String_Ticker);
}
void _stop_daemons() {
S1_Stage1_stop_daemons();
S2_Stage2_stop_daemons();
}
