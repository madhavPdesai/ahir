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

void vcModule::Print_VHDL_Inarg_Level_Forks(ostream& ofile)
{
}

void vcModule::Print_VHDL_Outarg_Level_Joins(ostream& ofile)
{
}

void vcModule::Print_VHDL_Sample_Pulse_To_Level(ostream& ofile)
{
}

void vcModule::Print_VHDL_Update_Level_To_Pulse(ostream& ofile)
{
}

void vcModule::Print_VHDL_Level_Architecture(ostream& ofile)
{
	if(this->_foreign_flag)
		return;

	assert(this->_control_path);

	string arch_name = this->Get_VHDL_Architecture_Name();
	string entity_name = this->Get_VHDL_Entity_Name();

	ofile << "architecture " << arch_name << " of " << entity_name << " is -- {" << endl;

	// always true signal
	ofile << "-- always true..." << endl;

	if(this->Get_Operator_Flag())
	{
		ofile << "signal " << this->_control_path->Get_Always_True_Symbol() 
									<< ": Boolean;" << endl;
		ofile << "signal update_ack_symbol: Boolean;" << endl;
		ofile << "signal default_zero_sig: std_logic;" << endl;

		// level start/fin signals..
		ofile << "signal start_req, start_ack, fin_req, fin_ack: std_logic;" << endl;
	}

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

		if(!w->Is_Constant())
		{
			at_least_one_non_constant = true;
		}

	}

	if(!at_least_one_non_constant &&  this->Get_Pipeline_Flag() && !this->Get_Volatile_Flag())
	{
		vcSystem::Error("Pipelined module " + this->Get_Label() + " must have at least one non-constant output.");
	}


	ofile << "-- volatile/operator module components. " << endl;
	for(set<vcModule*>::iterator mciter = _called_modules.begin(), fmciter = _called_modules.end();
			mciter != fmciter; mciter++)
	{
		vcModule* mc = *mciter;

		// if this is operator, mc must be volatile or operator.
		if(!mc->Get_Level_Flag())
		{
			vcSystem::Error("module " + mc->Get_Label() + " called from level module " + this->Get_Label()
					+ " is not a level module");
		}

		if(!mc->Get_Is_Function_Library_Module())
			mc->Print_VHDL_Component(ofile);
		else
			ofile << "-- function library module " << mc->Get_Label() << " component not printed." << endl;
	}

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

		
	// TODO: in operator case, print pulse->level and level->pulse converts.
	if(this->Get_Operator_Flag())
	{
		this->Print_VHDL_Sample_Pulse_To_Level(ofile);
		this->Print_VHDL_Update_Level_To_Pulse(ofile);
	}



	ofile << "-- input handling ------------------------------------------------" << endl;
	{
		this->Print_VHDL_Inarg_Level_Forks(ofile);
		for(int idx = 0, fidx = inarg_wires.size(); idx < fidx; idx++)
		{
			vcWire* w = inarg_wires[idx];
			ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_VHDL_Id() << ";" << endl;
		}

		// TODO: print 

	}
	ofile << "-- output handling  -------------------------------------------------------" << endl;
	{
		int H = 0;
		int nouts = 0;

		this->Print_VHDL_Outarg_Level_Joins(ofile);
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
	}
	ofile << endl;

	assert(this->_data_path != NULL);
	ofile << "-- the data path" << endl;

	
	//
	//  When printing the data-path, we will first declare
	//  level protocol signals for each wire: These will
	//  be a pair of req/ack signals for each wire->dpe 
	//  connection in the data-path.
	//
	//  Further for each wire, we will instantiate a 
	//  level fork which generates req/ack pairs for
	//  each fanout, based on the req/ack pair of the
	//  dpe driving the wire.
	//
	//  The rest of the logic of the datapath is the
	//  same as before.
	//
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
