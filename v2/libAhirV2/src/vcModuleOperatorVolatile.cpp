//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcValue.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcOperator.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>

  
void vcModule::Print_VHDL_Operator_Entity(ostream& ofile)
{
  ofile << "entity " << this->Get_VHDL_Entity_Name() << " is -- {" << endl;
  ofile << "port ( -- {" << endl;
  ofile << "  sample_req: in boolean;" << endl;
  ofile << "  sample_ack: out boolean;" << endl;
  ofile << "  update_req: in boolean;" << endl;
  ofile << "  update_ack: out boolean;" << endl;
  string sc = this->Print_VHDL_Argument_Ports("", ofile);
  if(this->_data_path != NULL)
  {
	// these are checks.  if ports are found, an error will be flagged
  	sc = this->_data_path->Print_VHDL_Memory_Interface_Ports(sc, ofile);
        sc = this->_data_path->Print_VHDL_IO_Interface_Ports(sc, ofile);
        sc = this->_data_path->Print_VHDL_Call_Interface_Ports(sc, ofile);
  }
  ofile << sc << endl;
  ofile << "clk, reset: in std_logic" << endl;
  ofile << "-- } " << endl << ");" << endl;
  ofile << "-- }" << endl << "end entity " << this->Get_VHDL_Entity_Name() << ";" << endl;
}

void vcModule::Print_VHDL_Operator_Component(ostream& ofile)
{
	ofile << "component " << this->Get_VHDL_Entity_Name() << " is -- {" << endl;
	ofile << "port ( -- {" << endl;
	ofile << "  sample_req: in boolean;" << endl;
	ofile << "  sample_ack: out boolean;" << endl;
	ofile << "  update_req: in boolean;" << endl;
	ofile << "  update_ack: out boolean;" << endl;
	string sc = this->Print_VHDL_Argument_Ports("", ofile);
	if(this->_data_path != NULL)
	{
		// these are checks.  if ports are found, an error will be flagged
		sc = this->_data_path->Print_VHDL_Memory_Interface_Ports(sc, ofile);
		sc = this->_data_path->Print_VHDL_IO_Interface_Ports(sc, ofile);
		sc = this->_data_path->Print_VHDL_Call_Interface_Ports(sc, ofile);
	}
  	ofile << sc << endl;
	ofile << "  clk, reset: in std_logic" << endl;
	ofile << "-- } " << endl << ");" << endl;
	ofile << "-- }" << endl << "end component;" << endl;

}

void vcModule::Print_VHDL_Volatile_Entity(ostream& ofile)
{
	ofile << "entity " << this->Get_VHDL_Entity_Name() << " is -- {" << endl;
	ofile << "port ( -- {" << endl;
  	if(vcSystem::_enable_logging)
	  ofile << " clk, reset: in std_logic; " << endl;
	string sc = this->Print_VHDL_Argument_Ports("", ofile);
	ofile << "-- } " << endl << ");" << endl;
	ofile << "-- }" << endl << "end entity " << this->Get_VHDL_Entity_Name() << ";" << endl;
}



void vcModule::Print_VHDL_Volatile_Component(ostream& ofile)
{
  ofile << "component " << this->Get_VHDL_Entity_Name() << " is -- {" << endl;
  ofile << "port ( -- {" << endl;
  if(vcSystem::_enable_logging)
	  ofile << " clk, reset: in std_logic; " << endl;
  string sc = this->Print_VHDL_Argument_Ports("", ofile);
  if(this->_data_path != NULL)
  {
	  // these are checks.  if ports are found, an error will be flagged
	  sc = this->_data_path->Print_VHDL_Memory_Interface_Ports(sc, ofile);
	  sc = this->_data_path->Print_VHDL_IO_Interface_Ports(sc, ofile);
	  sc = this->_data_path->Print_VHDL_Call_Interface_Ports(sc, ofile);
  }
  ofile << "-- } " << endl << ");" << endl;
  ofile << "-- }" << endl << "end component; " << endl;
}

