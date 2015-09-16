#ifndef _rtl_Object_h__
#define _rtl_Object_h__

class rtlType;

class rtlObject: public hierRoot
{
	protected:

	string _name;
	rtlType* _type;

        public:

	rtlObject(string name, rtlType* t);


	virtual bool Is_Variable() {return(false);}
	virtual bool Is_Signal()   {return(false);}
	virtual bool Is_Constant() {return(false);}

	virtual bool Get_Is_Input() {return(false);}
	virtual bool Get_Is_Output() {return(false);}
	virtual bool Get_Is_Internal() {return(false);}

	virtual rtlValue* Get_Value() {return(NULL);}
	
};

class rtlConstant: public rtlObject
{
	rtlValue* _value;
	public:

	rtlConstant(string name, rtlType* t, rtlValue* v); 

	virtual bool Get_Is_Internal() {return(true);}
	virtual bool Is_Constant() {return(true);}
	virtual rtlValue* Get_Value() {return(_value);}
};

class rtlVariable: public rtlObject
{
	public:

	rtlVariable(string name, rtlType* t);
	virtual bool Get_Is_Internal() {return(true);}

};


class rtlSignal: public rtlObject
{
	public:
	rtlSignal(string name, rtlType* t);

	virtual bool Is_Signal() {return(true);}
};

#endif
