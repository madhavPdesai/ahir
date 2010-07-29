#include <Aa2C.h>
typedef struct sum_mod_State__
{
  uint_10 a;
  uint_10 b;
  uint_10 c;
  uint_10 d;
  uint_10 result;
  struct _p__
  {
    unsigned int p_entry:1;
    unsigned int p_exit:1;
    unsigned int p_in_progress:1;
    struct _s1__
    {
      unsigned int s1_entry:1;
      unsigned int s1_exit:1;
      unsigned int s1_in_progress:1;
      unsigned int _assign_line_8_entry:1;
      unsigned int _assign_line_8_in_progress:1;
      unsigned int _assign_line_8_exit:1;
      uint_10 q;
    } s1;
    struct _s2__
    {
      unsigned int s2_entry:1;
      unsigned int s2_exit:1;
      unsigned int s2_in_progress:1;
      unsigned int _assign_line_9_entry:1;
      unsigned int _assign_line_9_in_progress:1;
      unsigned int _assign_line_9_exit:1;
      uint_10 r;
    } s2;
    unsigned int _join_line_11_entry:1;
    unsigned int _join_line_11_exit:1;
    unsigned int _join_line_11_in_progress:1;
    unsigned int _assign_line_12_entry:1;
    unsigned int _assign_line_12_in_progress:1;
    unsigned int _assign_line_12_exit:1;
    uint_10 s;
    unsigned int _assign_line_13_entry:1;
    unsigned int _assign_line_13_in_progress:1;
    unsigned int _assign_line_13_exit:1;
    uint_10 t;
  } p;
  unsigned int _assign_line_16_entry:1;
  unsigned int _assign_line_16_in_progress:1;
  unsigned int _assign_line_16_exit:1;
  unsigned sum_mod_entry:1;
  unsigned sum_mod_in_progress:1;
  unsigned sum_mod_exit:1;
} sum_mod_State;
sum_mod_State *sum_mod_ (sum_mod_State *);
int sum_mod (uint_10, uint_10, uint_10, uint_10, uint_10 *);
