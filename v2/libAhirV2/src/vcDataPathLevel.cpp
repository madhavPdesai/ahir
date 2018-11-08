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
#include <vcControlPath.hpp>
#include <vcOperator.hpp>
#include <vcMemorySpace.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>

  
//
// Print the latching stage for the wire..
//
//   The latching is performed if the 
//   inputs to the dpe driving the wire
//   are also valid
// 
//   We expect that either all in-wires are
//   valid or none are valid..  This needs
//   to be checked, so we put an assertion.
//
void vcWire::Print_VHDL_Level_Repeater(string stall_sig, ostream& ofile)
{
	ofile << "-------------------------------------------------------------------------------------" << endl;
	ofile << "-- Wire " << this->Get_VHDL_Id() << endl;
	ofile << "-------------------------------------------------------------------------------------" << endl;

	// constants don't need anything..
	if(this->Is_Constant())
		return;

	vcDatapathElement* dpe = this->Get_Driver();
	if(dpe == NULL)
	// null dpe, do nothing and return.
	{
		return;
	}
	
	// how many delays in the repeater?
	int bufsize    = dpe->Get_Output_Buffering (this);

	// valid sigs.  v_sig is a repeated version of vin_sig.
 	string vin_sig = this->Get_VHDL_Signal_Id() + "_valid_rptr_in";
 	string v_sig   = this->Get_VHDL_Signal_Id() + "_valid";

	// expression for vin_sig
	string v_string = "(";
	bool f = true;

	// there can be a guard which will enable the
	// repeater..   note if enable is true, valid
	// is forwarded but data wire values are not 	
	// updated.
	string enable_string = "constant_one_1";
	vcWire* gw = dpe->Get_Guard_Wire();
	if ((gw != NULL) && !gw->Is_Constant() && !dpe->Get_Guard_WAR_Flag())
	{
		f = false;
		string gw_valid =  gw->Get_VHDL_Signal_Id() + "_valid"; 
		v_string += gw_valid;

		//
		// The assertion.. either all inputs to the dpe are valid
		// or none are valid..
		//
		ofile << "assert (not (clk'event and clk = '0')) or (" << vin_sig << " = " << gw_valid << ") report \"valid flag (guard) mismatch for wire " + this->Get_VHDL_Id() + "\" severity error;" << endl; 

		if(dpe->Get_Guard_Complement())
			enable_string = "not " + gw->Get_VHDL_Signal_Id() + "(0)";
		else
			enable_string =  gw->Get_VHDL_Signal_Id() + "(0)";
	
	}

	//
	// for the other inputs... note that WAR connections are ignored..
	//
	for (int I=0, fI=dpe->Get_Number_Of_Input_Wires(); I < fI; I++)
	{
		vcWire* iw = dpe->Get_Input_Wire(I);
		if(!iw->Is_Constant() && !dpe->Get_Input_WAR_Flag(I))
		{
			
			if(!f) v_string += " and ";
			string iw_valid =  iw->Get_VHDL_Signal_Id() + "_valid"; 
			v_string +=  iw_valid;

			f = false;

			ofile << "assert (not (clk'event and clk = '0')) or (" << vin_sig << " = " << iw_valid << ") report \"valid flag mismatch (" << I << ") for wire " + this->Get_VHDL_Signal_Id() << "\" severity error;" << endl; 
		}
	}

	v_string += ")";

	// this is the valid for the repeater..
	if(!f)
	  ofile << vin_sig << " <= " << v_string << ";" << endl;

	// f flag = true implies wire dpe has no useful inputs.
	if(f)
	{
		vcSystem::Error("wire " + this->Get_VHDL_Signal_Id() + 
				" has no non-trivial, non-WAR wires on which it depends");
		return;
	}

	
	// now instantiate the repeater.
	if(dpe->Get_Flow_Through())
	{
		ofile << "-- flow-through dpe, pass valids, values" << endl;
		ofile << v_sig << " <= " << vin_sig << ";" << endl;
		ofile << this->Get_VHDL_Signal_Id() << " <= " << this->Get_VHDL_Level_Rptr_In_Id() << ";" << endl;
	}
	else
	{
		ofile << "-- non-flow-through dpe, pass valids, values through repeater" << endl;
		vcWire* gw = dpe->Get_Guard_Wire();
		string rptr_name = this->Get_VHDL_Id() + "_rptr";
			
		if((gw != NULL) && dpe->Get_Guard_Complement())
		{
			ofile << rptr_name << "_block: block -- { " <<endl;
			ofile << "signal compl_guard_enable: std_logic; --}" << endl;
			ofile << "begin --{" << endl;
			ofile << "compl_guard_enable <= " << enable_string << ";" << endl;
			enable_string = "compl_guard_enable";
		}
		// repeater.
		ofile << rptr_name << ": LevelRepeater --{" << endl;
		ofile << "generic map (name => \"" << rptr_name << "\","
				<< " g_data_width => " << this->Get_Size() << ","
				<< " g_depth => " << bufsize << ")" << endl;
		ofile << "port map (clk=>clk, reset=>reset,"
				<< " enable => " << enable_string << ","
				<< " data_in => " << this->Get_VHDL_Level_Rptr_In_Id() << ","
				<< " data_out => " << this->Get_VHDL_Signal_Id() << ","
				<< " valid_in => " << vin_sig << ","
				<< " valid_out => " << v_sig << ","
				<< " stall => " << stall_sig << "); --}" << endl;

		if((gw != NULL) && dpe->Get_Guard_Complement())
		{
			ofile << "-- }" << endl;
			ofile << "end block;" << endl;
		}
	}
	ofile << "-------------------------------------------------------------------------------------" << endl;
}


