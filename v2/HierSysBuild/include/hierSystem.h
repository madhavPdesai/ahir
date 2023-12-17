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


class rtlObject;
class rtlThread;
class rtlString;

uint32_t getGlobalInstanceId ();
uint32_t IntPower(uint32_t A, uint32_t B); // return A**B
string  Make_C_Legal(string x);

class hierRoot
{
	public:
	int    _index;
	int    _line_number;
	string _id;
	bool _error;
	

	static int _error_count;
	static int _warning_count;

	hierRoot(string id);
	hierRoot();

	virtual void Set_Line_Number(int q) {_line_number = q;}
	int Get_Line_Number() {return(_line_number);}

	string Get_Id() {return(_id);}
	int Get_Index() {return(_index);}

	void Set_Error(bool v) {_error = true;}
	bool Get_Error() {return(_error);}

	void Report_Info(string err_msg)
	{ 
		cerr << "Info: " << err_msg << endl;
	}
	void Report_Warning(string err_msg)
	{ 
		cerr << "Warning: " << err_msg  <<  endl;
		hierRoot::_warning_count++;
	}
	void Report_Error(string err_msg)
	{ 
		cerr << "Error: " << err_msg <<  endl; this->Set_Error(true); 
		hierRoot::_error_count++;
	}
	
	virtual string Kind() {return("hierRoot");}
	bool Is(string K) {return(K==this->Kind());}


	virtual void Print(ostream& ofile) {assert(0);}
	void Print(ofstream& ofile);
	void Print(string& ostring);
	virtual string To_String()
	{
		string ret_val;
		this->Print(ret_val);
		return(ret_val);
	}
	
};

class hierSystem;
class hierPipe: public hierRoot
{
	public:
	hierSystem* _scope;
	string _name;
	int    _width;
	int    _depth;
	bool   _is_signal;
	bool   _is_noblock;
	bool   _is_shiftreg;
	bool   _is_p2p;
	bool   _is_input;
	bool   _is_output;
	bool   _is_internal;
        bool   _bypass;
	bool   _is_clock;
	bool   _is_reset;

	string _default_clock;
	string _default_reset;

	hierPipe(string name, int width, int depth);
	void Set_Is_Signal(bool v) {_is_signal = v;}
	void Set_Is_Noblock(bool v) {_is_noblock = v;}
	void Set_Is_Shiftreg(bool v) {_is_shiftreg = v;}
	void Set_Is_P2P(bool v) {_is_p2p = v;}
	void Set_Is_Input(bool v) {_is_input = v;}
	void Set_Is_Output(bool v) {_is_output = v;}
	void Set_Is_Internal(bool v) {_is_internal = v;}
	void Set_Bypass(bool v) {_bypass = v;}
	void Set_Is_Clock(bool v) {_is_clock = v;}
	void Set_Is_Reset(bool v) {_is_reset = v;}

	bool Get_Is_Signal() {return(_is_signal);}
	bool Get_Is_Noblock() {return(_is_noblock);}
	bool Get_Is_Shiftreg() {return(_is_shiftreg);}
	bool Get_Is_P2P() {return(_is_p2p);}
	bool Get_Is_Input() {return(_is_input);}
	bool Get_Is_Output() {return(_is_output);}
	bool Get_Is_Internal() {return(_is_internal);}
	bool Get_Bypass() {return(_bypass);}
	bool Get_Is_Clock() {return(_is_clock);}
	bool Get_Is_Reset() {return(_is_reset);}

	string Get_Name() {return(_name);}
	int    Get_Depth() {return(_depth);}
	int    Get_Width() {return(_width);}

	virtual void Print(ostream& ofile)
	{
		ofile << " ";
		if(_is_noblock)
			ofile  << "$noblock ";
		if(_is_p2p)
			ofile  << "$p2p ";
		if(_bypass)
			ofile << "$bypass ";
		if(_is_signal)
		{
			ofile << "$signal ";
			if(_is_clock) ofile << " $clk " ;
			else if(_is_reset) ofile << " $reset ";
		}
		else
			ofile << "$pipe ";

		ofile << _name << " " << _width << " $depth " << _depth << " " << endl;

	}

