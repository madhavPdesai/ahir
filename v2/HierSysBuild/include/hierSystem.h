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

enum rtlOperation {
	__NOP,
	__NOT,
	__OR,
	__AND,
	__XOR,
	__NOR,
	__NAND,
	__XNOR,
	__PLUS,
	__MINUS,
	__CONCAT,
	__SLICE,
	__BITSEL
};

class rtlObject;
class rtlThread;
class hierRoot
{
	public:
	string _id;
	bool _error;
	
	hierRoot(string id) {_id = id; _error = false;}

	string Get_Id() {return(_id);}
	void Set_Error(bool v) {_error = true;}
	bool Get_Error() {return(_error);}

	void Report_Info(string err_msg) { cerr << "Info: " << err_msg << endl;}
	void Report_Warning(string err_msg) { cerr << "Warning: " << err_msg << endl;}
	void Report_Error(string err_msg) { cerr << "Error: " << err_msg << endl; this->Set_Error(true); }
	
	
};


class hierSystem;

class hierSystemInstance: public hierRoot
{
	public:

	hierSystem* _parent;
	hierSystem* _base_system;
	map<string, string> _port_map;
	map<string, string> _reverse_port_map;


	hierSystemInstance(hierSystem* parent, hierSystem* base_sys, string id);


	hierSystem* Get_Parent() {return(_parent);}
	hierSystem* Get_Base_System() {return(_base_system);}
	bool Add_Port_Mapping(string formal, 
				string actual, 
				map<string, pair<int,int> >& pmap, 
				set<string>& signals);
	bool Add_Port_Mapping(string formal, 
				string actual);

	bool Map_Unmapped_Ports_To_Defaults( map<string, pair<int,int> >& pmap, set<string>& signals);

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
        string _library;
	hierSystem* _parent;
	map<string, pair<int,int> > _in_pipes;
	map<string, pair<int,int> > _out_pipes;
	map<string, pair<int,int> > _internal_pipes;

	map<string, hierSystemInstance*>  _pipe_to_subsystem_connection_map;
	map<hierSystemInstance*, vector<string> > _subsystem_pipe_connection_map;
	map<string,  hierSystemInstance* > _child_map;

	set<string> _signals;
	int _instance_count;

	// pipes that are driven
	set<string> _driven_pipes;
	set<string> _driving_pipes;

	//
	// order is important (for generating C model).
	//
	map<string, rtlThread*> _thread_map;
	vector<rtlString*> _rtl_strings;


public:

	hierSystem(string id) :hierRoot(id)
	{
		_library = "work";
		_instance_count = 0;
	}

	void Set_Driven_Pipe(string pname) { _driven_pipes.insert(pname);}
	void Set_Driving_Pipe(string pname) { _driving_pipes.insert(pname);}

	bool Is_Driven_Pipe(string pname) {return(_driven_pipes.find(pname) != _driven_pipes.end());}
	bool Is_Driving_Pipe(string pname) {return(_driving_pipes.find(pname) != _driving_pipes.end());}


	int Get_Instance_Count() {return(_instance_count);}
	void Increment_Instance_Count() {_instance_count++;}

        bool Is_Leaf() {return(_child_map.size() == 0);}
	void Set_Library(string s) {cerr << "Info: setting library for " << _id << " to " << s << endl; _library = s;}
	string Get_Library() {return(_library);}

	int Get_Number_Of_In_Pipes() {return(_in_pipes.size());}
	void List_In_Pipe_Names(vector<string>& pvec);
	void List_Out_Pipe_Names(vector<string>& pvec);
	void List_Internal_Pipe_Names(vector<string>& pvec);
	
	

	void Add_Signal(string pname)
	{
		_signals.insert(pname);
	}

	bool Is_Signal(string pname)
	{
		return(_signals.find(pname) != _signals.end());
	}

