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
#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <rtlStatement.h>
#include <rtlThread.h>

bool matchPrefix(string entire_name, set<string>& prefixes)
{
	bool ret_val = false;
	for(set<string>::iterator iter = prefixes.begin(), fiter = prefixes.end(); iter != fiter; iter++)
	{
		string prefix = *iter;
		if(prefix.size() <= entire_name.size())
		{
			string sub_entire_name = entire_name.substr(0, prefix.size());
			if(sub_entire_name == prefix)
			{
				ret_val = true;
				break;
			}	
		}
	}
	return(ret_val);
}

string hierPipeInstance::Hierarchical_Name()
{
	string ret_val;
	if(this->_pipe && this->_pipe->_scope != NULL)
		ret_val  = this->_instance_graph_node->Hierarchical_Name() + "/";
	ret_val = ret_val + this->_pipe->Get_Id();
	return (ret_val);
}


void hierInstanceGraphArc::Print(ostream& ofile)
{
	for(int I = 0; I < _parent->_depth; I++)
		ofile << "  ";

	if(_driver != NULL)
		ofile << _driver->Hierarchical_Name() << " --> ";
	else
		ofile << "ENV --> ";
	

	if(_receiver != NULL)
		ofile <<  _receiver->Hierarchical_Name();
	else
		ofile << " ENV";

	ofile << " formal=" << 
			((_formal_pipe == NULL) ? "null" : _formal_pipe->Hierarchical_Name()) << ", actual=" 
			<< ((_actual_pipe != NULL) ? _actual_pipe->Hierarchical_Name()  : "null");
	ofile << endl;
}

//
// make a hierarchical instance graph, which we can then conveniently
// flatten.
//
void hierSystem::Build_Instance_Hierarchy(hierInstanceGraph** hi_graph)
{
	if(*hi_graph == NULL)
		*hi_graph = new hierInstanceGraph(this);

	if(_child_map.size() > 0)
	{
		for(map<string,hierSystemInstance*>::iterator miter = _child_map.begin(), fmiter = _child_map.end();
				miter != fmiter; miter++)
		{
			hierSystemInstance* inst = (*miter).second;

			hierInstanceGraph* new_node = new hierInstanceGraph(inst);
			(*hi_graph)->Add_Node(new_node);

			new_node->_parent = *hi_graph;

			inst->Get_Base_System()->Build_Instance_Hierarchy(&new_node);
		}
	}
}


//
// start from the top.  for each child instance, add arcs between child instances
// of between this and the child instance depending on the port map.
// 
void hierSystem:: Build_Instance_Graph_Arcs (hierInstanceGraph* instance_graph)
{
	instance_graph->Build_Connectivity();
}


	
void hierSystem::Partition_Flat_Graph(FlatLeafGraph* g, set<string>& hw_instances, FlatLeafGraph** sw_graph, FlatLeafGraph** hw_graph)
{
	*sw_graph = new FlatLeafGraph();
	*hw_graph = new FlatLeafGraph();

	for(set<hierInstanceGraph*>::iterator iter = g->_instances.begin(), fiter = g->_instances.end();
				iter != fiter; iter++)
	{
		hierInstanceGraph* ig = *iter;
		if(ig->_instance != NULL)
		{
			string hname = ig->Hierarchical_Name();
			if(matchPrefix(hname, hw_instances)) 
			{
				(*hw_graph)->_instances.insert(ig);
			}
			else
			{
				(*sw_graph)->_instances.insert(ig);
			}
		}
	}

	for(map<hierPipeInstance*, hierInstanceGraph*>::iterator miter = g->_driven_instance_map.begin(),
			fmiter = g->_driven_instance_map.end(); miter != fmiter; miter++)
	{
		hierPipeInstance* p = (*miter).first;
		hierInstanceGraph* igg = (*miter).second;
		if((*hw_graph)->_instances.find(igg) != (*hw_graph)->_instances.end())
		{
			(*hw_graph)->_flat_pipes.insert(p);
			(*hw_graph)->_driven_instance_map[p] = igg;		
		}
		else
		{
			(*sw_graph)->_flat_pipes.insert(p);
			(*sw_graph)->_driven_instance_map[p] = igg;		
		}
	}

	for(map<hierPipeInstance*, hierInstanceGraph*>::iterator miter = g->_driving_instance_map.begin(),
			fmiter = g->_driving_instance_map.end(); miter != fmiter; miter++)
	{
		hierPipeInstance* p = (*miter).first;
		hierInstanceGraph* igg = (*miter).second;
		if((*hw_graph)->_instances.find(igg) != (*hw_graph)->_instances.end())
		{
			(*hw_graph)->_flat_pipes.insert(p);
			(*hw_graph)->_driving_instance_map[p] = igg;		
		}
		else
		{
			(*sw_graph)->_flat_pipes.insert(p);
			(*sw_graph)->_driving_instance_map[p] = igg;		
		}
	}
}