	void Print_Vhdl_Instance(hierSystem* sys, ostream& ofile);
};

class hierSystem;
class hierSystemInstance: public hierRoot
{
	public:

	hierSystem* _parent;
	hierSystemInstance* _parent_instance;
	hierSystem* _base_system;

	uint32_t _global_instance_id;
	void  	  Set_Global_Instance_Id(uint32_t u) { _global_instance_id = u;}
	uint32_t  Get_Global_Instance_Id() {return (_global_instance_id);}

	// defaults are clk, reset.
	string _default_clock;
	string _default_reset;

	map<string, string> _port_map;
	map<string, string> _reverse_port_map;


	hierSystemInstance(hierSystem* parent, hierSystem* base_sys, string id);


	hierSystem* Get_Parent() {return(_parent);}
	hierSystem* Get_Base_System() {return(_base_system);}
	bool Add_Port_Mapping(string formal, 
				string actual, 
				map<string, hierPipe* >& pmap);
	bool Add_Port_Mapping(string formal, string actual);
	bool Map_Unmapped_Ports_To_Defaults( map<string, hierPipe* >& pmap);


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


	void Set_Default_Clock(string clk_id);
	void Set_Default_Reset(string reset_id);
	

	virtual void Print(ostream& ofile);
	void Print_Vhdl(ostream& ofile);


};

class hierInstanceGraph;
class FlatLeafGraph;
class hierSystem: public hierRoot
{
        string _library;
	hierSystem* _parent;


	set<hierPipe*> _pipe_set;

	map<string, hierPipe* > _pipe_map;

	map<string, hierPipe* > _in_pipes;
	map<string, hierPipe* > _out_pipes;
	map<string, hierPipe* > _internal_pipes;

	map<string, hierSystemInstance*>  _pipe_to_subsystem_connection_map;
	map<hierSystemInstance*, vector<string> > _subsystem_pipe_connection_map;
	map<string,  hierSystemInstance* > _child_map;

	int _instance_count;

	// pipes that are driven
	set<string> _driven_pipes;
	set<string> _driving_pipes;

	map<string, rtlThread*> _thread_map;

	//
	// order is important (for generating C model).
	//
	map<string, rtlString*> _rtl_string_map;
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


	bool Pipe_Is_Mapped_To_Subsystem(string pname)
        {
		bool ret_val = (_pipe_to_subsystem_connection_map.find(pname) !=  _pipe_to_subsystem_connection_map.end());
		return(ret_val);
        }
	int Get_Instance_Count() {return(_instance_count);}
	void Increment_Instance_Count() {_instance_count++;}

        bool Is_Leaf() {return(_child_map.size() == 0);}
	void Set_Library(string s) {cerr << "Info: setting library for " << _id << " to " << s << endl; _library = s;}
	string Get_Library() {return(_library);}

	int Get_Number_Of_In_Pipes() {return(_in_pipes.size());}
	void List_In_Pipe_Names(vector<string>& pvec);
	void List_Out_Pipe_Names(vector<string>& pvec);
	void List_Internal_Pipe_Names(vector<string>& pvec);
	
	void List_In_Pipes(vector<hierPipe*>& pvec);
	void List_Out_Pipes(vector<hierPipe*>& pvec);
	void List_Internal_Pipes(vector<hierPipe*>& pvec);

	hierPipe* Find_Pipe(string pname)
	{
		if(_pipe_map.find(pname) != _pipe_map.end())
			return(_pipe_map[pname]);
		else	
			return(NULL);
	}	

	void Add_Noblock_Pipe(string pname)
	{
		if(_pipe_map.find(pname) != _pipe_map.end())
			_pipe_map[pname]->Set_Is_Noblock(true);
		else
			hierRoot::Report_Error("Failed to add noblock pipe " + pname + ", pipe not found.");
	}

	bool Is_Noblock_Pipe(string pname)
	{
		if(_pipe_map.find(pname) != _pipe_map.end())
			return(_pipe_map[pname]->Get_Is_Noblock());
		else
			return(false);
	}

	void Add_Signal(string pname)
	{
		if(_pipe_map.find(pname) != _pipe_map.end())
			_pipe_map[pname]->Set_Is_Signal(true);
		else
			hierRoot::Report_Error("Failed to add signal " + pname + ", pipe not found.");
	}

