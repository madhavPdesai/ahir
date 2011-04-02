#include <aa_c_model.h>
int
sum_mod (uint_10 a, uint_10 * b, uint_10 * c)
{
  sum_mod_State *__top = (sum_mod_State *) calloc (1, sizeof (sum_mod_State));
  __top->sum_mod_entry = 1;
  __top->a = a;
  while (!__top->sum_mod_exit)
    {
      __top = sum_mod_ (__top);
    }
  *b = __top->b;
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
      __top->bb1.bb1_entry = 1;
    }
  if (__top->sum_mod_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Block bb1
// -------------------------------------------------------------------------------------------
      if (__top->bb1.bb1_entry)
	{
	  __top->bb1.bb1_entry = 0;
	  __top->bb1.bb1_in_progress = 1;
	  __top->bb1._merge_line_10_entry = 1;
	}
      if (__top->bb1.bb1_in_progress)
	{
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_10
// -------------------------------------------------------------------------------------------
	  if (__top->bb1._merge_line_10_entry || __top->bb1.loopback)
	    {
	      if (__top->bb1._merge_line_10_entry)
		{
		  __top->bb1._merge_line_10_entry = 0;
		  __top->bb1._merge_line_10_from_entry = 1;
		}
	      __top->bb1._merge_line_10_in_progress = 1;
	      __top->bb1._phi_line_11_entry = 1;
	    }
	  if (__top->bb1._merge_line_10_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _phi_line_11
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._phi_line_11_entry)
		{
		  if (1)
		    {
		      if (__top->bb1._merge_line_10_from_entry)
			(__top->bb1.loop_counter).__val = (__top->a).__val;
		      if (__top->bb1.loopback)
			(__top->bb1.loop_counter).__val =
			  (__top->bb1.new_loop_counter).__val;
		      __top->bb1._phi_line_11_entry = 0;
		      __top->bb1._phi_line_11_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _phi_line_11
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._phi_line_11_exit)
		{
		  __top->bb1._phi_line_11_exit = 0;
		  __top->bb1._phi_line_12_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _phi_line_12
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._phi_line_12_entry)
		{
		  if (1)
		    {
		      if (__top->bb1._merge_line_10_from_entry)
			(__top->bb1.temp_t).__val = 0;
		      if (__top->bb1.loopback)
			(__top->bb1.temp_t).__val = (__top->bb1.t).__val;
		      __top->bb1._phi_line_12_entry = 0;
		      __top->bb1._phi_line_12_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _phi_line_12
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._phi_line_12_exit)
		{
		  __top->bb1._phi_line_11_exit = 0;
		  __top->bb1._phi_line_12_exit = 0;
		  // clear the place flag 
		  __top->bb1.loopback = 0;
		  __top->bb1._merge_line_10_from_entry = 0;
		  __top->bb1._merge_line_10_in_progress = 0;
		  __top->bb1._merge_line_10_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block _merge_line_10
// -------------------------------------------------------------------------------------------
	  if (__top->bb1._merge_line_10_exit)
	    {
	      __top->bb1._merge_line_10_exit = 0;
	      __top->bb1._assign_line_14_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_14
// -------------------------------------------------------------------------------------------
	  if (__top->bb1._assign_line_14_entry)
	    {
	      if (1)
		{
		  (__top->bb1.new_loop_counter).__val = __MINUS ((__top->bb1.loop_counter).__val, 1);	// file BranchBlock.aa, line 14
		  __top->bb1._assign_line_14_entry = 0;
		  __top->bb1._assign_line_14_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_14
// -------------------------------------------------------------------------------------------
	  if (__top->bb1._assign_line_14_exit)
	    {
	      __top->bb1._assign_line_14_exit = 0;
	      __top->bb1._assign_line_15_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_15
// -------------------------------------------------------------------------------------------
	  if (__top->bb1._assign_line_15_entry)
	    {
	      if (1)
		{
		  (__top->bb1.t).__val = __PLUS ((__top->bb1.temp_t).__val, 1);	// file BranchBlock.aa, line 15
		  __top->bb1._assign_line_15_entry = 0;
		  __top->bb1._assign_line_15_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_15
// -------------------------------------------------------------------------------------------
	  if (__top->bb1._assign_line_15_exit)
	    {
	      __top->bb1._assign_line_15_exit = 0;
	      __top->bb1._switch_line_16_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _switch_line_16
// -------------------------------------------------------------------------------------------
	  if (__top->bb1._switch_line_16_entry)
	    {
	      if (1)
		{
		  switch ((__top->bb1.new_loop_counter).__val)
		    {
		    case 1:
		      __top->bb1._switch_line_16_entry = 0;
		      __top->bb1._switch_line_16_in_progress = 1;
		      __top->bb1._place_line_16_entry = 1;
		      break;
		    case 2:
		      __top->bb1._switch_line_16_entry = 0;
		      __top->bb1._switch_line_16_in_progress = 1;
		      __top->bb1._place_line_17_entry = 1;
		      break;
		    case 3:
		      __top->bb1._switch_line_16_entry = 0;
		      __top->bb1._switch_line_16_in_progress = 1;
		      __top->bb1._place_line_18_entry = 1;
		      break;
		    default:
		      __top->bb1._switch_line_16_entry = 0;
		      __top->bb1._switch_line_16_in_progress = 1;
		      __top->bb1._null_line_0_entry = 1;
		      break;
		    }		// transfer control based on test condition
		}		// proceed if pipe is available 
	    }			// entry flag
	  if (__top->bb1._switch_line_16_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_16
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._place_line_16_entry)
		{
		  __top->bb1.loopback = 1;
		  __top->bb1._place_line_16_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_16
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->bb1._switch_line_16_in_progress = 0;
		  __top->bb1._switch_line_16_exit = 1;
		}
	    }
	  if (__top->bb1._switch_line_16_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_17
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._place_line_17_entry)
		{
		  __top->bb1.loopback = 1;
		  __top->bb1._place_line_17_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_17
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->bb1._switch_line_16_in_progress = 0;
		  __top->bb1._switch_line_16_exit = 1;
		}
	    }
	  if (__top->bb1._switch_line_16_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_18
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._place_line_18_entry)
		{
		  __top->bb1.loopback = 1;
		  __top->bb1._place_line_18_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_18
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->bb1._switch_line_16_in_progress = 0;
		  __top->bb1._switch_line_16_exit = 1;
		}
	    }
	  if (__top->bb1._switch_line_16_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _null_line_0
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._null_line_0_entry)
		{
		  if (1)
		    {
		      ;
		      __top->bb1._null_line_0_entry = 0;
		      __top->bb1._null_line_0_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _null_line_0
// -------------------------------------------------------------------------------------------
	      if (__top->bb1._null_line_0_exit)
		{
		  __top->bb1._null_line_0_exit = 0;
		  __top->bb1._switch_line_16_in_progress = 0;
		  __top->bb1._switch_line_16_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _switch_line_16
// -------------------------------------------------------------------------------------------
	  if (__top->bb1._switch_line_16_exit)
	    {
	      __top->bb1._merge_line_10_exit = 0;
	      __top->bb1._assign_line_14_exit = 0;
	      __top->bb1._assign_line_15_exit = 0;
	      __top->bb1._switch_line_16_exit = 0;
	      __top->bb1.bb1_in_progress = 0;
	      __top->bb1.bb1_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Block bb1
// -------------------------------------------------------------------------------------------
      if (__top->bb1.bb1_exit)
	{
	  __top->bb1.bb1_exit = 0;
	  __top->_assign_line_21_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_21
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_21_entry)
	{
	  if (1)
	    {
	      (__top->b).__val = (__top->bb1.t).__val;	// file BranchBlock.aa, line 21
	      __top->_assign_line_21_entry = 0;
	      __top->_assign_line_21_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_21
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_21_exit)
	{
	  __top->_assign_line_21_exit = 0;
	  __top->_assign_line_22_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_22
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_22_entry)
	{
	  if (1)
	    {
	      (__top->c).__val = (__top->bb1.t).__val;	// file BranchBlock.aa, line 22
	      __top->_assign_line_22_entry = 0;
	      __top->_assign_line_22_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_22
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_22_exit)
	{
	  __top->bb1.bb1_exit = 0;
	  __top->_assign_line_21_exit = 0;
	  __top->_assign_line_22_exit = 0;
	  __top->sum_mod_in_progress = 0;
	  __top->sum_mod_exit = 1;
	}
    }
  return __top;
}
