#include <stdio.h>
void _start_daemons(FILE* fp, int trace_on);
void _stop_daemons();
typedef enum __replicateClockStateEnum_ 
{
__rst_state
} __replicateClockStateEnum;
typedef struct __replicateClockState_ __replicateClockState;
struct __replicateClockState_ 
{
int  _tick_count;
char* _string_name;
__replicateClockStateEnum  _state;
__replicateClockStateEnum  _next_state;
bit_vector A;
bit_vector B;
bit_vector __next__B;
SignalMatcherRec* __matcher_A;
SignalMatcherRec* __matcher_B;
};
void S1_Stage1_start_daemons(FILE* fp, int trace_on);
void S2_Stage2_start_daemons(FILE* fp, int trace_on);
void S1_Stage1_stop_daemons();
void S2_Stage2_stop_daemons();
