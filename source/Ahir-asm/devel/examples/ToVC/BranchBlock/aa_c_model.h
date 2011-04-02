#include <Aa2C.h>
typedef struct sum_mod_State__
{
  uint_10 a;
  uint_10 b;
  uint_10 c;
  struct _bb1__
  {
    unsigned int bb1_entry:1;
    unsigned int bb1_exit:1;
    unsigned int bb1_in_progress:1;
    unsigned int _merge_line_10_entry:1;
    unsigned int _merge_line_10_exit:1;
    unsigned int _merge_line_10_in_progress:1;
    unsigned int _phi_line_11_entry:1;
    unsigned int _phi_line_11_in_progress:1;
    unsigned int _phi_line_11_exit:1;
    uint_10 loop_counter;
    unsigned int _phi_line_12_entry:1;
    unsigned int _phi_line_12_in_progress:1;
    unsigned int _phi_line_12_exit:1;
    uint_10 temp_t;
    unsigned int _merge_line_10_from_entry:1;
    unsigned int _assign_line_14_entry:1;
    unsigned int _assign_line_14_in_progress:1;
    unsigned int _assign_line_14_exit:1;
    uint_10 new_loop_counter;
    unsigned int _assign_line_15_entry:1;
    unsigned int _assign_line_15_in_progress:1;
    unsigned int _assign_line_15_exit:1;
    uint_10 t;
    unsigned int _switch_line_16_entry:1;
    unsigned int _switch_line_16_in_progress:1;
    unsigned int _switch_line_16_exit:1;
    unsigned int loopback:1;
    unsigned int _place_line_16_entry:1;
    unsigned int loopback:1;
    unsigned int _place_line_17_entry:1;
    unsigned int loopback:1;
    unsigned int _place_line_18_entry:1;
    unsigned int _null_line_0_entry:1;
    unsigned int _null_line_0_in_progress:1;
    unsigned int _null_line_0_exit:1;
  } bb1;
  unsigned int _assign_line_21_entry:1;
  unsigned int _assign_line_21_in_progress:1;
  unsigned int _assign_line_21_exit:1;
  unsigned int _assign_line_22_entry:1;
  unsigned int _assign_line_22_in_progress:1;
  unsigned int _assign_line_22_exit:1;
  unsigned sum_mod_entry:1;
  unsigned sum_mod_in_progress:1;
  unsigned sum_mod_exit:1;
} sum_mod_State;
sum_mod_State *sum_mod_ (sum_mod_State *);
int sum_mod (uint_10, uint_10 *, uint_10 *);
