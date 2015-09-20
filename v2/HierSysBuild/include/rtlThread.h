#ifndef rtl_Thread_h__
#define rtl_Thread_h__

using namespace std;
class hierRoot;
class hierSystem;
class rtlStatement;

//
//  rtl threads..
// 
class rtlThread: public hierRoot
{
  hierSystem* _parent;
  
	vector<rtlStatement*> _statements;
	map<string, rtlObject*> _objects;

	public:

	rtlThread(hierSystem* p, string id);
	hierSystem* Get_Parent() {return(_parent);}


	void Add_Statement(rtlStatement* stmt) {_statements.push_back(stmt);}
	rtlStatement* Get_Statement(int idx)
	{
		if((idx >= 0) && (idx < _statements.size()))
			return(_statements[idx]);
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

	friend class hierSystem;
};


class rtlString: public hierRoot
{

	rtlThread* _base_thread;
	map<string,vector<string> >  _actual_to_formal_port_map;


	public:
	
	rtlString(string inst_name, rtlThread* base);
	void Add_Port_Map_Entry(vector<string>& formals, string actual);
	void Print(ostream& ofile);

	rtlThread* Get_Base_Thread() {return(_base_thread);}

	void Print_C_State_Structure_Declaration(ostream& source_file);
	void Print_C_State_Structure_Allocator(ostream& source_file);
	void Print_C_State_Structure_Allocator_Call(ostream& source_file);
	void Print_C_Rtl_Aa_Matcher_Structure_Declarations(ostream& source_file);
	void Print_C_Rtl_Aa_Matcher_Allocator(ostream& source_file);
	void Print_C_Rtl_Aa_Ack_Transfers(ostream& source_file);
	void Print_C_Run_Function_Call(ostream& source_file);
	void Print_C_Rtl_Aa_Req_Transfers(ostream& source_file);
	void Print_C_Tick_Function_Call(ostream& source_file);
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

void Print_C_Binary_Operation(string tgt_name, string first_op, string second_op, rtlType* tgt_type, rtlOperation opcode , ostream& ofile);
void Print_C_Assignment(string tgt, string src, rtlType* tt, ostream& ofile);

#endif
