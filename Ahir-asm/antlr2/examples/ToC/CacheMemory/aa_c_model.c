#include <aa_c_model.h>
int
cachememory ()
{
  cachememory_State *__top = (cachememory_State *) calloc (1, sizeof (cachememory_State));
  __top->cachememory_entry = 1;
  while (!__top->cachememory_exit)
    {
      __top = cachememory_ (__top);
    }
  cfree (__top);
  return AASUCCESS;
}

cachememory_State *
cachememory_ (cachememory_State * __top)
{
  if (__top->cachememory_entry)
    {
      __top->cachememory_entry = 0;
      __top->cachememory_in_progress = 1;
      __top->map_mask.__val = 3;
      __top->cachememory_entry = 0;
      __top->cachememory_in_progress = 1;
      __top->init.init_entry = 1;
    }
  if (__top->cachememory_in_progress)
    {
// -------------------------------------------------------------------------------------------
// Begin Block init
// -------------------------------------------------------------------------------------------
      if (__top->init.init_entry)
	{
	  __top->init.I.__val = 0;
	  __top->init.init_entry = 0;
	  __top->init.init_in_progress = 1;
	  __top->init._merge_line_35_entry = 1;
	}
      if (__top->init.init_in_progress)
	{
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_35
// -------------------------------------------------------------------------------------------
	  if (__top->init._merge_line_35_entry || __top->init.loopback)
	    {
	      if (__top->init._merge_line_35_entry)
		{
		  __top->init._merge_line_35_entry = 0;
		  __top->init._merge_line_35_from_entry = 1;
		}
	      __top->init._merge_line_35_in_progress = 1;
	    }
	  if (__top->init._merge_line_35_in_progress)
	    {
	      if (1)
		{
		  // clear the place flag 
		  __top->init.loopback = 0;
		  __top->init._merge_line_35_from_entry = 0;
		  __top->init._merge_line_35_in_progress = 0;
		  __top->init._merge_line_35_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block _merge_line_35
// -------------------------------------------------------------------------------------------
	  if (__top->init._merge_line_35_exit)
	    {
	      __top->init._merge_line_35_exit = 0;
	      __top->init._assign_line_36_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_36
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_36_entry)
	    {
	      if (1)
		{
		  (__top->addr_array[(__top->init.I).__val]).__val = 0;	//  file CacheMemory.aa, line 36
		  __top->init._assign_line_36_entry = 0;
		  __top->init._assign_line_36_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_36
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_36_exit)
	    {
	      __top->init._assign_line_36_exit = 0;
	      __top->init._assign_line_37_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_37
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_37_entry)
	    {
	      if (1)
		{
		  (__top->data_array[(__top->init.I).__val]).__val = 0;	//  file CacheMemory.aa, line 37
		  __top->init._assign_line_37_entry = 0;
		  __top->init._assign_line_37_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_37
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_37_exit)
	    {
	      __top->init._assign_line_37_exit = 0;
	      __top->init._assign_line_38_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_38
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_38_entry)
	    {
	      if (1)
		{
		  (__top->valid_array[(__top->init.I).__val]).__val = 0;	//  file CacheMemory.aa, line 38
		  __top->init._assign_line_38_entry = 0;
		  __top->init._assign_line_38_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_38
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_38_exit)
	    {
	      __top->init._assign_line_38_exit = 0;
	      __top->init._if_line_0_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_0
// -------------------------------------------------------------------------------------------
	  if (__top->init._if_line_0_entry)
	    {
	      if (1)
		{
		  if (__LESS ((__top->init.I).__val, 3))
		    {
		      __top->init._if_line_0_entry = 0;
		      __top->init._if_line_0_in_progress = 1;
		      __top->init._assign_line_40_entry = 1;
		    }
		  else
		    {
		      __top->init._if_line_0_entry = 0;
		      __top->init._if_line_0_in_progress = 0;
		      __top->init._if_line_0_exit = 1;
		    }		// transfer control based on test condition
		}		// proceed if pipe is available 
	    }			// entry flag
	  if (__top->init._if_line_0_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_40
// -------------------------------------------------------------------------------------------
	      if (__top->init._assign_line_40_entry)
		{
		  if (1)
		    {
		      (__top->init.I).__val = __PLUS ((__top->init.I).__val, 1);	//  file CacheMemory.aa, line 40
		      __top->init._assign_line_40_entry = 0;
		      __top->init._assign_line_40_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_40
// -------------------------------------------------------------------------------------------
	      if (__top->init._assign_line_40_exit)
		{
		  __top->init._assign_line_40_exit = 0;
		  __top->init._place_line_41_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_41
// -------------------------------------------------------------------------------------------
	      if (__top->init._place_line_41_entry)
		{
		  __top->init.loopback = 1;
		  __top->init._place_line_41_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_41
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->init._assign_line_40_exit = 0;
		  __top->init._if_line_0_in_progress = 0;
		  __top->init._if_line_0_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _if_line_0
// -------------------------------------------------------------------------------------------
	  if (__top->init._if_line_0_exit)
	    {
	      __top->init._merge_line_35_exit = 0;
	      __top->init._assign_line_36_exit = 0;
	      __top->init._assign_line_37_exit = 0;
	      __top->init._assign_line_38_exit = 0;
	      __top->init._if_line_0_exit = 0;
	      __top->init.init_in_progress = 0;
	      __top->init.init_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Block init
// -------------------------------------------------------------------------------------------
      if (__top->init.init_exit)
	{
	  __top->init.init_exit = 0;
	  __top->p1.p1_entry = 1;
	}
// -------------------------------------------------------------------------------------------
// Begin Block p1
// -------------------------------------------------------------------------------------------
      if (__top->p1.p1_entry)
	{
	  __top->p1.p1_entry = 0;
	  __top->p1.p1_in_progress = 1;
	  __top->p1.reader.reader_entry = 1;
	  __top->p1.writeport.writeport_entry = 1;
	  __top->p1.readport.readport_entry = 1;
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
	      __top->p1.reader._merge_line_49_entry = 1;
	    }
	  if (__top->p1.reader.reader_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_49
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._merge_line_49_entry || __top->p1.reader.loopback)
		{
		  if (__top->p1.reader._merge_line_49_entry)
		    {
		      __top->p1.reader._merge_line_49_entry = 0;
		      __top->p1.reader._merge_line_49_from_entry = 1;
		    }
		  __top->p1.reader._merge_line_49_in_progress = 1;
		}
	      if (__top->p1.reader._merge_line_49_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.reader.loopback = 0;
		      __top->p1.reader._merge_line_49_from_entry = 0;
		      __top->p1.reader._merge_line_49_in_progress = 0;
		      __top->p1.reader._merge_line_49_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_49
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._merge_line_49_exit)
		{
		  __top->p1.reader._merge_line_49_exit = 0;
		  __top->p1.reader._call_line_50_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_50
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_50_entry)
		{
		  if (__top->p1.reader._call_line_50_called_fn_struct == NULL)
		    {
		      __top->p1.reader._call_line_50_called_fn_struct = (Fetch_State *) calloc (1, sizeof (Fetch_State));
		      __top->p1.reader._call_line_50_called_fn_struct->Fetch_entry = 1;
// reset entry flag and set in progress flag
		      __top->p1.reader._call_line_50_entry = 0;
		      __top->p1.reader._call_line_50_in_progress = 1;
		    }		// allocation of pointer to called function
		}		// entry into this call statement
	      if (__top->p1.reader._call_line_50_in_progress)
		{
		  if (__top->p1.reader._call_line_50_called_fn_struct->Fetch_entry)
		    {		// entry flag set?
		      if (1)
			{	// check if pipes can be read from
			}	// arguments copied to call structure
		    }		// called function had entry flag set
		  if (!__top->p1.reader._call_line_50_called_fn_struct->Fetch_exit)
		    {		// called function had not finished
// call the function
		      Fetch (&(__top->p1.reader._call_line_50_called_fn_struct->req));	//   file CacheMemory.aa, line 50
		      __top->p1.reader._call_line_50_called_fn_struct->Fetch_entry = 0;
		      __top->p1.reader._call_line_50_called_fn_struct->Fetch_in_progress = 0;
		      __top->p1.reader._call_line_50_called_fn_struct->Fetch_exit = 1;
		    }		// called function was in progress 
		  if (__top->p1.reader._call_line_50_called_fn_struct->Fetch_exit)
		    {
		      if (1)
			{
			  (__top->p1.reader.req_pointer).__val = __top->p1.reader._call_line_50_called_fn_struct->req.__val;
			  cfree (__top->p1.reader._call_line_50_called_fn_struct);
			  __top->p1.reader._call_line_50_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			  __top->p1.reader._call_line_50_exit = 1;
			  __top->p1.reader._call_line_50_in_progress = 0;
			}	// ok to copy outputs to destinations?
		    }		// called function had finishes?
		}		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_50
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_50_exit)
		{
		  __top->p1.reader._call_line_50_exit = 0;
		  __top->p1.reader._call_line_52_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_52
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_52_entry)
		{
		  if (__top->p1.reader._call_line_52_called_fn_struct == NULL)
		    {
		      __top->p1.reader._call_line_52_called_fn_struct =
			(Is_Read_Access_State *) calloc (1, sizeof (Is_Read_Access_State));
		      __top->p1.reader._call_line_52_called_fn_struct->Is_Read_Access_entry = 1;
// reset entry flag and set in progress flag
		      __top->p1.reader._call_line_52_entry = 0;
		      __top->p1.reader._call_line_52_in_progress = 1;
		    }		// allocation of pointer to called function
		}		// entry into this call statement
	      if (__top->p1.reader._call_line_52_in_progress)
		{
		  if (__top->p1.reader._call_line_52_called_fn_struct->Is_Read_Access_entry)
		    {		// entry flag set?
		      if (1)
			{	// check if pipes can be read from
			  __top->p1.reader._call_line_52_called_fn_struct->req.__val = (__top->p1.reader.req_pointer).__val;
			}	// arguments copied to call structure
		    }		// called function had entry flag set
		  if (!__top->p1.reader._call_line_52_called_fn_struct->Is_Read_Access_exit)
		    {		// called function had not finished
// call the function
		      Is_Read_Access (__top->p1.reader._call_line_52_called_fn_struct->req, &(__top->p1.reader._call_line_52_called_fn_struct->flag));	//   file CacheMemory.aa, line 52
		      __top->p1.reader._call_line_52_called_fn_struct->Is_Read_Access_entry = 0;
		      __top->p1.reader._call_line_52_called_fn_struct->Is_Read_Access_in_progress = 0;
		      __top->p1.reader._call_line_52_called_fn_struct->Is_Read_Access_exit = 1;
		    }		// called function was in progress 
		  if (__top->p1.reader._call_line_52_called_fn_struct->Is_Read_Access_exit)
		    {
		      if (1)
			{
			  (__top->p1.reader.is_read).__val = __top->p1.reader._call_line_52_called_fn_struct->flag.__val;
			  cfree (__top->p1.reader._call_line_52_called_fn_struct);
			  __top->p1.reader._call_line_52_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			  __top->p1.reader._call_line_52_exit = 1;
			  __top->p1.reader._call_line_52_in_progress = 0;
			}	// ok to copy outputs to destinations?
		    }		// called function had finishes?
		}		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_52
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_52_exit)
		{
		  __top->p1.reader._call_line_52_exit = 0;
		  __top->p1.reader._if_line_53_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_53
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._if_line_53_entry)
		{
		  if (1)
		    {
		      if ((__top->p1.reader.is_read).__val)
			{
			  __top->p1.reader._if_line_53_entry = 0;
			  __top->p1.reader._if_line_53_in_progress = 1;
			  __top->p1.reader._call_line_54_entry = 1;
			}
		      else
			{
			  __top->p1.reader._if_line_53_entry = 0;
			  __top->p1.reader._if_line_53_in_progress = 1;
			  __top->p1.reader.extwrite.extwrite_entry = 1;
			}	// transfer control based on test condition
		    }		// proceed if pipe is available 
		}		// entry flag
	      if (__top->p1.reader._if_line_53_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_54
// -------------------------------------------------------------------------------------------
		  if (__top->p1.reader._call_line_54_entry)
		    {
		      if (__top->p1.reader._call_line_54_called_fn_struct == NULL)
			{
			  __top->p1.reader._call_line_54_called_fn_struct =
			    (Access_Address_State *) calloc (1, sizeof (Access_Address_State));
			  __top->p1.reader._call_line_54_called_fn_struct->Access_Address_entry = 1;
// reset entry flag and set in progress flag
			  __top->p1.reader._call_line_54_entry = 0;
			  __top->p1.reader._call_line_54_in_progress = 1;
			}	// allocation of pointer to called function
		    }		// entry into this call statement
		  if (__top->p1.reader._call_line_54_in_progress)
		    {
		      if (__top->p1.reader._call_line_54_called_fn_struct->Access_Address_entry)
			{	// entry flag set?
			  if (1)
			    {	// check if pipes can be read from
			      __top->p1.reader._call_line_54_called_fn_struct->req.__val = (__top->p1.reader.req_pointer).__val;
			    }	// arguments copied to call structure
			}	// called function had entry flag set
		      if (!__top->p1.reader._call_line_54_called_fn_struct->Access_Address_exit)
			{	// called function had not finished
// call the function
			  Access_Address (__top->p1.reader._call_line_54_called_fn_struct->req, &(__top->p1.reader._call_line_54_called_fn_struct->addr));	//   file CacheMemory.aa, line 54
			  __top->p1.reader._call_line_54_called_fn_struct->Access_Address_entry = 0;
			  __top->p1.reader._call_line_54_called_fn_struct->Access_Address_in_progress = 0;
			  __top->p1.reader._call_line_54_called_fn_struct->Access_Address_exit = 1;
			}	// called function was in progress 
		      if (__top->p1.reader._call_line_54_called_fn_struct->Access_Address_exit)
			{
			  if (1 && !__top->read_address_pipe_valid__)
			    {
			      (__top->read_address_pipe).__val = __top->p1.reader._call_line_54_called_fn_struct->addr.__val;
			      __top->read_address_pipe_valid__ = 1;
			      cfree (__top->p1.reader._call_line_54_called_fn_struct);
			      __top->p1.reader._call_line_54_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			      __top->p1.reader._call_line_54_exit = 1;
			      __top->p1.reader._call_line_54_in_progress = 0;
			    }	// ok to copy outputs to destinations?
			}	// called function had finishes?
		    }		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_54
// -------------------------------------------------------------------------------------------
		  if (__top->p1.reader._call_line_54_exit)
		    {
		      __top->p1.reader._call_line_54_exit = 0;
		      __top->p1.reader._if_line_53_in_progress = 0;
		      __top->p1.reader._if_line_53_exit = 1;
		    }
		}
	      if (__top->p1.reader._if_line_53_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Block extwrite
// -------------------------------------------------------------------------------------------
		  if (__top->p1.reader.extwrite.extwrite_entry)
		    {
		      __top->p1.reader.extwrite.extwrite_entry = 0;
		      __top->p1.reader.extwrite.extwrite_in_progress = 1;
		      __top->p1.reader.extwrite._call_line_57_entry = 1;
		      __top->p1.reader.extwrite._call_line_58_entry = 1;
		    }
		  if (__top->p1.reader.extwrite.extwrite_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_57
// -------------------------------------------------------------------------------------------
		      if (__top->p1.reader.extwrite._call_line_57_entry)
			{
			  if (__top->p1.reader.extwrite._call_line_57_called_fn_struct == NULL)
			    {
			      __top->p1.reader.extwrite._call_line_57_called_fn_struct =
				(Access_Address_State *) calloc (1, sizeof (Access_Address_State));
			      __top->p1.reader.extwrite._call_line_57_called_fn_struct->Access_Address_entry = 1;
// reset entry flag and set in progress flag
			      __top->p1.reader.extwrite._call_line_57_entry = 0;
			      __top->p1.reader.extwrite._call_line_57_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.reader.extwrite._call_line_57_in_progress)
			{
			  if (__top->p1.reader.extwrite._call_line_57_called_fn_struct->Access_Address_entry)
			    {	// entry flag set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.reader.extwrite._call_line_57_called_fn_struct->req.__val =
				    (__top->p1.reader.req_pointer).__val;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (!__top->p1.reader.extwrite._call_line_57_called_fn_struct->Access_Address_exit)
			    {	// called function had not finished
// call the function
			      Access_Address (__top->p1.reader.extwrite._call_line_57_called_fn_struct->req, &(__top->p1.reader.extwrite._call_line_57_called_fn_struct->addr));	//   file CacheMemory.aa, line 57
			      __top->p1.reader.extwrite._call_line_57_called_fn_struct->Access_Address_entry = 0;
			      __top->p1.reader.extwrite._call_line_57_called_fn_struct->Access_Address_in_progress = 0;
			      __top->p1.reader.extwrite._call_line_57_called_fn_struct->Access_Address_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.reader.extwrite._call_line_57_called_fn_struct->Access_Address_exit)
			    {
			      if (1 && !__top->write_address_pipe_valid__)
				{
				  (__top->write_address_pipe).__val =
				    __top->p1.reader.extwrite._call_line_57_called_fn_struct->addr.__val;
				  __top->write_address_pipe_valid__ = 1;
				  cfree (__top->p1.reader.extwrite._call_line_57_called_fn_struct);
				  __top->p1.reader.extwrite._call_line_57_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.reader.extwrite._call_line_57_exit = 1;
				  __top->p1.reader.extwrite._call_line_57_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_57
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_58
// -------------------------------------------------------------------------------------------
		      if (__top->p1.reader.extwrite._call_line_58_entry)
			{
			  if (__top->p1.reader.extwrite._call_line_58_called_fn_struct == NULL)
			    {
			      __top->p1.reader.extwrite._call_line_58_called_fn_struct =
				(Access_Data_State *) calloc (1, sizeof (Access_Data_State));
			      __top->p1.reader.extwrite._call_line_58_called_fn_struct->Access_Data_entry = 1;
// reset entry flag and set in progress flag
			      __top->p1.reader.extwrite._call_line_58_entry = 0;
			      __top->p1.reader.extwrite._call_line_58_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.reader.extwrite._call_line_58_in_progress)
			{
			  if (__top->p1.reader.extwrite._call_line_58_called_fn_struct->Access_Data_entry)
			    {	// entry flag set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.reader.extwrite._call_line_58_called_fn_struct->req.__val =
				    (__top->p1.reader.req_pointer).__val;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (!__top->p1.reader.extwrite._call_line_58_called_fn_struct->Access_Data_exit)
			    {	// called function had not finished
// call the function
			      Access_Data (__top->p1.reader.extwrite._call_line_58_called_fn_struct->req, &(__top->p1.reader.extwrite._call_line_58_called_fn_struct->data));	//   file CacheMemory.aa, line 58
			      __top->p1.reader.extwrite._call_line_58_called_fn_struct->Access_Data_entry = 0;
			      __top->p1.reader.extwrite._call_line_58_called_fn_struct->Access_Data_in_progress = 0;
			      __top->p1.reader.extwrite._call_line_58_called_fn_struct->Access_Data_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.reader.extwrite._call_line_58_called_fn_struct->Access_Data_exit)
			    {
			      if (1 && !__top->write_data_pipe_valid__)
				{
				  (__top->write_data_pipe).__val =
				    __top->p1.reader.extwrite._call_line_58_called_fn_struct->data.__val;
				  __top->write_data_pipe_valid__ = 1;
				  cfree (__top->p1.reader.extwrite._call_line_58_called_fn_struct);
				  __top->p1.reader.extwrite._call_line_58_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.reader.extwrite._call_line_58_exit = 1;
				  __top->p1.reader.extwrite._call_line_58_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_58
// -------------------------------------------------------------------------------------------
		      if ((1 && __top->p1.reader.extwrite._call_line_58_exit && __top->p1.reader.extwrite._call_line_57_exit))
			{
			  __top->p1.reader.extwrite._call_line_57_exit = 0;
			  __top->p1.reader.extwrite._call_line_58_exit = 0;
			  __top->p1.reader.extwrite.extwrite_in_progress = 0;
			  __top->p1.reader.extwrite.extwrite_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Block extwrite
// -------------------------------------------------------------------------------------------
		  if (__top->p1.reader.extwrite.extwrite_exit)
		    {
		      __top->p1.reader.extwrite.extwrite_exit = 0;
		      __top->p1.reader._if_line_53_in_progress = 0;
		      __top->p1.reader._if_line_53_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _if_line_53
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._if_line_53_exit)
		{
		  __top->p1.reader._if_line_53_exit = 0;
		  __top->p1.reader._place_line_61_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_61
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._place_line_61_entry)
		{
		  __top->p1.reader.loopback = 1;
		  __top->p1.reader._place_line_61_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_61
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.reader._merge_line_49_exit = 0;
		  __top->p1.reader._call_line_50_exit = 0;
		  __top->p1.reader._call_line_52_exit = 0;
		  __top->p1.reader._if_line_53_exit = 0;
		  __top->p1.reader.reader_in_progress = 0;
		  __top->p1.reader.reader_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block reader
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Block writeport
// -------------------------------------------------------------------------------------------
	  if (__top->p1.writeport.writeport_entry)
	    {
	      __top->p1.writeport.writeport_entry = 0;
	      __top->p1.writeport.writeport_in_progress = 1;
	      __top->p1.writeport._merge_line_68_entry = 1;
	    }
	  if (__top->p1.writeport.writeport_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_68
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._merge_line_68_entry || __top->p1.writeport.loopback)
		{
		  if (__top->p1.writeport._merge_line_68_entry)
		    {
		      __top->p1.writeport._merge_line_68_entry = 0;
		      __top->p1.writeport._merge_line_68_from_entry = 1;
		    }
		  __top->p1.writeport._merge_line_68_in_progress = 1;
		}
	      if (__top->p1.writeport._merge_line_68_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.writeport.loopback = 0;
		      __top->p1.writeport._merge_line_68_from_entry = 0;
		      __top->p1.writeport._merge_line_68_in_progress = 0;
		      __top->p1.writeport._merge_line_68_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_68
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._merge_line_68_exit)
		{
		  __top->p1.writeport._merge_line_68_exit = 0;
		  __top->p1.writeport.getdetails.getdetails_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Block getdetails
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport.getdetails.getdetails_entry)
		{
		  __top->p1.writeport.getdetails.getdetails_entry = 0;
		  __top->p1.writeport.getdetails.getdetails_in_progress = 1;
		  __top->p1.writeport.getdetails._assign_line_70_entry = 1;
		  __top->p1.writeport.getdetails._assign_line_71_entry = 1;
		}
	      if (__top->p1.writeport.getdetails.getdetails_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_70
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport.getdetails._assign_line_70_entry)
		    {
		      if (1 && __top->write_address_pipe_valid__)
			{
			  (__top->p1.writeport.write_address).__val = (__top->write_address_pipe).__val;	//  file CacheMemory.aa, line 70
			  __top->write_address_pipe_valid__ = 0;
			  __top->p1.writeport.getdetails._assign_line_70_entry = 0;
			  __top->p1.writeport.getdetails._assign_line_70_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_70
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_71
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport.getdetails._assign_line_71_entry)
		    {
		      if (1 && __top->write_data_pipe_valid__)
			{
			  (__top->p1.writeport.write_data).__val = (__top->write_data_pipe).__val;	//  file CacheMemory.aa, line 71
			  __top->write_data_pipe_valid__ = 0;
			  __top->p1.writeport.getdetails._assign_line_71_entry = 0;
			  __top->p1.writeport.getdetails._assign_line_71_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_71
// -------------------------------------------------------------------------------------------
		  if ((1 && __top->p1.writeport.getdetails._assign_line_71_exit
		       && __top->p1.writeport.getdetails._assign_line_70_exit))
		    {
		      __top->p1.writeport.getdetails._assign_line_70_exit = 0;
		      __top->p1.writeport.getdetails._assign_line_71_exit = 0;
		      __top->p1.writeport.getdetails.getdetails_in_progress = 0;
		      __top->p1.writeport.getdetails.getdetails_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block getdetails
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport.getdetails.getdetails_exit)
		{
		  __top->p1.writeport.getdetails.getdetails_exit = 0;
		  __top->p1.writeport._assign_line_73_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_73
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._assign_line_73_entry)
		{
		  if (1)
		    {
		      (__top->p1.writeport.addr).__val = __AND ((__top->p1.writeport.write_address).__val, (__top->map_mask).__val);	//  file CacheMemory.aa, line 73
		      __top->p1.writeport._assign_line_73_entry = 0;
		      __top->p1.writeport._assign_line_73_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_73
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._assign_line_73_exit)
		{
		  __top->p1.writeport._assign_line_73_exit = 0;
		  __top->p1.writeport._if_line_74_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_74
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._if_line_74_entry)
		{
		  if (1)
		    {
		      if ((__top->valid_array[(__top->p1.writeport.addr).__val]).__val)
			{
			  __top->p1.writeport._if_line_74_entry = 0;
			  __top->p1.writeport._if_line_74_in_progress = 1;
			  __top->p1.writeport._if_line_75_entry = 1;
			}
		      else
			{
			  __top->p1.writeport._if_line_74_entry = 0;
			  __top->p1.writeport._if_line_74_in_progress = 1;
			  __top->p1.writeport._assign_line_85_entry = 1;
			}	// transfer control based on test condition
		    }		// proceed if pipe is available 
		}		// entry flag
	      if (__top->p1.writeport._if_line_74_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_75
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._if_line_75_entry)
		    {
		      if (1)
			{
			  if (__EQUAL
			      ((__top->addr_array[(__top->p1.writeport.addr).__val]).__val,
			       (__top->p1.writeport.write_address).__val))
			    {
			      __top->p1.writeport._if_line_75_entry = 0;
			      __top->p1.writeport._if_line_75_in_progress = 1;
			      __top->p1.writeport._assign_line_77_entry = 1;
			    }
			  else
			    {
			      __top->p1.writeport._if_line_75_entry = 0;
			      __top->p1.writeport._if_line_75_in_progress = 1;
			      __top->p1.writeport._call_line_81_entry = 1;
			    }	// transfer control based on test condition
			}	// proceed if pipe is available 
		    }		// entry flag
		  if (__top->p1.writeport._if_line_75_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_77
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._assign_line_77_entry)
			{
			  if (1)
			    {
			      (__top->data_array[(__top->p1.writeport.addr).__val]).__val = (__top->p1.writeport.write_data).__val;	//  file CacheMemory.aa, line 77
			      __top->p1.writeport._assign_line_77_entry = 0;
			      __top->p1.writeport._assign_line_77_exit = 1;
			    }
			}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_77
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._assign_line_77_exit)
			{
			  __top->p1.writeport._assign_line_77_exit = 0;
			  __top->p1.writeport._call_line_78_entry = 1;
			}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_78
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._call_line_78_entry)
			{
			  if (__top->p1.writeport._call_line_78_called_fn_struct == NULL)
			    {
			      __top->p1.writeport._call_line_78_called_fn_struct =
				(Write_Hit_State *) calloc (1, sizeof (Write_Hit_State));
			      __top->p1.writeport._call_line_78_called_fn_struct->Write_Hit_entry = 1;
// reset entry flag and set in progress flag
			      __top->p1.writeport._call_line_78_entry = 0;
			      __top->p1.writeport._call_line_78_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.writeport._call_line_78_in_progress)
			{
			  if (__top->p1.writeport._call_line_78_called_fn_struct->Write_Hit_entry)
			    {	// entry flag set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.writeport._call_line_78_called_fn_struct->addr.__val =
				    (__top->p1.writeport.write_address).__val;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (!__top->p1.writeport._call_line_78_called_fn_struct->Write_Hit_exit)
			    {	// called function had not finished
// call the function
			      Write_Hit (__top->p1.writeport._call_line_78_called_fn_struct->addr);	//   file CacheMemory.aa, line 78
			      __top->p1.writeport._call_line_78_called_fn_struct->Write_Hit_entry = 0;
			      __top->p1.writeport._call_line_78_called_fn_struct->Write_Hit_in_progress = 0;
			      __top->p1.writeport._call_line_78_called_fn_struct->Write_Hit_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.writeport._call_line_78_called_fn_struct->Write_Hit_exit)
			    {
			      if (1)
				{
				  cfree (__top->p1.writeport._call_line_78_called_fn_struct);
				  __top->p1.writeport._call_line_78_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.writeport._call_line_78_exit = 1;
				  __top->p1.writeport._call_line_78_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_78
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._call_line_78_exit)
			{
			  __top->p1.writeport._assign_line_77_exit = 0;
			  __top->p1.writeport._call_line_78_exit = 0;
			  __top->p1.writeport._if_line_75_in_progress = 0;
			  __top->p1.writeport._if_line_75_exit = 1;
			}
		    }
		  if (__top->p1.writeport._if_line_75_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_81
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._call_line_81_entry)
			{
			  if (__top->p1.writeport._call_line_81_called_fn_struct == NULL)
			    {
			      __top->p1.writeport._call_line_81_called_fn_struct =
				(Write_Miss_State *) calloc (1, sizeof (Write_Miss_State));
			      __top->p1.writeport._call_line_81_called_fn_struct->Write_Miss_entry = 1;
// reset entry flag and set in progress flag
			      __top->p1.writeport._call_line_81_entry = 0;
			      __top->p1.writeport._call_line_81_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.writeport._call_line_81_in_progress)
			{
			  if (__top->p1.writeport._call_line_81_called_fn_struct->Write_Miss_entry)
			    {	// entry flag set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.writeport._call_line_81_called_fn_struct->addr.__val =
				    (__top->p1.writeport.write_address).__val;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (!__top->p1.writeport._call_line_81_called_fn_struct->Write_Miss_exit)
			    {	// called function had not finished
// call the function
			      Write_Miss (__top->p1.writeport._call_line_81_called_fn_struct->addr);	//   file CacheMemory.aa, line 81
			      __top->p1.writeport._call_line_81_called_fn_struct->Write_Miss_entry = 0;
			      __top->p1.writeport._call_line_81_called_fn_struct->Write_Miss_in_progress = 0;
			      __top->p1.writeport._call_line_81_called_fn_struct->Write_Miss_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.writeport._call_line_81_called_fn_struct->Write_Miss_exit)
			    {
			      if (1)
				{
				  cfree (__top->p1.writeport._call_line_81_called_fn_struct);
				  __top->p1.writeport._call_line_81_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.writeport._call_line_81_exit = 1;
				  __top->p1.writeport._call_line_81_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_81
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._call_line_81_exit)
			{
			  __top->p1.writeport._call_line_81_exit = 0;
			  __top->p1.writeport._if_line_75_in_progress = 0;
			  __top->p1.writeport._if_line_75_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _if_line_75
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._if_line_75_exit)
		    {
		      __top->p1.writeport._if_line_75_exit = 0;
		      __top->p1.writeport._if_line_74_in_progress = 0;
		      __top->p1.writeport._if_line_74_exit = 1;
		    }
		}
	      if (__top->p1.writeport._if_line_74_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_85
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_85_entry)
		    {
		      if (1)
			{
			  (__top->data_array[(__top->p1.writeport.addr).__val]).__val = (__top->p1.writeport.write_data).__val;	//  file CacheMemory.aa, line 85
			  __top->p1.writeport._assign_line_85_entry = 0;
			  __top->p1.writeport._assign_line_85_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_85
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_85_exit)
		    {
		      __top->p1.writeport._assign_line_85_exit = 0;
		      __top->p1.writeport._assign_line_86_entry = 1;
		    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_86
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_86_entry)
		    {
		      if (1)
			{
			  (__top->valid_array[(__top->p1.writeport.addr).__val]).__val = 1;	//  file CacheMemory.aa, line 86
			  __top->p1.writeport._assign_line_86_entry = 0;
			  __top->p1.writeport._assign_line_86_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_86
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_86_exit)
		    {
		      __top->p1.writeport._assign_line_86_exit = 0;
		      __top->p1.writeport._assign_line_87_entry = 1;
		    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_87
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_87_entry)
		    {
		      if (1)
			{
			  (__top->addr_array[(__top->p1.writeport.addr).__val]).__val = (__top->p1.writeport.write_address).__val;	//  file CacheMemory.aa, line 87
			  __top->p1.writeport._assign_line_87_entry = 0;
			  __top->p1.writeport._assign_line_87_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_87
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_87_exit)
		    {
		      __top->p1.writeport._assign_line_87_exit = 0;
		      __top->p1.writeport._call_line_88_entry = 1;
		    }
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_88
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._call_line_88_entry)
		    {
		      if (__top->p1.writeport._call_line_88_called_fn_struct == NULL)
			{
			  __top->p1.writeport._call_line_88_called_fn_struct =
			    (Write_Hit_State *) calloc (1, sizeof (Write_Hit_State));
			  __top->p1.writeport._call_line_88_called_fn_struct->Write_Hit_entry = 1;
// reset entry flag and set in progress flag
			  __top->p1.writeport._call_line_88_entry = 0;
			  __top->p1.writeport._call_line_88_in_progress = 1;
			}	// allocation of pointer to called function
		    }		// entry into this call statement
		  if (__top->p1.writeport._call_line_88_in_progress)
		    {
		      if (__top->p1.writeport._call_line_88_called_fn_struct->Write_Hit_entry)
			{	// entry flag set?
			  if (1)
			    {	// check if pipes can be read from
			      __top->p1.writeport._call_line_88_called_fn_struct->addr.__val =
				(__top->p1.writeport.write_address).__val;
			    }	// arguments copied to call structure
			}	// called function had entry flag set
		      if (!__top->p1.writeport._call_line_88_called_fn_struct->Write_Hit_exit)
			{	// called function had not finished
// call the function
			  Write_Hit (__top->p1.writeport._call_line_88_called_fn_struct->addr);	//   file CacheMemory.aa, line 88
			  __top->p1.writeport._call_line_88_called_fn_struct->Write_Hit_entry = 0;
			  __top->p1.writeport._call_line_88_called_fn_struct->Write_Hit_in_progress = 0;
			  __top->p1.writeport._call_line_88_called_fn_struct->Write_Hit_exit = 1;
			}	// called function was in progress 
		      if (__top->p1.writeport._call_line_88_called_fn_struct->Write_Hit_exit)
			{
			  if (1)
			    {
			      cfree (__top->p1.writeport._call_line_88_called_fn_struct);
			      __top->p1.writeport._call_line_88_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			      __top->p1.writeport._call_line_88_exit = 1;
			      __top->p1.writeport._call_line_88_in_progress = 0;
			    }	// ok to copy outputs to destinations?
			}	// called function had finishes?
		    }		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_88
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._call_line_88_exit)
		    {
		      __top->p1.writeport._assign_line_85_exit = 0;
		      __top->p1.writeport._assign_line_86_exit = 0;
		      __top->p1.writeport._assign_line_87_exit = 0;
		      __top->p1.writeport._call_line_88_exit = 0;
		      __top->p1.writeport._if_line_74_in_progress = 0;
		      __top->p1.writeport._if_line_74_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _if_line_74
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._if_line_74_exit)
		{
		  __top->p1.writeport._if_line_74_exit = 0;
		  __top->p1.writeport._place_line_90_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_90
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._place_line_90_entry)
		{
		  __top->p1.writeport.loopback = 1;
		  __top->p1.writeport._place_line_90_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_90
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.writeport._merge_line_68_exit = 0;
		  __top->p1.writeport.getdetails.getdetails_exit = 0;
		  __top->p1.writeport._assign_line_73_exit = 0;
		  __top->p1.writeport._if_line_74_exit = 0;
		  __top->p1.writeport.writeport_in_progress = 0;
		  __top->p1.writeport.writeport_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block writeport
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Block readport
// -------------------------------------------------------------------------------------------
	  if (__top->p1.readport.readport_entry)
	    {
	      __top->p1.readport.readport_entry = 0;
	      __top->p1.readport.readport_in_progress = 1;
	      __top->p1.readport._merge_line_96_entry = 1;
	    }
	  if (__top->p1.readport.readport_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_96
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._merge_line_96_entry || __top->p1.readport.loopback)
		{
		  if (__top->p1.readport._merge_line_96_entry)
		    {
		      __top->p1.readport._merge_line_96_entry = 0;
		      __top->p1.readport._merge_line_96_from_entry = 1;
		    }
		  __top->p1.readport._merge_line_96_in_progress = 1;
		}
	      if (__top->p1.readport._merge_line_96_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.readport.loopback = 0;
		      __top->p1.readport._merge_line_96_from_entry = 0;
		      __top->p1.readport._merge_line_96_in_progress = 0;
		      __top->p1.readport._merge_line_96_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_96
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._merge_line_96_exit)
		{
		  __top->p1.readport._merge_line_96_exit = 0;
		  __top->p1.readport._assign_line_97_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_97
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._assign_line_97_entry)
		{
		  if (1 && __top->read_address_pipe_valid__)
		    {
		      (__top->p1.readport.read_address).__val = (__top->read_address_pipe).__val;	//  file CacheMemory.aa, line 97
		      __top->read_address_pipe_valid__ = 0;
		      __top->p1.readport._assign_line_97_entry = 0;
		      __top->p1.readport._assign_line_97_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_97
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._assign_line_97_exit)
		{
		  __top->p1.readport._assign_line_97_exit = 0;
		  __top->p1.readport._assign_line_98_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_98
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._assign_line_98_entry)
		{
		  if (1)
		    {
		      (__top->p1.readport.addr).__val = __AND ((__top->p1.readport.read_address).__val, (__top->map_mask).__val);	//  file CacheMemory.aa, line 98
		      __top->p1.readport._assign_line_98_entry = 0;
		      __top->p1.readport._assign_line_98_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_98
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._assign_line_98_exit)
		{
		  __top->p1.readport._assign_line_98_exit = 0;
		  __top->p1.readport._if_line_99_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_99
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._if_line_99_entry)
		{
		  if (1)
		    {
		      if ((__top->valid_array[(__top->p1.readport.addr).__val]).__val)
			{
			  __top->p1.readport._if_line_99_entry = 0;
			  __top->p1.readport._if_line_99_in_progress = 1;
			  __top->p1.readport._if_line_100_entry = 1;
			}
		      else
			{
			  __top->p1.readport._if_line_99_entry = 0;
			  __top->p1.readport._if_line_99_in_progress = 1;
			  __top->p1.readport._call_line_109_entry = 1;
			}	// transfer control based on test condition
		    }		// proceed if pipe is available 
		}		// entry flag
	      if (__top->p1.readport._if_line_99_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_100
// -------------------------------------------------------------------------------------------
		  if (__top->p1.readport._if_line_100_entry)
		    {
		      if (1)
			{
			  if (__EQUAL
			      ((__top->addr_array[(__top->p1.readport.addr).__val]).__val, (__top->p1.readport.read_address).__val))
			    {
			      __top->p1.readport._if_line_100_entry = 0;
			      __top->p1.readport._if_line_100_in_progress = 1;
			      __top->p1.readport._call_line_102_entry = 1;
			    }
			  else
			    {
			      __top->p1.readport._if_line_100_entry = 0;
			      __top->p1.readport._if_line_100_in_progress = 1;
			      __top->p1.readport._call_line_105_entry = 1;
			    }	// transfer control based on test condition
			}	// proceed if pipe is available 
		    }		// entry flag
		  if (__top->p1.readport._if_line_100_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_102
// -------------------------------------------------------------------------------------------
		      if (__top->p1.readport._call_line_102_entry)
			{
			  if (__top->p1.readport._call_line_102_called_fn_struct == NULL)
			    {
			      __top->p1.readport._call_line_102_called_fn_struct =
				(Read_Hit_State *) calloc (1, sizeof (Read_Hit_State));
			      __top->p1.readport._call_line_102_called_fn_struct->Read_Hit_entry = 1;
// reset entry flag and set in progress flag
			      __top->p1.readport._call_line_102_entry = 0;
			      __top->p1.readport._call_line_102_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.readport._call_line_102_in_progress)
			{
			  if (__top->p1.readport._call_line_102_called_fn_struct->Read_Hit_entry)
			    {	// entry flag set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.readport._call_line_102_called_fn_struct->addr.__val =
				    (__top->p1.readport.read_address).__val;
				  __top->p1.readport._call_line_102_called_fn_struct->data.__val =
				    (__top->data_array[(__top->p1.readport.addr).__val]).__val;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (!__top->p1.readport._call_line_102_called_fn_struct->Read_Hit_exit)
			    {	// called function had not finished
// call the function
			      Read_Hit (__top->p1.readport._call_line_102_called_fn_struct->addr, __top->p1.readport._call_line_102_called_fn_struct->data);	//   file CacheMemory.aa, line 102
			      __top->p1.readport._call_line_102_called_fn_struct->Read_Hit_entry = 0;
			      __top->p1.readport._call_line_102_called_fn_struct->Read_Hit_in_progress = 0;
			      __top->p1.readport._call_line_102_called_fn_struct->Read_Hit_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.readport._call_line_102_called_fn_struct->Read_Hit_exit)
			    {
			      if (1)
				{
				  cfree (__top->p1.readport._call_line_102_called_fn_struct);
				  __top->p1.readport._call_line_102_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.readport._call_line_102_exit = 1;
				  __top->p1.readport._call_line_102_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_102
// -------------------------------------------------------------------------------------------
		      if (__top->p1.readport._call_line_102_exit)
			{
			  __top->p1.readport._call_line_102_exit = 0;
			  __top->p1.readport._if_line_100_in_progress = 0;
			  __top->p1.readport._if_line_100_exit = 1;
			}
		    }
		  if (__top->p1.readport._if_line_100_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_105
// -------------------------------------------------------------------------------------------
		      if (__top->p1.readport._call_line_105_entry)
			{
			  if (__top->p1.readport._call_line_105_called_fn_struct == NULL)
			    {
			      __top->p1.readport._call_line_105_called_fn_struct =
				(Read_Miss_State *) calloc (1, sizeof (Read_Miss_State));
			      __top->p1.readport._call_line_105_called_fn_struct->Read_Miss_entry = 1;
// reset entry flag and set in progress flag
			      __top->p1.readport._call_line_105_entry = 0;
			      __top->p1.readport._call_line_105_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.readport._call_line_105_in_progress)
			{
			  if (__top->p1.readport._call_line_105_called_fn_struct->Read_Miss_entry)
			    {	// entry flag set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.readport._call_line_105_called_fn_struct->addr.__val =
				    (__top->p1.readport.read_address).__val;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (!__top->p1.readport._call_line_105_called_fn_struct->Read_Miss_exit)
			    {	// called function had not finished
// call the function
			      Read_Miss (__top->p1.readport._call_line_105_called_fn_struct->addr);	//   file CacheMemory.aa, line 105
			      __top->p1.readport._call_line_105_called_fn_struct->Read_Miss_entry = 0;
			      __top->p1.readport._call_line_105_called_fn_struct->Read_Miss_in_progress = 0;
			      __top->p1.readport._call_line_105_called_fn_struct->Read_Miss_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.readport._call_line_105_called_fn_struct->Read_Miss_exit)
			    {
			      if (1)
				{
				  cfree (__top->p1.readport._call_line_105_called_fn_struct);
				  __top->p1.readport._call_line_105_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.readport._call_line_105_exit = 1;
				  __top->p1.readport._call_line_105_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_105
// -------------------------------------------------------------------------------------------
		      if (__top->p1.readport._call_line_105_exit)
			{
			  __top->p1.readport._call_line_105_exit = 0;
			  __top->p1.readport._if_line_100_in_progress = 0;
			  __top->p1.readport._if_line_100_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _if_line_100
// -------------------------------------------------------------------------------------------
		  if (__top->p1.readport._if_line_100_exit)
		    {
		      __top->p1.readport._if_line_100_exit = 0;
		      __top->p1.readport._if_line_99_in_progress = 0;
		      __top->p1.readport._if_line_99_exit = 1;
		    }
		}
	      if (__top->p1.readport._if_line_99_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_109
// -------------------------------------------------------------------------------------------
		  if (__top->p1.readport._call_line_109_entry)
		    {
		      if (__top->p1.readport._call_line_109_called_fn_struct == NULL)
			{
			  __top->p1.readport._call_line_109_called_fn_struct =
			    (Read_Miss_State *) calloc (1, sizeof (Read_Miss_State));
			  __top->p1.readport._call_line_109_called_fn_struct->Read_Miss_entry = 1;
// reset entry flag and set in progress flag
			  __top->p1.readport._call_line_109_entry = 0;
			  __top->p1.readport._call_line_109_in_progress = 1;
			}	// allocation of pointer to called function
		    }		// entry into this call statement
		  if (__top->p1.readport._call_line_109_in_progress)
		    {
		      if (__top->p1.readport._call_line_109_called_fn_struct->Read_Miss_entry)
			{	// entry flag set?
			  if (1)
			    {	// check if pipes can be read from
			      __top->p1.readport._call_line_109_called_fn_struct->addr.__val =
				(__top->p1.readport.read_address).__val;
			    }	// arguments copied to call structure
			}	// called function had entry flag set
		      if (!__top->p1.readport._call_line_109_called_fn_struct->Read_Miss_exit)
			{	// called function had not finished
// call the function
			  Read_Miss (__top->p1.readport._call_line_109_called_fn_struct->addr);	//   file CacheMemory.aa, line 109
			  __top->p1.readport._call_line_109_called_fn_struct->Read_Miss_entry = 0;
			  __top->p1.readport._call_line_109_called_fn_struct->Read_Miss_in_progress = 0;
			  __top->p1.readport._call_line_109_called_fn_struct->Read_Miss_exit = 1;
			}	// called function was in progress 
		      if (__top->p1.readport._call_line_109_called_fn_struct->Read_Miss_exit)
			{
			  if (1)
			    {
			      cfree (__top->p1.readport._call_line_109_called_fn_struct);
			      __top->p1.readport._call_line_109_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			      __top->p1.readport._call_line_109_exit = 1;
			      __top->p1.readport._call_line_109_in_progress = 0;
			    }	// ok to copy outputs to destinations?
			}	// called function had finishes?
		    }		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_109
// -------------------------------------------------------------------------------------------
		  if (__top->p1.readport._call_line_109_exit)
		    {
		      __top->p1.readport._call_line_109_exit = 0;
		      __top->p1.readport._if_line_99_in_progress = 0;
		      __top->p1.readport._if_line_99_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _if_line_99
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._if_line_99_exit)
		{
		  __top->p1.readport._if_line_99_exit = 0;
		  __top->p1.readport._place_line_111_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_111
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._place_line_111_entry)
		{
		  __top->p1.readport.loopback = 1;
		  __top->p1.readport._place_line_111_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_111
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.readport._merge_line_96_exit = 0;
		  __top->p1.readport._assign_line_97_exit = 0;
		  __top->p1.readport._assign_line_98_exit = 0;
		  __top->p1.readport._if_line_99_exit = 0;
		  __top->p1.readport.readport_in_progress = 0;
		  __top->p1.readport.readport_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block readport
// -------------------------------------------------------------------------------------------
	  if ((1 && __top->p1.readport.readport_exit && __top->p1.writeport.writeport_exit && __top->p1.reader.reader_exit))
	    {
	      __top->p1.reader.reader_exit = 0;
	      __top->p1.writeport.writeport_exit = 0;
	      __top->p1.readport.readport_exit = 0;
	      __top->p1.p1_in_progress = 0;
	      __top->p1.p1_exit = 1;
	    }
	}
// -------------------------------------------------------------------------------------------
// End Block p1
// -------------------------------------------------------------------------------------------
      if (__top->p1.p1_exit)
	{
	  __top->init.init_exit = 0;
	  __top->p1.p1_exit = 0;
	  __top->cachememory_in_progress = 0;
	  __top->cachememory_exit = 1;
	}
    }
  return __top;
}
