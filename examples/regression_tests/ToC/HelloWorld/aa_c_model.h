#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
#include <pipeHandler.h>
void _set_trace_file (FILE * fp);
void __init_aa_globals__ ();
void _sum_mod_ (bit_vector *, bit_vector *, bit_vector *);
void sum_mod_wrap (uint16_t, uint16_t, uint32_t *);
void _sum_mod_wrap_ (bit_vector *, bit_vector *, bit_vector *);
void start_daemons (FILE * fp, int trace_on);
void stop_daemons ();
