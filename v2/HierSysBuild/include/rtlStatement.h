#ifndef _rtl_Statement__
#define _rtl_Statement__

class rtlExpression;
class rtlThread;

class rtlStatement: public hierRoot
{
	protected:

	rtlThread* _parent_thread;

	public:

	rtlStatement(rtlThread* p);
	virtual void Print(ostream& ofile) {assert(0);}
	virtual string Get_Label() {assert(0);}
	virtual void Print_C(ostream& source_file) {assert(0);}
	rtlThread* Get_Parent_Thread() {return(_parent_thread);}
	virtual void Collect_Target_Objects(set<rtlObject*> obj_set) {};
	virtual void Collect_Source_Objects(set<rtlObject*> obj_set) {};

	virtual void Set_Tick(bool v) {}
	virtual bool Get_Tick() {return(false);}
	virtual void Print_Vhdl(ostream& ofile) {assert(0);}
};

class rtlAssignStatement: public rtlStatement
{

	rtlExpression* _target;
	rtlExpression* _source; 
	bool _volatile;
	bool _tick;

	public:

	rtlAssignStatement(rtlThread* p,bool volatile_flag,  rtlExpression* tgt, rtlExpression* src);

	bool Get_Volatile() {return(_volatile);}	

	virtual void Set_Tick(bool v);
	virtual bool Get_Tick() {return(_tick);}

	rtlExpression* Get_Target() {return(_target);}
	rtlExpression* Get_Source() {return(_source);}


	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);

	virtual void Collect_Target_Objects(set<rtlObject*> obj_set);
	virtual void Collect_Source_Objects(set<rtlObject*> obj_set);
	virtual void Print_Vhdl(ostream& ofile);
};


class rtlGotoStatement: public rtlStatement
{
	string _label;

	public:
	rtlGotoStatement(rtlThread* p, string lbl);

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
	virtual void Print_Vhdl(ostream& ofile);
};

class rtlBlockStatement: public rtlStatement
{
	vector<rtlStatement*> _statement_block;

	public:
	rtlBlockStatement(rtlThread* p, vector<rtlStatement*>& sblock): rtlStatement(p)
	{
		_statement_block = sblock;
	}

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
	virtual void Print_Vhdl(ostream& ofile);

	virtual void Collect_Target_Objects(set<rtlObject*> obj_set)
	{
		for(int I = 0, fI = _statement_block.size(); I < fI; I++)
			_statement_block[I]->Collect_Target_Objects(obj_set);
	}

	virtual void Collect_Source_Objects(set<rtlObject*> obj_set)
	{
		for(int I = 0, fI = _statement_block.size(); I < fI; I++)
			_statement_block[I]->Collect_Source_Objects(obj_set);
	}

	virtual void Set_Tick(bool v)
	{
		for(int I = 0, fI = _statement_block.size(); I < fI; I++)
			_statement_block[I]->Set_Tick(v);
	}
};

class rtlIfStatement: public rtlStatement
{
	rtlExpression* _test;
	rtlBlockStatement* _if_block;
	rtlBlockStatement* _else_block; 
	public:
	rtlIfStatement(rtlThread* p,
			rtlExpression* test, 
			rtlBlockStatement* if_block,
			rtlBlockStatement* else_block):rtlStatement(p)
	{
		_test = test;
		_if_block = if_block;
		_else_block  = else_block;
	}
	

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
	virtual void Print_Vhdl(ostream& ofile);
	virtual void Collect_Target_Objects(set<rtlObject*> obj_set)
	{
		if(_if_block)	
			_if_block->Collect_Target_Objects(obj_set);
		if(_else_block)	
			_else_block->Collect_Target_Objects(obj_set);
	}
	virtual void Collect_Source_Objects(set<rtlObject*> obj_set)
	{
		if(_if_block)	
			_if_block->Collect_Source_Objects(obj_set);
		if(_else_block)	
			_else_block->Collect_Source_Objects(obj_set);
	}
	virtual void Set_Tick(bool v)
	{
		if(_if_block)	
			_if_block->Set_Tick(v);
		if(_else_block)	
			_else_block->Set_Tick(v);
	}
};



class rtlLabeledBlockStatement: public rtlBlockStatement
{
	string _label; 

	public:
	rtlLabeledBlockStatement(rtlThread* p, string lbl, vector<rtlStatement*>& sblock):rtlBlockStatement(p,sblock)
	{
		_label = lbl;
	}

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
	virtual void Print_Vhdl(ostream& ofile);
	virtual string Get_Label() {return(_label);}
};


// null statement
class rtlNullStatement: public rtlStatement
{
	public:
	rtlNullStatement(rtlThread* p);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file) {source_file << endl << ";" << endl;}
	virtual void Print_Vhdl(ostream& ofile) {}
};


class rtlLogStatement:public rtlStatement
{
	rtlObject* _object;	
	public:
	rtlLogStatement(rtlThread* p, rtlObject* obj): rtlStatement(p)
	{
		_object = obj;
	}

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
	virtual void Print_Vhdl(ostream& ofile);
};
#endif
