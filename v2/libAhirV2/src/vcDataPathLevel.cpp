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
#include <BGLWrap.hpp>

  
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
	int det_pipeline_level = this->Get_Deterministic_Level();

	ofile << "-------------------------------------------------------------------------------------" << endl;
	ofile << "-- Repeater for Wire " << this->Get_VHDL_Id() << endl;
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
	int bufsize    = dpe->Get_Deterministic_Pipeline_Delay();
	int L = (det_pipeline_level - bufsize)+1;

	string local_stall_sig = stall_sig + "(" + IntToStr(L) + " to "  + IntToStr(det_pipeline_level) + 
			")";


	bool f = true;

	string enable_string = "constant_one_1";
	vcWire* gw = dpe->Get_Guard_Wire();
	if ((gw != NULL) && !gw->Is_Constant() && !dpe->Get_Guard_WAR_Flag())
	{
		int guard_slack = dpe->Get_Guard_Slack();
		if(dpe->Get_Guard_Complement())
			enable_string = "not " + gw->Get_VHDL_Deterministic_Delayed_Id(guard_slack) + "(0)";
		else
			enable_string =  gw->Get_VHDL_Deterministic_Delayed_Id(guard_slack) + "(0)";

	}

	//
	// for the other inputs... note that WAR connections are ignored..
	//
	for (int I=0, fI=dpe->Get_Number_Of_Input_Wires(); I < fI; I++)
	{
		vcWire* iw = dpe->Get_Input_Wire(I);
		if(!iw->Is_Constant() && !dpe->Get_Input_WAR_Flag(I))
		{
			f = false;
		}
	}


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
		ofile << rptr_name << ": SquashLevelRepeater --{" << endl;
		ofile << "generic map (name => \"" << rptr_name << "\","
			<< " g_data_width => " << this->Get_Size() << ","
			<< " g_depth => " << bufsize << ")" << endl;
		ofile << "port map (clk=>clk, reset=>reset,"
			<< " enable => " << enable_string << ","
			<< " data_in => " << this->Get_VHDL_Level_Rptr_In_Id() << ","
			<< " data_out => " << this->Get_VHDL_Signal_Id() << ","
			<< " stall_vector => " << local_stall_sig << "); --}" << endl;

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


void vcDataPath::Calculate_Wire_Slacks(std::map<vcWire*, std::set<int> >& wire_slack_map)
{
	vector<vcWire*> wire_vec;
	int longest_path = this->Get_Parent()->Get_Deterministic_Longest_Path();

	for(int I = 0, fI = this->Get_Parent()->Get_Number_Of_Output_Arguments(); I < fI; I++)
	{
		vcWire* ow = this->Get_Parent()->Get_Output_Wire(I);
		int ow_slack = longest_path - ow->Get_Deterministic_Level();

		wire_slack_map[ow].insert(ow_slack);
		wire_vec.push_back(ow);
	}
	for(map<string, vcWire*>::iterator iter = _wire_map.begin();
			iter != _wire_map.end();
			iter++)
	{
		vcWire* w = (*iter).second;
		wire_vec.push_back(w);
	}
	
	for(int I = 0, fI = wire_vec.size(); I < fI; I++)
	{
		vcWire* w  = wire_vec[I];
		vcDatapathElement* dpe = w->Get_Driver();

		if(dpe != NULL)
		{
			int dpe_delay =  (dpe->Get_Flow_Through() ? 0 : 
						dpe->Get_Deterministic_Pipeline_Delay());
				
			for(int J = 0, fJ = dpe->Get_Number_Of_Input_Wires(); J < fJ; J++)
			{
				vcWire* fiw = dpe->Get_Input_Wire(J);
				if(!dpe->Get_Input_WAR_Flag(J) && !fiw->Is_Constant() && (fiw != w))
				{
					int slack = dpe->Get_Input_Slack(J);
					wire_slack_map[fiw].insert(slack);
				}	
			}		
			if(dpe->Get_Guard_Wire() != NULL)
			{
				vcWire* gw = dpe->Get_Guard_Wire();
				int slack = dpe->Get_Guard_Slack();
				wire_slack_map[gw].insert(slack);
			}
		}
	}
}



