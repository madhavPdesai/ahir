#ifndef _rtl_Object_h__
#define _rtl_Object_h__

class rtlType;

class rtlObject: public hierRoot
{
	protected:

	rtlType* _type;

        public:

	rtlObject(string name, rtlType* t);


	virtual bool Is_Variable() {return(false);}
	virtual bool Is_Signal()   {return(false);}
	virtual bool Is_Constant() {return(false);}
	virtual bool Is_InPort()   {return(false);}
	virtual bool Is_OutPort()  {return(false);}


	virtual rtlValue* Get_Value() {return(NULL);}
	rtlType* Get_Type() {return(_type);}

	virtual void Print(ostream& ofile) {assert(0);}
		
	virtual string Get_C_Name() {return("__sstate->" + this->Get_Id());}
	virtual string Get_C_Target_Name() 
	{
		if(this->Needs_Next())
			return("__sstate->__next__" + this->Get_Id());
	}
	virtual void Print_C_Struct_Field_Initialization(string obj_name, ostream& source_file);
	
	virtual void Set_Is_Emitted(bool v) {}
	virtual bool Get_Is_Emitted(bool v) {return(false);}

	virtual void Set_Is_Volatile(bool v) {}
	virtual bool Get_Is_Volatile() {return(false);}

	virtual bool Needs_Next() {return(false);}
};

class rtlConstant: public rtlObject
{
	rtlValue* _value;
	public:

	rtlConstant(string name, rtlType* t, rtlValue* v); 

	virtual bool Is_Constant() {return(true);}
	virtual rtlValue* Get_Value() {return(_value);}
	virtual void Print(ostream& ofile);

	virtual void Print_C_Struct_Field_Initialization(string obj_name,  ostream& source_file);
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
	bool _is_volatile;
	public:
	rtlSignal(string name, rtlType* t);

	virtual bool Is_Signal() {return(true);}
	virtual void Print(ostream& ofile);
	virtual void Set_Is_Volatile(bool v) {_is_volatile = v;}
	virtual bool Get_Is_Volatile() {return(_is_volatile);}
	virtual bool Needs_Next() {return(this->Get_Is_Volatile());}
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
	bool _is_emitted;
	public:
	rtlOutPort(string name, rtlType* t) : rtlSignal(name,t) {_is_emitted = false;}
	virtual bool Is_OutPort() {return(true);}
	virtual void Print(ostream& ofile);

	virtual void Set_Is_Emitted(bool v) {_is_emitted = v;}
	virtual bool Get_Is_Emitted() {return(_is_emitted);}
	virtual bool Needs_Next() {return(!(this->Get_Is_Volatile() || this->Get_Is_Emitted()));}

};
#endif
