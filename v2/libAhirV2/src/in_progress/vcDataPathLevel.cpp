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

	vcDatapathElement* dpe = w->Get_Driver();
	if(dpe == NULL)
	// null dpe, do nothing and return.
	{
		return;
	}
	
	// how many delays in the repeater?
	int bufsize    = dpe->Get_Outwire_Buffering (this);

	// valid sigs.  v_sig is a repeated version of vin_sig.
 	string vin_sig = w->Get_VHDL_Signal_Id() + "_valid_rptr_in";
 	string v_sig   = w->Get_VHDL_Id() + "_valid";

	// expression for vin_sig
	string v_string = "(";
	bool f = true;

	// there can be a guard which will enable the
	// repeater..   note if enable is true, valid
	// is forwarded but data wire values are not 	
	// updated.
	string enable_string = "module_constant_one_1";
	vcWire* gw = dpe->Get_Guard_Wire();
	if ((gw != NULL) && !gw->Is_Constant())
	{
		f = false;
		string gw_valid =  gw->Get_VHDL_Signal_Id() + "_valid"; 
		v_string += gw_valid;

		//
		// The assertion.. either all inputs to the dpe are valid
		// or none are valid..
		//
		ofile << "assert (" << vin_sig << " = " << gw_valid << ") report valid flag (guard) mismatch for wire " + w->Get_VHDL_Id() " severity error;" << endl; 
		enable_string = gw->Get_VHDL_Signal_Id();
	}

	//
	// for the other inputs...
	//
	for (int I=0, fI=dpe->Get_Number_Of_Input_Wires(); I < fI; I++)
	{
		vcWire* iw = dpe->Get_Input_Wire(I);
		if(!iw->Is_Constant())
		{
			
			if(!f) v_string += " & ";
			string iw_valid =  iw->Get_VHDL_Signal_Id() + "_valid"; 
			v_string +=  iw_valid;
			

			ofile << "assert (" << vin_sig << " = " << iw_valid << ") report valid flag mismatch (" << I << ") for wire " + w->Get_VHDL_Signal_Id() " severity error;" << endl; 
		}
		f = false;
	}

	v_string += ")";

	// this is the valid for the repeater..
	if(!f)
	  ofile << vin_sig << " << " << v_string << ");" << endl;

	// f_flag = true implies wire dpe has no useful inputs.
	if(f_flag)
	{
		vcSystem::Error("wire " + this->Get_VHDL_Signal_Id() + 
				" has no non-trivial wires on which it depends");
		return;
	}

	
	// now instantiate the repeater.
	if(dpe->Get_Flow_Through())
	{
		ofile << "-- flow-through dpe, pass valids, values" << endl;
		ofile << v_sig << " <= " << vin_sig ";" << endl;
		w->Get_VHDL_Id() << " <= " << w->Get_VHDL_Level_Rptr_In_Id();
	}
	else
	{
		ofile << "-- non-flow-through dpe, pass valids, values through repeater" << endl;
		// repeater.
		string rptr_name = w->Get_VHDL_Id() + "_rptr";
		ofile << rptr_name << ": LevelRepeater --{" << endl;
		ofile << "generic map (name => " << w->Get_VHDL_Id() + "_rptr,"
				<< " g_data_width => " << w->Get_Size() << ","
				<< " g_depth => " << bufsize << ")" << endl;
		ofile << "port map (clk=>clk, reset=>reset, data_in => "
				<< w->Get_VHDL_Level_Rptr_In_Id() << ","
				<< " data_out => " << w->Get_VHDL_Signal_Id() << ","
				<< " valid_in => " << vin_sig << ","
				<< " valid_out => " << v_sig << ","
				<< " stall => " << stall_sig << "); --}" << endl;
	}
	ofile << "-------------------------------------------------------------------------------------" << endl;
}


bool vcDataPath::Is_Legal_In_Level_Module(vcDatpathElement* dpe)
{
	bool ret_val = false;
  	string kind = dpe->Kind();
	if( (kind == "vcEquivalence") ||
		(kind == "vcBinarySplitOperator") ||
		(kind == "vcUnarySplitOperator") ||
		(kind == "vcSelect") ||
		((kind == "vcCall") && dpe->Get_Flow_Through()) ||
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

		ofile << w->Get_VHDL_Signal_Id() << "_valid_rptr_in: std_logic;" << endl;
		ofile << w->Get_VHDL_Id() << "_valid: std_logic;" << endl;
	}

	ofile << "-- }" << endl << "begin -- { " << endl;


	// tie constant wires to their values.
	for(map<string, vcWire*>::iterator iter = _wire_map.begin();
			iter != _wire_map.end();
			iter++)
	{
		vcWire* w = (*iter).second;
		this->Print_VHDL_For_Wire(w,stall_sig,ofile);
	}

	ofile << "-- }" << endl << "end Block; -- data_path" << endl;
}

void vcDataPath::Print_VHDL_For_Wire(vcWire* w, string stall_sig, ostream& ofile)
{	
	if(w->Is("vcConstantWire"))
	{
		ofile << w->Get_VHDL_Signal_Id() << " <= " 
			<< ((vcConstantWire*)w)->Get_Value()->To_VHDL_String() << ";" << endl;
	}
	else
	{
		vcDatapathElement* dpe = w->Get_Driver();
		if(dpe != NULL)
		{
			dpe->Print_Flow_Through_VHDL(w->Get_VHDL_Signal_Id() + "_in",ofile);
			w->Print_VHDL_Level_Repeater(stall_sig, ofile);
		}
	}
}