void vcDataPath::Print_VHDL_Level(string stall_sig, ostream& ofile)
{
	this->_estimated_buffering_bits = 0;

	// set the longest path...
	if(this->Get_Parent()->Get_Deterministic_Longest_Path() < 0)
	{
		this->Get_Parent()->Calculate_And_Set_Deterministic_Longest_Path();
	}
	

	set<vcDatapathElement*> printed_dpe_set;
	ofile << "data_path: Block -- { " << endl;

	map<vcWire*,set<int> > wire_slack_map;
	this->Calculate_Wire_Slacks(wire_slack_map);

	// print wires.
	for(map<string, vcWire*>::iterator iter = _wire_map.begin();
			iter != _wire_map.end();
			iter++)
	{
		vcWire* w = (*iter).second;
		ofile << "signal " << w->Get_VHDL_Level_Rptr_In_Id() << ": "
			<< " std_logic_vector(" << w->Get_Size()-1 << " downto 0);" << endl;
		w->Print_VHDL_Std_Logic_Declaration(ofile);
	}
	
	for(map<vcWire*, set<int> >::iterator miter = wire_slack_map.begin(),fmiter = wire_slack_map.end();
			miter != fmiter; miter++)
	{
		vcWire* w = (*miter).first;
		for(set<int>::iterator iter = wire_slack_map[w].begin(), fiter = wire_slack_map[w].end();
			iter != fiter; iter++)
		{
			int slack = *iter;
			if(slack > 0)
			{
			    ofile << "signal " << w->Get_VHDL_Deterministic_Delayed_Id(slack) << " : "
				<< " std_logic_vector(" << w->Get_Size()-1 << " downto 0);" << endl;
			}
		}
	}

	ofile << "-- }" << endl << "begin -- { " << endl;

	// for input wires of the parent module
	for(int I = 0, fI = this->Get_Parent()->Get_Number_Of_Input_Arguments(); I < fI; I++)
	{
		vcWire* iw = this->Get_Parent()->Get_Input_Wire(I);
		this->Print_VHDL_Level_For_Wire(printed_dpe_set, wire_slack_map, iw,stall_sig,ofile);
        }

	// for output wires of the parent module
	for(int I = 0, fI = this->Get_Parent()->Get_Number_Of_Output_Arguments(); I < fI; I++)
	{
		vcWire* ow = this->Get_Parent()->Get_Output_Wire(I);
		this->Print_VHDL_Level_For_Wire(printed_dpe_set, wire_slack_map, ow,stall_sig,ofile);
	}

	// wires in the data path.
	for(map<string, vcWire*>::iterator iter = _wire_map.begin();
			iter != _wire_map.end();
			iter++)
	{
		vcWire* w = (*iter).second;
		this->Print_VHDL_Level_For_Wire(printed_dpe_set, wire_slack_map, w,stall_sig,ofile);
	}

	ofile << "-- }" << endl << "end Block; -- data_path" << endl;
	printed_dpe_set.clear();
	vcSystem::Info("estimated buffering in module " + this->Get_Parent()->Get_VHDL_Id() + " is " +
					IntToStr(this->_estimated_buffering_bits));

	if(!this->Get_Parent()->Get_Operator_Flag())
		vcSystem::_estimated_buffering_bits += this->_estimated_buffering_bits;

}

