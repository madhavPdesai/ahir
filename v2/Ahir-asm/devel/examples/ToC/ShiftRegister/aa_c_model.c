#include <aa_c_model.h>
int
shiftregister (uint_10 a, uint_10 * b)
{
  shiftregister_State *__top =
    (shiftregister_State *) calloc (1, sizeof (shiftregister_State));
  __top->shiftregister_entry = 1;
  __top->a = a;
  while (!__top->shiftregister_exit)
    {
      __top = shiftregister_ (__top);
    }
  *b = __top->b;
  cfree (__top);
  return AASUCCESS;
}

shiftregister_State *
shiftregister_ (shiftregister_State * __top)
{
  if (__top->shiftregister_entry)
    {
      __top->shiftregister_entry = 0;
      __top->shiftregister_in_progress = 1;
      __top->shiftregister_entry = 0;
      __top->shiftregister_in_progress = 1;
      __top->p1.p1_entry = 1;
    }
  if (__top->shiftregister_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Block p1
// -------------------------------------------------------------------------------------------
      if (__top->p1.p1_entry)
	{
	  __top->p1.p1_entry = 0;
	  __top->p1.p1_in_progress = 1;
	  __top->p1.reader.reader_entry = 1;
	  __top->p1.b1.b1_entry = 1;
	  __top->p1.b2.b2_entry = 1;
	  __top->p1.writer.writer_entry = 1;
	}
      if (__top->p1.p1_in_progress)
	{
// -------------------------------------------------------------------------------------------
// Begin Block reader
// -------------------------------------------------------------------------------------------
	  if (__top->p1.reader.reader_entry)
	    {
	      __top->p1.reader.reader_entry = 0;
	      __top->p1.reader.reader_in_progress = 1;
	      __top->p1.reader._merge_line_17_entry = 1;
	    }
	  if (__top->p1.reader.reader_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_17
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._merge_line_17_entry
		  || __top->p1.reader.loopback)
		{
		  if (__top->p1.reader._merge_line_17_entry)
		    {
		      __top->p1.reader._merge_line_17_entry = 0;
		      __top->p1.reader._merge_line_17_from_entry = 1;
		    }
		  __top->p1.reader._merge_line_17_in_progress = 1;
		}
	      if (__top->p1.reader._merge_line_17_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.reader.loopback = 0;
		      __top->p1.reader._merge_line_17_from_entry = 0;
		      __top->p1.reader._merge_line_17_in_progress = 0;
		      __top->p1.reader._merge_line_17_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_17
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._merge_line_17_exit)
		{
		  __top->p1.reader._merge_line_17_exit = 0;
		  __top->p1.reader._call_line_20_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_20
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_20_entry)
		{
		  if (__top->p1.reader._call_line_20_called_fn_struct == NULL)
		    {
		      __top->p1.reader._call_line_20_called_fn_struct =
			(Print_State *) calloc (1, sizeof (Print_State));
// reset entry flag and set in progress flag
		      __top->p1.reader._call_line_20_entry = 0;
		      __top->p1.reader._call_line_20_in_progress = 1;
		    }		// allocation of pointer to called function
		}		// entry into this call statement
	      if (__top->p1.reader._call_line_20_in_progress)
		{
		  if (!__top->p1.reader._call_line_20_called_fn_struct->
		      Print_entry
		      && !__top->p1.reader._call_line_20_called_fn_struct->
		      Print_in_progress)
		    {		// entry and in_progress flags not set?
		      if (1 && __top->outpipe_valid__)
			{	// check if pipes can be read from
			  __top->p1.reader._call_line_20_called_fn_struct->a.
			    __val = (__top->outpipe).__val;
			  __top->outpipe_valid__ = 0;
			  __top->p1.reader._call_line_20_called_fn_struct->
			    Print_entry = 1;
			}	// arguments copied to call structure
		    }		// called function had entry flag set
		  if (__top->p1.reader._call_line_20_called_fn_struct->
		      Print_entry
		      || __top->p1.reader._call_line_20_called_fn_struct->
		      Print_in_progress)
		    {		// called function still in progress
// call the function
		      Print (__top->p1.reader._call_line_20_called_fn_struct->a);	//   file ShiftRegister.aa, line 20
		      __top->p1.reader._call_line_20_called_fn_struct->
			Print_entry = 0;
		      __top->p1.reader._call_line_20_called_fn_struct->
			Print_in_progress = 0;
		      __top->p1.reader._call_line_20_called_fn_struct->
			Print_exit = 1;
		    }		// called function was in progress 
		  if (__top->p1.reader._call_line_20_called_fn_struct->
		      Print_exit)
		    {
		      if (1)
			{
			  cfree (__top->p1.reader.
				 _call_line_20_called_fn_struct);
			  __top->p1.reader._call_line_20_called_fn_struct =
			    NULL;
// reset in progress flag and set exit flag
			  __top->p1.reader._call_line_20_exit = 1;
			  __top->p1.reader._call_line_20_in_progress = 0;
			}	// ok to copy outputs to destinations?
		    }		// called function had finishes?
		}		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_20
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_20_exit)
		{
		  __top->p1.reader._call_line_20_exit = 0;
		  __top->p1.reader._place_line_21_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_21
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._place_line_21_entry)
		{
		  __top->p1.reader.loopback = 1;
		  __top->p1.reader._place_line_21_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_21
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.reader._merge_line_17_exit = 0;
		  __top->p1.reader._call_line_20_exit = 0;
		  __top->p1.reader.reader_in_progress = 0;
		  __top->p1.reader.reader_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block reader
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Block b1
// -------------------------------------------------------------------------------------------
	  if (__top->p1.b1.b1_entry)
	    {
	      __top->p1.b1.b1_entry = 0;
	      __top->p1.b1.b1_in_progress = 1;
	      __top->p1.b1._merge_line_25_entry = 1;
	    }
	  if (__top->p1.b1.b1_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_25
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b1._merge_line_25_entry || __top->p1.b1.loopback)
		{
		  if (__top->p1.b1._merge_line_25_entry)
		    {
		      __top->p1.b1._merge_line_25_entry = 0;
		      __top->p1.b1._merge_line_25_from_entry = 1;
		    }
		  __top->p1.b1._merge_line_25_in_progress = 1;
		}
	      if (__top->p1.b1._merge_line_25_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.b1.loopback = 0;
		      __top->p1.b1._merge_line_25_from_entry = 0;
		      __top->p1.b1._merge_line_25_in_progress = 0;
		      __top->p1.b1._merge_line_25_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_25
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b1._merge_line_25_exit)
		{
		  __top->p1.b1._merge_line_25_exit = 0;
		  __top->p1.b1._assign_line_26_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_26
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b1._assign_line_26_entry)
		{
		  if (1 && __top->inpipe_valid__
		      && !__top->p1.midpipe_valid__)
		    {
		      (__top->p1.midpipe).__val = (__top->inpipe).__val;	//  file ShiftRegister.aa, line 26
		      __top->p1.midpipe_valid__ = 1;
		      __top->inpipe_valid__ = 0;
		      __top->p1.b1._assign_line_26_entry = 0;
		      __top->p1.b1._assign_line_26_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_26
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b1._assign_line_26_exit)
		{
		  __top->p1.b1._assign_line_26_exit = 0;
		  __top->p1.b1._place_line_27_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_27
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b1._place_line_27_entry)
		{
		  __top->p1.b1.loopback = 1;
		  __top->p1.b1._place_line_27_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_27
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.b1._merge_line_25_exit = 0;
		  __top->p1.b1._assign_line_26_exit = 0;
		  __top->p1.b1.b1_in_progress = 0;
		  __top->p1.b1.b1_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block b1
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Block b2
// -------------------------------------------------------------------------------------------
	  if (__top->p1.b2.b2_entry)
	    {
	      __top->p1.b2.b2_entry = 0;
	      __top->p1.b2.b2_in_progress = 1;
	      __top->p1.b2._merge_line_31_entry = 1;
	    }
	  if (__top->p1.b2.b2_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_31
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b2._merge_line_31_entry || __top->p1.b2.loopback)
		{
		  if (__top->p1.b2._merge_line_31_entry)
		    {
		      __top->p1.b2._merge_line_31_entry = 0;
		      __top->p1.b2._merge_line_31_from_entry = 1;
		    }
		  __top->p1.b2._merge_line_31_in_progress = 1;
		}
	      if (__top->p1.b2._merge_line_31_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.b2.loopback = 0;
		      __top->p1.b2._merge_line_31_from_entry = 0;
		      __top->p1.b2._merge_line_31_in_progress = 0;
		      __top->p1.b2._merge_line_31_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_31
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b2._merge_line_31_exit)
		{
		  __top->p1.b2._merge_line_31_exit = 0;
		  __top->p1.b2._assign_line_32_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_32
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b2._assign_line_32_entry)
		{
		  if (1 && __top->p1.midpipe_valid__
		      && !__top->outpipe_valid__)
		    {
		      (__top->outpipe).__val = (__top->p1.midpipe).__val;	//  file ShiftRegister.aa, line 32
		      __top->outpipe_valid__ = 1;
		      __top->p1.midpipe_valid__ = 0;
		      __top->p1.b2._assign_line_32_entry = 0;
		      __top->p1.b2._assign_line_32_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_32
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b2._assign_line_32_exit)
		{
		  __top->p1.b2._assign_line_32_exit = 0;
		  __top->p1.b2._place_line_33_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_33
// -------------------------------------------------------------------------------------------
	      if (__top->p1.b2._place_line_33_entry)
		{
		  __top->p1.b2.loopback = 1;
		  __top->p1.b2._place_line_33_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_33
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.b2._merge_line_31_exit = 0;
		  __top->p1.b2._assign_line_32_exit = 0;
		  __top->p1.b2.b2_in_progress = 0;
		  __top->p1.b2.b2_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block b2
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Block writer
// -------------------------------------------------------------------------------------------
	  if (__top->p1.writer.writer_entry)
	    {
	      __top->p1.writer.writer_entry = 0;
	      __top->p1.writer.writer_in_progress = 1;
	      __top->p1.writer._merge_line_37_entry = 1;
	    }
	  if (__top->p1.writer.writer_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_37
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writer._merge_line_37_entry
		  || __top->p1.writer.loopback)
		{
		  if (__top->p1.writer._merge_line_37_entry)
		    {
		      __top->p1.writer._merge_line_37_entry = 0;
		      __top->p1.writer._merge_line_37_from_entry = 1;
		    }
		  __top->p1.writer._merge_line_37_in_progress = 1;
		}
	      if (__top->p1.writer._merge_line_37_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.writer.loopback = 0;
		      __top->p1.writer._merge_line_37_from_entry = 0;
		      __top->p1.writer._merge_line_37_in_progress = 0;
		      __top->p1.writer._merge_line_37_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_37
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writer._merge_line_37_exit)
		{
		  __top->p1.writer._merge_line_37_exit = 0;
		  __top->p1.writer._call_line_40_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_40
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writer._call_line_40_entry)
		{
		  if (__top->p1.writer._call_line_40_called_fn_struct == NULL)
		    {
		      __top->p1.writer._call_line_40_called_fn_struct =
			(Read_State *) calloc (1, sizeof (Read_State));
// reset entry flag and set in progress flag
		      __top->p1.writer._call_line_40_entry = 0;
		      __top->p1.writer._call_line_40_in_progress = 1;
		    }		// allocation of pointer to called function
		}		// entry into this call statement
	      if (__top->p1.writer._call_line_40_in_progress)
		{
		  if (!__top->p1.writer._call_line_40_called_fn_struct->
		      Read_entry
		      && !__top->p1.writer._call_line_40_called_fn_struct->
		      Read_in_progress)
		    {		// entry and in_progress flags not set?
		      if (1)
			{	// check if pipes can be read from
			  __top->p1.writer._call_line_40_called_fn_struct->
			    Read_entry = 1;
			}	// arguments copied to call structure
		    }		// called function had entry flag set
		  if (__top->p1.writer._call_line_40_called_fn_struct->
		      Read_entry
		      || __top->p1.writer._call_line_40_called_fn_struct->
		      Read_in_progress)
		    {		// called function still in progress
// call the function
		      Read (&(__top->p1.writer._call_line_40_called_fn_struct->result));	//   file ShiftRegister.aa, line 40
		      __top->p1.writer._call_line_40_called_fn_struct->
			Read_entry = 0;
		      __top->p1.writer._call_line_40_called_fn_struct->
			Read_in_progress = 0;
		      __top->p1.writer._call_line_40_called_fn_struct->
			Read_exit = 1;
		    }		// called function was in progress 
		  if (__top->p1.writer._call_line_40_called_fn_struct->
		      Read_exit)
		    {
		      if (1 && !__top->inpipe_valid__)
			{
			  (__top->inpipe).__val =
			    __top->p1.writer._call_line_40_called_fn_struct->
			    result.__val;
			  __top->inpipe_valid__ = 1;
			  cfree (__top->p1.writer.
				 _call_line_40_called_fn_struct);
			  __top->p1.writer._call_line_40_called_fn_struct =
			    NULL;
// reset in progress flag and set exit flag
			  __top->p1.writer._call_line_40_exit = 1;
			  __top->p1.writer._call_line_40_in_progress = 0;
			}	// ok to copy outputs to destinations?
		    }		// called function had finishes?
		}		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_40
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writer._call_line_40_exit)
		{
		  __top->p1.writer._call_line_40_exit = 0;
		  __top->p1.writer._place_line_41_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_41
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writer._place_line_41_entry)
		{
		  __top->p1.writer.loopback = 1;
		  __top->p1.writer._place_line_41_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_41
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.writer._merge_line_37_exit = 0;
		  __top->p1.writer._call_line_40_exit = 0;
		  __top->p1.writer.writer_in_progress = 0;
		  __top->p1.writer.writer_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block writer
// -------------------------------------------------------------------------------------------
	  if ((1 && __top->p1.writer.writer_exit && __top->p1.b2.b2_exit
	       && __top->p1.b1.b1_exit && __top->p1.reader.reader_exit))
	    {
	      __top->p1.reader.reader_exit = 0;
	      __top->p1.b1.b1_exit = 0;
	      __top->p1.b2.b2_exit = 0;
	      __top->p1.writer.writer_exit = 0;
	      __top->p1.p1_in_progress = 0;
	      __top->p1.p1_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Block p1
// -------------------------------------------------------------------------------------------
      if (__top->p1.p1_exit)
	{
	  __top->p1.p1_exit = 0;
	  __top->_call_line_44_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_44
// -------------------------------------------------------------------------------------------
      if (__top->_call_line_44_entry)
	{
	  if (__top->_call_line_44_called_fn_struct == NULL)
	    {
	      __top->_call_line_44_called_fn_struct =
		(Print_State *) calloc (1, sizeof (Print_State));
// reset entry flag and set in progress flag
	      __top->_call_line_44_entry = 0;
	      __top->_call_line_44_in_progress = 1;
	    }			// allocation of pointer to called function
	}			// entry into this call statement
      if (__top->_call_line_44_in_progress)
	{
	  if (!__top->_call_line_44_called_fn_struct->Print_entry
	      && !__top->_call_line_44_called_fn_struct->Print_in_progress)
	    {			// entry and in_progress flags not set?
	      if (1)
		{		// check if pipes can be read from
		  __top->_call_line_44_called_fn_struct->a.__val =
		    (__top->b).__val;
		  __top->_call_line_44_called_fn_struct->Print_entry = 1;
		}		// arguments copied to call structure
	    }			// called function had entry flag set
	  if (__top->_call_line_44_called_fn_struct->Print_entry
	      || __top->_call_line_44_called_fn_struct->Print_in_progress)
	    {			// called function still in progress
// call the function
	      Print (__top->_call_line_44_called_fn_struct->a);	//   file ShiftRegister.aa, line 44
	      __top->_call_line_44_called_fn_struct->Print_entry = 0;
	      __top->_call_line_44_called_fn_struct->Print_in_progress = 0;
	      __top->_call_line_44_called_fn_struct->Print_exit = 1;
	    }			// called function was in progress 
	  if (__top->_call_line_44_called_fn_struct->Print_exit)
	    {
	      if (1)
		{
		  cfree (__top->_call_line_44_called_fn_struct);
		  __top->_call_line_44_called_fn_struct = NULL;
// reset in progress flag and set exit flag
		  __top->_call_line_44_exit = 1;
		  __top->_call_line_44_in_progress = 0;
		}		// ok to copy outputs to destinations?
	    }			// called function had finishes?
	}			// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_44
// -------------------------------------------------------------------------------------------
      if (__top->_call_line_44_exit)
	{
	  __top->p1.p1_exit = 0;
	  __top->_call_line_44_exit = 0;
	  __top->shiftregister_in_progress = 0;
	  __top->shiftregister_exit = 1;
	}
    }
  return __top;
}