	bool Is_Signal(string pname)
	{
		if(_pipe_map.find(pname) != _pipe_map.end())
			return(_pipe_map[pname]->Get_Is_Signal());
		else	
			return(false);
	}

	void Mark_As_Clock(string sname)
	{
		if(this->Is_Signal(sname))
		{
			_pipe_map[sname]->Set_Is_Clock(true);
		}
	}	

	void Mark_As_Reset(string sname)
	{
		if(this->Is_Signal(sname))
		{
			_pipe_map[sname]->Set_Is_Reset(true);
		}
	}	

	bool Is_Marked_As_Clock(string sname)
	{
		bool rv = false;
		if(this->Is_Signal(sname))
		{
			rv =  (_pipe_map[sname]->Get_Is_Clock());
		}
		return(rv);
	}

	bool Is_Marked_As_Reset(string sname)
	{
		bool rv = false;
		if(this->Is_Signal(sname))
		{
			rv =  (_pipe_map[sname]->Get_Is_Reset());
		}
		return(rv);
	}

	int Get_Pipe_Width(map<string, hierPipe*>& pmap, string pname)
	{
		if(pmap.find(pname) != pmap.end())
			return(pmap[pname]->Get_Width());
		else
			return(0);
	}
	int Get_Pipe_Depth(map<string, hierPipe*>& pmap, string pname)
	{
		if(pmap.find(pname) != pmap.end())
			return(pmap[pname]->Get_Depth());
		else
			return(0);
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
		if(_pipe_map.find(pipe_id) != _pipe_map.end())
			return(_pipe_map[pipe_id]->Get_Width());
		else
			return(0);
	}
	int Get_Pipe_Depth(string pipe_id)
	{
		if(_pipe_map.find(pipe_id) != _pipe_map.end())
			return(_pipe_map[pipe_id]->Get_Depth());
		else
			return(0);
	}
	bool Has_Port(string pid)
	{
		return(_pipe_map.find(pid) != _pipe_map.end());
	}

        void Print_Pipe_Map(map<string, hierPipe* >& pmap, ostream& ofile)
	{
		for(map<string,hierPipe* >::iterator iter = pmap.begin(), fiter = pmap.end(); iter != fiter; iter++)
		{
			(*iter).second->Print(ofile);
		}
	}

	// add pipe to pipe-map.
	hierPipe* Add_Pipe(string pid, int pipe_width, int pipe_depth, string pipe_type)
	{
		hierPipe* p = NULL;
		if(_pipe_map.find(pid) != _pipe_map.end())
		{
			hierRoot::Report_Warning("Warning : redeclaration of " + pipe_type + " " 
								+ pid + " will ignore second declaration");

			p = _pipe_map[pid];
			if(p->Get_Width() != pipe_width)
			{
				hierRoot::Report_Error("incompatible widths.. redeclaration of " + pipe_type + 
										" " + pid + " will be ignored. ");
			}
			if(p->Get_Depth() != pipe_depth)
			{
				hierRoot::Report_Error("incompatible depths.. redeclaration of " + pipe_type + 
										" " + pid + " will be ignored. ");
			}
		}
		else
		{
			p = new hierPipe(pid, pipe_width, pipe_depth);
			_pipe_map[pid] = p;
			_pipe_set.insert(p);
			p->_scope =  this;
		}
		return(p);
	}

