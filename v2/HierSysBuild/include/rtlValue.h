#ifndef rtl_Value_h__
#define rtl_Value_h__
#include<rtlType.h>

using namespace _base_value_;

class hierRoot;
enum rtlOperation;

class rtlValue:public hierRoot
{
	protected:
	rtlType* _type;
	
	public:
	rtlValue(rtlType* t) { t = NULL;}
	rtlType* Get_Type() {return(_type);}
	virtual void Print(ostream& ofile) {assert(0);}

	virtual int  To_Integer() {assert(0);}

	virtual bool Get_Bit(int bit_index) {assert(0);}
	virtual void Set_Bit(int bit_index, bool bit_val) {assert(0);}
};


class rtlIntegerValue: public rtlValue
{
	protected:
	int _value;

	public:
	rtlIntegerValue(rtlType* t, int v):rtlValue(t) {_value = v;}
	int Get_Value() {return(_value);}
	virtual void Print(ostream& ofile);
	virtual int  To_Integer() {return(_value);}
};



class rtlUnsignedValue: public rtlValue
{
	Value* _value;

	public:
	rtlUnsignedValue(rtlType* t, Value* v):rtlValue(t) {_value = v;} 
	virtual void Print(ostream& ofile);	
	virtual int  To_Integer();		
	virtual bool Get_Bit(int bi);
	virtual void Set_Bit(int bit_index, bool bit_val);
};


class rtlSignedValue: public rtlUnsignedValue
{
	public:

	rtlSignedValue(rtlType* t, Value* v):rtlUnsignedValue(t,v) {}
	virtual void Print(ostream& ofile);
	virtual int  To_Integer();		
};

class rtlArrayValue: public rtlValue
{
	vector<rtlValue*> _values;

	public:
	rtlArrayValue(rtlType* t, vector<rtlValue*> vals):rtlValue(t)
	{
		_values = vals;
	}

	rtlValue* Get_Value(int index) 
	{
		if((index >= 0)	 && (index < _values.size()))
		  return(_values[index]);
		else
			return(NULL);
	}
	rtlValue* Get_Value(vector<int>& indices);
	virtual void Print(ostream& ofile);
};


// make a value..
rtlValue* Make_Rtl_Value(rtlType* t, vector<string>& init_values);
rtlValue* Make_Unsigned_Zero(rtlType* t);
rtlValue* Perform_Unary_Operation(rtlOperation op, rtlValue* v);
rtlValue* Perform_Binary_Operation(rtlOperation op, rtlValue* f, rtlValue* s);
bool      Is_Zero(rtlValue* v);
bool      Are_Equal(rtlValue* f, rtlValue* s);

#endif
