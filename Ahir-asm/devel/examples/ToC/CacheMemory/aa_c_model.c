#include <aa_c_model.h>
uint_32 g_data_array[4];
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
	  __top->init._merge_line_38_entry = 1;
	}
      if (__top->init.init_in_progress)
	{
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_38
// -------------------------------------------------------------------------------------------
	  if (__top->init._merge_line_38_entry || __top->init.loopback)
	    {
	      if (__top->init._merge_line_38_entry)
		{
		  __top->init._merge_line_38_entry = 0;
		  __top->init._merge_line_38_from_entry = 1;
		}
	      __top->init._merge_line_38_in_progress = 1;
	    }
	  if (__top->init._merge_line_38_in_progress)
	    {
	      if (1)
		{
		  // clear the place flag 
		  __top->init.loopback = 0;
		  __top->init._merge_line_38_from_entry = 0;
		  __top->init._merge_line_38_in_progress = 0;
		  __top->init._merge_line_38_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Block _merge_line_38
// -------------------------------------------------------------------------------------------
	  if (__top->init._merge_line_38_exit)
	    {
	      __top->init._merge_line_38_exit = 0;
	      __top->init._assign_line_39_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_39
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_39_entry)
	    {
	      if (1)
		{
		  (__top->addr_array[(__top->init.I).__val]).__val = 0;	//  file CacheMemory.aa, line 39
		  __top->init._assign_line_39_entry = 0;
		  __top->init._assign_line_39_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_39
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_39_exit)
	    {
	      __top->init._assign_line_39_exit = 0;
	      __top->init._assign_line_40_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_40
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_40_entry)
	    {
	      if (1)
		{
		  (__top->data_array[(__top->init.I).__val]).__val = 0;	//  file CacheMemory.aa, line 40
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
	      __top->init._assign_line_41_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_41
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_41_entry)
	    {
	      if (1)
		{
		  (__top->valid_array[(__top->init.I).__val]).__val = 0;	//  file CacheMemory.aa, line 41
		  __top->init._assign_line_41_entry = 0;
		  __top->init._assign_line_41_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_41
// -------------------------------------------------------------------------------------------
	  if (__top->init._assign_line_41_exit)
	    {
	      __top->init._assign_line_41_exit = 0;
	      __top->init._if_line_10310760_entry = 1;
	    }
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_10310760
// -------------------------------------------------------------------------------------------
	  if (__top->init._if_line_10310760_entry)
	    {
	      if (1)
		{
		  if (__LESS ((__top->init.I).__val, 3))
		    {
		      __top->init._if_line_10310760_entry = 0;
		      __top->init._if_line_10310760_in_progress = 1;
		      __top->init._assign_line_43_entry = 1;
		    }
		  else
		    {
		      __top->init._if_line_10310760_entry = 0;
		      __top->init._if_line_10310760_in_progress = 0;
		      __top->init._if_line_10310760_exit = 1;
		    }		// transfer control based on test condition
		}		// proceed if pipe is available 
	    }			// entry flag
	  if (__top->init._if_line_10310760_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_43
// -------------------------------------------------------------------------------------------
	      if (__top->init._assign_line_43_entry)
		{
		  if (1)
		    {
		      (__top->init.I).__val = __PLUS ((__top->init.I).__val, 1);	//  file CacheMemory.aa, line 43
		      __top->init._assign_line_43_entry = 0;
		      __top->init._assign_line_43_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_43
// -------------------------------------------------------------------------------------------
	      if (__top->init._assign_line_43_exit)
		{
		  __top->init._assign_line_43_exit = 0;
		  __top->init._place_line_44_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_44
// -------------------------------------------------------------------------------------------
	      if (__top->init._place_line_44_entry)
		{
		  __top->init.loopback = 1;
		  __top->init._place_line_44_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_44
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->init._assign_line_43_exit = 0;
		  __top->init._if_line_10310760_in_progress = 0;
		  __top->init._if_line_10310760_exit = 1;
		}
	    }
// -------------------------------------------------------------------------------------------
// End Statement _if_line_10310760
// -------------------------------------------------------------------------------------------
	  if (__top->init._if_line_10310760_exit)
	    {
	      __top->init._merge_line_38_exit = 0;
	      __top->init._assign_line_39_exit = 0;
	      __top->init._assign_line_40_exit = 0;
	      __top->init._assign_line_41_exit = 0;
	      __top->init._if_line_10310760_exit = 0;
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
	      __top->p1.reader._merge_line_52_entry = 1;
	    }
	  if (__top->p1.reader.reader_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_52
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._merge_line_52_entry || __top->p1.reader.loopback)
		{
		  if (__top->p1.reader._merge_line_52_entry)
		    {
		      __top->p1.reader._merge_line_52_entry = 0;
		      __top->p1.reader._merge_line_52_from_entry = 1;
		    }
		  __top->p1.reader._merge_line_52_in_progress = 1;
		}
	      if (__top->p1.reader._merge_line_52_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.reader.loopback = 0;
		      __top->p1.reader._merge_line_52_from_entry = 0;
		      __top->p1.reader._merge_line_52_in_progress = 0;
		      __top->p1.reader._merge_line_52_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_52
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._merge_line_52_exit)
		{
		  __top->p1.reader._merge_line_52_exit = 0;
		  __top->p1.reader._call_line_53_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_53
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_53_entry)
		{
		  if (__top->p1.reader._call_line_53_called_fn_struct == NULL)
		    {
		      __top->p1.reader._call_line_53_called_fn_struct = (Fetch_State *) calloc (1, sizeof (Fetch_State));
// reset entry flag and set in progress flag
		      __top->p1.reader._call_line_53_entry = 0;
		      __top->p1.reader._call_line_53_in_progress = 1;
		    }		// allocation of pointer to called function
		}		// entry into this call statement
	      if (__top->p1.reader._call_line_53_in_progress)
		{
		  if (!__top->p1.reader._call_line_53_called_fn_struct->Fetch_entry
		      && !__top->p1.reader._call_line_53_called_fn_struct->Fetch_in_progress)
		    {		// entry and in_progress flags not set?
		      if (1)
			{	// check if pipes can be read from
			  __top->p1.reader._call_line_53_called_fn_struct->Fetch_entry = 1;
			}	// arguments copied to call structure
		    }		// called function had entry flag set
		  if (__top->p1.reader._call_line_53_called_fn_struct->Fetch_entry
		      || __top->p1.reader._call_line_53_called_fn_struct->Fetch_in_progress)
		    {		// called function still in progress
// call the function
		      Fetch (&(__top->p1.reader._call_line_53_called_fn_struct->req));	//   file CacheMemory.aa, line 53
		      __top->p1.reader._call_line_53_called_fn_struct->Fetch_entry = 0;
		      __top->p1.reader._call_line_53_called_fn_struct->Fetch_in_progress = 0;
		      __top->p1.reader._call_line_53_called_fn_struct->Fetch_exit = 1;
		    }		// called function was in progress 
		  if (__top->p1.reader._call_line_53_called_fn_struct->Fetch_exit)
		    {
		      if (1)
			{
			  (__top->p1.reader.req_pointer).__val = __top->p1.reader._call_line_53_called_fn_struct->req.__val;
			  cfree (__top->p1.reader._call_line_53_called_fn_struct);
			  __top->p1.reader._call_line_53_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			  __top->p1.reader._call_line_53_exit = 1;
			  __top->p1.reader._call_line_53_in_progress = 0;
			}	// ok to copy outputs to destinations?
		    }		// called function had finishes?
		}		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_53
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_53_exit)
		{
		  __top->p1.reader._call_line_53_exit = 0;
		  __top->p1.reader._call_line_55_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_55
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_55_entry)
		{
		  if (__top->p1.reader._call_line_55_called_fn_struct == NULL)
		    {
		      __top->p1.reader._call_line_55_called_fn_struct =
			(Is_Read_Access_State *) calloc (1, sizeof (Is_Read_Access_State));
// reset entry flag and set in progress flag
		      __top->p1.reader._call_line_55_entry = 0;
		      __top->p1.reader._call_line_55_in_progress = 1;
		    }		// allocation of pointer to called function
		}		// entry into this call statement
	      if (__top->p1.reader._call_line_55_in_progress)
		{
		  if (!__top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_entry
		      && !__top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_in_progress)
		    {		// entry and in_progress flags not set?
		      if (1)
			{	// check if pipes can be read from
			  __top->p1.reader._call_line_55_called_fn_struct->req.__val = (__top->p1.reader.req_pointer).__val;
			  __top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_entry = 1;
			}	// arguments copied to call structure
		    }		// called function had entry flag set
		  if (__top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_entry
		      || __top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_in_progress)
		    {		// called function still in progress
// call the function
		      Is_Read_Access (__top->p1.reader._call_line_55_called_fn_struct->req, &(__top->p1.reader._call_line_55_called_fn_struct->flag));	//   file CacheMemory.aa, line 55
		      __top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_entry = 0;
		      __top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_in_progress = 0;
		      __top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_exit = 1;
		    }		// called function was in progress 
		  if (__top->p1.reader._call_line_55_called_fn_struct->Is_Read_Access_exit)
		    {
		      if (1)
			{
			  (__top->p1.reader.is_read).__val = __top->p1.reader._call_line_55_called_fn_struct->flag.__val;
			  cfree (__top->p1.reader._call_line_55_called_fn_struct);
			  __top->p1.reader._call_line_55_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			  __top->p1.reader._call_line_55_exit = 1;
			  __top->p1.reader._call_line_55_in_progress = 0;
			}	// ok to copy outputs to destinations?
		    }		// called function had finishes?
		}		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_55
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._call_line_55_exit)
		{
		  __top->p1.reader._call_line_55_exit = 0;
		  __top->p1.reader._if_line_56_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_56
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._if_line_56_entry)
		{
		  if (1)
		    {
		      if ((__top->p1.reader.is_read).__val)
			{
			  __top->p1.reader._if_line_56_entry = 0;
			  __top->p1.reader._if_line_56_in_progress = 1;
			  __top->p1.reader._call_line_57_entry = 1;
			}
		      else
			{
			  __top->p1.reader._if_line_56_entry = 0;
			  __top->p1.reader._if_line_56_in_progress = 1;
			  __top->p1.reader.extwrite.extwrite_entry = 1;
			}	// transfer control based on test condition
		    }		// proceed if pipe is available 
		}		// entry flag
	      if (__top->p1.reader._if_line_56_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_57
// -------------------------------------------------------------------------------------------
		  if (__top->p1.reader._call_line_57_entry)
		    {
		      if (__top->p1.reader._call_line_57_called_fn_struct == NULL)
			{
			  __top->p1.reader._call_line_57_called_fn_struct =
			    (Access_Address_State *) calloc (1, sizeof (Access_Address_State));
// reset entry flag and set in progress flag
			  __top->p1.reader._call_line_57_entry = 0;
			  __top->p1.reader._call_line_57_in_progress = 1;
			}	// allocation of pointer to called function
		    }		// entry into this call statement
		  if (__top->p1.reader._call_line_57_in_progress)
		    {
		      if (!__top->p1.reader._call_line_57_called_fn_struct->Access_Address_entry
			  && !__top->p1.reader._call_line_57_called_fn_struct->Access_Address_in_progress)
			{	// entry and in_progress flags not set?
			  if (1)
			    {	// check if pipes can be read from
			      __top->p1.reader._call_line_57_called_fn_struct->req.__val = (__top->p1.reader.req_pointer).__val;
			      __top->p1.reader._call_line_57_called_fn_struct->Access_Address_entry = 1;
			    }	// arguments copied to call structure
			}	// called function had entry flag set
		      if (__top->p1.reader._call_line_57_called_fn_struct->Access_Address_entry
			  || __top->p1.reader._call_line_57_called_fn_struct->Access_Address_in_progress)
			{	// called function still in progress
// call the function
			  Access_Address (__top->p1.reader._call_line_57_called_fn_struct->req, &(__top->p1.reader._call_line_57_called_fn_struct->addr));	//   file CacheMemory.aa, line 57
			  __top->p1.reader._call_line_57_called_fn_struct->Access_Address_entry = 0;
			  __top->p1.reader._call_line_57_called_fn_struct->Access_Address_in_progress = 0;
			  __top->p1.reader._call_line_57_called_fn_struct->Access_Address_exit = 1;
			}	// called function was in progress 
		      if (__top->p1.reader._call_line_57_called_fn_struct->Access_Address_exit)
			{
			  if (1 && !__top->read_address_pipe_valid__)
			    {
			      (__top->read_address_pipe).__val = __top->p1.reader._call_line_57_called_fn_struct->addr.__val;
			      __top->read_address_pipe_valid__ = 1;
			      cfree (__top->p1.reader._call_line_57_called_fn_struct);
			      __top->p1.reader._call_line_57_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			      __top->p1.reader._call_line_57_exit = 1;
			      __top->p1.reader._call_line_57_in_progress = 0;
			    }	// ok to copy outputs to destinations?
			}	// called function had finishes?
		    }		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_57
// -------------------------------------------------------------------------------------------
		  if (__top->p1.reader._call_line_57_exit)
		    {
		      __top->p1.reader._call_line_57_exit = 0;
		      __top->p1.reader._if_line_56_in_progress = 0;
		      __top->p1.reader._if_line_56_exit = 1;
		    }
		}
	      if (__top->p1.reader._if_line_56_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Block extwrite
// -------------------------------------------------------------------------------------------
		  if (__top->p1.reader.extwrite.extwrite_entry)
		    {
		      __top->p1.reader.extwrite.extwrite_entry = 0;
		      __top->p1.reader.extwrite.extwrite_in_progress = 1;
		      __top->p1.reader.extwrite._call_line_60_entry = 1;
		      __top->p1.reader.extwrite._call_line_61_entry = 1;
		    }
		  if (__top->p1.reader.extwrite.extwrite_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_60
// -------------------------------------------------------------------------------------------
		      if (__top->p1.reader.extwrite._call_line_60_entry)
			{
			  if (__top->p1.reader.extwrite._call_line_60_called_fn_struct == NULL)
			    {
			      __top->p1.reader.extwrite._call_line_60_called_fn_struct =
				(Access_Address_State *) calloc (1, sizeof (Access_Address_State));
// reset entry flag and set in progress flag
			      __top->p1.reader.extwrite._call_line_60_entry = 0;
			      __top->p1.reader.extwrite._call_line_60_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.reader.extwrite._call_line_60_in_progress)
			{
			  if (!__top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_entry
			      && !__top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_in_progress)
			    {	// entry and in_progress flags not set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.reader.extwrite._call_line_60_called_fn_struct->req.__val =
				    (__top->p1.reader.req_pointer).__val;
				  __top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_entry = 1;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (__top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_entry
			      || __top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_in_progress)
			    {	// called function still in progress
// call the function
			      Access_Address (__top->p1.reader.extwrite._call_line_60_called_fn_struct->req, &(__top->p1.reader.extwrite._call_line_60_called_fn_struct->addr));	//   file CacheMemory.aa, line 60
			      __top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_entry = 0;
			      __top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_in_progress = 0;
			      __top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.reader.extwrite._call_line_60_called_fn_struct->Access_Address_exit)
			    {
			      if (1 && !__top->write_address_pipe_valid__)
				{
				  (__top->write_address_pipe).__val =
				    __top->p1.reader.extwrite._call_line_60_called_fn_struct->addr.__val;
				  __top->write_address_pipe_valid__ = 1;
				  cfree (__top->p1.reader.extwrite._call_line_60_called_fn_struct);
				  __top->p1.reader.extwrite._call_line_60_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.reader.extwrite._call_line_60_exit = 1;
				  __top->p1.reader.extwrite._call_line_60_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_60
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_61
// -------------------------------------------------------------------------------------------
		      if (__top->p1.reader.extwrite._call_line_61_entry)
			{
			  if (__top->p1.reader.extwrite._call_line_61_called_fn_struct == NULL)
			    {
			      __top->p1.reader.extwrite._call_line_61_called_fn_struct =
				(Access_Data_State *) calloc (1, sizeof (Access_Data_State));
// reset entry flag and set in progress flag
			      __top->p1.reader.extwrite._call_line_61_entry = 0;
			      __top->p1.reader.extwrite._call_line_61_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.reader.extwrite._call_line_61_in_progress)
			{
			  if (!__top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_entry
			      && !__top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_in_progress)
			    {	// entry and in_progress flags not set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.reader.extwrite._call_line_61_called_fn_struct->req.__val =
				    (__top->p1.reader.req_pointer).__val;
				  __top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_entry = 1;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (__top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_entry
			      || __top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_in_progress)
			    {	// called function still in progress
// call the function
			      Access_Data (__top->p1.reader.extwrite._call_line_61_called_fn_struct->req, &(__top->p1.reader.extwrite._call_line_61_called_fn_struct->data));	//   file CacheMemory.aa, line 61
			      __top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_entry = 0;
			      __top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_in_progress = 0;
			      __top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.reader.extwrite._call_line_61_called_fn_struct->Access_Data_exit)
			    {
			      if (1 && !__top->write_data_pipe_valid__)
				{
				  (__top->write_data_pipe).__val =
				    __top->p1.reader.extwrite._call_line_61_called_fn_struct->data.__val;
				  __top->write_data_pipe_valid__ = 1;
				  cfree (__top->p1.reader.extwrite._call_line_61_called_fn_struct);
				  __top->p1.reader.extwrite._call_line_61_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.reader.extwrite._call_line_61_exit = 1;
				  __top->p1.reader.extwrite._call_line_61_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_61
// -------------------------------------------------------------------------------------------
		      if ((1 && __top->p1.reader.extwrite._call_line_61_exit && __top->p1.reader.extwrite._call_line_60_exit))
			{
			  __top->p1.reader.extwrite._call_line_60_exit = 0;
			  __top->p1.reader.extwrite._call_line_61_exit = 0;
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
		      __top->p1.reader._if_line_56_in_progress = 0;
		      __top->p1.reader._if_line_56_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _if_line_56
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._if_line_56_exit)
		{
		  __top->p1.reader._if_line_56_exit = 0;
		  __top->p1.reader._place_line_64_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_64
// -------------------------------------------------------------------------------------------
	      if (__top->p1.reader._place_line_64_entry)
		{
		  __top->p1.reader.loopback = 1;
		  __top->p1.reader._place_line_64_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_64
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.reader._merge_line_52_exit = 0;
		  __top->p1.reader._call_line_53_exit = 0;
		  __top->p1.reader._call_line_55_exit = 0;
		  __top->p1.reader._if_line_56_exit = 0;
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
	      __top->p1.writeport._merge_line_71_entry = 1;
	    }
	  if (__top->p1.writeport.writeport_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_71
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._merge_line_71_entry || __top->p1.writeport.loopback)
		{
		  if (__top->p1.writeport._merge_line_71_entry)
		    {
		      __top->p1.writeport._merge_line_71_entry = 0;
		      __top->p1.writeport._merge_line_71_from_entry = 1;
		    }
		  __top->p1.writeport._merge_line_71_in_progress = 1;
		}
	      if (__top->p1.writeport._merge_line_71_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.writeport.loopback = 0;
		      __top->p1.writeport._merge_line_71_from_entry = 0;
		      __top->p1.writeport._merge_line_71_in_progress = 0;
		      __top->p1.writeport._merge_line_71_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_71
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._merge_line_71_exit)
		{
		  __top->p1.writeport._merge_line_71_exit = 0;
		  __top->p1.writeport.getdetails.getdetails_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Block getdetails
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport.getdetails.getdetails_entry)
		{
		  __top->p1.writeport.getdetails.getdetails_entry = 0;
		  __top->p1.writeport.getdetails.getdetails_in_progress = 1;
		  __top->p1.writeport.getdetails._assign_line_73_entry = 1;
		  __top->p1.writeport.getdetails._assign_line_74_entry = 1;
		}
	      if (__top->p1.writeport.getdetails.getdetails_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_73
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport.getdetails._assign_line_73_entry)
		    {
		      if (1 && __top->write_address_pipe_valid__)
			{
			  (__top->p1.writeport.write_address).__val = (__top->write_address_pipe).__val;	//  file CacheMemory.aa, line 73
			  __top->write_address_pipe_valid__ = 0;
			  __top->p1.writeport.getdetails._assign_line_73_entry = 0;
			  __top->p1.writeport.getdetails._assign_line_73_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_73
// -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_74
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport.getdetails._assign_line_74_entry)
		    {
		      if (1 && __top->write_data_pipe_valid__)
			{
			  (__top->p1.writeport.write_data).__val = (__top->write_data_pipe).__val;	//  file CacheMemory.aa, line 74
			  __top->write_data_pipe_valid__ = 0;
			  __top->p1.writeport.getdetails._assign_line_74_entry = 0;
			  __top->p1.writeport.getdetails._assign_line_74_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_74
// -------------------------------------------------------------------------------------------
		  if ((1 && __top->p1.writeport.getdetails._assign_line_74_exit
		       && __top->p1.writeport.getdetails._assign_line_73_exit))
		    {
		      __top->p1.writeport.getdetails._assign_line_73_exit = 0;
		      __top->p1.writeport.getdetails._assign_line_74_exit = 0;
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
		  __top->p1.writeport._assign_line_76_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_76
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._assign_line_76_entry)
		{
		  if (1)
		    {
		      (__top->p1.writeport.addr).__val = __AND ((__top->p1.writeport.write_address).__val, (__top->map_mask).__val);	//  file CacheMemory.aa, line 76
		      __top->p1.writeport._assign_line_76_entry = 0;
		      __top->p1.writeport._assign_line_76_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_76
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._assign_line_76_exit)
		{
		  __top->p1.writeport._assign_line_76_exit = 0;
		  __top->p1.writeport._if_line_77_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_77
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._if_line_77_entry)
		{
		  if (1)
		    {
		      if ((__top->valid_array[(__top->p1.writeport.addr).__val]).__val)
			{
			  __top->p1.writeport._if_line_77_entry = 0;
			  __top->p1.writeport._if_line_77_in_progress = 1;
			  __top->p1.writeport._if_line_78_entry = 1;
			}
		      else
			{
			  __top->p1.writeport._if_line_77_entry = 0;
			  __top->p1.writeport._if_line_77_in_progress = 1;
			  __top->p1.writeport._assign_line_88_entry = 1;
			}	// transfer control based on test condition
		    }		// proceed if pipe is available 
		}		// entry flag
	      if (__top->p1.writeport._if_line_77_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_78
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._if_line_78_entry)
		    {
		      if (1)
			{
			  if (__EQUAL
			      ((__top->addr_array[(__top->p1.writeport.addr).__val]).__val,
			       (__top->p1.writeport.write_address).__val))
			    {
			      __top->p1.writeport._if_line_78_entry = 0;
			      __top->p1.writeport._if_line_78_in_progress = 1;
			      __top->p1.writeport._assign_line_80_entry = 1;
			    }
			  else
			    {
			      __top->p1.writeport._if_line_78_entry = 0;
			      __top->p1.writeport._if_line_78_in_progress = 1;
			      __top->p1.writeport._call_line_84_entry = 1;
			    }	// transfer control based on test condition
			}	// proceed if pipe is available 
		    }		// entry flag
		  if (__top->p1.writeport._if_line_78_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_80
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._assign_line_80_entry)
			{
			  if (1)
			    {
			      (__top->data_array[(__top->p1.writeport.addr).__val]).__val = (__top->p1.writeport.write_data).__val;	//  file CacheMemory.aa, line 80
			      __top->p1.writeport._assign_line_80_entry = 0;
			      __top->p1.writeport._assign_line_80_exit = 1;
			    }
			}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_80
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._assign_line_80_exit)
			{
			  __top->p1.writeport._assign_line_80_exit = 0;
			  __top->p1.writeport._call_line_81_entry = 1;
			}
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_81
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._call_line_81_entry)
			{
			  if (__top->p1.writeport._call_line_81_called_fn_struct == NULL)
			    {
			      __top->p1.writeport._call_line_81_called_fn_struct =
				(Write_Hit_State *) calloc (1, sizeof (Write_Hit_State));
// reset entry flag and set in progress flag
			      __top->p1.writeport._call_line_81_entry = 0;
			      __top->p1.writeport._call_line_81_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.writeport._call_line_81_in_progress)
			{
			  if (!__top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_entry
			      && !__top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_in_progress)
			    {	// entry and in_progress flags not set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.writeport._call_line_81_called_fn_struct->addr.__val =
				    (__top->p1.writeport.write_address).__val;
				  __top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_entry = 1;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (__top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_entry
			      || __top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_in_progress)
			    {	// called function still in progress
// call the function
			      Write_Hit (__top->p1.writeport._call_line_81_called_fn_struct->addr);	//   file CacheMemory.aa, line 81
			      __top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_entry = 0;
			      __top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_in_progress = 0;
			      __top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.writeport._call_line_81_called_fn_struct->Write_Hit_exit)
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
			  __top->p1.writeport._assign_line_80_exit = 0;
			  __top->p1.writeport._call_line_81_exit = 0;
			  __top->p1.writeport._if_line_78_in_progress = 0;
			  __top->p1.writeport._if_line_78_exit = 1;
			}
		    }
		  if (__top->p1.writeport._if_line_78_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_84
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._call_line_84_entry)
			{
			  if (__top->p1.writeport._call_line_84_called_fn_struct == NULL)
			    {
			      __top->p1.writeport._call_line_84_called_fn_struct =
				(Write_Miss_State *) calloc (1, sizeof (Write_Miss_State));
// reset entry flag and set in progress flag
			      __top->p1.writeport._call_line_84_entry = 0;
			      __top->p1.writeport._call_line_84_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.writeport._call_line_84_in_progress)
			{
			  if (!__top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_entry
			      && !__top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_in_progress)
			    {	// entry and in_progress flags not set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.writeport._call_line_84_called_fn_struct->addr.__val =
				    (__top->p1.writeport.write_address).__val;
				  __top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_entry = 1;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (__top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_entry
			      || __top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_in_progress)
			    {	// called function still in progress
// call the function
			      Write_Miss (__top->p1.writeport._call_line_84_called_fn_struct->addr);	//   file CacheMemory.aa, line 84
			      __top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_entry = 0;
			      __top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_in_progress = 0;
			      __top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.writeport._call_line_84_called_fn_struct->Write_Miss_exit)
			    {
			      if (1)
				{
				  cfree (__top->p1.writeport._call_line_84_called_fn_struct);
				  __top->p1.writeport._call_line_84_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.writeport._call_line_84_exit = 1;
				  __top->p1.writeport._call_line_84_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_84
// -------------------------------------------------------------------------------------------
		      if (__top->p1.writeport._call_line_84_exit)
			{
			  __top->p1.writeport._call_line_84_exit = 0;
			  __top->p1.writeport._if_line_78_in_progress = 0;
			  __top->p1.writeport._if_line_78_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _if_line_78
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._if_line_78_exit)
		    {
		      __top->p1.writeport._if_line_78_exit = 0;
		      __top->p1.writeport._if_line_77_in_progress = 0;
		      __top->p1.writeport._if_line_77_exit = 1;
		    }
		}
	      if (__top->p1.writeport._if_line_77_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_88
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_88_entry)
		    {
		      if (1)
			{
			  (__top->data_array[(__top->p1.writeport.addr).__val]).__val = (__top->p1.writeport.write_data).__val;	//  file CacheMemory.aa, line 88
			  __top->p1.writeport._assign_line_88_entry = 0;
			  __top->p1.writeport._assign_line_88_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_88
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_88_exit)
		    {
		      __top->p1.writeport._assign_line_88_exit = 0;
		      __top->p1.writeport._assign_line_89_entry = 1;
		    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_89
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_89_entry)
		    {
		      if (1)
			{
			  (__top->valid_array[(__top->p1.writeport.addr).__val]).__val = 1;	//  file CacheMemory.aa, line 89
			  __top->p1.writeport._assign_line_89_entry = 0;
			  __top->p1.writeport._assign_line_89_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_89
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_89_exit)
		    {
		      __top->p1.writeport._assign_line_89_exit = 0;
		      __top->p1.writeport._assign_line_90_entry = 1;
		    }
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_90
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_90_entry)
		    {
		      if (1)
			{
			  (__top->addr_array[(__top->p1.writeport.addr).__val]).__val = (__top->p1.writeport.write_address).__val;	//  file CacheMemory.aa, line 90
			  __top->p1.writeport._assign_line_90_entry = 0;
			  __top->p1.writeport._assign_line_90_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_90
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._assign_line_90_exit)
		    {
		      __top->p1.writeport._assign_line_90_exit = 0;
		      __top->p1.writeport._call_line_91_entry = 1;
		    }
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_91
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._call_line_91_entry)
		    {
		      if (__top->p1.writeport._call_line_91_called_fn_struct == NULL)
			{
			  __top->p1.writeport._call_line_91_called_fn_struct =
			    (Write_Hit_State *) calloc (1, sizeof (Write_Hit_State));
// reset entry flag and set in progress flag
			  __top->p1.writeport._call_line_91_entry = 0;
			  __top->p1.writeport._call_line_91_in_progress = 1;
			}	// allocation of pointer to called function
		    }		// entry into this call statement
		  if (__top->p1.writeport._call_line_91_in_progress)
		    {
		      if (!__top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_entry
			  && !__top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_in_progress)
			{	// entry and in_progress flags not set?
			  if (1)
			    {	// check if pipes can be read from
			      __top->p1.writeport._call_line_91_called_fn_struct->addr.__val =
				(__top->p1.writeport.write_address).__val;
			      __top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_entry = 1;
			    }	// arguments copied to call structure
			}	// called function had entry flag set
		      if (__top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_entry
			  || __top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_in_progress)
			{	// called function still in progress
// call the function
			  Write_Hit (__top->p1.writeport._call_line_91_called_fn_struct->addr);	//   file CacheMemory.aa, line 91
			  __top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_entry = 0;
			  __top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_in_progress = 0;
			  __top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_exit = 1;
			}	// called function was in progress 
		      if (__top->p1.writeport._call_line_91_called_fn_struct->Write_Hit_exit)
			{
			  if (1)
			    {
			      cfree (__top->p1.writeport._call_line_91_called_fn_struct);
			      __top->p1.writeport._call_line_91_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			      __top->p1.writeport._call_line_91_exit = 1;
			      __top->p1.writeport._call_line_91_in_progress = 0;
			    }	// ok to copy outputs to destinations?
			}	// called function had finishes?
		    }		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_91
// -------------------------------------------------------------------------------------------
		  if (__top->p1.writeport._call_line_91_exit)
		    {
		      __top->p1.writeport._assign_line_88_exit = 0;
		      __top->p1.writeport._assign_line_89_exit = 0;
		      __top->p1.writeport._assign_line_90_exit = 0;
		      __top->p1.writeport._call_line_91_exit = 0;
		      __top->p1.writeport._if_line_77_in_progress = 0;
		      __top->p1.writeport._if_line_77_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _if_line_77
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._if_line_77_exit)
		{
		  __top->p1.writeport._if_line_77_exit = 0;
		  __top->p1.writeport._place_line_93_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_93
// -------------------------------------------------------------------------------------------
	      if (__top->p1.writeport._place_line_93_entry)
		{
		  __top->p1.writeport.loopback = 1;
		  __top->p1.writeport._place_line_93_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_93
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.writeport._merge_line_71_exit = 0;
		  __top->p1.writeport.getdetails.getdetails_exit = 0;
		  __top->p1.writeport._assign_line_76_exit = 0;
		  __top->p1.writeport._if_line_77_exit = 0;
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
	      __top->p1.readport._merge_line_99_entry = 1;
	    }
	  if (__top->p1.readport.readport_in_progress)
	    {
// -------------------------------------------------------------------------------------------
// Begin Block _merge_line_99
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._merge_line_99_entry || __top->p1.readport.loopback)
		{
		  if (__top->p1.readport._merge_line_99_entry)
		    {
		      __top->p1.readport._merge_line_99_entry = 0;
		      __top->p1.readport._merge_line_99_from_entry = 1;
		    }
		  __top->p1.readport._merge_line_99_in_progress = 1;
		}
	      if (__top->p1.readport._merge_line_99_in_progress)
		{
		  if (1)
		    {
		      // clear the place flag 
		      __top->p1.readport.loopback = 0;
		      __top->p1.readport._merge_line_99_from_entry = 0;
		      __top->p1.readport._merge_line_99_in_progress = 0;
		      __top->p1.readport._merge_line_99_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Block _merge_line_99
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._merge_line_99_exit)
		{
		  __top->p1.readport._merge_line_99_exit = 0;
		  __top->p1.readport._assign_line_100_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_100
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._assign_line_100_entry)
		{
		  if (1 && __top->read_address_pipe_valid__)
		    {
		      (__top->p1.readport.read_address).__val = (__top->read_address_pipe).__val;	//  file CacheMemory.aa, line 100
		      __top->read_address_pipe_valid__ = 0;
		      __top->p1.readport._assign_line_100_entry = 0;
		      __top->p1.readport._assign_line_100_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_100
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._assign_line_100_exit)
		{
		  __top->p1.readport._assign_line_100_exit = 0;
		  __top->p1.readport._assign_line_101_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_101
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._assign_line_101_entry)
		{
		  if (1)
		    {
		      (__top->p1.readport.addr).__val = __AND ((__top->p1.readport.read_address).__val, (__top->map_mask).__val);	//  file CacheMemory.aa, line 101
		      __top->p1.readport._assign_line_101_entry = 0;
		      __top->p1.readport._assign_line_101_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _assign_line_101
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._assign_line_101_exit)
		{
		  __top->p1.readport._assign_line_101_exit = 0;
		  __top->p1.readport._if_line_102_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_102
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._if_line_102_entry)
		{
		  if (1)
		    {
		      if ((__top->valid_array[(__top->p1.readport.addr).__val]).__val)
			{
			  __top->p1.readport._if_line_102_entry = 0;
			  __top->p1.readport._if_line_102_in_progress = 1;
			  __top->p1.readport._if_line_103_entry = 1;
			}
		      else
			{
			  __top->p1.readport._if_line_102_entry = 0;
			  __top->p1.readport._if_line_102_in_progress = 1;
			  __top->p1.readport._call_line_112_entry = 1;
			}	// transfer control based on test condition
		    }		// proceed if pipe is available 
		}		// entry flag
	      if (__top->p1.readport._if_line_102_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _if_line_103
// -------------------------------------------------------------------------------------------
		  if (__top->p1.readport._if_line_103_entry)
		    {
		      if (1)
			{
			  if (__EQUAL
			      ((__top->addr_array[(__top->p1.readport.addr).__val]).__val, (__top->p1.readport.read_address).__val))
			    {
			      __top->p1.readport._if_line_103_entry = 0;
			      __top->p1.readport._if_line_103_in_progress = 1;
			      __top->p1.readport._call_line_105_entry = 1;
			    }
			  else
			    {
			      __top->p1.readport._if_line_103_entry = 0;
			      __top->p1.readport._if_line_103_in_progress = 1;
			      __top->p1.readport._call_line_108_entry = 1;
			    }	// transfer control based on test condition
			}	// proceed if pipe is available 
		    }		// entry flag
		  if (__top->p1.readport._if_line_103_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_105
// -------------------------------------------------------------------------------------------
		      if (__top->p1.readport._call_line_105_entry)
			{
			  if (__top->p1.readport._call_line_105_called_fn_struct == NULL)
			    {
			      __top->p1.readport._call_line_105_called_fn_struct =
				(Read_Hit_State *) calloc (1, sizeof (Read_Hit_State));
// reset entry flag and set in progress flag
			      __top->p1.readport._call_line_105_entry = 0;
			      __top->p1.readport._call_line_105_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.readport._call_line_105_in_progress)
			{
			  if (!__top->p1.readport._call_line_105_called_fn_struct->Read_Hit_entry
			      && !__top->p1.readport._call_line_105_called_fn_struct->Read_Hit_in_progress)
			    {	// entry and in_progress flags not set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.readport._call_line_105_called_fn_struct->addr.__val =
				    (__top->p1.readport.read_address).__val;
				  __top->p1.readport._call_line_105_called_fn_struct->data.__val =
				    (__top->data_array[(__top->p1.readport.addr).__val]).__val;
				  __top->p1.readport._call_line_105_called_fn_struct->Read_Hit_entry = 1;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (__top->p1.readport._call_line_105_called_fn_struct->Read_Hit_entry
			      || __top->p1.readport._call_line_105_called_fn_struct->Read_Hit_in_progress)
			    {	// called function still in progress
// call the function
			      Read_Hit (__top->p1.readport._call_line_105_called_fn_struct->addr, __top->p1.readport._call_line_105_called_fn_struct->data);	//   file CacheMemory.aa, line 105
			      __top->p1.readport._call_line_105_called_fn_struct->Read_Hit_entry = 0;
			      __top->p1.readport._call_line_105_called_fn_struct->Read_Hit_in_progress = 0;
			      __top->p1.readport._call_line_105_called_fn_struct->Read_Hit_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.readport._call_line_105_called_fn_struct->Read_Hit_exit)
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
			  __top->p1.readport._if_line_103_in_progress = 0;
			  __top->p1.readport._if_line_103_exit = 1;
			}
		    }
		  if (__top->p1.readport._if_line_103_in_progress)
		    {
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_108
// -------------------------------------------------------------------------------------------
		      if (__top->p1.readport._call_line_108_entry)
			{
			  if (__top->p1.readport._call_line_108_called_fn_struct == NULL)
			    {
			      __top->p1.readport._call_line_108_called_fn_struct =
				(Read_Miss_State *) calloc (1, sizeof (Read_Miss_State));
// reset entry flag and set in progress flag
			      __top->p1.readport._call_line_108_entry = 0;
			      __top->p1.readport._call_line_108_in_progress = 1;
			    }	// allocation of pointer to called function
			}	// entry into this call statement
		      if (__top->p1.readport._call_line_108_in_progress)
			{
			  if (!__top->p1.readport._call_line_108_called_fn_struct->Read_Miss_entry
			      && !__top->p1.readport._call_line_108_called_fn_struct->Read_Miss_in_progress)
			    {	// entry and in_progress flags not set?
			      if (1)
				{	// check if pipes can be read from
				  __top->p1.readport._call_line_108_called_fn_struct->addr.__val =
				    (__top->p1.readport.read_address).__val;
				  __top->p1.readport._call_line_108_called_fn_struct->Read_Miss_entry = 1;
				}	// arguments copied to call structure
			    }	// called function had entry flag set
			  if (__top->p1.readport._call_line_108_called_fn_struct->Read_Miss_entry
			      || __top->p1.readport._call_line_108_called_fn_struct->Read_Miss_in_progress)
			    {	// called function still in progress
// call the function
			      Read_Miss (__top->p1.readport._call_line_108_called_fn_struct->addr);	//   file CacheMemory.aa, line 108
			      __top->p1.readport._call_line_108_called_fn_struct->Read_Miss_entry = 0;
			      __top->p1.readport._call_line_108_called_fn_struct->Read_Miss_in_progress = 0;
			      __top->p1.readport._call_line_108_called_fn_struct->Read_Miss_exit = 1;
			    }	// called function was in progress 
			  if (__top->p1.readport._call_line_108_called_fn_struct->Read_Miss_exit)
			    {
			      if (1)
				{
				  cfree (__top->p1.readport._call_line_108_called_fn_struct);
				  __top->p1.readport._call_line_108_called_fn_struct = NULL;
// reset in progress flag and set exit flag
				  __top->p1.readport._call_line_108_exit = 1;
				  __top->p1.readport._call_line_108_in_progress = 0;
				}	// ok to copy outputs to destinations?
			    }	// called function had finishes?
			}	// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_108
// -------------------------------------------------------------------------------------------
		      if (__top->p1.readport._call_line_108_exit)
			{
			  __top->p1.readport._call_line_108_exit = 0;
			  __top->p1.readport._if_line_103_in_progress = 0;
			  __top->p1.readport._if_line_103_exit = 1;
			}
		    }
// -------------------------------------------------------------------------------------------
// End Statement _if_line_103
// -------------------------------------------------------------------------------------------
		  if (__top->p1.readport._if_line_103_exit)
		    {
		      __top->p1.readport._if_line_103_exit = 0;
		      __top->p1.readport._if_line_102_in_progress = 0;
		      __top->p1.readport._if_line_102_exit = 1;
		    }
		}
	      if (__top->p1.readport._if_line_102_in_progress)
		{
// -------------------------------------------------------------------------------------------
// Begin Statement _call_line_112
// -------------------------------------------------------------------------------------------
		  if (__top->p1.readport._call_line_112_entry)
		    {
		      if (__top->p1.readport._call_line_112_called_fn_struct == NULL)
			{
			  __top->p1.readport._call_line_112_called_fn_struct =
			    (Read_Miss_State *) calloc (1, sizeof (Read_Miss_State));
// reset entry flag and set in progress flag
			  __top->p1.readport._call_line_112_entry = 0;
			  __top->p1.readport._call_line_112_in_progress = 1;
			}	// allocation of pointer to called function
		    }		// entry into this call statement
		  if (__top->p1.readport._call_line_112_in_progress)
		    {
		      if (!__top->p1.readport._call_line_112_called_fn_struct->Read_Miss_entry
			  && !__top->p1.readport._call_line_112_called_fn_struct->Read_Miss_in_progress)
			{	// entry and in_progress flags not set?
			  if (1)
			    {	// check if pipes can be read from
			      __top->p1.readport._call_line_112_called_fn_struct->addr.__val =
				(__top->p1.readport.read_address).__val;
			      __top->p1.readport._call_line_112_called_fn_struct->Read_Miss_entry = 1;
			    }	// arguments copied to call structure
			}	// called function had entry flag set
		      if (__top->p1.readport._call_line_112_called_fn_struct->Read_Miss_entry
			  || __top->p1.readport._call_line_112_called_fn_struct->Read_Miss_in_progress)
			{	// called function still in progress
// call the function
			  Read_Miss (__top->p1.readport._call_line_112_called_fn_struct->addr);	//   file CacheMemory.aa, line 112
			  __top->p1.readport._call_line_112_called_fn_struct->Read_Miss_entry = 0;
			  __top->p1.readport._call_line_112_called_fn_struct->Read_Miss_in_progress = 0;
			  __top->p1.readport._call_line_112_called_fn_struct->Read_Miss_exit = 1;
			}	// called function was in progress 
		      if (__top->p1.readport._call_line_112_called_fn_struct->Read_Miss_exit)
			{
			  if (1)
			    {
			      cfree (__top->p1.readport._call_line_112_called_fn_struct);
			      __top->p1.readport._call_line_112_called_fn_struct = NULL;
// reset in progress flag and set exit flag
			      __top->p1.readport._call_line_112_exit = 1;
			      __top->p1.readport._call_line_112_in_progress = 0;
			    }	// ok to copy outputs to destinations?
			}	// called function had finishes?
		    }		// statement was in progress
// -------------------------------------------------------------------------------------------
// End Statement _call_line_112
// -------------------------------------------------------------------------------------------
		  if (__top->p1.readport._call_line_112_exit)
		    {
		      __top->p1.readport._call_line_112_exit = 0;
		      __top->p1.readport._if_line_102_in_progress = 0;
		      __top->p1.readport._if_line_102_exit = 1;
		    }
		}
// -------------------------------------------------------------------------------------------
// End Statement _if_line_102
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._if_line_102_exit)
		{
		  __top->p1.readport._if_line_102_exit = 0;
		  __top->p1.readport._place_line_114_entry = 1;
		}
// -------------------------------------------------------------------------------------------
// Begin Statement _place_line_114
// -------------------------------------------------------------------------------------------
	      if (__top->p1.readport._place_line_114_entry)
		{
		  __top->p1.readport.loopback = 1;
		  __top->p1.readport._place_line_114_entry = 0;
		}
// -------------------------------------------------------------------------------------------
// End Statement _place_line_114
// -------------------------------------------------------------------------------------------
	      if (0)
		{
		  __top->p1.readport._merge_line_99_exit = 0;
		  __top->p1.readport._assign_line_100_exit = 0;
		  __top->p1.readport._assign_line_101_exit = 0;
		  __top->p1.readport._if_line_102_exit = 0;
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