void hierInstanceGraph::Build_Connectivity()
{
	assert(_system != NULL);

	vector<hierPipe*> in_pipes;
	vector<hierPipe*> out_pipes;
	vector<hierPipe*> internal_pipes;

	this->_system->List_In_Pipes(in_pipes);
	this->_system->List_Out_Pipes(out_pipes);
	this->_system->List_Internal_Pipes(internal_pipes);


	for(int I = 0, fI = in_pipes.size(); I < fI; I++)
	{
		hierPipe* p = in_pipes[I];
		hierPipeInstance* pi = new hierPipeInstance(p, this);
		_pipe_instance_map[p] = pi;

		hierPipeInstance* pp = NULL;
		if(this->_parent != NULL)
		{
			assert(this->_instance != NULL);

			hierPipe* ap = this->_parent->_system->Find_Pipe(this->_instance->Get_Actual(p->Get_Id()));	
			assert(ap != NULL);
			pp = this->_parent->_pipe_instance_map[ap];
			assert(pp != NULL);
		}

		this->Add_Arc(this->_parent, this, pi, pp);
	}
	for(int I = 0, fI = out_pipes.size(); I < fI; I++)
	{
		hierPipe* p = out_pipes[I];
		hierPipeInstance* pi = new hierPipeInstance(p, this);
		_pipe_instance_map[p] = pi;

		hierPipeInstance* pp = NULL;
		if(this->_parent != NULL)
		{
			assert(this->_instance != NULL);

			hierPipe* ap = this->_parent->_system->Find_Pipe(this->_instance->Get_Actual(p->Get_Id()));	
			assert(ap != NULL);
			pp = this->_parent->_pipe_instance_map[ap];
			assert(pp != NULL);
		}

		this->Add_Arc(this, this->_parent, pi, pp);
	}	

	// internal pipe instances.
	for(int I = 0, fI = internal_pipes.size(); I < fI; I++)
	{
		hierPipe* p = internal_pipes[I];
		hierPipeInstance* pi = new hierPipeInstance(p, this);
		_pipe_instance_map[p] = pi;
	}

	for(int J = 0, fJ = _child_nodes.size(); J < fJ; J++)
	{
		hierInstanceGraph* child_node = _child_nodes[J];
		child_node->Build_Connectivity();
	}

	this->Set_Default_Flat_Clock();
	this->Set_Default_Flat_Reset();
}

string hierInstanceGraph::Find_Default_Flat_Clock()
{
	if(this->_instance == NULL)
		return ("clk");

	string ret_val = this->_instance->_default_clock;

	if(this->_instance->_default_clock == "clk")
	{
		ret_val = this->_parent->Find_Default_Flat_Clock();
	}
	else
	{
		vector<hierPipe*> in_pipes;
		this->_system->List_In_Pipes(in_pipes);
		for(int I = 0, fI = in_pipes.size(); I < fI; I++)
		{
			hierPipe* ip = in_pipes[I];
			if(ip->Get_Id() == this->_instance->_default_clock)
			{
				hierPipeInstance* ipp = _pipe_instance_map[ip];
				hierPipeInstance* ripp = ipp->_root_actual_pipe;
				
				assert(ripp != NULL);
				ret_val = ripp->Hierarchical_Name();
				break;
			}
		}
	}
	return(ret_val);
}

