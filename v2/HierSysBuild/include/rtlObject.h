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
	virtual bool Is_InPort()   {return(false);}
	virtual bool Is_OutPort()  {return(false);}


	virtual rtlValue* Get_Value() {return(NULL);}

	virtual void Print(ostream& ofile) {assert(0);}
	
};

class rtlConstant: public rtlObject
{
	rtlValue* _value;
	public:

	rtlConstant(string name, rtlType* t, rtlValue* v); 

	virtual bool Is_Constant() {return(true);}
	virtual rtlValue* Get_Value() {return(_value);}
	virtual void Print(ostream& ofile);
};

class rtlVariable: public rtlObject
{
	public:

	rtlVariable(string name, rtlType* t);
	virtual bool Is_Variable() {return(true);}
	virtual void Print(ostream& ofile);

};


class rtlSignal: public rtlObject
{
	public:
	rtlSignal(string name, rtlType* t);

	virtual bool Is_Signal() {return(true);}
	virtual void Print(ostream& ofile);
};

class rtlInPort: public rtlSignal
{
	public:
	rtlInPort(string name, rtlType* t) : rtlSignal(name,t) {}
	virtual bool Is_InPort() {return(true);}
	virtual void Print(ostream& ofile);

};

class rtlOutPort: public rtlSignal
{
	public:
	rtlOutPort(string name, rtlType* t) : rtlSignal(name,t) {}
	virtual bool Is_OutPort() {return(true);}
	virtual void Print(ostream& ofile);

};
#endif
