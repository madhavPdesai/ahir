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
	  __top->p.s1.s1_entry = 1;
	  __top->p.s2.s2_entry = 1;
	  __top->p._join_line_11_entry = 1;
	}
      if (__top->p.p_in_progress)
	{
// -------------------------------------------------------------------------------------------
// Begin Block s1
// -------------------------------------------------------------------------------------------
	  if (__top->p.s1.s1_entry)
	    {
	      __top->p.s1.s1_entry = 0;
	      __top->p.s1.s1_in_progress = 1;
	      __top->p.s1._assign_line_8_entry = 1;
	    }
	  if (__top->p.s1.s1_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_8
// -------------------------------------------------------------------------------------------
	      if (__top->p.s1._assign_line_8_entry)
		{
		  if (1)
		    {
		      (__top->p.s1.q).__val = __PLUS ((__top->a).__val, (__top->b).__val);	//  file ForkBlock.aa, line 8
		      __top->p.s1._assign_line_8_entry = 0;
		      __top->p.s1._assign_line_8_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_8
// -------------------------------------------------------------------------------------------
	      if (__top->p.s1._assign_line_8_exit)
		{
		  __top->p.s1._assign_line_8_exit = 0;
		  __top->p.s1.s1_in_progress = 0;
		  __top->p.s1.s1_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block s1
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Block s2
// -------------------------------------------------------------------------------------------
	  if (__top->p.s2.s2_entry)
	    {
	      __top->p.s2.s2_entry = 0;
	      __top->p.s2.s2_in_progress = 1;
	      __top->p.s2._assign_line_9_entry = 1;
	    }
	  if (__top->p.s2.s2_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_9
// -------------------------------------------------------------------------------------------
	      if (__top->p.s2._assign_line_9_entry)
		{
		  if (1)
		    {
		      (__top->p.s2.r).__val = __PLUS ((__top->c).__val, (__top->d).__val);	//  file ForkBlock.aa, line 9
		      __top->p.s2._assign_line_9_entry = 0;
		      __top->p.s2._assign_line_9_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_9
// -------------------------------------------------------------------------------------------
	      if (__top->p.s2._assign_line_9_exit)
		{
		  __top->p.s2._assign_line_9_exit = 0;
		  __top->p.s2.s2_in_progress = 0;
		  __top->p.s2.s2_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block s2
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Block _join_line_11
// -------------------------------------------------------------------------------------------
	  if (__top->p._join_line_11_entry)
	    {
	      if (1 && __top->p.s1.s1_exit && __top->p.s2.s2_exit)
		{
		  __top->p._join_line_11_entry = 0;
		  __top->p._join_line_11_in_progress = 1;
		  __top->p._assign_line_12_entry = 1;
		  __top->p._assign_line_13_entry = 1;
		}
	    }
	  if (__top->p._join_line_11_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_12
// -------------------------------------------------------------------------------------------
	      if (__top->p._assign_line_12_entry)
		{
		  if (1)
		    {
		      (__top->p.s).__val = __MINUS ((__top->p.s1.q).__val, (__top->p.s2.r).__val);	//  file ForkBlock.aa, line 12
		      __top->p._assign_line_12_entry = 0;
		      __top->p._assign_line_12_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_12
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_13
// -------------------------------------------------------------------------------------------
	      if (__top->p._assign_line_13_entry)
		{
		  if (1)
		    {
		      (__top->p.t).__val = __PLUS ((__top->p.s1.q).__val, (__top->p.s2.r).__val);	//  file ForkBlock.aa, line 13
		      __top->p._assign_line_13_entry = 0;
		      __top->p._assign_line_13_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_13
// -------------------------------------------------------------------------------------------
	      if ((1 && __top->p._assign_line_13_exit
		   && __top->p._assign_line_12_exit))
		{
		  __top->p._assign_line_12_exit = 0;
		  __top->p._assign_line_13_exit = 0;
		  __top->p._join_line_11_in_progress = 0;
		  __top->p._join_line_11_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block _join_line_11
// -------------------------------------------------------------------------------------------
	  if ((1 && __top->p._join_line_11_exit && __top->p.s2.s2_exit
	       && __top->p.s1.s1_exit))
	    {
	      __top->p.s1.s1_exit = 0;
	      __top->p.s2.s2_exit = 0;
	      __top->p._join_line_11_exit = 0;
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
	  __top->_assign_line_16_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_16
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_16_entry)
	{
	  if (1)
	    {
	      (__top->result).__val = __PLUS ((__top->p.s).__val, (__top->p.t).__val);	//  file ForkBlock.aa, line 16
	      __top->_assign_line_16_entry = 0;
	      __top->_assign_line_16_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_16
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_16_exit)
	{
	  __top->p.p_exit = 0;
	  __top->_assign_line_16_exit = 0;
	  __top->sum_mod_in_progress = 0;
	  __top->sum_mod_exit = 1;
	}
    }
  return __top;
}