string hierInstanceGraph::Find_Default_Flat_Reset()
{
	if(this->_instance == NULL)
		return ("reset");

	string ret_val = this->_instance->_default_reset;
	if(this->_instance->_default_reset == "reset")
	{
		ret_val = this->_parent->Find_Default_Flat_Reset();
	}
	else
	{
		vector<hierPipe*> in_pipes;
		this->_system->List_In_Pipes(in_pipes);
		for(int I = 0, fI = in_pipes.size(); I < fI; I++)
		{
			hierPipe* ip = in_pipes[I];
			if(ip->Get_Id() == this->_instance->_default_reset)
			{
				hierPipeInstance* ipp = _pipe_instance_map[ip];
				hierPipeInstance* ripp = ipp->_root_actual_pipe;
				
				assert(ripp != NULL);
				ret_val = ripp->Hierarchical_Name();
				break;
			}
		}
	}
	return(ret_val);
}

void hierInstanceGraph::Set_Default_Flat_Clock()
{
	string def_clk = this->Find_Default_Flat_Clock();
	this->_default_flat_clock = def_clk;
}

void hierInstanceGraph::Set_Default_Flat_Reset()
{
	string def_reset = this->Find_Default_Flat_Reset();
	this->_default_flat_reset = def_reset;
}


void hierInstanceGraph::Set_Root_Pipes(map<hierPipeInstance*,hierPipeInstance*>& root_pipe_map)
{
	if(this->_instance == NULL)
	{
		vector<hierPipe*> io_pipes;
		this->_system->List_In_Pipes(io_pipes);
		this->_system->List_Out_Pipes(io_pipes);

		for(int I = 0, fI = io_pipes.size(); I < fI; I++)
		{
			hierPipeInstance* pi = _pipe_instance_map[io_pipes[I]];
			assert(pi != NULL);
			root_pipe_map[pi] = pi;
			pi->_root_actual_pipe = pi;
		}
	}
	

	vector<hierPipe*> internal_pipes;
	this->_system->List_Internal_Pipes(internal_pipes);
	for(int I = 0, fI = internal_pipes.size(); I < fI; I++)
	{
		hierPipeInstance* pi = _pipe_instance_map[internal_pipes[I]];
		assert(pi != NULL);
		root_pipe_map[pi] = pi;
		pi->_root_actual_pipe = pi;
	}

	for(int I = 0, fI = _arcs.size(); I < fI; I++)
	{
		hierInstanceGraphArc* arc = _arcs[I];
		if(arc->_actual_pipe != NULL)
		{
			hierPipeInstance* rap = root_pipe_map[arc->_actual_pipe];
			assert(rap != NULL);

			root_pipe_map[arc->_formal_pipe] = rap;
			arc->_formal_pipe->_root_actual_pipe = rap;
		}
	}

	for(int I = 0, fI = _child_nodes.size(); I < fI; I++)
		_child_nodes[I]->Set_Root_Pipes(root_pipe_map);
}

void hierInstanceGraph::Print(ostream& ofile)
{
	for(int I = 0; I < _depth; I++)
		ofile << "  ";

	ofile << this->Get_Id();
	if(this->_child_nodes.size() == 0)
	{
		ofile << "=LEAF";
		ofile << " $clk => " << this->_default_flat_clock << " "; 
		ofile << " $reset => " << this->_default_flat_reset << " "; 
	}
	if(this->_instance == NULL)
		ofile << "=TOP";
	ofile << endl;

	if(_arcs.size() > 0)
	{
		for(int I = 0, fI = _arcs.size(); I < fI; I++)
			_arcs[I]->Print(ofile);
	}

	for(int J = 0, fJ = _child_nodes.size(); J < fJ; J++)
	{
		hierInstanceGraph* child = _child_nodes[J];
		child->Print(ofile);
	}
}


