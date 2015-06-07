#include <Pipes.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <aa_c_model.h>
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
  _stage_0_ ();
}


void
_stage_0_ ()
{
  {
// merge:  file ShiftRegister.aa, line 14
    uint8_t merge_stmt_7_entry_flag;
    merge_stmt_7_entry_flag = 1;
    uint8_t loopback_6_flag = 0;
    goto merge_stmt_7_run;
  loopback_6:loopback_6_flag = 1;
    goto merge_stmt_7_run;

  merge_stmt_7_run:;
    loopback_6_flag = 0;
    merge_stmt_7_entry_flag = 0;
//              $call Read () (inpipe ) 
//  file ShiftRegister.aa, line 16
    __declare_bit_vector (WPIPE_inpipe_8, 16);
    uint16_t __WPIPE_inpipe_8;
    Read (&__WPIPE_inpipe_8);
    bit_vector_assign_uint64 (0, &WPIPE_inpipe_8, __WPIPE_inpipe_8);
    {
      uint16_t __tmp;
      __tmp = bit_vector_to_uint64 (0, &WPIPE_inpipe_8);
      write_uint16 ("inpipe", __tmp);
    }
    goto loopback_6;
  }
// output side transfers...
}

void
stage_1 ()
{
  _stage_1_ ();
}


void
_stage_1_ ()
{
  {
// merge:  file ShiftRegister.aa, line 27
    uint8_t merge_stmt_15_entry_flag;
    merge_stmt_15_entry_flag = 1;
    uint8_t loopback_14_flag = 0;
    goto merge_stmt_15_run;
  loopback_14:loopback_14_flag = 1;
    goto merge_stmt_15_run;

  merge_stmt_15_run:;
    loopback_14_flag = 0;
    merge_stmt_15_entry_flag = 0;
//              midpipe := ($bitcast ($uint<20>) inpipe )
//  file ShiftRegister.aa, line 28
    __declare_bit_vector (RPIPE_inpipe_17, 16);
    __declare_bit_vector (type_cast_18, 20);
    bit_vector_assign_uint64 (0, &RPIPE_inpipe_17, read_uint16 ("inpipe"));
    bit_vector_cast_to_bit_vector (0, &(type_cast_18), &(RPIPE_inpipe_17));
    write_uint8_n ("midpipe", type_cast_18.val.byte_array,
		   type_cast_18.val.array_size);
    goto loopback_14;
  }
// output side transfers...
}

void
stage_2 ()
{
  _stage_2_ ();
}


void
_stage_2_ ()
{
  {
// merge:  file ShiftRegister.aa, line 39
    uint8_t merge_stmt_25_entry_flag;
    merge_stmt_25_entry_flag = 1;
    uint8_t loopback_24_flag = 0;
    goto merge_stmt_25_run;
  loopback_24:loopback_24_flag = 1;
    goto merge_stmt_25_run;

  merge_stmt_25_run:;
    loopback_24_flag = 0;
    merge_stmt_25_entry_flag = 0;
//              outpipe := ($bitcast ($uint<16>) midpipe )
//  file ShiftRegister.aa, line 40
    __declare_bit_vector (RPIPE_midpipe_27, 20);
    __declare_bit_vector (type_cast_28, 16);
    read_uint8_n ("midpipe", RPIPE_midpipe_27.val.byte_array,
		  RPIPE_midpipe_27.val.array_size);
    bit_vector_cast_to_bit_vector (0, &(type_cast_28), &(RPIPE_midpipe_27));
    {
      uint16_t __tmp;
      __tmp = bit_vector_to_uint64 (0, &type_cast_28);
      write_uint16 ("outpipe", __tmp);
    }
    goto loopback_24;
  }
// output side transfers...
}

void
stage_3 ()
{
  _stage_3_ ();
}


void
_stage_3_ ()
{
  {
// merge:  file ShiftRegister.aa, line 51
    uint8_t merge_stmt_35_entry_flag;
    merge_stmt_35_entry_flag = 1;
    goto merge_stmt_35_run;

  merge_stmt_35_run:;
    merge_stmt_35_entry_flag = 0;
    {
// do-while:   file ShiftRegister.aa, line 53
      __declare_bit_vector (konst_41, 1);
      bit_vector_clear (&konst_41);
      konst_41.val.byte_array[0] = 1;
      uint8_t do_while_entry_flag;
      do_while_entry_flag = 1;
      uint8_t do_while_loopback_flag;
      do_while_loopback_flag = 0;
      do
	{
// merge:  file ShiftRegister.aa, line 54
	  uint8_t merge_stmt_37_entry_flag;
	  merge_stmt_37_entry_flag = do_while_entry_flag;
	  goto merge_stmt_37_run;

	merge_stmt_37_run:;
	  merge_stmt_37_entry_flag = 0;
//                      $call Print (outpipe ) () 
//  file ShiftRegister.aa, line 55
	  __declare_bit_vector (RPIPE_outpipe_38, 16);
	  bit_vector_assign_uint64 (0, &RPIPE_outpipe_38,
				    read_uint16 ("outpipe"));
	  uint16_t __RPIPE_outpipe_38;
	  Print (bit_vector_to_uint64 (0, &RPIPE_outpipe_38));
	  do_while_entry_flag = 0;
	  do_while_loopback_flag = 1;
	}
      while (bit_vector_to_uint64 (0, &konst_41));
    }
  }
// output side transfers...
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
start_daemons ()
{
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
