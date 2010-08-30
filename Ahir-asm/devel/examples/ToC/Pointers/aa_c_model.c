#include <aa_c_model.h>
int
passpointer (pointer a, pointer * b)
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
      __top->_call_line_11_entry = 1;
    }
  if (__top->passpointer_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_11
// -------------------------------------------------------------------------------------------
      if (__top->_call_line_11_entry)
	{
	  if (__top->_call_line_11_called_fn_struct == NULL)
	    {
	      __top->_call_line_11_called_fn_struct =
		(Increment_State *) calloc (1, sizeof (Increment_State));
// reset entry flag and set in progress flag
	      __top->_call_line_11_entry = 0;
	      __top->_call_line_11_in_progress = 1;
	    }			// allocation of pointer to called function
	}			// entry into this call statement
      if (__top->_call_line_11_in_progress)
	{
	  if (!__top->_call_line_11_called_fn_struct->Increment_entry
	      && !__top->_call_line_11_called_fn_struct->
	      Increment_in_progress)
	    {			// entry and in_progress flags not set?
	      if (1)
		{		// check if pipes can be read from
		  __top->_call_line_11_called_fn_struct->a.__val =
		    (__top->a).__val;
		  __top->_call_line_11_called_fn_struct->Increment_entry = 1;
		}		// arguments copied to call structure
	    }			// called function had entry flag set
	  if (__top->_call_line_11_called_fn_struct->Increment_entry
	      || __top->_call_line_11_called_fn_struct->Increment_in_progress)
	    {			// called function still in progress
// call the function
	      Increment (__top->_call_line_11_called_fn_struct->a, &(__top->_call_line_11_called_fn_struct->b));	//   file Pointers.aa, line 11
	      __top->_call_line_11_called_fn_struct->Increment_entry = 0;
	      __top->_call_line_11_called_fn_struct->Increment_in_progress =
		0;
	      __top->_call_line_11_called_fn_struct->Increment_exit = 1;
	    }			// called function was in progress 
	  if (__top->_call_line_11_called_fn_struct->Increment_exit)
	    {
	      if (1)
		{
		  (__top->b).__val =
		    __top->_call_line_11_called_fn_struct->b.__val;
		  cfree (__top->_call_line_11_called_fn_struct);
		  __top->_call_line_11_called_fn_struct = NULL;
// reset in progress flag and set exit flag
		  __top->_call_line_11_exit = 1;
		  __top->_call_line_11_in_progress = 0;
		}		// ok to copy outputs to destinations?
	    }			// called function had finishes?
	}			// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_11
// -------------------------------------------------------------------------------------------
      if (__top->_call_line_11_exit)
	{
	  __top->_call_line_11_exit = 0;
	  __top->passpointer_in_progress = 0;
	  __top->passpointer_exit = 1;
	}
    }
  return __top;
}