string hierInstanceGraph::Hierarchical_Name()
{
	string ret_val;
	if(this->_parent)
		ret_val = this->_parent->Hierarchical_Name() + "/";
	if(this->_instance)
		ret_val += this->_instance->Get_Id();
	else 
		ret_val += this->_system->Get_Id();

	return(ret_val);
}

void hierInstanceGraph::Build_Flat_Leaf_Graph(FlatLeafGraph** flg)
{
	if(*flg == NULL)
		*flg = new FlatLeafGraph();


	bool is_leaf = (this->_child_nodes.size() == 0);


	if(is_leaf)
	{
		(*flg)->_instances.insert(this);
	}

	hierSystemInstance* inst = this->_instance;
	hierSystem* sys = this->_system;
	vector<hierPipe*> in_pipes;
	sys->List_In_Pipes(in_pipes);
	for(int I = 0, fI = in_pipes.size(); I < fI; I++)
	{
		hierPipe* ip = in_pipes[I];
		hierPipeInstance* ipp = _pipe_instance_map[ip];
		hierPipeInstance* ripp = ipp;
		if(inst != NULL)
			ripp = ipp->_root_actual_pipe;

		assert (ripp != NULL);

		if(is_leaf)
		{
			(*flg)->_flat_pipes.insert(ripp);
			(*flg)->_driven_instance_map[ripp] = this;
		}
	}

	vector<hierPipe*> out_pipes;
	sys->List_Out_Pipes(out_pipes);
	for(int I = 0, fI = out_pipes.size(); I < fI; I++)
	{
		hierPipe* op = out_pipes[I];
		hierPipeInstance* opp = _pipe_instance_map[op];
		hierPipeInstance* ropp = opp;
		if(inst != NULL)
			ropp = opp->_root_actual_pipe;

		assert (ropp != NULL);

		if(is_leaf)
		{
			(*flg)->_flat_pipes.insert(ropp);
			(*flg)->_driving_instance_map[ropp] = this;
		}
	}

	for(int I = 0, fI = this->_child_nodes.size(); I < fI; I++)
	{
		hierInstanceGraph* child_node = this->_child_nodes[I];
		child_node->Build_Flat_Leaf_Graph(flg);
	}
}


void FlatLeafGraph::Print(ostream& ofile)
{
	ofile << "Flat-graph nodes" << endl;
	for(set<hierInstanceGraph*>::iterator iiter = _instances.begin(), fiiter = _instances.end();
			iiter != fiiter; iiter++)
	{
		hierInstanceGraph* g = *iiter;
		ofile << "  " << g->Hierarchical_Name() << endl;
	}
	ofile << "Flat-graph arcs" << endl;
	for(set<hierPipeInstance*>::iterator pter = _flat_pipes.begin(), fpter = _flat_pipes.end();
			pter != fpter; pter++)
	{
		hierPipeInstance* pi = *pter;
		hierInstanceGraph* g = pi->_instance_graph_node;

		ofile << "  Pipe: " << g->Hierarchical_Name() << "/" << pi->_pipe->Get_Id() <<  endl;
		if(_driven_instance_map.find(pi) != _driven_instance_map.end())
		{
			ofile << "      --> " << _driven_instance_map[pi]->Hierarchical_Name() << endl;
		}
		else
		{
			ofile << "    drives nothing." << endl;
		}
		if(_driving_instance_map.find(pi) != _driving_instance_map.end())
		{
			ofile << "      <-- " << _driving_instance_map[pi]->Hierarchical_Name() << endl;
		}
		else
		{
			ofile << "    driven by nothing." << endl;
		}
	}
}


