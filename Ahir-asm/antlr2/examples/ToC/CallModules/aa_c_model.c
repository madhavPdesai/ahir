#include <aa_c_model.h>
int
add (uint_10 a, uint_10 b, uint_10 * result)
{
  add_State *__top = (add_State *) calloc (1, sizeof (add_State));
  __top->add_entry = 1;
  __top->a = a;
  __top->b = b;
  while (!__top->add_exit)
    {
      __top = add_ (__top);
    }
  *result = __top->result;
  cfree (__top);
  return AASUCCESS;
}

add_State *
add_ (add_State * __top)
{
  if (__top->add_entry)
    {
      __top->add_entry = 0;
      __top->add_in_progress = 1;
      __top->add_entry = 0;
      __top->add_in_progress = 1;
      __top->_assign_line_22_entry = 1;
    }
  if (__top->add_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_22
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_22_entry)
	{
	  if (1)
	    {
	      (__top->result).__val = __PLUS ((__top->a).__val, (__top->b).__val);	//  file CallModules.aa, line 22
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
	  __top->add_in_progress = 0;
	  __top->add_exit = 1;
	}
    }
  return __top;
}

int
sum_mod (uint_10 a, uint_10 b, uint_10 c, uint_10 d, uint_10 * result)
{
  sum_mod_State *__top = (sum_mod_State *) calloc (1, sizeof (sum_mod_State));
  __top->sum_mod_entry = 1;
  __top->a = a;
  __top->b = b;
  __top->c = c;
  __top->d = d;
  while (!__top->sum_mod_exit)
    {
      __top = sum_mod_ (__top);
    }
  *result = __top->result;
  cfree (__top);
  return AASUCCESS;
}

