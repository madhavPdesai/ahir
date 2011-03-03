#include <Aa2C.h>
typedef struct sum_mod_State__
{
  uint_10 a;
  uint_10 b;
  uint_10 c;
  uint_10 I;
  unsigned int _assign_line_8_entry:1;
  unsigned int _assign_line_8_in_progress:1;
  unsigned int _assign_line_8_exit:1;
  struct _bb__
  {
    unsigned int bb_entry:1;
    unsigned int bb_exit:1;
    unsigned int bb_in_progress:1;
    unsigned int _merge_line_10_entry:1;
    unsigned int _merge_line_10_exit:1;
    unsigned int _merge_line_10_in_progress:1;
    unsigned int _phi_line_11_entry:1;
    unsigned int _phi_line_11_in_progress:1;
    unsigned int _phi_line_11_exit:1;
    uint_10 s1;
    unsigned int _merge_line_10_from_entry:1;
    unsigned int _assign_line_13_entry:1;
    unsigned int _assign_line_13_in_progress:1;
    unsigned int _assign_line_13_exit:1;
    uint_10 s;
    unsigned int _assign_line_14_entry:1;
    unsigned int _assign_line_14_in_progress:1;
    unsigned int _assign_line_14_exit:1;
    unsigned int _switch_line_15_entry:1;
    unsigned int _switch_line_15_in_progress:1;
    unsigned int _switch_line_15_exit:1;
    unsigned int loopback:1;
    unsigned int _place_line_15_entry:1;
    unsigned int _null_line_0_entry:1;
    unsigned int _null_line_0_in_progress:1;
    unsigned int _null_line_0_exit:1;
  } bb;
  unsigned int _assign_line_17_entry:1;
  unsigned int _assign_line_17_in_progress:1;
  unsigned int _assign_line_17_exit:1;
  unsigned sum_mod_entry:1;
  unsigned sum_mod_in_progress:1;
  unsigned sum_mod_exit:1;
} sum_mod_State;
sum_mod_State *sum_mod_ (sum_mod_State *);
int sum_mod (uint_10, uint_10, uint_10 *);