void FlatLeafGraph::Print_Hsys_File(string top_name, string top_lib_name, ostream& ofile)
{
	vector<hierPipe*> in_pipes;
	vector<hierPipe*> out_pipes;

	ofile << "$system " << 	top_name << " $library " << top_lib_name << endl;
	for(set<hierPipeInstance*>::iterator piter =this->_flat_pipes.begin(), fpiter = this->_flat_pipes.end();
				piter != fpiter; piter++)
	{
		hierPipeInstance* pi = *piter;
		hierPipe* p = pi->_pipe;
		bool driven_by_nothing = (this->_driving_instance_map.find(pi) == this->_driving_instance_map.end());
		bool drives_nothing = (this->_driven_instance_map.find(pi) == this->_driven_instance_map.end());

		if(p->_is_input)
		{
			assert(driven_by_nothing);
			in_pipes.push_back(p);
		}
		else if (p->_is_output)
		{
			assert(drives_nothing);
			out_pipes.push_back(p);
		}
		else if(driven_by_nothing && !drives_nothing)
		{
			in_pipes.push_back(p);
		}
		else if(!driven_by_nothing && drives_nothing)
		{
			out_pipes.push_back(p);
		}
	}
	
	ofile << " $in " << endl;
	for (int I = 0, fI = in_pipes.size(); I < fI; I++)
	{
		hierPipe* p = in_pipes[I];
		ofile << (p->_is_signal ? "  $signal " : "  $pipe ") << p->Get_Id() << endl;
	}
	ofile << " $out " << endl;
	for (int I = 0, fI = out_pipes.size(); I < fI; I++)
	{
		hierPipe* p = out_pipes[I];
		ofile << (p->_is_signal ? "  $signal " : "  $pipe ") << p->Get_Id() << endl;
	}
   ofile << "{" << endl;
   for(set<hierInstanceGraph*>::iterator iiter = this->_instances.begin(), fiiter = this->_instances.end();
		iiter != fiiter; iiter++)
   {
	hierInstanceGraph* g = *iiter;
	ofile << "  $instance " << g->_instance->Get_Id() << " " << g->_system->Get_Library() <<  ":" << g->_system->Get_Id() << endl;
   }
   ofile << "}" << endl;
}
		

