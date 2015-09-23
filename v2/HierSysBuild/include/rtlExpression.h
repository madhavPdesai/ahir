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

	public:
	
	rtlExpression(string id);
	rtlExpression();

	string Kind() {return("rtlExpression");}

	// is a target expression?
	virtual void Set_Is_Target(bool v) {_is_target = v;}
	virtual void Set_Is_Emitted(bool v) {}
	virtual void Set_Is_Volatile(bool v) {}

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
	virtual void Set_Is_Emitted(bool v);
	virtual void Set_Is_Volatile(bool v);
};


class rtlSimpleObjectReference: public rtlObjectReference
{

	public:

	// type extracted from object.
	rtlSimpleObjectReference(rtlObject* obj);

	string Kind() {return("rtlSimpleObjectReference");}

	virtual void Evaluate(rtlThread* t);
	virtual string Get_C_Name();
	virtual string Get_C_Target_Name();
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);
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

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);
};

class rtlUnaryExpression: public rtlExpression
{
	rtlOperation _op;
	rtlExpression* _rest;
	
	public:
	// type extracted from rest.
	rtlUnaryExpression(rtlOperation op, rtlExpression* rest);
	string Kind() {return("rtlUnaryExpression");}

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);
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

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);

	void Infer_And_Set_Type();
};

class rtlTernaryExpression: public rtlExpression
{
	rtlExpression* _test;
	rtlExpression* _if_true;
	rtlExpression* _if_false;

	public:

	rtlTernaryExpression(rtlExpression* test, rtlExpression* if_true, rtlExpression* if_false);
	string Kind() {return("rtlTernaryExpression");}

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_C(ostream& ofile);

};

void Print_C_Test_Condition(rtlExpression* expr, ostream& ofile);

#endif
