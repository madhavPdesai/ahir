#ifndef hier_System_h__
#define hier_System_h__

using namespace std;

#include <cstddef>
#include <algorithm>
#include <stdlib.h>
#include <ctype.h>
#include <malloc.h>
#include <unistd.h>
#include <fstream>
#include <iostream>
#include <getopt.h>
#include <string>
#include <set>
#include <list>
#include <vector>
#include <deque>
#include <map>
#include <deque>
#include <iomanip>
#include <sstream>
#include <math.h>
#include <istream>
#include <ostream>
#include <assert.h>
#include <stdint.h>

class hierRoot
{
	public:
	string _id;
	bool _error;
	
	hierRoot(string id) {_id = id; _error = false;}

	string Get_Id() {return(_id);}
	void Set_Error(bool v) {_error = true;}
	bool Get_Error() {return(_error);}
	
};


class hierSystem;

class hierSystemInstance: public hierRoot
{
	public:

	hierSystem* _parent;
	hierSystem* _base_system;
	map<string, string> _port_map;
	map<string, string> _reverse_port_map;


	hierSystemInstance(hierSystem* parent, hierSystem* base_sys, string id):hierRoot(id) 
	{	
		_parent = parent;
		_base_system = base_sys; 
	}


	hierSystem* Get_Parent() {return(_parent);}
	hierSystem* Get_Base_System() {return(_base_system);}
	void Add_Port_Mapping(string formal, string actual);

	string Get_Actual(string formal)
	{
		string ret_string = "";
		if(_port_map.find(formal) != _port_map.end())
			ret_string = _port_map[formal];
		return(ret_string);
	}


	string Get_Formal(string actual)
	{
		string ret_string = "";
		if(_reverse_port_map.find(actual) != _reverse_port_map.end())
			ret_string = _reverse_port_map[actual];
		return(ret_string);
	}


	void Print(ostream& ofile);
	void Print_Vhdl(ostream& ofile);
};

class hierSystem: public hierRoot
{
	bool _error;
        string _library;
	hierSystem* _parent;
	map<string, int> _in_pipes;
	map<string, int> _out_pipes;
	map<string, int> _internal_pipes;

	map<string, hierSystemInstance*>  _pipe_to_subsystem_connection_map;
	map<hierSystemInstance*, vector<string> > _subsystem_pipe_connection_map;
	map<string,  hierSystemInstance* > _child_map;

	set<string> _signals;

public:
	hierSystem(string id) :hierRoot(id)
	{
		_library = "work";
	}

        bool Is_Leaf() {return(_child_map.size() == 0);}
	void Set_Library(string s) {cerr << "Info: setting library for " << _id << " to " << s << endl; _library = s;}
	string Get_Library() {return(_library);}

	void Add_Signal(string pname)
	{
		_signals.insert(pname);
	}

	bool Is_Signal(string pname)
	{
		return(_signals.find(pname) != _signals.end());
	}

	int Get_Pipe_Width(map<string, int>& pmap, string pipe_id)
	{
		return((pmap.find(pipe_id) != pmap.end()) ? pmap[pipe_id] : 0);
	}

	int Get_Input_Pipe_Width(string pipe_id) {
		return(this->Get_Pipe_Width(_in_pipes, pipe_id));
	}
	int Get_Output_Pipe_Width(string pipe_id) {
		return(this->Get_Pipe_Width(_out_pipes, pipe_id));
	}
	int Get_Internal_Pipe_Width(string pipe_id) {
		return(this->Get_Pipe_Width(_internal_pipes, pipe_id));
	}

	int Get_Pipe_Width(string pipe_id)
	{
		int ret_w = this->Get_Input_Pipe_Width(pipe_id);
		if(ret_w > 0)
			return(ret_w);
		ret_w = this->Get_Output_Pipe_Width(pipe_id);

		if(ret_w > 0)
			return(ret_w);

		ret_w = this->Get_Internal_Pipe_Width(pipe_id);
			
		return(ret_w);
	}
	bool Has_Port(string pid)
	{
		return ( (this->Get_Input_Pipe_Width(pid) > 0)
			||  (this->Get_Output_Pipe_Width(pid) > 0)
			||  (this->Get_Internal_Pipe_Width(pid) > 0));
	}


        void Print_Pipe_Map(map<string, int>& pmap, ostream& ofile)
	{
		for(map<string,int>::iterator iter = pmap.begin(), fiter = pmap.end(); iter != fiter; iter++)
		{
			ofile << (this->Is_Signal((*iter).first) ? "  $signal " : "  $pipe ");
			ofile << " " << (*iter).first << " " << (*iter).second << " ";
			ofile << endl;
		}
	}

