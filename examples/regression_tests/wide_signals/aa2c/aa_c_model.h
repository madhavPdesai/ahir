#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
#include <pipeHandler.h>
void _set_trace_file(FILE* fp);
void __init_aa_globals__(); 
void global_storage_initializer_();
void _global_storage_initializer__();
void p2p_check_daemon();
void _p2p_check_daemon_();
void start_daemons(FILE* fp, int trace_on);
void stop_daemons();
