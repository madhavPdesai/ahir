#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <rtlStatement.h>
#include <rtlThread.h>

void hierInstanceGraphArc::Print(ostream& ofile)
{
	for(int I = 0; I < _parent->_depth; I++)
		ofile << "  ";

	if(_driver != NULL)
		ofile << _driver->Get_Id() << " --> ";
	else
		ofile << "ENV --> ";
	

	if(_receiver != NULL)
		ofile <<  _receiver->Get_Id();
	else
		ofile << " ENV";

	ofile << " formal=" << 
			((_formal_pipe == NULL) ? "null" : _formal_pipe->_pipe->Get_Id()) << ", actual=" 
			<< ((_actual_pipe != NULL) ? _actual_pipe->_pipe->Get_Id()  : "null");
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
