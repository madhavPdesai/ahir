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

	virtual bool Get_Tick() {return(false);}
	virtual void Print_Vhdl(ostream& ofile) {assert(0);}
};

class rtlAssignStatementBase: public rtlStatement
{
	protected:
	vector<rtlExpression*>  _targets;
	vector<rtlExpression*>  _sources; 
	bool _volatile;
	bool _tick;

	public:
	rtlAssignStatementBase(rtlThread* p, bool volatile_flag, bool tick_flag, bool imm_flag):rtlStatement(p)
	{
		_volatile = (volatile_flag || imm_flag);
		_tick     = tick_flag;
	}

	bool Get_Volatile() {return(_volatile);}	
	virtual bool Get_Tick() {return(_tick);}

	rtlExpression* Get_Target(int idx) {if((idx >= 0) && (idx < _targets.size())) return(_targets[idx]); else return(NULL);}
	rtlExpression* Get_Source(int idx)  {if((idx >= 0) && (idx < _sources.size())) return(_sources[idx]); else return(NULL);}
	rtlExpression* Get_Target() {return(this->Get_Target(0));}
	rtlExpression* Get_Source() {return(this->Get_Source(0));}

	virtual void Collect_Target_Objects(set<rtlObject*> obj_set);
	virtual void Collect_Source_Objects(set<rtlObject*> obj_set);
	virtual void Update_Target_Flags();

	void Print(ostream& source_file, rtlExpression* target, rtlExpression* source);
	void Print_C(ostream& source_file, rtlExpression* target, rtlExpression* source);
	void Print_Vhdl(ostream& ofile, rtlExpression* target, rtlExpression* source);
};

class rtlAssignStatement: public rtlAssignStatementBase
{
	public:
	rtlAssignStatement(rtlThread* p,bool volatile_flag, bool tick_flag, bool imm_flag,  rtlExpression* tgt, rtlExpression* src);

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
	virtual void Print_Vhdl(ostream& ofile);
};

class rtlSplitStatement: public rtlAssignStatementBase
{
	public:
	rtlSplitStatement(rtlThread* p, bool volatile_flag, bool tick_flag, bool imm_flag,  
						vector<rtlExpression*>& tgts, rtlExpression* src);

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& source_file);
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
