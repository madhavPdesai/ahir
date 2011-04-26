#include <aa_c_model.h>
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
	  __top->p._assign_line_8_entry = 1;
	  __top->p._assign_line_9_entry = 1;
	}
      if (__top->p.p_in_progress)
	{
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_8
// -------------------------------------------------------------------------------------------
	  if (__top->p._assign_line_8_entry)
	    {
	      if (1)
		{
		  (__top->p.q).__val = __PLUS ((__top->a).__val, (__top->b).__val);	// file ParallelBlock.aa, line 8
		  __top->p._assign_line_8_entry = 0;
		  __top->p._assign_line_8_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_8
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_9
// -------------------------------------------------------------------------------------------
	  if (__top->p._assign_line_9_entry)
	    {
	      if (1)
		{
		  (__top->p.r).__val = __PLUS ((__top->c).__val, (__top->d).__val);	// file ParallelBlock.aa, line 9
		  __top->p._assign_line_9_entry = 0;
		  __top->p._assign_line_9_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_9
// -------------------------------------------------------------------------------------------
	  if ((1 && __top->p._assign_line_9_exit
	       && __top->p._assign_line_8_exit))
	    {
	      __top->p._assign_line_8_exit = 0;
	      __top->p._assign_line_9_exit = 0;
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
	  __top->_assign_line_11_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_11
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_11_entry)
	{
	  if (1)
	    {
	      (__top->result).__val = __PLUS ((__top->p.q).__val, (__top->p.r).__val);	// file ParallelBlock.aa, line 11
	      __top->_assign_line_11_entry = 0;
	      __top->_assign_line_11_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_11
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_11_exit)
	{
	  __top->p.p_exit = 0;
	  __top->_assign_line_11_exit = 0;
	  __top->sum_mod_in_progress = 0;
	  __top->sum_mod_exit = 1;
	}
    }
  return __top;
}