	bool Has_Pipe(hierPipe* p) {return(_pipe_set.find(p) != _pipe_set.end());}
	void Add_Pipe_To_Map(map<string, hierPipe*>& pipe_map, string pipe_name, int width, int depth,
					string pipe_type)
	{
		if(pipe_map.find(pipe_name) != pipe_map.end())
		{
			hierRoot::Report_Warning("Warning : redeclaration of " + pipe_type + " " 
								+ pipe_name + " will ignore second declaration");

			hierPipe* p = pipe_map[pipe_name];
			if(p->Get_Width() != width)
			{
				hierRoot::Report_Error("incompatible widths.. redeclaration of " + pipe_type + 
										" " + pipe_name + " will be ignored. ");
			}
			if(p->Get_Depth() != depth)
			{
				hierRoot::Report_Error("incompatible depths.. redeclaration of " + pipe_type + 
										" " + pipe_name + " will be ignored. ");
			}

		}
		else
		{
			pipe_map[pipe_name] = new hierPipe(pipe_name, width, depth);
		}
	 }


			
	void Add_In_Pipe(string pid, int pipe_width, int depth, bool noblock_flag, bool p2p_flag, 
						bool shiftreg_mode, bool bypass_flag)
	{
		hierPipe* p = this->Add_Pipe(pid, pipe_width, depth, "in-pipe");
		_in_pipes[pid] = p;
		p->Set_Is_Input(true);

		if(noblock_flag)
			p->Set_Is_Noblock(true);
		if(p2p_flag)
			p->Set_Is_P2P(true);
		if(shiftreg_mode)
			p->Set_Is_Shiftreg(true);
		if(bypass_flag)
			p->Set_Bypass(true);

		if(this->Get_Output_Pipe_Width(pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both input and output pipe.");
		}
		if(this->Get_Internal_Pipe_Width(pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both input and internal pipe.");
		}

	}
	void Add_Out_Pipe(string pid, int pipe_width, int depth, bool noblock_flag, bool p2p_flag, 
						bool shiftreg_mode, bool bypass_flag)
	{
		hierPipe* p = this->Add_Pipe(pid, pipe_width, depth, "out-pipe");
		_out_pipes[pid] = p;
		p->Set_Is_Output(true);
		if(noblock_flag)
			p->Set_Is_Noblock(true);
		if(p2p_flag)
			p->Set_Is_P2P(true);
		if(shiftreg_mode)
			p->Set_Is_Shiftreg(true);
		if(bypass_flag)
			p->Set_Bypass(true);

		if(this->Get_Input_Pipe_Width( pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both input and output pipe.");
		}
		if(this->Get_Internal_Pipe_Width( pid) > 0)
		{
			this->Report_Error("pipe " + pid + " in system " + this->_id + " is both internal and output pipe.");
		}
	}
	void Add_Internal_Pipe(string pid, int pipe_width, int depth, bool noblock_flag, bool p2p_flag, 
					bool shiftreg_mode, bool bypass_flag)
	{
		hierPipe* p = this->Add_Pipe(pid, pipe_width, depth, "internal-pipe");
		_internal_pipes[pid] = p;
		p->Set_Is_Internal(true);
		if(noblock_flag)
			p->Set_Is_Noblock(true);
		if(p2p_flag)
			p->Set_Is_P2P(true);
		if(shiftreg_mode)
			p->Set_Is_Shiftreg(true);
		if(bypass_flag)
			p->Set_Bypass(true);

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

	rtlThread* Find_Thread(string tname)
	{
		if(_thread_map.find(tname) != _thread_map.end())
			return(_thread_map[tname]);
		else
			return(NULL);
	}

	rtlString* Find_String(string sname)
	{
		if(_rtl_string_map.find(sname) != _rtl_string_map.end())
			return(_rtl_string_map[sname]);
		else
			return(NULL);
	}

	void List_Threads(vector<rtlThread*>& thread_vec)
	{
		for(map<string,rtlThread*>::iterator iter = _thread_map.begin(),
				fiter = _thread_map.end(); iter != fiter; iter++)
		{
			thread_vec.push_back((*iter).second);
		}
	}

	void List_Strings(vector<rtlString*>& string_vec)
	{
		
		for(int I = 0, fI = _rtl_strings.size(); I < fI; I++)
		{
			string_vec.push_back(_rtl_strings[I]);
		}
	}	

	
	int Number_Of_Strings() {return(_rtl_strings.size());}
	rtlString* Get_Rtl_String(int idx)
	{
		if((idx >= 0) && (idx < _rtl_strings.size()))
			return(_rtl_strings[idx]);
		else
			return(NULL);
	}


	// C string ticker!
	//   - print two functions for each 
	//     thread
	//         - run
	//         - tick.
	// these functions will be declared in the
	// header and defined in the source file.
	// 
	// For each string, declare a data structure
	// which encodes the string state (in the header file).
	//
	// Declare a ticker thread and define it in the
	// source
	//    - creates the string data structures
	//    - runs an infinite loop
	//         run-all-strings
	//         tick-all-strings
	//
	// For each pipe mapped to an input of a string
	//  - create an Aa2Rtl matcher structure and thread.
	// 
	// For each pipe mapped to an output of a string
	// -  create an Rtl2Aa matcher structure.
	//
	// For each signal mapped to an input of a string
	//  - create an Aa2Rtl matcher structure and thread.
	// 
	// For each signal mapped to an output of a string
	// -  create an Rtl2Aa matcher structure.
	//
	// in start daemons, start the ticker and the individual
	// threads for Rtl<->Aa matchers.
	//
	void Print_C_String_Ticker(ostream& header_file, ostream& src_file, vector<string>& match_daemons);

	// return true if error found.
	bool Check_For_Errors();

	// print function.. reproduce description.
	virtual void Print(ostream& ofile);

	// print Vhdl
	void Print_Vhdl_Port_Declarations(ostream& ofile);
	void Print_Vhdl_Component_Declaration(ostream& ofile);
	void Print_Vhdl_Inclusions(ostream& ofile, int map_all_libs_to_work, bool print_fence);
	void Print_Vhdl_Rtl_Threads(ostream& ofile, int map_all_libs_to_work);
	void Print_Vhdl_Entity_Architecture(ostream& ofile, int map_all_libs_to_work);
	void Print_Vhdl_Test_Bench(string sim_link_lib, string sim_link_prefix, ostream& ofile, int map_all_libs_to_work); // in progress.
	void Print_Vhdl_Instance_In_Testbench(string inst_name, ostream& ofile);
	void Print_Vhdl_Pipe_Instance(string pipe_name, int pipe_width, int pipe_depth, ostream& ofile);

	//  pipe access names.
	string Get_Pipe_Vhdl_Write_Data_Name(string pipe);
	string Get_Pipe_Vhdl_Write_Req_Name(string pipe);
	string Get_Pipe_Vhdl_Write_Ack_Name(string pipe);

	string Get_Pipe_Vhdl_Read_Data_Name(string pipe);
	string Get_Pipe_Vhdl_Read_Req_Name(string pipe);
	string Get_Pipe_Vhdl_Read_Ack_Name(string pipe);

	void Print_Vhdl_Rtl_Type_Package(ostream& ofile);

	void Build_Instance_Hierarchy(hierInstanceGraph** instance_graph);
	void Build_Instance_Graph_Arcs (hierInstanceGraph* instance_graph);
	void Partition_Flat_Graph(FlatLeafGraph* g, set<string>& hw_instances, FlatLeafGraph** sw_graph, FlatLeafGraph** hw_graph);

	void Set_Pipe_Default_Clock (string pipe_name, string clk_name);
	void Set_Pipe_Default_Reset (string pipe_name, string reset_name);
};

class hierInstanceGraph;
class hierPipeInstance: public hierRoot
{
	public:
		hierPipe* _pipe;
		hierInstanceGraph* _instance_graph_node;
		hierPipeInstance* _root_actual_pipe;

		hierPipeInstance(hierPipe* p, hierInstanceGraph* g)
		{
			_pipe = p;
			_instance_graph_node = g;
			_root_actual_pipe = NULL;
		}

		string Hierarchical_Name();
};

class hierInstanceGraphArc: public hierRoot
{
	public:

	hierPipeInstance* _formal_pipe;
	hierPipeInstance* _actual_pipe;


	hierInstanceGraph* _driver;
	hierInstanceGraph* _receiver;
	hierInstanceGraph* _parent;

	hierInstanceGraphArc(hierInstanceGraph* prnt, string id): hierRoot(id)
	{
		_parent = prnt;
		_formal_pipe = NULL;
		_actual_pipe = NULL;
		_driver = NULL;
		_receiver = NULL;
	}


	void Set_Formal_Pipe(hierPipeInstance* p) 
	{	
		assert((_formal_pipe == NULL) || (_formal_pipe == p));
		_formal_pipe = p;
	}
	
	void Set_Actual_Pipe(hierPipeInstance* p) 
	{	
		assert((_actual_pipe == NULL) || (_actual_pipe == p));
		_actual_pipe = p;
	}

	void Set_Driver(hierInstanceGraph* driver)
	{
		assert(_driver == NULL);
		_driver = driver;
	}

	void Set_Receiver(hierInstanceGraph* receiver)
	{
		assert(_receiver == NULL);
		_receiver = receiver;
	}

	virtual void Print(ostream& ofile);
};


class FlatLeafGraph;
class hierInstanceGraph: public hierRoot
{
	public:
		hierSystem* _system;

		hierSystemInstance* _instance;

		hierInstanceGraph* _parent;

		vector<hierInstanceGraph*> _child_nodes;
		vector<hierInstanceGraphArc*> _arcs;


		string _default_flat_clock;
		string _default_flat_reset;

		// pipe-instance map.
		map<hierPipe*, hierPipeInstance*> _pipe_instance_map;

		int _depth;

		hierInstanceGraph(hierSystemInstance* inst): hierRoot(inst->Get_Id())
		{
			_parent = NULL;
			_instance = inst;
			_system   = inst->Get_Base_System();
			_depth    = 0;
		}

		hierInstanceGraph(hierSystem* sys):hierRoot(sys->Get_Id())  
		{
			_parent = NULL;
			_depth = 0;
			_system = sys; 
			_instance = NULL;
		}
		
		void Add_Node(hierInstanceGraph* child) 
		{ 
			_child_nodes.push_back(child); 
			child->_depth = (this->_depth + 1);
		}
		void Add_Arc(hierInstanceGraph* driver, hierInstanceGraph* receiver, hierPipeInstance* formal_p, hierPipeInstance* actual_p)
		{
			string arc_id = ((formal_p == NULL) ? "null" : formal_p->_pipe->Get_Id()) 
						+ "_" + ((actual_p != NULL) ? actual_p->_pipe->Get_Id() : "null");
			hierInstanceGraphArc* new_arc = new hierInstanceGraphArc(this,arc_id);

			new_arc->_formal_pipe = formal_p;
			new_arc->_actual_pipe = actual_p;
			new_arc->_driver = driver;
			new_arc->_receiver = receiver;

			_arcs.push_back(new_arc);
		}

		void Build_Connectivity();
		void Set_Root_Pipes(map<hierPipeInstance*,hierPipeInstance*>& root_pipe_map);
		void Build_Flat_Leaf_Graph(FlatLeafGraph** flg);

		string Find_Default_Flat_Clock();
		string Find_Default_Flat_Reset();

		void Set_Default_Flat_Clock();
		void Set_Default_Flat_Reset();

		virtual void Print(ostream& ofile);
	
		
		string Hierarchical_Name();
};


class FlatLeafGraph: public hierRoot
{
	public:

		set<hierPipeInstance*> _flat_pipes;
		set<hierInstanceGraph*> _instances;

		map<hierPipeInstance*, hierInstanceGraph*> _driven_instance_map;
		map<hierPipeInstance*, hierInstanceGraph*> _driving_instance_map;

		FlatLeafGraph():hierRoot() {}
		virtual void Print(ostream& ofile);


		void Print_Hsys_File(string top_name, string top_lib_name, ostream& ofile);
		void Print_Pipe_Classifications(set<string>& hw_instances, ostream& ofile);

		void Print_Uniquification_File (string top_name, string top_lib_name, ostream& ofile);

};

void listPipeMap(map<string, hierPipe* >& pmap, vector<string>& pvec);
void listPipeMap(map<string, hierPipe* >& pmap, vector<hierPipe*>& pvec);

bool getPipeInfoFromGlobals(string pname, 
				map<string, hierPipe*>& pmap,
					int& width, int& depth, bool& is_signal, bool& noblock_flag,
						bool& p2p_flag, bool& shiftreg_flag, bool& bypass_flag);

void addPipeToGlobalMaps(string oname, 
				map<string, hierPipe*>& pipe_map, 
					int pipe_width, int pipe_depth, bool is_signal, bool noblock_mode, 
						bool shiftreg_mode,
						bool p2p_mode, bool bypass_flag);


string IntToStr(int u);
string UintToStr(unsigned int u);
#endif
