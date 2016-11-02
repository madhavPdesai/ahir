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
#ifndef rtl_Expression_h__
#define rtl_Expression_h__


#include <rtlInclusions.h>
#include <hierSystem.h>
#include <rtlType.h>



class hierRoot;
class rtlType;
class rtlValue;
class rtlObject;
enum  rtlOperation;

class rtlExpression: public hierRoot
{
	protected:

	rtlType* _type;
	rtlValue* _value;
	bool      _is_target;
	bool      _tick;

	public:
	
	rtlExpression(string id);
	rtlExpression();

	string Kind() {return("rtlExpression");}

	// is a target expression?
	virtual void Set_Is_Target(bool v) {_is_target = v;}
	virtual void Set_Is_Volatile(bool v) {}
	virtual void Set_Is_Not_Volatile(bool v) {}

 	bool Get_Is_Target() {return(_is_target);}


	void Set_Type(rtlType* t) {_type = t;}
	rtlType* Get_Type() {return(_type);}




	virtual void Evaluate(rtlThread* t) {assert(0);}

	virtual bool Is(string kind) {return(kind == this->Kind());}
	virtual void Print(ostream& ofile) {assert(0);}

	virtual rtlValue* Get_Value() {return(_value);}

	virtual string Get_C_Name();
	virtual string Get_C_Target_Name() {return(this->Get_C_Name());}
	virtual string C_Int_Reference();

	virtual void Print_C(ostream& ofile) {assert(0);}
	virtual void Print_C_Declaration(rtlValue* v, ostream& ofile);


	virtual void Collect_Target_Objects(set<rtlObject*> obj_set) {};
	virtual void Collect_Source_Objects(set<rtlObject*> obj_set) {};

	virtual void Set_Tick(bool v) {_tick = v;}
	virtual bool Get_Tick() {return(_tick);}

	virtual string To_Vhdl_String()  {assert(0);};
	virtual bool Writes_To_Signal() {return(false);}
};

class rtlConstantLiteralExpression: public rtlExpression
{
	public:
	
	// literal string and type.
	rtlConstantLiteralExpression(rtlType* t, rtlValue* v): rtlExpression() 
	{
		_type = t;
		_value = v;
	}

	string Kind() {return("rtlConstantLiteralExpression");}

	virtual void Evaluate(rtlThread* t);

	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);

	virtual string To_Vhdl_String();
};

class rtlObjectReference: public rtlExpression
{
	protected:

	rtlObject* _object;

	public:

	rtlObjectReference(string id, rtlObject* obj): rtlExpression(id) {_object = obj;}
	string Kind() {return("rtlObjectReference");}
	
	virtual rtlObject* Get_Object() {return(_object);}

	// passed to objects.
	virtual void Set_Is_Volatile(bool v);
	virtual void Set_Is_Not_Volatile(bool v);
	virtual void Set_Tick(bool v);

	virtual void Collect_Target_Objects(set<rtlObject*> obj_set) 
	{
		if(this->_is_target)
			obj_set.insert(_object);
	};
	virtual void Collect_Source_Objects(set<rtlObject*> obj_set)
	{
		if(!this->_is_target)
			obj_set.insert(_object);
	}
};


class rtlSimpleObjectReference: public rtlObjectReference
{

	bool _req_flag;
	bool _ack_flag;
	bool _is_volatile;
	bool _is_not_volatile;

	public:

	// type extracted from object.
	rtlSimpleObjectReference(rtlObject* obj);
	rtlSimpleObjectReference(rtlObject* obj, bool req_flag, bool ack_flag);

	string Kind() {return("rtlSimpleObjectReference");}

	bool Get_Req_Flag() {return(_req_flag);}
	bool Get_Ack_Flag() {return(_ack_flag);}
	virtual void Evaluate(rtlThread* t);
	virtual string Get_C_Name();
	virtual string Get_C_Target_Name();
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);
	virtual string To_Vhdl_String();
	virtual bool Writes_To_Signal();

	virtual void Set_Is_Volatile(bool v);
	virtual void Set_Is_Not_Volatile(bool v);
	virtual void Set_Tick(bool v);
};

class rtlArrayObjectReference: public rtlObjectReference
{
	protected:
	vector<rtlExpression*> _indices;
	public:

	// type is extracted from object-type's element.
	// Note: currently array references must be to the element-type
	rtlArrayObjectReference(rtlObject* obj, vector<rtlExpression*>& indices);
	string Kind() {return("rtlArrayObjectReference");}

	virtual string Get_C_Target_Name();
	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);
	virtual string To_Vhdl_String();
	virtual bool Writes_To_Signal();
};

class rtlSliceExpression: public rtlExpression
{
	protected:
	rtlExpression* _base;
	int _high;
	int _low;

 public:
	rtlSliceExpression(rtlExpression* base,  int hindex, int lindex):
			rtlExpression(base->Get_Id() + "[" + IntToStr(hindex)  + ":" + IntToStr(lindex) + "]")
	{
		_type = Find_Or_Make_Unsigned_Type((hindex-lindex)+1);
		_base = base;
		_high = hindex;
		_low  = lindex;
	}

	string Kind() {return("rtlSliceExpression");}
	virtual void Set_Is_Target(bool v) 
	{
		this->_base->Set_Is_Target(v);
		this->_is_target = v;
	}

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);
	virtual string To_Vhdl_String();
	virtual bool Writes_To_Signal();
};

class rtlUnaryExpression: public rtlExpression
{
	rtlOperation _op;
	rtlExpression* _rest;
	
	public:
	// type extracted from rest.
	rtlUnaryExpression(rtlOperation op, rtlExpression* rest);
	string Kind() {return("rtlUnaryExpression");}

	virtual void Set_Is_Target(bool v) 
	{
		cerr << "FATAL: unary expression cannot be a target" << endl;
		assert(0);
	}
	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);
	virtual string To_Vhdl_String();
};

class rtlBinaryExpression: public rtlExpression
{
	rtlOperation _op;
	rtlExpression* _first;
	rtlExpression* _second;

	public:

	// type extracted from first, second and op.
	rtlBinaryExpression(rtlOperation op, rtlExpression* first, rtlExpression* second);

	string Kind() {return("rtlBinaryExpression");}

	virtual void Set_Is_Target(bool v) 
	{
		cerr << "FATAL: binary expression cannot be a target" << endl;
		assert(0);
	}

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);

	void Infer_And_Set_Type();
	virtual string To_Vhdl_String();
};

class rtlTernaryExpression: public rtlExpression
{
	rtlExpression* _test;
	rtlExpression* _if_true;
	rtlExpression* _if_false;

	public:

	rtlTernaryExpression(rtlExpression* test, rtlExpression* if_true, rtlExpression* if_false);
	string Kind() {return("rtlTernaryExpression");}

	virtual void Set_Is_Target(bool v) 
	{
		cerr << "FATAL: ternary expression cannot be a target" << endl;
		assert(0);
	}

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);
	virtual string To_Vhdl_String();
};

void Print_C_Test_Condition(rtlExpression* expr, ostream& ofile);

#endif