void FlatLeafGraph::Print_Uniquification_File (string top_name, string top_lib_name, ostream& ofile)
{
	ofile << "! Uniguification file for system " << top_name << " library " << top_lib_name
				<< endl;
	ofile << "! Prefix renames.. " << endl;
	for(set<hierInstanceGraph*>::iterator iiter = _instances.begin(), fiiter = _instances.end();
			iiter != fiiter; iiter++)
	{
		hierInstanceGraph* g = *iiter;
		string g_c_name = Make_C_Legal(g->Hierarchical_Name());
		hierSystem* gs = g->_system;

		ofile << "prefix_rename  " << gs->Get_Library() << " "  << gs->Get_Id() << "  " 
						<< " " << 
						g_c_name << endl;

		vector<hierPipe*> int_pipes;
		gs->List_Internal_Pipes (int_pipes);
		if(int_pipes.size() > 0)
			ofile << "! internal pipe renames.. for instance " 
						<< g->Hierarchical_Name() << endl;
		for(int P=0, fP = int_pipes.size(); P < fP; P++)
		{

			ofile << "register_pipe_rename "
						<< gs->Get_Library() << " "  << 
								gs->Get_Id() << " " <<
								g_c_name << "  " 
								<< int_pipes[P]->Get_Id() << " "
								<<  g_c_name << "_"
								<< int_pipes[P]->Get_Id() << endl;
			ofile << "rpipe_rename  " 
						<< gs->Get_Library() << " "  << 
								gs->Get_Id() << " " <<
								g_c_name << "  " 
								<< int_pipes[P]->Get_Id() << " "
								<<  g_c_name << "_"
								<< int_pipes[P]->Get_Id() << endl;
			ofile << "wpipe_rename  " << gs->Get_Library() << " "  << 
								gs->Get_Id() << " " <<
								g_c_name << "  " 
								<< int_pipes[P]->Get_Id() << " "
								<<  g_c_name << "_"
								<< int_pipes[P]->Get_Id() << endl;
		}

		vector<hierPipe*> in_pipes;
		gs->List_In_Pipes (in_pipes);
		if(in_pipes.size() > 0)
			ofile << "! in pipe renames.. for instance " 
						<< g->Hierarchical_Name() << endl;
		for(int P=0, fP = in_pipes.size(); P < fP; P++)
		{
			hierPipeInstance* ip = g->_pipe_instance_map[in_pipes[P]];

			bool top_level = false;
			if((ip->_root_actual_pipe->_pipe->_scope->Get_Id() == top_name) && 
				(ip->_root_actual_pipe->_pipe->_scope->Get_Library() == top_lib_name))
				top_level = true;
			string rename_name = (top_level ? ip->_root_actual_pipe->_pipe->Get_Id() :
						Make_C_Legal(ip->_root_actual_pipe->Hierarchical_Name()));

			ofile << "rpipe_rename  " << gs->Get_Library() << " "  << 
								gs->Get_Id() << " " <<
								g_c_name << "  " 
								<< ip->_pipe->Get_Id() << " "
								<< rename_name << endl;
		}

		vector<hierPipe*> out_pipes;
		gs->List_Out_Pipes (out_pipes);
		if(out_pipes.size() > 0)
			ofile << "! out pipe renames.. for instance " 
						<< g->Hierarchical_Name() << endl;
		for(int P=0, fP = out_pipes.size(); P < fP; P++)
		{
			hierPipeInstance* op = g->_pipe_instance_map[out_pipes[P]];

			bool top_level = false;
			if((op->_root_actual_pipe->_pipe->_scope->Get_Id() == top_name) && 
				(op->_root_actual_pipe->_pipe->_scope->Get_Library() == top_lib_name))
				top_level = true;

			string rename_name = (top_level ? op->_root_actual_pipe->_pipe->Get_Id() :
						Make_C_Legal(op->_root_actual_pipe->Hierarchical_Name()));

			ofile << "wpipe_rename  " << gs->Get_Library() << " "  << 
								gs->Get_Id() << " " <<
								g_c_name << "  " 
								<< op->_pipe->Get_Id() << " "
								<< rename_name << endl;
		}

	}
}


void FlatLeafGraph::Print_Pipe_Classifications(set<string>& hw_instance_names, ostream& ofile)
{
	for(set<hierPipeInstance*>::iterator iter = this->_flat_pipes.begin(), fiter = this->_flat_pipes.end();
			iter != fiter; iter++)
	{
		hierPipeInstance* pi = *iter;
		hierInstanceGraph* driver   = this->_driving_instance_map[pi];
		bool driver_in_hw = ((driver != NULL) && matchPrefix(driver->Hierarchical_Name(), hw_instance_names));

		hierInstanceGraph* receiver = this->_driven_instance_map[pi];
		bool receiver_in_hw = ((receiver != NULL) && matchPrefix(receiver->Hierarchical_Name(), hw_instance_names));

		ofile << pi->_pipe->Get_Id() << " " 
			<< pi->_pipe->Get_Width() << " " << pi->_pipe->Get_Depth() 
			<< " " << (pi->_pipe->Get_Is_Signal() ? "signal" : "pipe") << " "
			<< (pi->_pipe->Get_Is_Noblock() ? "noblock" : "block") << " " 
			<< ((driver == NULL) ? "ENV" : (driver_in_hw ? "HW" : "SW")) << " " 
			<< ((receiver == NULL) ? "ENV" : (receiver_in_hw ? "HW" : "SW"))  << endl;
	}
}