bool vcDataPath::Is_Legal_In_Level_Module(vcDatapathElement* dpe)
{
	bool ret_val = false;
  	string kind = dpe->Kind();
	if( (kind == "vcEquivalence") ||
		(kind == "vcBinarySplitOperator") ||
		(kind == "vcUnarySplitOperator") ||
		(kind == "vcSelect") ||
		((kind == "vcCall") && 
			(dpe->Get_Flow_Through() || dpe->Is_Deterministic_Pipeline_Operator())) ||
		(kind == "vcRegister") ||
		(kind == "vcInterlockBuffer") ||
		(kind == "vcSlice") ||
		(kind == "vcPermutation"))
	{
		ret_val = !dpe->Is_Floating_Point_Dpe();
	}

	return(ret_val);
}


				
int vcDataPath::Get_Driving_Dpe_Buffering(vcWire* w)
{
	int ret_val = 0;
	vcDatapathElement* dpe = w->Get_Driver();
	if(dpe != NULL)
	{
		ret_val = dpe->Get_Output_Buffering(w);
	}
	return(ret_val);
}

		

void vcDataPath::Print_VHDL_Level(string stall_sig, ostream& ofile)
{
	set<vcDatapathElement*> printed_dpe_set;
	ofile << "data_path: Block -- { " << endl;
	

	// print wires.
	for(map<string, vcWire*>::iterator iter = _wire_map.begin();
			iter != _wire_map.end();
			iter++)
	{
		vcWire* w = (*iter).second;
		ofile << "signal " << w->Get_VHDL_Level_Rptr_In_Id() << ": "
			<< " std_logic_vector(" << w->Get_Size()-1 << " downto 0);" << endl;
		w->Print_VHDL_Std_Logic_Declaration(ofile);

		ofile << "signal " << w->Get_VHDL_Signal_Id() << "_valid_rptr_in: std_logic;" << endl;
		ofile << "signal " << w->Get_VHDL_Id() << "_valid: std_logic;" << endl;
	}

	ofile << "-- }" << endl << "begin -- { " << endl;

	// for output wires of the parent module
	for(int I = 0, fI = this->Get_Parent()->Get_Number_Of_Output_Arguments(); I < fI; I++)
	{
		vcWire* ow = this->Get_Parent()->Get_Output_Wire(I);
		this->Print_VHDL_Level_For_Wire(printed_dpe_set, ow,stall_sig,ofile);
	}

	// wires in the data path.
	for(map<string, vcWire*>::iterator iter = _wire_map.begin();
			iter != _wire_map.end();
			iter++)
	{
		vcWire* w = (*iter).second;
		this->Print_VHDL_Level_For_Wire(printed_dpe_set, w,stall_sig,ofile);
	}

	ofile << "-- }" << endl << "end Block; -- data_path" << endl;
	printed_dpe_set.clear();
}

void vcDataPath::Print_VHDL_Level_For_Wire(set<vcDatapathElement*>& printed_dpe_set, vcWire* w, string stall_sig, ostream& ofile)
{	
	if(w->Is("vcConstantWire"))
	{
		ofile << w->Get_VHDL_Signal_Id() << " <= " 
			<< ((vcConstantWire*)w)->Get_Value()->To_VHDL_String() << ";" << endl;
	}
	else
	{
		vcDatapathElement* dpe = w->Get_Driver();
		if((dpe != NULL) && (printed_dpe_set.find(dpe) == printed_dpe_set.end()))
		{
			if(dpe->Is_Deterministic_Pipeline_Operator())
				dpe->Print_Deterministic_Pipeline_Operator_VHDL(stall_sig, ofile);
			else
				dpe->Print_Flow_Through_VHDL(true,ofile);
			printed_dpe_set.insert(dpe);
		}

		// deterministic pipeline operator will have 	
		// at least one unit of delay.
		if(!dpe->Is_Deterministic_Pipeline_Operator())
			w->Print_VHDL_Level_Repeater(stall_sig, ofile);
	}
}
