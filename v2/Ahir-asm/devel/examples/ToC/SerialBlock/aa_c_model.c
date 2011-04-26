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


#define sum_mod_Entry__   if (__top->sum_mod_entry)\
    {\
      __top->sum_mod_entry = 0;\
      __top->sum_mod_in_progress = 1;\
      __top->sum_mod_entry = 0;\
      __top->sum_mod_in_progress = 1;\
      __top->_assign_line_9_entry = 1;\
    }\
  if (__top->sum_mod_in_progress)\
    {


#define SerialBlock_line_9_Entry__      if (__top->_assign_line_9_entry)\
	{\
	  if (1)\
	    {

#define SerialBlock_line_9_Exit__	      __top->_assign_line_9_entry = 0;\
	      __top->_assign_line_9_exit = 1;\
	    }\
	}\
      if (__top->_assign_line_9_exit)\
	{\
	  __top->_assign_line_9_exit = 0;\
	  __top->_assign_line_10_entry = 1;\
	}



#define sum_mod_Exit__      if (__top->_assign_line_18_exit)\
	{\
	  __top->_assign_line_9_exit = 0;\
	  __top->_assign_line_10_exit = 0;\
	  __top->_assign_line_11_exit = 0;\
	  __top->_assign_line_12_exit = 0;\
	  __top->_assign_line_13_exit = 0;\
	  __top->_assign_line_14_exit = 0;\
	  __top->_assign_line_15_exit = 0;\
	  __top->_assign_line_16_exit = 0;\
	  __top->_assign_line_17_exit = 0;\
	  __top->_assign_line_18_exit = 0;\
	  __top->sum_mod_in_progress = 0;\
	  __top->sum_mod_exit = 1;\
	}\
  }


sum_mod_State *
sum_mod_ (sum_mod_State * __top)
{

  sum_mod_Entry__ // check entry flag and pass token to succeeding statements.

  SerialBlock_line_9_Entry__
    
    (__top->x).__val = __PLUS ((__top->a).__val, (__top->b).__val);	//  file SerialBlock.aa, line 9
  
  SerialBlock_line_9_Exit__

// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_10
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_10_entry)
	{
	  if (1)
	    {
	      (__top->x).__val = __MINUS ((__top->x).__val, (__top->b).__val);	//  file SerialBlock.aa, line 10
	      __top->_assign_line_10_entry = 0;
	      __top->_assign_line_10_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_10
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_10_exit)
	{
	  __top->_assign_line_10_exit = 0;
	  __top->_assign_line_11_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_11
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_11_entry)
	{
	  if (1)
	    {
	      (__top->x).__val = __MUL ((__top->x).__val, (__top->b).__val);	//  file SerialBlock.aa, line 11
	      __top->_assign_line_11_entry = 0;
	      __top->_assign_line_11_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_11
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_11_exit)
	{
	  __top->_assign_line_11_exit = 0;
	  __top->_assign_line_12_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_12
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_12_entry)
	{
	  if (1)
	    {
	      (__top->x).__val = __NOR ((__top->x).__val, (__top->b).__val);	//  file SerialBlock.aa, line 12
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
	      (__top->x).__val = __NAND ((__top->x).__val, (__top->b).__val);	//  file SerialBlock.aa, line 13
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
	      (__top->x).__val = __XNOR ((__top->x).__val, (__top->b).__val);	//  file SerialBlock.aa, line 14
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
	      (__top->x).__val = __XOR ((__top->x).__val, (__top->b).__val);	//  file SerialBlock.aa, line 15
	      __top->_assign_line_15_entry = 0;
	      __top->_assign_line_15_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_15
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_15_exit)
	{
	  __top->_assign_line_15_exit = 0;
	  __top->_assign_line_16_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_16
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_16_entry)
	{
	  if (1)
	    {
	      (__top->x).__val = __AND ((__top->x).__val, (__top->b).__val);	//  file SerialBlock.aa, line 16
	      __top->_assign_line_16_entry = 0;
	      __top->_assign_line_16_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_16
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_16_exit)
	{
	  __top->_assign_line_16_exit = 0;
	  __top->_assign_line_17_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_17
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_17_entry)
	{
	  if (1)
	    {
	      (__top->x).__val = __OR ((__top->x).__val, (__top->b).__val);	//  file SerialBlock.aa, line 17
	      __top->_assign_line_17_entry = 0;
	      __top->_assign_line_17_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_17
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_17_exit)
	{
	  __top->_assign_line_17_exit = 0;
	  __top->_assign_line_18_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_18
// -------------------------------------------------------------------------------------------
      if (__top->_assign_line_18_entry)
	{
	  if (1)
	    {
	      (__top->c).__val = (__top->x).__val;	//  file SerialBlock.aa, line 18
	      __top->_assign_line_18_entry = 0;
	      __top->_assign_line_18_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_18
// -------------------------------------------------------------------------------------------

      sum_mod_Exit__

  return __top;
}
