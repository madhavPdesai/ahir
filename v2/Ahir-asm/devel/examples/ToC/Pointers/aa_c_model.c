#include <aa_c_model.h>
uint_32 u;
uint_32 v;
int
increment (uint_32 incr_a, uint_32 * incr_b)
{
  increment_State *__top =
    (increment_State *) calloc (1, sizeof (increment_State));
  __top->increment_entry = 1;
  __top->incr_a = incr_a;
  while (!__top->increment_exit)
    {
      __top = increment_ (__top);
    }
  *incr_b = __top->incr_b;
  cfree (__top);
  return AASUCCESS;
}

increment_State *
increment_ (increment_State * __top)
{
  if (__top->increment_entry)
    {
      __top->increment_entry = 0;
      __top->increment_in_progress = 1;
      __top->increment_entry = 0;
      __top->increment_in_progress = 1;
      __top->_assign_line_12_entry = 1;
    }
  if (__top->increment_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_12
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_12_entry)
	{
	  if (1)
	    {
	      (__top->incr_t1) = ((uint_32 *) (__top->incr_a).__val);	// file Pointers.aa, line 12
	      __top->_assign_line_12_entry = 0;
	      __top->_assign_line_12_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_12
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_12_exit)
	{
	  __top->_assign_line_12_exit = 0;
	  __top->_assign_line_13_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_13
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_13_entry)
	{
	  if (1)
	    {
	      (__top->incr_temp).__val = (*(__top->incr_t1)).__val;	// file Pointers.aa, line 13
	      __top->_assign_line_13_entry = 0;
	      __top->_assign_line_13_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_13
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_13_exit)
	{
	  __top->_assign_line_13_exit = 0;
	  __top->_assign_line_14_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_14
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_14_entry)
	{
	  if (1)
	    {
	      (*(__top->incr_t1)).__val = __PLUS ((__top->incr_temp).__val, 1);	// file Pointers.aa, line 14
	      __top->_assign_line_14_entry = 0;
	      __top->_assign_line_14_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_14
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_14_exit)
	{
	  __top->_assign_line_14_exit = 0;
	  __top->_assign_line_15_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_15
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_15_entry)
	{
	  if (1)
	    {
	      (__top->incr_b).__val = (*(__top->incr_t1)).__val;	// file Pointers.aa, line 15
	      __top->_assign_line_15_entry = 0;
	      __top->_assign_line_15_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_15
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_15_exit)
	{
	  __top->_assign_line_12_exit = 0;
	  __top->_assign_line_13_exit = 0;
	  __top->_assign_line_14_exit = 0;
	  __top->_assign_line_15_exit = 0;
	  __top->increment_in_progress = 0;
	  __top->increment_exit = 1;
	}
    }
  return __top;
}

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
      __top->_assign_line_23_entry = 1;
    }
  if (__top->passpointer_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_23
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_23_entry)
	{
	  if (1)
	    {
	      (u).__val = (__top->a).__val;	// file Pointers.aa, line 23
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
	  __top->_assign_line_24_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_24
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_24_entry)
	{
	  if (1)
	    {
	      (v).__val = (__top->a).__val;	// file Pointers.aa, line 24
	      __top->_assign_line_24_entry = 0;
	      __top->_assign_line_24_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_24
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_24_exit)
	{
	  __top->_assign_line_24_exit = 0;
	  __top->_assign_line_25_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_25
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_25_entry)
	{
	  if (1)
	    {
	      (__top->pu) = (&(u));	// file Pointers.aa, line 25
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
	  __top->_assign_line_26_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_26
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_26_entry)
	{
	  if (1)
	    {
	      (__top->pv) = (&(v));	// file Pointers.aa, line 26
	      __top->_assign_line_26_entry = 0;
	      __top->_assign_line_26_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_26
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_26_exit)
	{
	  __top->_assign_line_26_exit = 0;
	  __top->_assign_line_27_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_27
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_27_entry)
	{
	  if (1)
	    {
	      (__top->t).__val = (*(__top->pu)).__val;	// file Pointers.aa, line 27
	      __top->_assign_line_27_entry = 0;
	      __top->_assign_line_27_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_27
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_27_exit)
	{
	  __top->_assign_line_27_exit = 0;
	  __top->_assign_line_28_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_28
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_28_entry)
	{
	  if (1)
	    {
	      (__top->s).__val = (*(__top->pv)).__val;	// file Pointers.aa, line 28
	      __top->_assign_line_28_entry = 0;
	      __top->_assign_line_28_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_28
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_28_exit)
	{
	  __top->_assign_line_28_exit = 0;
	  __top->_assign_line_29_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_29
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_29_entry)
	{
	  if (1)
	    {
	      (__top->t1).__val = ((__GREATER ((__top->a).__val, 0)) ? ((__top->s).__val) : ((__top->t).__val));	// file Pointers.aa, line 29
	      __top->_assign_line_29_entry = 0;
	      __top->_assign_line_29_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_29
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_29_exit)
	{
	  __top->_assign_line_29_exit = 0;
	  __top->_assign_line_30_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_30
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_30_entry)
	{
	  if (1)
	    {
	      (__top->q).__val = ((uint32_t) (__top->t1).__val);	// file Pointers.aa, line 30
	      __top->_assign_line_30_entry = 0;
	      __top->_assign_line_30_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_30
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_30_exit)
	{
	  __top->_assign_line_30_exit = 0;
	  __top->_call_line_31_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_31
// -------------------------------------------------------------------------------------------
      if (__top->_call_line_31_entry)
	{
	  if (__top->_call_line_31_called_fn_struct == NULL)
	    {
	      __top->_call_line_31_called_fn_struct =
		(increment_State *) calloc (1, sizeof (increment_State));
// reset entry flag and set in progress flag
	      __top->_call_line_31_entry = 0;
	      __top->_call_line_31_in_progress = 1;
	    }			// allocation of pointer to called function
	}			// entry into this call statement
      if (__top->_call_line_31_in_progress)
	{
	  if (!__top->_call_line_31_called_fn_struct->increment_entry
	      && !__top->_call_line_31_called_fn_struct->
	      increment_in_progress)
	    {			// entry and in_progress flags not set?
	      if (1)
		{		// check if pipes can be read from
		  __top->_call_line_31_called_fn_struct->incr_a.__val =
		    (__top->q).__val;
		  __top->_call_line_31_called_fn_struct->increment_entry = 1;
		}		// arguments copied to call structure
	    }			// called function had entry flag set
	  if (__top->_call_line_31_called_fn_struct->increment_entry
	      || __top->_call_line_31_called_fn_struct->increment_in_progress)
	    {			// called function still in progress
// call the function
	      __top->_call_line_31_called_fn_struct = increment_ (__top->_call_line_31_called_fn_struct);	// file Pointers.aa, line 31
	    }			// called function was in progress 
	  if (__top->_call_line_31_called_fn_struct->increment_exit)
	    {
	      if (1)
		{
		  (__top->b).__val =
		    __top->_call_line_31_called_fn_struct->incr_b.__val;
		  cfree (__top->_call_line_31_called_fn_struct);
		  __top->_call_line_31_called_fn_struct = NULL;
// reset in progress flag and set exit flag
		  __top->_call_line_31_exit = 1;
		  __top->_call_line_31_in_progress = 0;
		}		// ok to copy outputs to destinations?
	    }			// called function had finishes?
	}			// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_31
// -------------------------------------------------------------------------------------------
      if (__top->_call_line_31_exit)
	{
	  __top->_assign_line_23_exit = 0;
	  __top->_assign_line_24_exit = 0;
	  __top->_assign_line_25_exit = 0;
	  __top->_assign_line_26_exit = 0;
	  __top->_assign_line_27_exit = 0;
	  __top->_assign_line_28_exit = 0;
	  __top->_assign_line_29_exit = 0;
	  __top->_assign_line_30_exit = 0;
	  __top->_call_line_31_exit = 0;
	  __top->passpointer_in_progress = 0;
	  __top->passpointer_exit = 1;
	}
    }
  return __top;
}