	int Get_Pipe_Width(map<string, pair<int,int> >& pmap, string pipe_id)
	{
		return((pmap.find(pipe_id) != pmap.end()) ? pmap[pipe_id].first : 0);
	}
	int Get_Pipe_Depth(map<string, pair<int,int> >& pmap, string pipe_id)
	{
		return((pmap.find(pipe_id) != pmap.end()) ? pmap[pipe_id].second : 0);
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

	int Get_Input_Pipe_Depth(string pipe_id) {
		return(this->Get_Pipe_Depth(_in_pipes, pipe_id));
	}
	int Get_Output_Pipe_Depth(string pipe_id) {
		return(this->Get_Pipe_Depth(_out_pipes, pipe_id));
	}
	int Get_Internal_Pipe_Depth(string pipe_id) {
		return(this->Get_Pipe_Depth(_internal_pipes, pipe_id));
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
	int Get_Pipe_Depth(string pipe_id)
	{
		int ret_w = this->Get_Input_Pipe_Depth(pipe_id);
		if(ret_w > 0)
			return(ret_w);
		ret_w = this->Get_Output_Pipe_Depth(pipe_id);

		if(ret_w > 0)
			return(ret_w);

		ret_w = this->Get_Internal_Pipe_Depth(pipe_id);
			
		return(ret_w);
	}
	bool Has_Port(string pid)
	{
		return ( (this->Get_Input_Pipe_Width(pid) > 0)
			||  (this->Get_Output_Pipe_Width(pid) > 0)
			||  (this->Get_Internal_Pipe_Width(pid) > 0));
	}


        void Print_Pipe_Map(map<string, pair<int,int> >& pmap, ostream& ofile)
	{
		for(map<string,pair<int,int> >::iterator iter = pmap.begin(), fiter = pmap.end(); iter != fiter; iter++)
		{
			ofile << (this->Is_Signal((*iter).first) ? "  $signal " : "  $pipe ");
			ofile << " " << (*iter).first << " " << (*iter).second.first << " $depth " <<
					(*iter).second.second;
			ofile << endl;
		}
	}

	void Add_Pipe_To_Map(map<string, pair<int,int> >& pipe_map, string pid, int pipe_width, int pipe_depth,  string pipe_type)
	{
		if(pipe_map.find(pid) != pipe_map.end())
		{
			int width = pipe_map[pid].first;

			if(width != pipe_width)
			{
				hierRoot::Report_Error("incompatible redeclaration of " + pipe_type + 
										" " + pid + " will be ignored. ");
			}
			else
			{
				hierRoot::Report_Warning("Warning : redeclaration of " + pipe_type + " " 
								+ pid + " will ignore second declaration");
			}

		}
		else
		{
			pipe_map[pid] = pair<int,int>(pipe_width, pipe_depth);
		}
	 }


			
	void Add_In_Pipe(string pid, int pipe_width, int depth)
	{

		this->Add_Pipe_To_Map(_in_pipes, pid, pipe_width, depth, "in-pipe");

		if(this->Get_Output_Pipe_Width(pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both input and output pipe.");
		}
		if(this->Get_Internal_Pipe_Width(pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both input and internal pipe.");
		}

	}
	void Add_Out_Pipe(string pid, int pipe_width, int depth)
	{
		Add_Pipe_To_Map(_out_pipes, pid, pipe_width, depth, "out-pipe");
		if(this->Get_Input_Pipe_Width( pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both input and output pipe.");
		}
		if(this->Get_Internal_Pipe_Width( pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both internal and output pipe.");
		}
	}
	void Add_Internal_Pipe(string pid, int pipe_width, int depth)
	{
		Add_Pipe_To_Map(_internal_pipes, pid, pipe_width, depth,  "internal-pipe");
		if(this->Get_Input_Pipe_Width(pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both internal and input pipe.");
		}
		if(this->Get_Output_Pipe_Width(pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both internal and output pipe.");
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
				this->Report_Error(" pipe " + pipe_id + " in system " + 
						this->_id + " is connected to multiple system instances");
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
			this->Report_Error("illegal connection of pipe " + pipe_id + " to child " + 
					child->Get_Id() + " in " + this->_id);
		}
	}
	
	void Add_Child(hierSystemInstance* child)
	{
		if(child == NULL) return;

		string child_id = child->Get_Id();
		if(_child_map.find(child_id) != _child_map.end())
		{
			this->Report_Error("added multiple instances of child " + child_id + " to system " + _id);
		}
		_child_map[child_id] = child;
	}

	//
	// threads and thread-objects.
	//
	void Add_Thread(rtlThread* t);
	void Add_String(rtlString* ti);


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
	void Print_Vhdl_Pipe_Instance(string pipe_name, int pipe_width, int pipe_depth, ostream& ofile);

};

void listPipeMap(map<string, pair<int,int> >& pmap, vector<string>& pvec);

bool getPipeInfoFromGlobals(string pname, map<string, pair<int,int> >& pmap, set<string>& signals, 
			int& width, int& depth, bool& is_signal);

void addPipeToGlobalMaps(string oname, map<string, pair<int,int> >& pipe_map, 
				set<string>& signals, int pipe_width, int pipe_depth, bool is_signal);
#endif
