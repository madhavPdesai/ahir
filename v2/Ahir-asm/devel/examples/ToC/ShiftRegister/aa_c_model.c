#include <Pipes.h>
#include <aa_c_model.h>
void
__init_aa_globals__ ()
{
}

void
shiftregister (uint16_t a, uint16_t * b)
{
  __declare_bit_vector (__a, 16);
  bit_vector_assign_uint64 (0, &__a, a);
  __declare_bit_vector (__b, 16);
  _shiftregister_ (&__a, &__b);
  *b = bit_vector_to_uint64 (0, &__b);
}


void
_shiftregister_ (bit_vector * __pa, bit_vector * __pb)
{
  __declare_bit_vector (a, 16);
  bit_vector_assign_bit_vector (0, &((*__pa)), &(a));
  __declare_bit_vector (b, 16);
  {
    {
// merge:  file ShiftRegister.aa, line 21
      uint8_t merge_stmt_9_entry_flag;
      merge_stmt_9_entry_flag = 1;
      uint8_t loopback_8_flag = 0;
      goto merge_stmt_9_run;
    loopback_8:loopback_8_flag = 1;
      goto merge_stmt_9_run;

    merge_stmt_9_run:;
      loopback_8_flag = 0;
      merge_stmt_9_entry_flag = 0;
//                      $call Read () (inpipe ) 
//  file ShiftRegister.aa, line 24
      __declare_bit_vector (WPIPE_xxshiftregisterxxinpipe_10, 16);
      uint16_t __WPIPE_xxshiftregisterxxinpipe_10;
      Read (&__WPIPE_xxshiftregisterxxinpipe_10);
      bit_vector_assign_uint64 (0, &WPIPE_xxshiftregisterxxinpipe_10,
				__WPIPE_xxshiftregisterxxinpipe_10);
      {
	uint16_t __tmp;
	__tmp = bit_vector_to_uint64 (0, &WPIPE_xxshiftregisterxxinpipe_10);
	write_uint16 ("inpipe", __tmp);
      }
      goto loopback_8;
    }
    {
// merge:  file ShiftRegister.aa, line 29
      uint8_t merge_stmt_15_entry_flag;
      merge_stmt_15_entry_flag = 1;
      uint8_t loopback_14_flag = 0;
      goto merge_stmt_15_run;
    loopback_14:loopback_14_flag = 1;
      goto merge_stmt_15_run;

    merge_stmt_15_run:;
      loopback_14_flag = 0;
      merge_stmt_15_entry_flag = 0;
//                      midpipe := inpipe
//  file ShiftRegister.aa, line 30
      __declare_bit_vector (RPIPE_xxshiftregisterxxinpipe_17, 16);
      bit_vector_assign_uint64 (0, &RPIPE_xxshiftregisterxxinpipe_17,
				read_uint16 ("inpipe"));
      {
	uint16_t __tmp;
	__tmp = bit_vector_to_uint64 (0, &RPIPE_xxshiftregisterxxinpipe_17);
	write_uint16 ("midpipe", __tmp);
      }
      goto loopback_14;
    }
    {
// merge:  file ShiftRegister.aa, line 35
      uint8_t merge_stmt_22_entry_flag;
      merge_stmt_22_entry_flag = 1;
      uint8_t loopback_21_flag = 0;
      goto merge_stmt_22_run;
    loopback_21:loopback_21_flag = 1;
      goto merge_stmt_22_run;

    merge_stmt_22_run:;
      loopback_21_flag = 0;
      merge_stmt_22_entry_flag = 0;
//                      outpipe := midpipe
//  file ShiftRegister.aa, line 36
      __declare_bit_vector (RPIPE_xxshiftregisterxxp1xxmidpipe_24, 16);
      bit_vector_assign_uint64 (0, &RPIPE_xxshiftregisterxxp1xxmidpipe_24,
				read_uint16 ("midpipe"));
      {
	uint16_t __tmp;
	__tmp =
	  bit_vector_to_uint64 (0, &RPIPE_xxshiftregisterxxp1xxmidpipe_24);
	write_uint16 ("outpipe", __tmp);
      }
      goto loopback_21;
    }
    {
// merge:  file ShiftRegister.aa, line 40
      uint8_t merge_stmt_29_entry_flag;
      merge_stmt_29_entry_flag = 1;
      uint8_t loopback_28_flag = 0;
      goto merge_stmt_29_run;
    loopback_28:loopback_28_flag = 1;
      goto merge_stmt_29_run;

    merge_stmt_29_run:;
      loopback_28_flag = 0;
      merge_stmt_29_entry_flag = 0;
//                      $call Print (outpipe ) () 
//  file ShiftRegister.aa, line 43
      __declare_bit_vector (RPIPE_xxshiftregisterxxoutpipe_30, 16);
      bit_vector_assign_uint64 (0, &RPIPE_xxshiftregisterxxoutpipe_30,
				read_uint16 ("outpipe"));
      Print (bit_vector_to_uint64 (0, &RPIPE_xxshiftregisterxxoutpipe_30));
      goto loopback_28;
    }
  }
//      $call Print (5  ) () 
//  file ShiftRegister.aa, line 47
  __declare_bit_vector (konst_35, 16);
  konst_35.val.byte_array[0] = 5;
  konst_35.val.byte_array[1] = 0;
  Print (bit_vector_to_uint64 (0, &konst_35));
// output side transfers...
  bit_vector_assign_bit_vector (0, &(b), &((*__pb)));
}
