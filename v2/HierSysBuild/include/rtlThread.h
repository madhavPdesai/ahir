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
#ifndef rtl_Thread_h__
#define rtl_Thread_h__

using namespace std;
class hierRoot;
class hierSystem;
class rtlStatement;
class rtlAssignStatement;
class rtlObject;

//
//  rtl threads..
// 
class rtlThread: public hierRoot
{
	protected:
  	hierSystem* _parent;
  
	vector<rtlStatement*> _statements;
	map<string, rtlStatement*> _statement_map;
	map<string, rtlObject*> _objects;

	vector<rtlStatement*> _default_statements;

        vector<rtlStatement*> _immediate_statements;
	vector<rtlStatement*> _tick_statements;


	public:

	rtlThread(hierSystem* p, string id);
	hierSystem* Get_Parent() {return(_parent);}


	void Add_Statement(rtlStatement* stmt);
	void Add_Default_Statement(rtlStatement* stmt) {_default_statements.push_back(stmt);}
	void Add_Immediate_Statement(rtlStatement* stmt);
	void Add_Tick_Statement(rtlStatement* stmt);

	int Get_Number_Of_Statements() {return(_statements.size());}
	rtlStatement* Get_Statement(int idx)
	{
		if((idx >= 0) && (idx < _statements.size()))
			return(_statements[idx]);
		else
			return(NULL);
	}
	rtlStatement* Get_Statement(string label)
	{
		if(_statement_map.find(label) != _statement_map.end())
			return(_statement_map[label]);
		else
			return(NULL);
	}
	void Add_Object(rtlObject* obj);
	rtlObject* Find_Object(string obj_name)
	{
		if(_objects.find(obj_name) != _objects.end())
			return(_objects[obj_name]);
		else
			return(NULL);
	}

	void Lookup_Objects(vector<string> obj_names, vector<rtlObject*>& object_vector)
	{
		for(int I = 0, fI = obj_names.size(); I < fI; I++)
		{
			rtlObject* obj  = this->Find_Object(obj_names[I]);
			assert(obj != NULL);
			object_vector.push_back(obj);
		}
	}
	void List_Objects(vector<rtlObject*>& object_vector)
	{
		for(map<string, rtlObject*>::iterator iter = _objects.begin(), fiter = _objects.end();
			iter != fiter;
			iter++)
		{
			object_vector.push_back((*iter).second);
		}
	}

	// replica print.
	void Print(ostream& ofile);


	void Print_C_Struct_Declaration(ostream& header_file);
	void Print_C_Run_Function(ostream& source_file);
	void Print_C_Tick_Function(ostream& source_file);
	void Print_C_Log_Function(ostream& source_file);

	void Print_Vhdl_Port_Declarations(ostream& ofile);
	void Print_Vhdl_Object_Declarations(bool signal_flag, bool constant_flag, bool variable_flag, ostream& ofile);
	void Print_Vhdl_Buffer_Assignments(ostream& ofile);
	void Print_Vhdl_Component(ostream& ofile);
	void Print_Vhdl_Entity_Architecture(ostream& ofile, int map_all_libs_to_work);

	friend class hierSystem;
	friend class rtlString;
};


class rtlString: public hierRoot
{

	rtlThread* _base_thread;

	// record of pipe accesses.
	map<string,rtlPipeSignalAccessType> _pipe_access_type_map;


	// formal group to actual port map
	map<string,string>  _formal_to_actual_map;

	public:

	string _default_clock;
	string _default_reset;

	
	rtlString(string inst_name, rtlThread* base);
	void Add_Port_Map_Entry(string formal_obj, string actual);
	void Print(ostream& ofile);

	rtlThread* Get_Base_Thread() {return(_base_thread);}

	void Print_C_State_Structure_Declaration(ostream& source_file);
	void Print_C_State_Structure_Allocator(ostream& source_file);
	void Print_C_State_Structure_Allocator_Call(ostream& source_file);
	void Print_C_Rtl_Aa_Matcher_Structure_Declarations(ostream& source_file);
	void Print_C_Rtl_Aa_Matcher_Allocator(ostream& source_file);
	void Print_C_Run_Function_Call(ostream& source_file);
	void Print_C_Tick_Function_Call(ostream& source_file);
	void Print_C_Matcher_Start_Daemons(ostream& source_file, vector<string>& match_daemons);


	rtlPipeSignalAccessType Get_Access_Type(string pipe_name)
	{
		if(_pipe_access_type_map.find(pipe_name) != _pipe_access_type_map.end())
		{
			return(_pipe_access_type_map[pipe_name]);
		}
		else
			return(_NOT_ACCESSED);
	}

	void Set_PipeXSignal_Is_Read_From(string pipe_name)
	{
		rtlPipeSignalAccessType at = this->Get_Access_Type(pipe_name);
		if(at == _NOT_ACCESSED)
			_pipe_access_type_map[pipe_name] = _READ_FROM;
		else if(at == _WRITTEN_TO)
			_pipe_access_type_map[pipe_name] = _READ_FROM_AND_WRITTEN_TO;
	}

	void Set_PipeXSignal_Is_Written_Into(string pipe_name)
	{
		rtlPipeSignalAccessType at = this->Get_Access_Type(pipe_name);
		if(at == _NOT_ACCESSED)
			_pipe_access_type_map[pipe_name] = _WRITTEN_TO;
		else if(at == _WRITTEN_TO)
			_pipe_access_type_map[pipe_name] = _READ_FROM_AND_WRITTEN_TO;
	}

	void Print_Vhdl_Instance(ostream& ofile);
};

string threadStructTypeName(rtlThread* t);
string stateEnum(string state_label);
string threadStateEnumTypeName(rtlThread* t);
string threadRunFunctionName(rtlThread* t);
string threadTickFunctionName(rtlThread* t);
string stringStructObjName(rtlString* s);
string stringStructAllocatorFunctionName(rtlString* s);
string stringMatcherAllocatorFunctionName(rtlString* s);

string stringToPipeMatcherObjName(rtlString* s, string pipe_name);
string pipeToStringMatcherObjName(rtlString* s, string pipe_name);

string pipeToStringMatcherThreadName(rtlString* s, string pipe_name);
string stringToPipeMatcherThreadName(rtlString* s, string pipe_name);

string threadLogFunctionName(rtlThread* t);

void Print_C_Binary_Operation(string tgt_name, string first_op, string second_op, rtlType* tgt_type, rtlOperation opcode , ostream& ofile);
void Print_C_Assignment(string tgt, string src, rtlType* tt, ostream& ofile);

#endif