void vcDataPath::Print_VHDL_Level_For_Wire(set<vcDatapathElement*>& printed_dpe_set,
					map<vcWire*, set<int> >& wire_slack_map,
					 vcWire* w, string stall_sig, ostream& ofile)
{	
	int buffering_added = 0;
	if(w->Is("vcConstantWire"))
	{
		ofile << w->Get_VHDL_Signal_Id() << " <= " 
			<< ((vcConstantWire*)w)->Get_Value()->To_VHDL_String() << ";" << endl;
	}
	else
	{
		vcDatapathElement* dpe = w->Get_Driver();
		if(dpe != NULL) {
			ofile << "-------------------------------------------------------------------------------------" << endl;
			ofile << "-- Data-path logic driving wire " << w->Get_VHDL_Id() << endl;
			ofile << "-------------------------------------------------------------------------------------" << endl;
		}

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
		int dpe_buffering = 0;
		if((dpe != NULL) && !dpe->Is_Deterministic_Pipeline_Operator())
		{
			w->Print_VHDL_Level_Repeater(stall_sig, ofile);
			dpe_buffering = (dpe->Get_Flow_Through() ? 0 : 1);
			if(dpe_buffering > 0)
			{
				vcSystem::Info("estimated buffering for operator " + 
							dpe->Get_VHDL_Id() +  " = " 
							+ IntToStr(dpe_buffering));
			}
		}
		else if((dpe != NULL) && dpe->Is_Deterministic_Pipeline_Operator())
		{
			dpe_buffering = dpe->Estimate_Buffering_Bits();
		}

		if(dpe_buffering > 0)
		{
			this->_estimated_buffering_bits += dpe_buffering;
		}

		// print the deterministic-delay repeaters..
		if(wire_slack_map.find(w) != wire_slack_map.end())
		{
			int last_slack_point = 0;

			for(set<int>::iterator iter = wire_slack_map[w].begin(), 
					fiter = wire_slack_map[w].end();
					iter != fiter; iter++)
			{
				int curr_slack_point = *iter;
				if(curr_slack_point > 0)
				{
					ofile << "-------------------------------------------------------------------------------------" << endl;
					ofile << "-- deterministic-delay padding for wire " << w->Get_VHDL_Id() << ":slack = " << curr_slack_point << endl;
					ofile << "-------------------------------------------------------------------------------------" << endl;
					int L = w->Get_Deterministic_Level() + last_slack_point + 1;
					int H = w->Get_Deterministic_Level() + curr_slack_point;

					assert (H <= this->Get_Parent()->Get_Deterministic_Longest_Path());

					int D = (H-L) + 1;

					buffering_added += D;

					string local_stall_sig = stall_sig + "(" + IntToStr(L) + 
						" to " + IntToStr(H) + ")";

					string din = w->Get_VHDL_Deterministic_Delayed_Id(last_slack_point);
					string dout = w->Get_VHDL_Deterministic_Delayed_Id(curr_slack_point);

					ofile << "-- deterministic repeater slack=" << curr_slack_point << endl;
					string rptr_name = w->Get_VHDL_Id() + "_det_delay_rptr_" + IntToStr(curr_slack_point);

					// repeater.
					ofile << rptr_name << ": SquashLevelRepeater --{" << endl;
					ofile << "generic map (name => \"" << rptr_name << "\","
						<< " g_data_width => " << w->Get_Size() << ","
						<< " g_depth => " << D << ")" << endl;
					ofile << "port map (clk=>clk, reset=>reset,"
						<< " enable => constant_one_1, "
						<< " data_in => " << din << ","
						<< " data_out => " << dout << ","
						<< " stall_vector => " << local_stall_sig << "); --}" << endl;

					last_slack_point = curr_slack_point;
				}
			}
		}

	}
	this->_estimated_buffering_bits += (buffering_added * w->Get_Size());

	if(w->Is("vcOutputWire"))
	{
		ofile << "--- Connect Output  ---------------------------------------------------------------------------------" << endl;
		int ow_slack = this->Get_Parent()->Get_Deterministic_Longest_Path() -
			w->Get_Deterministic_Level();
		ofile << w->Get_VHDL_Id() << " <= " <<
			w->Get_VHDL_Deterministic_Delayed_Id(ow_slack) << ";" << endl;
	}

	ofile << "-------------------------------------------------------------------------------------" << endl;
}

