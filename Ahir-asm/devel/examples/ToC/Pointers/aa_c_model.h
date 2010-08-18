#include <Aa2C.h>
typedef struct Increment_State__
{
  pointer a;
  pointer b;
  unsigned Increment_entry:1;
  unsigned Increment_in_progress:1;
  unsigned Increment_exit:1;
} Increment_State;
int Increment (pointer, pointer *);
typedef struct passpointer_State__
{
  pointer a;
  pointer b;
  unsigned int _call_line_11_entry:1;
  unsigned int _call_line_11_in_progress:1;
  unsigned int _call_line_11_exit:1;
  Increment_State *_call_line_11_called_fn_struct;
  unsigned passpointer_entry:1;
  unsigned passpointer_in_progress:1;
  unsigned passpointer_exit:1;
} passpointer_State;
passpointer_State *passpointer_ (passpointer_State *);
int passpointer (pointer, pointer *);
