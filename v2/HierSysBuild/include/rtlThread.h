#ifndef rtl_Thread_h__
#define rtl_Thread_h__

using namespace std;
class hierRoot;
class hierSystem;

class rtlExpression: public hierRoot
{
	public:
};

class rtlObjectReference: public hierRoot
{
};


class rtlUnaryExpression: public hierRoot
{
	rtlOperation _op;
	rtlExpression* _rest;
	
	public:
};

class rtlBinaryExpression: public hierRoot
{
	rtlOperation _op;
	rtlExpression* _first;
	rtlExpression* _second;

	public:
};

class rtlTernaryExpression: public hierRoot
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

class rtlEmitStatement: public hierRoot
{
	rtlObjectReference* _obj_ref;
};

class rtlAssignStatement: public hierRoot
{
	rtlObjectReference* _target;
	rtlExpression*	    _source;

	public:
};


class rtlCallStatement: public hierRoot
{

	rtlThread* _called_thread;
	vector<pair<string, rtlObjectReference*> >  _input_args;
	vector<pair<string, rtlObjectReference*> > _output_args;

	public:
};

class rtlForkJoinStatement: public  hierRoot
{
	vector<rtlCallStatement*> _called_threads;	
	public:
};

class rtlThread: public hierRoot
{
	hierSystem* _parent_system;

	vector<rtlStatement*> _statements;

	set<rtlThread*>    _caller_threads;
	set<rtlThread*>    _called_threads;

	public:
	rtlThread(hierSystem* sys, string id);
	void Add_Statement(rtlStatement* stmt) {_statements.push_back(stmt);}

	void Add_Caller_Thread(rtlThread* t) {_caller_threads.insert(t);}
	void Add_Called_Thread(rtlThread* t) {_called_threads.insert(t);}
	
};


#endif