void vcModule::Print_VHDL_Operator_Architecture(ostream& ofile)
{
	if(this->_foreign_flag)
		return;

	assert(this->_control_path);

	string arch_name = this->Get_VHDL_Architecture_Name();
	string entity_name = this->Get_VHDL_Entity_Name();

	ofile << "architecture " << arch_name << " of " << entity_name << " is -- {" << endl;

	// always true signal
	ofile << "-- always true..." << endl;

	ofile << "signal " << this->_control_path->Get_Always_True_Symbol() << ": Boolean;" << endl;
	ofile << "signal update_ack_symbol: Boolean;" << endl;
	ofile << "signal default_zero_sig: std_logic;" << endl;

	// input port buffer signals.
	ofile << "-- input port buffer signals" << endl;
	vector<vcWire*> inarg_wires;
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		int wsize = w->Get_Type()->Size();

		inarg_wires.push_back(w);

		ofile << "signal " << w->Get_VHDL_Signal_Id() << " : " 
			<<  " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;

		// all inarg_reenable signals must be joined
		// to produce input_sample_reenable!
		// input-sample-reenable will unload from the
		// input buffer.
		string ue_sig =  w->Get_VHDL_Id() + "_update_enable";
		string ue_sigu =  w->Get_VHDL_Id() + "_update_enable_unmarked";

		ofile << "signal " << ue_sig << ": Boolean;" << endl;
		ofile << "signal " << ue_sigu << ": Boolean;" << endl;

	}

	// output port buffer signals.
	ofile << "-- output port buffer signals" << endl;
	vector<vcWire*> outarg_wires;
	bool at_least_one_non_constant = false;
	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{
		vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
		outarg_wires.push_back(w);

		ofile << "signal " << w->Get_VHDL_Signal_Id() << " : " 
			<<  " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;

		// exit of CP will trigger write to the output-buffer..
		// TODO: completion of write to output-buffer must
		//       be used to reenable all output updates in 
		//       pipelined body.
		if(!w->Is_Constant())
		{
			ofile << "signal " << w->Get_VHDL_Id() << "_update_enable: Boolean;" << endl;
			at_least_one_non_constant = true;
		}

	}

	if(!at_least_one_non_constant &&  this->Get_Pipeline_Flag() && !this->Get_Volatile_Flag())
	{
		vcSystem::Error("Pipelined operator module " + this->Get_Label() + " must have at least one non-constant output.");
	}




	// control-path start symbol
	string cp_entry_symbol = this->_control_path->Get_Start_Symbol();
	string cp_exit_symbol  = this->_control_path->Get_Exit_Symbol();
	string cp_inputs_sampled_signal  = "cp_all_inputs_sampled";

	ofile << "signal " << cp_entry_symbol << ": Boolean;" << endl;
	ofile << "signal " << cp_exit_symbol << ": Boolean;" << endl;
	ofile << "signal " << cp_inputs_sampled_signal << ": Boolean;" << endl;



	ofile << "-- volatile/operator module components. " << endl;
	for(set<vcModule*>::iterator mciter = _called_modules.begin(), fmciter = _called_modules.end();
			mciter != fmciter; mciter++)
	{
		vcModule* mc = *mciter;

		// if this is operator, mc must be volatile or operator.
		if(!(mc->Get_Volatile_Flag() || mc->Get_Operator_Flag()))
		{
			vcSystem::Error("module " + mc->Get_Label() + " called from operator module " + this->Get_Label()
					+ " is not volatile/operator");
		}

		if(!mc->Get_Is_Function_Library_Module())
			mc->Print_VHDL_Component(ofile);
		else
			ofile << "-- function library module " << mc->Get_Label() << " component not printed." << endl;
	}

	// print link signals between CP and DP
	ofile << "-- links between control-path and data-path" << endl;
	for(set<vcTransition*>::iterator iter = _linked_transition_set.begin();
			iter != _linked_transition_set.end();
			iter++)
	{
		if((*iter)->Get_Is_Input())
			ofile << "signal " << (*iter)->Get_DP_To_CP_Symbol() << " : boolean;" << endl;
		else if((*iter)->Get_Is_Output()) 
			ofile << "signal " << (*iter)->Get_CP_To_DP_Symbol() << " : boolean;" << endl;
	}
	ofile << endl;

	// print link signals between DP and Memories within the module
	// note: operators can also have internal memory spaces.
	for(map<string, vcMemorySpace*>::iterator iter = _memory_space_map.begin();
			iter != _memory_space_map.end();
			iter++)
	{
		// error checking will happen here.
		(*iter).second->Print_VHDL_Interface_Signal_Declarations(ofile);
	}

	if(vcSystem::_enable_logging)
	{
		ofile << "signal global_clock_cycle_count: integer := 0;" << endl;
	}

	ofile << "-- }" << endl << "begin --  {" << endl;

	if(vcSystem::_enable_logging)
	{
		ofile << " ---------------------------------------------------------- " << endl;
		ofile << "process(clk)  " << endl;
		ofile << "begin -- { " << endl;
		ofile << "  if(clk'event and clk = '1') then -- { " << endl;
		ofile << "    if(reset = '1') then -- { " << endl;
		ofile << "       global_clock_cycle_count <= 0; --} " << endl;
		ofile << "    else -- { " << endl;
		ofile << "       global_clock_cycle_count <= global_clock_cycle_count + 1; -- }" << endl;
		ofile << "    end if; --} " << endl;
		ofile << "  end if; --} " << endl;
		ofile << "end process;" << endl;
		ofile << " ---------------------------------------------------------- " << endl;
	}


	// sample-ack generation logic.
	if(this->_pipeline_flag)
	{
		ofile << "-- sample-ack is join of  cp-entry-symbol and all-inputs-sampled " << endl;
		ofile << "sample_ack <= " << cp_inputs_sampled_signal << ";" << endl;
	}
	else
	{
		ofile << "sample_ack <= " << cp_exit_symbol <<  ";"  << endl;
	}

	ofile << "-- input handling ------------------------------------------------" << endl;
	{
		for(int idx = 0, fidx = inarg_wires.size(); idx < fidx; idx++)
		{
			vcWire* w = inarg_wires[idx];
			ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_VHDL_Id() << ";" << endl;
		}

		// In a non-volatile module, there are two distinct cases:
		//    In the pipeline case, 
		//             the unload_req_symbol is a join with the following predecessors
		//                  -  marked predecessor: unload_ack_symbol (self-release, 0-delay)
		//                  -  unmarked predecessor: input_update_enable  (in pipeline case only, 0-delay).
		//                  -  marked predecessor (with initial marking of pipeline-depth) input_sample_reenable_symbol
		//    The non-pipeline case
		//             the read_req_symbol is a join with the following predecessors
		//                  -  marked predecessor: unload_ack_symbol (self-release, 0-delay)
		//                  -  marked predecessor (with initial marking of 1) input_sample_reenable_symbol
		{
			vector<string> preds;
			vector<int>    pred_markings;
			vector<int>    pred_capacities;
			vector<int>    pred_delays;

			vector<string> ipreds;
			vector<int>    ipred_markings;
			vector<int>    ipred_capacities;
			vector<int>    ipred_delays;

			// sample req triggers the CP.
			preds.push_back("sample_req");
			pred_capacities.push_back(1);
			pred_markings.push_back(0);
			pred_delays.push_back(0); // revisit later..
			

			int ninputs = 0;
			if(this->_pipeline_flag)
			{
				preds.push_back("update_ack_symbol");
				pred_capacities.push_back(this->Get_Pipeline_Depth());
				pred_markings.push_back(this->Get_Pipeline_Depth());
				pred_delays.push_back(1); // revisit later..

				// in the pipeline case, need re-enable 
				// after each input has been sampled.
				for(int idx = 0, fidx = inarg_wires.size(); idx < fidx; idx++)
				{
					vcWire* w = inarg_wires[idx];

					// if wire is not used, then it is ignored.
					// because it's update is  never enabled..
					if(w->Get_Number_Of_Receivers() == 0) 
					{
						continue;
					}
					else
						ninputs++;

					ipreds.push_back(w->Get_VHDL_Id() + "_update_enable_unmarked");
					ipred_capacities.push_back(this->Get_Pipeline_Depth());
					ipred_markings.push_back(0);
					ipred_delays.push_back(0); // revisit later..
				}

				if(ninputs == 0)
				{
					vcSystem::Error("in pipelined operator module " + this->Get_Id() + ", no input is actually used in the module");
				}

				string joined_symbol = cp_entry_symbol;
				ofile << "-- join of sample-req and update-ack-symbol.. used to trigger CP." << endl;
				Print_VHDL_Join(joined_symbol + "_join", 
						preds,
						pred_markings,
						pred_capacities, 
						pred_delays, 
						joined_symbol,
						ofile);

				ofile << "-- join of all input-sampled signals.. used to produce sample_ack." << endl;
				joined_symbol = cp_inputs_sampled_signal;
				Print_VHDL_Join(joined_symbol + "_join", 
						ipreds,
						ipred_markings,
						ipred_capacities, 
						ipred_delays, 
						joined_symbol,
						ofile);
				ofile << endl;
			}
			else
			{
				//
				// join sample_req and update_req 
				// to trigger the control path.
				//
				preds.push_back("update_req");
				pred_capacities.push_back(1);
				pred_markings.push_back(0);
				pred_delays.push_back(0); // revisit later..

				ofile << "-- join of sample-req and update-req.. used to trigger CP." << endl;
				Print_VHDL_Join(cp_entry_symbol + "_join", 
						preds,
						pred_markings,
						pred_capacities, 
						pred_delays, 
						cp_entry_symbol,
						ofile);
			}
		}

	}
	ofile << "-- output handling  -------------------------------------------------------" << endl;
	{
		int H = 0;
		int nouts = 0;

		for(int idx = 0, fidx = outarg_wires.size(); idx < fidx; idx++)
		{
			vcOutputWire* w = (vcOutputWire*) outarg_wires[idx];
			int wsize  = w->Get_Type()->Size();

			if(w->Is_Constant())
				ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_Value()->To_VHDL_String() << ";" << endl;
			ofile << w->Get_VHDL_Id() << " <= " << w->Get_VHDL_Signal_Id() << ";"  << endl;

			if(w->Get_Number_Of_Drivers() == 0)
				continue;
			else
				nouts++;


			// update req from the outside world is the consumer.
			// NOTE: do not make this connection if w is a constant
			//       you will induce a combinational cycle.
			if(!w->Is_Constant())
				ofile << w->Get_VHDL_Id() << "_update_enable <= update_req;" << endl;

		}

		if(this->_pipeline_flag && (nouts == 0))
		{
			vcSystem::Error("in pipelined operator module " + this->Get_Id() + ", no output is actually driven in the module");
		}

		ofile << "update_ack_symbol <= " << cp_exit_symbol << ";" << endl;
		ofile << "update_ack <= update_ack_symbol;" << endl;
	}
	ofile << endl;

	// logging.
	if(vcSystem::_enable_logging)
	{
		ofile << "--- logging ------------------------------------------------------" << endl;
		string sreq_symbol_name =  '"'  +  this->Get_VHDL_Id() + " cp_entry_symbol " + '"';
		ofile << "LogCPEvent(clk,reset,global_clock_cycle_count," << cp_entry_symbol << "," <<  sreq_symbol_name << ");" << endl;


		string cack_symbol_name =  '"'  +  this->Get_VHDL_Id() + " cp_exit_symbol " + '"';
		ofile << "LogCPEvent(clk,reset,global_clock_cycle_count," << cp_exit_symbol << ", " <<  cack_symbol_name << ");" << endl;
	} 

	ofile << "-- the control path --------------------------------------------------" << endl;
	// the always true signal, tied to true..
	ofile << ((vcCPElement*)(this->_control_path))->Get_Always_True_Symbol() << " <= true; " << endl;
	ofile << "default_zero_sig <= '0';" << endl;

	if(vcSystem::_opt_flag)
		this->_control_path->Print_VHDL_Optimized(ofile);
	else
		this->_control_path->Print_VHDL(ofile);

	ofile << endl << endl;

	assert(this->_data_path != NULL);
	ofile << "-- the data path" << endl;
	this->_data_path->Print_VHDL(ofile);

	ofile << endl;

	for(map<string,vcMemorySpace*>::iterator iter = _memory_space_map.begin();
			iter != _memory_space_map.end();
			iter++)
	{
		vcMemorySpace* ms  = (*iter).second;
		ms->Print_VHDL_Instance(ofile);
	}

	ofile << "-- }" << endl << "end " << arch_name << ";" << endl;
}
