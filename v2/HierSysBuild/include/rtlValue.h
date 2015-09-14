#ifndef rtl_Value_h__
#define rtl_Value_h__

class rtlType;
class Value;
class Unsigned;
class Signed;

class rtlValue: public rtlRoot
{
	protected:
	rtlType* _type;
	Value*   _value;
	
	public:

	rtlValue(rtlType* t);
	
	Value* Get_Value() {return(_value);}
	Value* Get_Value(int index) {return(NULL);}
	Value* Get_Value(vector<int>& indices) {return(NULL);}
	rtlType* Get_Type() {return(_type);}

	

	virtual string To_String();
	virtual string To_VHDL_String();
	virtual string To_Integer() {assert(0);}
};



class rtlUnsignedValue: public rtlValue
{
	public:

	rtlUnsignedValue(rtlType* t, unsigned int uv);
	rtlUnsignedValue(rtlType* t, Unsigned* uv);
	rtlUnsignedValue(rtlType* t, string bit_string);

};


class rtlSignedValue: public rtlUnsignedValue
{
	public:

	rtlSignedValue(rtlType* t, int sv);
	rtlSignedValue(rtlType* t, Signed* sv);
	rtlSignedValue(rtlType* t, string bit_string);
};

// a 32 bit integer value.
class rtlIntegerValue: public rtlSignedValue
{
	public:
	
	// 32-bit integer.
	rtlIntegerValue(int sv);
};


class rtlArrayValue: public rtlValue
{
	vector<rtlValue*> _values;

	public:
	rtlArrayValue(rtlType* t, vector<rtlValue*> vals);

	rtlValue* Get_Value(int index);
	rtlValue* Get_Value(vector<int>& indices);

};


// make a value..
rtlValue* Make_Rtl_Value(rtlType* t, string init_string);

#endif
