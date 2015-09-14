#ifndef rtl_Expression_h__
#define rtl_Expression_h__

using namespace std;

class hierRoot;
class rtlType;
class rtlValue;
class rtlObject;

class rtlExpression: public hierRoot
{
	protected:

	rtlType* _type;
	rtlValue* _value;
	bool      _is_target;

	public:
	
	rtlExpression();

	string Kind() {return("rtlExpression");}

	// is a target expression?
	void Set_Is_Target(bool v) {_is_target = v;}
 	bool Get_Is_Target() {return(_is_target);}


	void Set_Type(rtlType* t) {_type = t;}
	rtlType* Get_Type() {return(_type);}


	virtual void Evaluate(rtlThread* t) {assert(0);}

	virtual bool Is(string kind) {return(kind == this->Kind());}
	virtual void Print(ostream& ofile);
	virtual void Print_VHDL();
};

class rtlConstantLiteralExpression: public rtlExpression
{
	string _literal_string;
	public:
	
	// parse literal string and set type.
	rtlConstantLiteralExpression(string lit_string);

	string Kind() {return("rtlConstantLiteralExpression");}

	virtual void Evaluate(rtlThread* t);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL();
};

class rtlObjectReference: public rtlExpression
{
	protected:

	rtlObject* _object;

	public:

	rtlObjectReference(rtlObject* obj);
	string Kind() {return("rtlObjectReference");}

};


class rtlSimpleObjectReference: public rtlObjectRefernce
{

	public:

	// type extracted from object.
	rtlSimpleObjectReference(rtlObject* obj);
	string Kind() {return("rtlSimpleObjectReference");}

	virtual void Evaluate(rtlThread* t);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL();
};

class rtlArrayObjectReference: public rtlObjectRefernce
{
	protected:
	vector<rtlExpression*> _indices;
	public:

	// type is extracted from object-type's element.
	// Note: currently array references must be to the element-type
	rtlArrayObjectReference(rtlObject* obj, vector<rtlExpression*>& indices);

	string Kind() {return("rtlSimpleObjectReference");}

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_VHDL();
};

class rtlSliceExpression: public rtlExpression
{
	protected:
	rtlExpression* _base;
	rtlExpression* _high;
	rtlExpression* _low;

	rtlSliceExpression(rtlExpression* base, rtlExpression* hexpr, rtlExpression* lexpr);

	string Kind() {return("rtlSliceExpression");}

	virtual void Evaluate(rtlThread* t);
	virtual void Print(ostream& ofile);
	virtual void Print_VHDL();
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
	virtual void Print_VHDL();
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
	virtual void Print_VHDL();
};

class rtlTernaryExpression: public rtlExpression
{
	rtlExpression* _test;
	rtlExpression* _if_true;
	rtlExpression* _if_false;

	public:

	rtlTernayExpression(rtlOperation op, rtlExpression* test, rtlExpression* if_true, rtlExpression* if_false);
	string Kind() {return("rtlTernayExpression");}

	virtual void Evaluate(rtlThread* t);

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL();
};

#endif
