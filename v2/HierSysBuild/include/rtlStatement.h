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
};

class rtlAssignStatement: public rtlStatement
{

	rtlExpression* _target;
	rtlExpression* _source; 
	bool _volatile;

	public:

	rtlAssignStatement(rtlThread* p,bool volatile_flag,  rtlExpression* tgt, rtlExpression* src);

	bool Get_Volatile() {return(_volatile);}

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
};


class rtlGotoStatement: public rtlStatement
{
	string _label;

	public:
	rtlGotoStatement(rtlThread* p, string lbl);

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
};

class rtlBlockStatement;
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
	virtual string Get_Label() {return(_label);}
};


// null statement
class rtlNullStatement: public rtlStatement
{
	public:
	rtlNullStatement(rtlThread* p);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file) {source_file << endl << ";" << endl;}
};

#endif
