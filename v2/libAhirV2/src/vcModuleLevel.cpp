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


void Print_VHDL_Sample_Pulse_To_Level(string mod_name,
						string sample_req, string sample_ack,
						string start_req, string start_ack,
						ostream& ofile)
{
	ofile << "p2l: Sample_Pulse_To_Level_Translate_Entity -- {" << endl;
	ofile << "  generic map (name => \"" <<  mod_name << ":p2l\")" << endl;
	ofile << "  port map (rL => " << sample_req << ", aL => " << sample_ack << ", " << endl;
	ofile << "            rR => " << start_req << ", aR => " << start_ack << "," << endl;
	ofile << "            clk => clk, reset => reset); -- }" << endl;
}

void Print_VHDL_Update_Stall_To_Pulse(string mod_name,
						string valid_sig, string stall_sig, 
						string update_req, string update_ack,
						ostream& ofile)
{
	ofile << "s2p: Stall_To_Pulse_Translate_Entity -- {" << endl;
	ofile << "  generic map (name => \"" << mod_name << ":s2p\")" << endl;
	ofile << "  port map (valid_in => " << valid_sig 
		<< ", stall_out => " <<  stall_sig <<  ", " << endl;
	ofile << "              rR => " << update_req << ", aR => " << update_ack << ", clk => clk, reset => reset); -- }" << endl;
}

