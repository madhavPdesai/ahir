#include <Aa2C.h>
typedef struct Print_State__
{
  uint_10 a;
  unsigned Print_entry:1;
  unsigned Print_in_progress:1;
  unsigned Print_exit:1;
} Print_State;
int Print (uint_10);
typedef struct Read_State__
{
  uint_10 result;
  unsigned Read_entry:1;
  unsigned Read_in_progress:1;
  unsigned Read_exit:1;
} Read_State;
int Read (uint_10 *);
typedef struct shiftregister_State__
{
  uint_10 a;
  uint_10 b;
  uint_10 inpipe;
  unsigned int inpipe_valid__:1;
  uint_10 outpipe;
  unsigned int outpipe_valid__:1;
  struct _p1__
  {
    uint_10 midpipe;
    unsigned int midpipe_valid__:1;
    unsigned int p1_entry:1;
    unsigned int p1_exit:1;
    unsigned int p1_in_progress:1;
    struct _reader__
    {
      unsigned int reader_entry:1;
      unsigned int reader_exit:1;
      unsigned int reader_in_progress:1;
      unsigned int _merge_line_17_entry:1;
      unsigned int _merge_line_17_exit:1;
      unsigned int _merge_line_17_in_progress:1;
      unsigned int _merge_line_17_from_entry:1;
      unsigned int _call_line_20_entry:1;
      unsigned int _call_line_20_in_progress:1;
      unsigned int _call_line_20_exit:1;
      Print_State *_call_line_20_called_fn_struct;
      unsigned int _place_line_21_entry:1;
      unsigned int loopback:1;
    } reader;
    struct _b1__
    {
      unsigned int b1_entry:1;
      unsigned int b1_exit:1;
      unsigned int b1_in_progress:1;
      unsigned int _merge_line_25_entry:1;
      unsigned int _merge_line_25_exit:1;
      unsigned int _merge_line_25_in_progress:1;
      unsigned int _merge_line_25_from_entry:1;
      unsigned int _assign_line_26_entry:1;
      unsigned int _assign_line_26_in_progress:1;
      unsigned int _assign_line_26_exit:1;
      unsigned int _place_line_27_entry:1;
      unsigned int loopback:1;
    } b1;
    struct _b2__
    {
      unsigned int b2_entry:1;
      unsigned int b2_exit:1;
      unsigned int b2_in_progress:1;
      unsigned int _merge_line_31_entry:1;
      unsigned int _merge_line_31_exit:1;
      unsigned int _merge_line_31_in_progress:1;
      unsigned int _merge_line_31_from_entry:1;
      unsigned int _assign_line_32_entry:1;
      unsigned int _assign_line_32_in_progress:1;
      unsigned int _assign_line_32_exit:1;
      unsigned int _place_line_33_entry:1;
      unsigned int loopback:1;
    } b2;
    struct _writer__
    {
      unsigned int writer_entry:1;
      unsigned int writer_exit:1;
      unsigned int writer_in_progress:1;
      unsigned int _merge_line_37_entry:1;
      unsigned int _merge_line_37_exit:1;
      unsigned int _merge_line_37_in_progress:1;
      unsigned int _merge_line_37_from_entry:1;
      unsigned int _call_line_40_entry:1;
      unsigned int _call_line_40_in_progress:1;
      unsigned int _call_line_40_exit:1;
      Read_State *_call_line_40_called_fn_struct;
      unsigned int _place_line_41_entry:1;
      unsigned int loopback:1;
    } writer;
  } p1;
  unsigned int _call_line_44_entry:1;
  unsigned int _call_line_44_in_progress:1;
  unsigned int _call_line_44_exit:1;
  Print_State *_call_line_44_called_fn_struct;
  unsigned shiftregister_entry:1;
  unsigned shiftregister_in_progress:1;
  unsigned shiftregister_exit:1;
} shiftregister_State;
shiftregister_State *shiftregister_ (shiftregister_State *);
int shiftregister (uint_10, uint_10 *);
