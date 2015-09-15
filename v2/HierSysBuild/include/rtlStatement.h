#ifndef _rtl_Statement__
#define _rtl_Statement__

class rtlExpression;
class rtlThread;

class rtlStatement: public hierRoot
{

	rtlThread* _parent_thread;

	public:

	rtlStatement(rtlThread* p);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL(ostream& ofile);

	// signal declarations associated with the statement.
	// e.g. for the call/return wait signals.
	virtual void Print_VHDL_Signal_Declarations(ostream& ofile) {}

	// variable declarations associated with each statement.
	// e.g. for the call/return wait variables.
	//      for volatile statements.
	virtual void Print_VHDL_Variable_Declarations(ostream& ofile) {}

	// default assignments for the variabls
	virtual void Print_VHDL_Variable_Default_Assignments(ostream& ofile) {}
	// reset values to signals.
	virtual void Print_VHDL_Reset_Assignments(ostream& ofile) {}
	// immediates (e.g. emits, calls).
	virtual void Print_VHDL_Immediate_Assignments(ostream& ofile) {}
	// clocked assignments (e.g. call wait signals).
	virtual void Print_VHDL_Clocked_Assignments(ostream& ofile) {}

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
	virtual void Print_VHDL(ostream& ofile);

	// signal declarations associated with the statement.
	// e.g. for the call/return wait signals.
	virtual void Print_VHDL_Signal_Declarations(ostream& ofile) {}
	// variable declarations associated with each statement.
	// e.g. for the call/return wait variables.
	virtual void Print_VHDL_Variable_Declarations(ostream& ofile) {}
	// default assignments for the variabls
	virtual void Print_VHDL_Variable_Default_Assignments(ostream& ofile) {}
	// reset values to signals.
	virtual void Print_VHDL_Reset_Assignments(ostream& ofile) {}
	// immediates (e.g. emits, calls).
};

class rtlEmitStatement: public rtlStatement
{
	rtlObject* _object;

	public:
	rtlEmitStatement(rtlThread* p, rtlObject* emittee);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL(ostream& ofile);
	// signal declarations associated with the statement.
	// e.g. for the call/return wait signals.
	virtual void Print_VHDL_Signal_Declarations(ostream& ofile) {}
	// variable declarations associated with each statement.
	// e.g. for the call/return wait variables.
	virtual void Print_VHDL_Variable_Declarations(ostream& ofile) {}
	// default assignments for the variabls
	virtual void Print_VHDL_Variable_Default_Assignments(ostream& ofile) {}
	// reset values to signals.
	virtual void Print_VHDL_Reset_Assignments(ostream& ofile) {}
	// immediates (e.g. emits, calls).
};

class rtlGotoStatement: public rtlStatement
{
	string _label;

	public:
	rtlGotoStatement(rtlThread* p, string lbl);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL(ostream& ofile);

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
			rtlBlockStatement* else_block);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL(ostream& ofile);

	// signal declarations associated with the statement.
	// e.g. for the call/return wait signals.
	virtual void Print_VHDL_Signal_Declarations(ostream& ofile) {}
	// variable declarations associated with each statement.
	// e.g. for the call/return wait variables.
	virtual void Print_VHDL_Variable_Declarations(ostream& ofile) {}
	// default assignments for the variabls
	virtual void Print_VHDL_Variable_Default_Assignments(ostream& ofile) {}
	// reset values to signals.
	virtual void Print_VHDL_Reset_Assignments(ostream& ofile) {}
	// immediates (e.g. emits, calls).

};


class rtlBlockStatement: public rtlStatement
{
	vector<rtlStatement*> _statement_block;

	public:
	rtlBlockStatement(rtlThread* p, vector<rtlStatement*>& sblock);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL(ostream& ofile);
	// signal declarations associated with the statement.
	// e.g. for the call/return wait signals.
	virtual void Print_VHDL_Signal_Declarations(ostream& ofile) {}
	// variable declarations associated with each statement.
	// e.g. for the call/return wait variables.
	virtual void Print_VHDL_Variable_Declarations(ostream& ofile) {}
	// default assignments for the variabls
	virtual void Print_VHDL_Variable_Default_Assignments(ostream& ofile) {}
	// reset values to signals.
	virtual void Print_VHDL_Reset_Assignments(ostream& ofile) {}
	// immediates (e.g. emits, calls).

};

class rtlLabeledBlockStatement: public rtlBlockStatement
{
	string _label; 

	public:
	rtlLabeledBlockStatement(rtlThread* p, string lbl, vector<rtlStatement*>& sblock);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL(ostream& ofile);

	// signal declarations associated with the statement.
	// e.g. for the call/return wait signals.
	virtual void Print_VHDL_Signal_Declarations(ostream& ofile) {}
	// variable declarations associated with each statement.
	// e.g. for the call/return wait variables.
	virtual void Print_VHDL_Variable_Declarations(ostream& ofile) {}
	// default assignments for the variabls
	virtual void Print_VHDL_Variable_Default_Assignments(ostream& ofile) {}
	// reset values to signals.
	virtual void Print_VHDL_Reset_Assignments(ostream& ofile) {}
	// immediates (e.g. emits, calls).

};


// null statement
class rtlNullStatement: public rtlStatement
{
	public:
	rtlNullStatement(rtlThread* p);
};

#endif