void vcModule::Print_VHDL_Level_Architecture(ostream& ofile)
{
	if(this->_foreign_flag)
		return;

	assert(this->_control_path);


	string arch_name = this->Get_VHDL_Architecture_Name()  + "_level";
	string entity_name = this->Get_VHDL_Entity_Name();

	ofile << "architecture " << arch_name << " of " << entity_name << " is -- {" << endl;

	ofile << "-- always 1/0..." << endl;
	ofile << "signal constant_one_1 : std_logic; " << endl;
	ofile << "signal constant_zero_1 : std_logic; " << endl;

	string stall_sig = this->Get_VHDL_Id() + "_stall";
        ofile << "signal " << stall_sig << ": std_logic;" << endl;

	string module_valid_sig = this->Get_VHDL_Id() + "_valid";
        ofile << "signal " << module_valid_sig << ": std_logic;" << endl;

	int tag_depth = this->Get_Delay();
	if(this->Get_Operator_Flag())
	{
		ofile << "signal " << this->_control_path->Get_Always_True_Symbol() 
									<< ": Boolean;" << endl;
		ofile << "signal update_ack_symbol: Boolean;" << endl;
		ofile << "signal default_zero_sig: std_logic;" << endl;

		// level start signals..
		ofile << "signal start_req, start_ack: std_logic;" << endl;
	}
	else
	{
	
		tag_depth = tag_depth - 2;
		ofile << "signal tag_valid_in, tag_valid: std_logic;" << endl;
	}

	string sample_req = "sample_req";
	string sample_ack = "sample_ack";

	string update_req = "update_req";
	string update_ack = "update_ack";

	string start_req = "start_req";
	string start_ack = "start_ack";

	string fin_req = "fin_req";
	string fin_ack = "fin_ack";

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
		ofile << "signal " << w->Get_VHDL_Signal_Id() << "_valid : std_logic;" << endl;
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
			ofile << "signal " << w->Get_VHDL_Level_Rptr_In_Id() << " : " 
				<<  " std_logic_vector(" << w->Get_Type()->Size()-1 
				<< " downto 0);" << endl;

			at_least_one_non_constant = true;
		
			ofile << "signal " << w->Get_VHDL_Signal_Id() << "_valid_rptr_in : std_logic;" << endl;
			ofile << "signal " << w->Get_VHDL_Signal_Id() << "_valid : std_logic;" << endl;
		}
	}

	if(!at_least_one_non_constant)
	{
		vcSystem::Error("Level module " + this->Get_Label() + " must have at least one non-constant output.");
	}


	if(vcSystem::_enable_logging)
	{
		ofile << "signal global_clock_cycle_count: integer := 0;" << endl;
	}

	this->Print_VHDL_Called_Module_Components(ofile);

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

		
	ofile << "constant_one_1 <= '1';" << endl;
	ofile << "constant_zero_1 <= '0';" << endl;

	ofile << "-- stall related to start_ack . " << endl;
	ofile << "start_ack <= not " << stall_sig << ";" << endl;

	if(this->Get_Operator_Flag())
	{
		ofile << "-- protocol converters in operator mode.." << endl;
		Print_VHDL_Sample_Pulse_To_Level(entity_name, sample_req,sample_ack,start_req, start_ack,
								ofile); 
		Print_VHDL_Update_Stall_To_Pulse(entity_name, module_valid_sig, stall_sig,
								update_req, update_ack, ofile); 
	}
	else
	{

		ofile << "-- valid,stall related to fin_ack/req in non-operator mode. " << endl;
		ofile << "fin_ack <= " << module_valid_sig << ";" << endl;
		ofile << stall_sig << " <= (not fin_req) and " << module_valid_sig << ";" << endl;

		// print tag repeater.
		ofile << "tag_valid_in <= start_req;" << endl;
		ofile << "tagRptr: LevelRepeater generic map (name => \"tagRptr\","
			<< " g_data_width => tag_length,"
			<< " g_depth => " << tag_depth << ")" << endl;
		ofile << "  port map (clk => clk, reset=> reset, enable => constant_one_1, data_in => tag_in, valid_in => tag_valid_in, data_out => tag_out, valid_out => tag_valid, stall => " << stall_sig << ");" << endl;

		ofile << "assert (tag_valid =" << module_valid_sig << ") report \"tag valid mismatch\""
			<< " severity error;" << endl;
	}

	ofile << "-- input handling ------------------------------------------------" << endl;
	{
		for(int idx = 0, fidx = inarg_wires.size(); idx < fidx; idx++)
		{
			vcWire* w = inarg_wires[idx];
			ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_VHDL_Id() << ";" << endl;
			ofile << w->Get_VHDL_Signal_Id() << "_valid <= start_req;" << endl;
		}
	}
	ofile << "-- output handling  -------------------------------------------------------" << endl;
	{
		vector<vcWire*> non_triv_outs;
		for(int idx = 0, fidx = outarg_wires.size(); idx < fidx; idx++)
		{
			vcOutputWire* w = (vcOutputWire*) outarg_wires[idx];

			if(w->Is_Constant())
			{
				ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_Value()->To_VHDL_String() << ";" << endl;
			}
			else if(w->Get_Number_Of_Drivers() == 0)
				continue;
			else
			{
				non_triv_outs.push_back(w);
				ofile << w->Get_VHDL_Id() << " <= " << w->Get_VHDL_Signal_Id() << ";"  
					<< endl;
			}
		}

		if(non_triv_outs.size() == 0)
		{
			vcSystem::Error("in level module " + this->Get_Id() + ", no output is actually driven in the module");
		}
		else
		{

			// an output buffer.
			string valid_assgn;
			valid_assgn = module_valid_sig + " <= ";
			for(int idx = 0, fidx = non_triv_outs.size(); idx < fidx; idx++)
			{
				vcWire* ntw = non_triv_outs[idx];
				if(idx > 0)
					valid_assgn += " and ";
				string sig_v_sig = ntw->Get_VHDL_Signal_Id() + "_valid";
				valid_assgn += sig_v_sig;

				ofile << "assert " + module_valid_sig + " = " + sig_v_sig + " report ";
				ofile << "\"  valid-mismatch for " 
						<<  sig_v_sig + "\"  severity error;" << endl;
			}
			valid_assgn += ";" ;
			ofile << valid_assgn << endl;
		}
	}
	ofile << endl;

	assert(this->_data_path != NULL);
	ofile << "-- the data path" << endl;


	//
	//  When printing the data-path, we will declare
	//  valid signals for each wire: 
	//
	//  For each wire, we generate a level repeater.
	//
	this->_data_path->Print_VHDL_Level(stall_sig, ofile);

	ofile << endl;

	ofile << "-- }" << endl << "end " << arch_name << ";" << endl;
}
