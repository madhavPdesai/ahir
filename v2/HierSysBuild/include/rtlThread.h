#ifndef rtl_Thread_h__
#define rtl_Thread_h__

using namespace std;
class hierRoot;
class hierSystem;

class rtlExpression: public hierRoot
{
	public:
};

class rtlConstantLiteral: public rtlExpression
{
	public:
};

class rtlObjectReference: public rtlExpression
{
};


class rtlUnaryExpression: public rtlExpression
{
	rtlOperation _op;
	rtlExpression* _rest;
	
	public:
};

class rtlBinaryExpression: public rtlExpression
{
	rtlOperation _op;
	rtlExpression* _first;
	rtlExpression* _second;

	public:
};

class rtlTernaryExpression: public rtlExpression
{
	rtlExpression* _test;
	rtlExpression* _if_true;
	rtlExpression* _if_false;

	public:
};

class rtlStatement: public hierRoot
{
	public:
};

class rtlEmitStatement: public rtlStatement
{
	rtlObjectReference* _obj_ref;
};

class rtlAssignStatement: public rtlStatement
{
	rtlObjectReference* _target;
	rtlExpression*	    _source;

	public:
};


class rtlCallStatement: public rtlStatement
{

	rtlThread* _called_thread;
	vector<pair<string, rtlObjectReference*> >  _input_args;
	vector<pair<string, rtlObjectReference*> > _output_args;

	public:
};

class rtlForkJoinStatement: public  rtlStatement
{
	vector<rtlCallStatement*> _called_threads;	
	public:
};

//
// TODO
// make a new class: hierModule and
// derive hierSystem, rtlThread from it.
// 
class rtlThread: public hierRoot
{

	hierSystem* _parent_system;
	map<string, int> _default_parameter_map;

	vector<rtlStatement*> _statements;

	set<rtlThread*>    _caller_threads;
	set<rtlThread*>    _called_threads;

	public:
	rtlThread(hierSystem* sys, string id);
	void Add_Default_Parameter(string param_name, int pvalue)
	{
		_default_parameter_map[param_name] = pvalue;
	}

	void Add_Statement(rtlStatement* stmt) {_statements.push_back(stmt);}

	void Add_Caller_Thread(rtlThread* t) {_caller_threads.insert(t);}
	void Add_Called_Thread(rtlThread* t) {_called_threads.insert(t);}
	void Set_Default_Parameter_Map(vector<pair<string,int> >& param_map);

	void Print(ostream& ofile);

	friend class rtlThreadInstance;
	
};

// TODO
// make a generic class rootInstance and
// derive hierInstance and rtlThreadInstance
// from it.
class rtlThreadInstance: public hierRoot
{
	map<string, string> _port_map;
	map<string, int>    _parameter_map;

	hierSystem* _parent_system;
	string _instance_name;
	string _thread_name;

	public:

	rtlThreadInstance(hierSystem* sys, string inst_name, string rtl_thread_name);
	void Set_Port_Map(vector<pair<string,string> >& port_map);

	void Set_Parameter_Map(vector<pair<string,int> >& param_map);


	void Print(ostream& ofile);

	friend class rtlThread;
};


#endif
