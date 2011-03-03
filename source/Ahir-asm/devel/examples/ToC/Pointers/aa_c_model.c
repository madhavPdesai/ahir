#include <aa_c_model.h>
uint_32 u[2];
int
passpointer (uint_32 a, uint_32 * b)
{
  passpointer_State *__top =
    (passpointer_State *) calloc (1, sizeof (passpointer_State));
  __top->passpointer_entry = 1;
  __top->a = a;
  while (!__top->passpointer_exit)
    {
      __top = passpointer_ (__top);
    }
  *b = __top->b;
  cfree (__top);
  return AASUCCESS;
}

passpointer_State *
passpointer_ (passpointer_State * __top)
{
  if (__top->passpointer_entry)
    {
      __top->passpointer_entry = 0;
      __top->passpointer_in_progress = 1;
      __top->passpointer_entry = 0;
      __top->passpointer_in_progress = 1;
      __top->_assign_line_19_entry = 1;
    }
  if (__top->passpointer_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_19
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_19_entry)
	{
	  if (1)
	    {
	      (u[0]).__val = (__top->a).__val;	//  file Pointers.aa, line 19
	      __top->_assign_line_19_entry = 0;
	      __top->_assign_line_19_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_19
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_19_exit)
	{
	  __top->_assign_line_19_exit = 0;
	  __top->_assign_line_20_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_20
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_20_entry)
	{
	  if (1)
	    {
	      (u[1]).__val = __MINUS ((__top->a).__val, 1);	//  file Pointers.aa, line 20
	      __top->_assign_line_20_entry = 0;
	      __top->_assign_line_20_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_20
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_20_exit)
	{
	  __top->_assign_line_20_exit = 0;
	  __top->_assign_line_22_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_22
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_22_entry)
	{
	  if (1)
	    {
	      (__top->p) = (&(u[0]));	//  file Pointers.aa, line 22
	      __top->_assign_line_22_entry = 0;
	      __top->_assign_line_22_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_22
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_22_exit)
	{
	  __top->_assign_line_22_exit = 0;
	  __top->_assign_line_23_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_23
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_23_entry)
	{
	  if (1)
	    {
	      (__top->q) = __PLUS ((__top->p), 1);	//  file Pointers.aa, line 23
	      __top->_assign_line_23_entry = 0;
	      __top->_assign_line_23_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_23
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_23_exit)
	{
	  __top->_assign_line_23_exit = 0;
	  __top->_assign_line_25_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_25
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_25_entry)
	{
	  if (1)
	    {
	      (__top->r) = ((__GREATER ((__top->a).__val, 5)) ? ((__top->p)) : ((__top->q)));	//  file Pointers.aa, line 25
	      __top->_assign_line_25_entry = 0;
	      __top->_assign_line_25_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_25
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_25_exit)
	{
	  __top->_assign_line_25_exit = 0;
	  __top->_assign_line_28_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_28
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_28_entry)
	{
	  if (1)
	    {
	      (__top->b).__val = (*(__top->r)).__val;	//  file Pointers.aa, line 28
	      __top->_assign_line_28_entry = 0;
	      __top->_assign_line_28_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_28
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_28_exit)
	{
	  __top->_assign_line_19_exit = 0;
	  __top->_assign_line_20_exit = 0;
	  __top->_assign_line_22_exit = 0;
	  __top->_assign_line_23_exit = 0;
	  __top->_assign_line_25_exit = 0;
	  __top->_assign_line_28_exit = 0;
	  __top->passpointer_in_progress = 0;
	  __top->passpointer_exit = 1;
	}
    }
  return __top;
}