// return the longest path from source to sink.
int vcDataPath::Calculate_Longest_Paths_From_Inputs()
{
	int ret_val = 0;

	vcSystem::Info("calculating longest paths for deterministic operator " +
			this->Get_Parent()->Get_VHDL_Id());

	map<vcWire*, int> longest_path_map;
	// First construct a weighted directed graph with
	// wires as vertices and dpe's as arcs (delay = weight of arc).
	//	(ignore WAR connections).
	//	(source node is null).
	// Ensure that the directed graph has no cycles.
	//
	// Find the longest paths from source node to each
	// wire.
	//
	// Confirm that the slack in each edge is 0.
	//
	// Record the length of the longest path in the return map.
	//
	GraphBase  t_graph;
	t_graph.Add_Vertex(NULL);


	// input wires.
	for(int I = 0, fI = this->Get_Parent()->Get_Number_Of_Input_Arguments(); I < fI; I++)
	{
		vcWire* iw = this->Get_Parent()->Get_Input_Wire(I);
		t_graph.Add_Edge(NULL,iw);
	}

	vector<vcWire*> wvec;
	for(map<string, vcWire*>::iterator iter = _wire_map.begin();
			iter != _wire_map.end();
			iter++)
	{
		vcWire* w = (*iter).second;
		wvec.push_back(w);
	}

	for(int I = 0, fI = this->Get_Parent()->Get_Number_Of_Output_Arguments(); I < fI; I++)
	{
		vcWire* ow = this->Get_Parent()->Get_Output_Wire(I);
		wvec.push_back(ow);
	}

	for(int I = 0, fI = wvec.size(); I < fI; I++)
	{

		vcWire* w  = wvec[I];
		vcDatapathElement* dpe = w->Get_Driver();
		if(dpe != NULL)
		{
			for(int J = 0, fJ = dpe->Get_Number_Of_Input_Wires(); J < fJ; J++)
			{
				vcWire* fiw = dpe->Get_Input_Wire(J);
				if(!dpe->Get_Input_WAR_Flag(J))
				{
					if(fiw != w)	
					{
						t_graph.Add_Edge(fiw,w);
						vcSystem::Info("added arc " + fiw->Get_VHDL_Id() + " -> " 
								+ w->Get_VHDL_Id());
					}
					else
					{
						vcSystem::Warning("skipped accumulative arc " 
								+ fiw->Get_VHDL_Id() + " -> " 
								+ w->Get_VHDL_Id());
					}
				}	
			}		

			if(dpe->Get_Guard_Wire() != NULL)
			{
				vcWire* gw = dpe->Get_Guard_Wire();
				if(gw != w)
				{
					t_graph.Add_Edge(gw,w);
					vcSystem::Info("added arc " + gw->Get_VHDL_Id() + "(guard) -> " 
							+ w->Get_VHDL_Id());
				}	
				else
				{
					vcSystem::Warning("skipped accumulative arc " 
							+ gw->Get_VHDL_Id() + "(guard) -> " 
							+ w->Get_VHDL_Id());
				}

			}
		}
	}

	vector<void*> precedence_order;
	t_graph.Topological_Sort(precedence_order);
	
	for(int i = precedence_order.size()-1 ; i >= 0; i--) 
	{
		vcWire* w = ((vcWire*) precedence_order[i]);
		if(w == NULL)
			continue;
			
		vcSystem::Info(" wire " + w->Get_VHDL_Id() + " precedence-index= " + IntToStr(i));
		vcDatapathElement* dpe = w->Get_Driver();
		if(dpe  != NULL)
		{
			int dpe_delay =  (dpe->Get_Flow_Through() ? 0 : 
						dpe->Get_Deterministic_Pipeline_Delay());
			vcSystem::Info("   dpe " + dpe->Get_VHDL_Id() + " delay= " + IntToStr(dpe_delay));
			int lp_value = 0;
			for(int J = 0, fJ = dpe->Get_Number_Of_Input_Wires(); J < fJ; J++)
			{
				vcWire* fiw = dpe->Get_Input_Wire(J);
				if(!dpe->Get_Input_WAR_Flag(J) && (fiw != w))
				{
					if(longest_path_map.find(fiw) == longest_path_map.end())
					{
						assert(0);
					}
					int pred_lp_value = longest_path_map[fiw];
					vcSystem::Info("      pred " + fiw->Get_VHDL_Id() + 
							" pred_lp_value= " + IntToStr(pred_lp_value));
					int tval = pred_lp_value + dpe_delay;
					if(lp_value < tval)
						lp_value = tval;
					if(ret_val < lp_value)
						ret_val = lp_value;
				}	
			}

			if(dpe->Get_Guard_Wire() != NULL)
			{
				vcWire* gw = dpe->Get_Guard_Wire();
				int pred_lp_value = longest_path_map[gw];
				vcSystem::Info("      pred (guard) " + gw->Get_VHDL_Id() + 
						" pred_lp_value= " + IntToStr(pred_lp_value));
				int tval = pred_lp_value + dpe_delay;
				if(lp_value < tval)
					lp_value = tval;
				if(ret_val < lp_value)
					ret_val = lp_value;
			}		

			vcSystem::Info("longest path to " + w->Get_VHDL_Id() + " = " + IntToStr(lp_value));
			longest_path_map[w] = lp_value;
			w->Set_Deterministic_Level(lp_value);
		}
		else
		{
			longest_path_map[w] = 0;
			w->Set_Deterministic_Level(0);
		}
	}


	// check that all slacks are 0.
	for(int I = 0, fI = wvec.size(); I < fI; I++)
	{
		vcWire* w  = wvec[I];
		vcDatapathElement* dpe = w->Get_Driver();
		int lp_value = longest_path_map[w];
		if(dpe != NULL)
		{
			int dpe_delay =  (dpe->Get_Flow_Through() ? 0 : 
					dpe->Get_Deterministic_Pipeline_Delay());

			dpe->Clear_Input_Slacks();
			for(int J = 0, fJ = dpe->Get_Number_Of_Input_Wires(); J < fJ; J++)
			{
				vcWire* fiw = dpe->Get_Input_Wire(J);
				int slack = 0;
				if(!dpe->Get_Input_WAR_Flag(J) && !fiw->Is_Constant() && (fiw != w))
				{
					int pred_lp_value = longest_path_map[fiw];
					int tval = pred_lp_value + dpe_delay;
					if(tval <  lp_value)
					{
						slack =  (lp_value - tval);
						vcSystem::Info("positive slack in balanced pipeline between wire " + fiw->Get_VHDL_Id() + " and " + w->Get_VHDL_Id());
					}
				}	
				dpe->Push_Back_Input_Slack(slack);
			}		

			if(dpe->Get_Guard_Wire() != NULL)
			{
				vcWire* gw = dpe->Get_Guard_Wire();
				if(!dpe->Get_Guard_WAR_Flag() && !gw->Is_Constant() && (gw != w))
				{
					int pred_lp_value = longest_path_map[gw];
					int tval = pred_lp_value + dpe_delay;
					int slack = 0;
					if(tval <  lp_value)
					{
						slack = (lp_value - tval);
						vcSystem::Info("positive slack in balanced pipeline between wire " + gw->Get_VHDL_Id() + " (guard) and " + w->Get_VHDL_Id());
					}
					dpe->Set_Guard_Slack(slack);
				}
			}
		}
	}
	vcSystem::Info("longest path through deterministic operator " +
			this->Get_Parent()->Get_VHDL_Id() + " is " + IntToStr(ret_val));
	return (ret_val);
}

