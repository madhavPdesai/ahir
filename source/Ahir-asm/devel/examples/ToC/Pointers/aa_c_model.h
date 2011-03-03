#include <Aa2C.h>
typedef struct passpointer_State__
{
  uint_32 a;
  uint_32 b;
  unsigned int _assign_line_19_entry:1;
  unsigned int _assign_line_19_in_progress:1;
  unsigned int _assign_line_19_exit:1;
  unsigned int _assign_line_20_entry:1;
  unsigned int _assign_line_20_in_progress:1;
  unsigned int _assign_line_20_exit:1;
  unsigned int _assign_line_22_entry:1;
  unsigned int _assign_line_22_in_progress:1;
  unsigned int _assign_line_22_exit:1;
  uint_32 *p;
  unsigned int _assign_line_23_entry:1;
  unsigned int _assign_line_23_in_progress:1;
  unsigned int _assign_line_23_exit:1;
  uint_32 *q;
  unsigned int _assign_line_25_entry:1;
  unsigned int _assign_line_25_in_progress:1;
  unsigned int _assign_line_25_exit:1;
  uint_32 *r;
  unsigned int _assign_line_28_entry:1;
  unsigned int _assign_line_28_in_progress:1;
  unsigned int _assign_line_28_exit:1;
  unsigned passpointer_entry:1;
  unsigned passpointer_in_progress:1;
  unsigned passpointer_exit:1;
} passpointer_State;
passpointer_State *passpointer_ (passpointer_State *);
int passpointer (uint_32, uint_32 *);