sum_mod_State *
sum_mod_ (sum_mod_State * __top)
{
  if (__top->sum_mod_entry)
    {
      __top->sum_mod_entry = 0;
      __top->sum_mod_in_progress = 1;
      __top->sum_mod_entry = 0;
      __top->sum_mod_in_progress = 1;
      __top->p.p_entry = 1;
    }
  if (__top->sum_mod_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Block p
// -------------------------------------------------------------------------------------------
      if (__top->p.p_entry)
	{
	  __top->p.p_entry = 0;
	  __top->p.p_in_progress = 1;
	  __top->p._call_line_10_entry = 1;
	  __top->p._call_line_11_entry = 1;
	  __top->p._call_line_12_entry = 1;
	}
      if (__top->p.p_in_progress)
	{
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_10
// -------------------------------------------------------------------------------------------
	  if (__top->p._call_line_10_entry)
	    {
	      if (__top->p._call_line_10_called_fn_struct == NULL)
		{
		  __top->p._call_line_10_called_fn_struct =
		    (add_State *) calloc (1, sizeof (add_State));
// reset entry flag and set in progress flag
		  __top->p._call_line_10_entry = 0;
		  __top->p._call_line_10_in_progress = 1;
		}		// allocation of pointer to called function
	    }			// entry into this call statement
	  if (__top->p._call_line_10_in_progress)
	    {
	      if (!__top->p._call_line_10_called_fn_struct->add_entry
		  && !__top->p._call_line_10_called_fn_struct->
		  add_in_progress)
		{		// entry and in_progress flags not set?
		  if (1)
		    {		// check if pipes can be read from
		      __top->p._call_line_10_called_fn_struct->a.__val =
			(__top->c).__val;
		      __top->p._call_line_10_called_fn_struct->b.__val =
			(__top->d).__val;
		      __top->p._call_line_10_called_fn_struct->add_entry = 1;
		    }		// arguments copied to call structure
		}		// called function had entry flag set
	      if (__top->p._call_line_10_called_fn_struct->add_entry
		  || __top->p._call_line_10_called_fn_struct->add_in_progress)
		{		// called function still in progress
// call the function
		  __top->p._call_line_10_called_fn_struct = add_ (__top->p._call_line_10_called_fn_struct);	//  file CallModules.aa, line 10
		}		// called function was in progress 
	      if (__top->p._call_line_10_called_fn_struct->add_exit)
		{
		  if (1 && !__top->ex1_valid__)
		    {
		      (__top->ex1).__val =
			__top->p._call_line_10_called_fn_struct->result.__val;
		      __top->ex1_valid__ = 1;
		      cfree (__top->p._call_line_10_called_fn_struct);
		      __top->p._call_line_10_called_fn_struct = NULL;
// reset in progress flag and set exit flag
		      __top->p._call_line_10_exit = 1;
		      __top->p._call_line_10_in_progress = 0;
		    }		// ok to copy outputs to destinations?
		}		// called function had finishes?
	    }			// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_10
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_11
// -------------------------------------------------------------------------------------------
	  if (__top->p._call_line_11_entry)
	    {
	      if (__top->p._call_line_11_called_fn_struct == NULL)
		{
		  __top->p._call_line_11_called_fn_struct =
		    (add_State *) calloc (1, sizeof (add_State));
// reset entry flag and set in progress flag
		  __top->p._call_line_11_entry = 0;
		  __top->p._call_line_11_in_progress = 1;
		}		// allocation of pointer to called function
	    }			// entry into this call statement
	  if (__top->p._call_line_11_in_progress)
	    {
	      if (!__top->p._call_line_11_called_fn_struct->add_entry
		  && !__top->p._call_line_11_called_fn_struct->
		  add_in_progress)
		{		// entry and in_progress flags not set?
		  if (1 && __top->ex1_valid__)
		    {		// check if pipes can be read from
		      __top->p._call_line_11_called_fn_struct->a.__val =
			(__top->a).__val;
		      __top->p._call_line_11_called_fn_struct->b.__val =
			(__top->ex1).__val;
		      __top->ex1_valid__ = 0;
		      __top->p._call_line_11_called_fn_struct->add_entry = 1;
		    }		// arguments copied to call structure
		}		// called function had entry flag set
	      if (__top->p._call_line_11_called_fn_struct->add_entry
		  || __top->p._call_line_11_called_fn_struct->add_in_progress)
		{		// called function still in progress
// call the function
		  __top->p._call_line_11_called_fn_struct = add_ (__top->p._call_line_11_called_fn_struct);	//  file CallModules.aa, line 11
		}		// called function was in progress 
	      if (__top->p._call_line_11_called_fn_struct->add_exit)
		{
		  if (1 && !__top->ex2_valid__)
		    {
		      (__top->ex2).__val =
			__top->p._call_line_11_called_fn_struct->result.__val;
		      __top->ex2_valid__ = 1;
		      cfree (__top->p._call_line_11_called_fn_struct);
		      __top->p._call_line_11_called_fn_struct = NULL;
// reset in progress flag and set exit flag
		      __top->p._call_line_11_exit = 1;
		      __top->p._call_line_11_in_progress = 0;
		    }		// ok to copy outputs to destinations?
		}		// called function had finishes?
	    }			// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_11
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_12
// -------------------------------------------------------------------------------------------
	  if (__top->p._call_line_12_entry)
	    {
	      if (__top->p._call_line_12_called_fn_struct == NULL)
		{
		  __top->p._call_line_12_called_fn_struct =
		    (add_State *) calloc (1, sizeof (add_State));
// reset entry flag and set in progress flag
		  __top->p._call_line_12_entry = 0;
		  __top->p._call_line_12_in_progress = 1;
		}		// allocation of pointer to called function
	    }			// entry into this call statement
	  if (__top->p._call_line_12_in_progress)
	    {
	      if (!__top->p._call_line_12_called_fn_struct->add_entry
		  && !__top->p._call_line_12_called_fn_struct->
		  add_in_progress)
		{		// entry and in_progress flags not set?
		  if (1 && __top->ex2_valid__)
		    {		// check if pipes can be read from
		      __top->p._call_line_12_called_fn_struct->a.__val =
			(__top->ex2).__val;
		      __top->p._call_line_12_called_fn_struct->b.__val =
			(__top->b).__val;
		      __top->ex2_valid__ = 0;
		      __top->p._call_line_12_called_fn_struct->add_entry = 1;
		    }		// arguments copied to call structure
		}		// called function had entry flag set
	      if (__top->p._call_line_12_called_fn_struct->add_entry
		  || __top->p._call_line_12_called_fn_struct->add_in_progress)
		{		// called function still in progress
// call the function
		  __top->p._call_line_12_called_fn_struct = add_ (__top->p._call_line_12_called_fn_struct);	//  file CallModules.aa, line 12
		}		// called function was in progress 
	      if (__top->p._call_line_12_called_fn_struct->add_exit)
		{
		  if (1)
		    {
		      (__top->p.r).__val =
			__top->p._call_line_12_called_fn_struct->result.__val;
		      cfree (__top->p._call_line_12_called_fn_struct);
		      __top->p._call_line_12_called_fn_struct = NULL;
// reset in progress flag and set exit flag
		      __top->p._call_line_12_exit = 1;
		      __top->p._call_line_12_in_progress = 0;
		    }		// ok to copy outputs to destinations?
		}		// called function had finishes?
	    }			// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_12
// -------------------------------------------------------------------------------------------
	  if ((1 && __top->p._call_line_12_exit && __top->p._call_line_11_exit
	       && __top->p._call_line_10_exit))
	    {
	      __top->p._call_line_10_exit = 0;
	      __top->p._call_line_11_exit = 0;
	      __top->p._call_line_12_exit = 0;
	      __top->p.p_in_progress = 0;
	      __top->p.p_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Block p
// -------------------------------------------------------------------------------------------
      if (__top->p.p_exit)
	{
	  __top->p.p_exit = 0;
	  __top->_assign_line_14_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_14
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_14_entry)
	{
	  if (1)
	    {
	      (__top->result).__val = (__top->p.r).__val;	//  file CallModules.aa, line 14
	      __top->_assign_line_14_entry = 0;
	      __top->_assign_line_14_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_14
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_14_exit)
	{
	  __top->p.p_exit = 0;
	  __top->_assign_line_14_exit = 0;
	  __top->sum_mod_in_progress = 0;
	  __top->sum_mod_exit = 1;
	}
    }
  return __top;
}
