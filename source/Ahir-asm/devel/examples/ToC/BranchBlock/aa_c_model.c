#include <aa_c_model.h>
int
sum_mod (uint_10 a, uint_10 b, uint_10 * c)
{
  sum_mod_State *__top = (sum_mod_State *) calloc (1, sizeof (sum_mod_State));
  __top->sum_mod_entry = 1;
  __top->a = a;
  __top->b = b;
  while (!__top->sum_mod_exit)
    {
      __top = sum_mod_ (__top);
    }
  *c = __top->c;
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
      __top->_assign_line_8_entry = 1;
    }
  if (__top->sum_mod_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_8
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_8_entry)
	{
	  if (1)
	    {
	      (__top->I).__val = (__top->b).__val;	// file BranchBlock.aa, line 8
	      __top->_assign_line_8_entry = 0;
	      __top->_assign_line_8_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_8
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_8_exit)
	{
	  __top->_assign_line_8_exit = 0;
	  __top->bb.bb_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Block bb
// -------------------------------------------------------------------------------------------
      if (__top->bb.bb_entry)
	{
	  __top->bb.bb_entry = 0;
	  __top->bb.bb_in_progress = 1;
	  __top->bb._merge_line_10_entry = 1;
	}
      if (__top->bb.bb_in_progress)
	{
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_10
// -------------------------------------------------------------------------------------------
	  if (__top->bb._merge_line_10_entry || __top->bb.loopback)
	    {
	      if (__top->bb._merge_line_10_entry)
		{
		  __top->bb._merge_line_10_entry = 0;
		  __top->bb._merge_line_10_from_entry = 1;
		}
	      __top->bb._merge_line_10_in_progress = 1;
	      __top->bb._phi_line_11_entry = 1;
	    }
	  if (__top->bb._merge_line_10_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _phi_line_11
// -------------------------------------------------------------------------------------------
	      if (__top->bb._phi_line_11_entry)
		{
		  if (1)
		    {
		      if (__top->bb._merge_line_10_from_entry)
			(__top->bb.s1).__val = 0;
		      if (__top->bb.loopback)
			(__top->bb.s1).__val = (__top->bb.s).__val;
		      __top->bb._phi_line_11_entry = 0;
		      __top->bb._phi_line_11_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _phi_line_11
// -------------------------------------------------------------------------------------------
	      if (__top->bb._phi_line_11_exit)
		{
		  __top->bb._phi_line_11_exit = 0;
		  // clear the place flag 
		  __top->bb.loopback = 0;
		  __top->bb._merge_line_10_from_entry = 0;
		  __top->bb._merge_line_10_in_progress = 0;
		  __top->bb._merge_line_10_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block _merge_line_10
// -------------------------------------------------------------------------------------------
	  if (__top->bb._merge_line_10_exit)
	    {
	      __top->bb._merge_line_10_exit = 0;
	      __top->bb._assign_line_13_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_13
// -------------------------------------------------------------------------------------------
	  if (__top->bb._assign_line_13_entry)
	    {
	      if (1)
		{
		  (__top->bb.s).__val = __PLUS ((__top->bb.s1).__val, (__top->a).__val);	// file BranchBlock.aa, line 13
		  __top->bb._assign_line_13_entry = 0;
		  __top->bb._assign_line_13_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_13
// -------------------------------------------------------------------------------------------
	  if (__top->bb._assign_line_13_exit)
	    {
	      __top->bb._assign_line_13_exit = 0;
	      __top->bb._assign_line_14_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_14
// -------------------------------------------------------------------------------------------
	  if (__top->bb._assign_line_14_entry)
	    {
	      if (1)
		{
		  (__top->I).__val = __MINUS ((__top->I).__val, 1);	// file BranchBlock.aa, line 14
		  __top->bb._assign_line_14_entry = 0;
		  __top->bb._assign_line_14_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_14
// -------------------------------------------------------------------------------------------
	  if (__top->bb._assign_line_14_exit)
	    {
	      __top->bb._assign_line_14_exit = 0;
	      __top->bb._switch_line_15_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _switch_line_15
// -------------------------------------------------------------------------------------------
	  if (__top->bb._switch_line_15_entry)
	    {
	      if (1)
		{
		  switch (__GREATER ((__top->I).__val, 0))
		    {
		    case 1:
		      __top->bb._switch_line_15_entry = 0;
		      __top->bb._switch_line_15_in_progress = 1;
		      __top->bb._place_line_15_entry = 1;
		      break;
		    default:
		      __top->bb._switch_line_15_entry = 0;
		      __top->bb._switch_line_15_in_progress = 1;
		      __top->bb._null_line_0_entry = 1;
		      break;
		    }		// transfer control based on test condition
		}		// proceed if pipe is available 
	    }			// entry flag
	  if (__top->bb._switch_line_15_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_15
// -------------------------------------------------------------------------------------------
	      if (__top->bb._place_line_15_entry)
		{
		  __top->bb.loopback = 1;
		  __top->bb._place_line_15_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_15
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->bb._switch_line_15_in_progress = 0;
		  __top->bb._switch_line_15_exit = 1;
		}
	    }
	  if (__top->bb._switch_line_15_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _null_line_0
// -------------------------------------------------------------------------------------------
	      if (__top->bb._null_line_0_entry)
		{
		  if (1)
		    {
		      ;
		      __top->bb._null_line_0_entry = 0;
		      __top->bb._null_line_0_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _null_line_0
// -------------------------------------------------------------------------------------------
	      if (__top->bb._null_line_0_exit)
		{
		  __top->bb._null_line_0_exit = 0;
		  __top->bb._switch_line_15_in_progress = 0;
		  __top->bb._switch_line_15_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _switch_line_15
// -------------------------------------------------------------------------------------------
	  if (__top->bb._switch_line_15_exit)
	    {
	      __top->bb._merge_line_10_exit = 0;
	      __top->bb._assign_line_13_exit = 0;
	      __top->bb._assign_line_14_exit = 0;
	      __top->bb._switch_line_15_exit = 0;
	      __top->bb.bb_in_progress = 0;
	      __top->bb.bb_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Block bb
// -------------------------------------------------------------------------------------------
      if (__top->bb.bb_exit)
	{
	  __top->bb.bb_exit = 0;
	  __top->_assign_line_17_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_17
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_17_entry)
	{
	  if (1)
	    {
	      (__top->c).__val = (__top->bb.s).__val;	// file BranchBlock.aa, line 17
	      __top->_assign_line_17_entry = 0;
	      __top->_assign_line_17_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_17
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_17_exit)
	{
	  __top->_assign_line_8_exit = 0;
	  __top->bb.bb_exit = 0;
	  __top->_assign_line_17_exit = 0;
	  __top->sum_mod_in_progress = 0;
	  __top->sum_mod_exit = 1;
	}
    }
  return __top;
}
