#include <Aa2C.h>
typedef struct add_State__
{
  uint_10 a;
  uint_10 b;
  uint_10 result;
  unsigned int _assign_line_22_entry:1;
  unsigned int _assign_line_22_in_progress:1;
  unsigned int _assign_line_22_exit:1;
  unsigned add_entry:1;
  unsigned add_in_progress:1;
  unsigned add_exit:1;
} add_State;
add_State *add_ (add_State *);
int add (uint_10, uint_10, uint_10 *);
typedef struct sum_mod_State__
{
  uint_10 a;
  uint_10 b;
  uint_10 c;
  uint_10 d;
  uint_10 result;
  uint_10 ex1;
  unsigned int ex1_valid__:1;
  uint_10 ex2;
  unsigned int ex2_valid__:1;
  struct _p__
  {
    unsigned int p_entry:1;
    unsigned int p_exit:1;
    unsigned int p_in_progress:1;
    unsigned int _call_line_10_entry:1;
    unsigned int _call_line_10_in_progress:1;
    unsigned int _call_line_10_exit:1;
    add_State *_call_line_10_called_fn_struct;
    unsigned int _call_line_11_entry:1;
    unsigned int _call_line_11_in_progress:1;
    unsigned int _call_line_11_exit:1;
    add_State *_call_line_11_called_fn_struct;
    unsigned int _call_line_12_entry:1;
    unsigned int _call_line_12_in_progress:1;
    unsigned int _call_line_12_exit:1;
    uint_10 r;
    add_State *_call_line_12_called_fn_struct;
  } p;
  unsigned int _assign_line_14_entry:1;
  unsigned int _assign_line_14_in_progress:1;
  unsigned int _assign_line_14_exit:1;
  unsigned sum_mod_entry:1;
  unsigned sum_mod_in_progress:1;
  unsigned sum_mod_exit:1;
} sum_mod_State;
sum_mod_State *sum_mod_ (sum_mod_State *);
int sum_mod (uint_10, uint_10, uint_10, uint_10, uint_10 *);