	void Add_Pipe_To_Map(map<string, int>& pipe_map, string pid, int pipe_width, string pipe_type)
	{
		if(pipe_map.find(pid) != pipe_map.end())
		{
			int width = pipe_map[pid];

			if(width != pipe_width)
			{
				cerr << "Error : redeclaration of " << pipe_type  << " "
					<< pid << " will overwrite existing declaration" << endl;
				_error = true;
			}
			else
			{
				cerr << "Warning : redeclaration of " << pipe_type << " " 
					<< pid << " will ignore second declaration" << endl;
			}

		}
		else
		{
			pipe_map[pid] = pipe_width;
		}
	 }


			
	void Add_In_Pipe(string pid, int pipe_width)
	{
		this->Add_Pipe_To_Map(_in_pipes, pid, pipe_width, "in-pipe");

		if(this->Get_Output_Pipe_Width(pid) > 0)
		{
			cerr << "Error: pipe " << pid << " in system " << this->_id << " is both input and output pipe." << endl;
			_error = true;
		}
		if(this->Get_Internal_Pipe_Width(pid) > 0)
		{
			cerr << "Error: pipe " << pid << " in system " << this->_id << " is both input and internal pipe." << endl;
			_error = true;
		}

	}
	void Add_Out_Pipe(string pid, int pipe_width)
	{
		Add_Pipe_To_Map(_out_pipes, pid, pipe_width, "out-pipe");
		if(this->Get_Input_Pipe_Width( pid) > 0)
		{
			cerr << "Error: pipe " << pid << " in system " << this->_id << " is both input and output pipe." << endl;
			_error = true;
		}
		if(this->Get_Internal_Pipe_Width( pid) > 0)
		{
			cerr << "Error: pipe " << pid << " in system " << this->_id << " is both output and internal pipe." << endl;
			_error = true;
		}
	}
	void Add_Internal_Pipe(string pid, int pipe_width)
	{
		Add_Pipe_To_Map(_internal_pipes, pid, pipe_width, "internal-pipe");
		if(this->Get_Input_Pipe_Width(pid) > 0)
		{
			cerr << "Error: pipe " << pid << " in system " << this->_id << " is both input and internal pipe." << endl;
			_error = true;
		}
		if(this->Get_Output_Pipe_Width(pid) > 0)
		{
			cerr << "Error: pipe " << pid << " in system " << this->_id << " is both output and internal pipe." << endl;
			_error = true;
		}
	}

	// make connections..
	void Connect(string pipe_id, hierSystemInstance* child, string child_port_id)
	{
		// pipe_id must be either an in-pipe or
		// an internal-pipe.
		if((this->Get_Output_Pipe_Width(pipe_id) > 0)
			|| (this->Get_Input_Pipe_Width(pipe_id) > 0))
		{
			if(_pipe_to_subsystem_connection_map.find(pipe_id) != _pipe_to_subsystem_connection_map.end())
			{
				cerr << "Error: pipe " << pipe_id << " is connected to multiple subsystems in "
					<< this->_id;
				_error = true;
			}	
			else
			{
				_pipe_to_subsystem_connection_map[pipe_id] = child;
				child->Add_Port_Mapping(pipe_id, child_port_id);
				_subsystem_pipe_connection_map[child].push_back(pipe_id);
			}
		}
		else
		{
			cerr << "Error: illegal connection of pipe " << pipe_id << " to child " << child->Get_Id() << " in " 
				<< this->_id << endl;
		}
	}
	
	void Add_Child(hierSystemInstance* child)
	{
		if(child == NULL) return;

		string child_id = child->Get_Id();
		if(_child_map.find(child_id) != _child_map.end())
		{
			cerr << "Error: added multiple instances of child " << child_id << " to system " << _id << endl;
			_error = true;
		}
		_child_map[child_id] = child;
	}

	// return true if error found.
	bool Check_For_Errors();

	// print function.. reproduce description.
	void Print(ostream& ofile);

	// print VHDL
	void Print_Vhdl_Port_Declarations(ostream& ofile);
	void Print_Vhdl_Component_Declaration(ostream& ofile);
	void Print_Vhdl_Entity_Architecture(ostream& ofile);
	void Print_Vhdl_Test_Bench(string sim_link_lib, string sim_link_prefix, ostream& ofile); // in progress.
	void Print_Vhdl_Instance_In_Testbench(string inst_name, ostream& ofile);
};

#endif
