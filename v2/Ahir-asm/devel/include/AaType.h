#ifndef _Aa_Type__
#define _Aa_Type__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>

class AaExpression;
/*****************************************  TYPE ****************************/

class AaType: public AaRoot
{
  AaScope* _scope;
  // types dont have names, only declarations.
 public:
  virtual AaScope* Get_Scope() {return(this->_scope);}

  AaType(AaScope* parent);
  ~AaType();
  virtual string Kind() {return("AaType");}
  virtual string CName() {assert(0);}
  virtual string CBaseName() {assert(0);}
  virtual string CDim() {assert(0);}
  virtual int Size() {assert(0);}
  virtual void Fill_LAU_Set(set<int>& s) {s.insert(this->Size());}

  virtual void Write_VC_Model(ostream& ofile) { assert(0);}
  virtual bool Is_Integer_Type() {return(false);}
  virtual bool Is_Uinteger_Type() {return(false);}
  virtual bool Is_Float_Type() {return(false);}
  virtual bool Is_Array_Type() {return(false);}
  virtual bool Is_Record_Type() {return(false);}
  virtual bool Is_Pointer_Type() {return(false);}
  virtual bool Is_Composite_Type()
  {
    return(Is_Array_Type() || Is_Record_Type());
  }

  virtual bool Is_Scalar_Type() {return (Is_Integer_Type() || Is_Float_Type());}
  
  virtual string Get_VC_Name() {assert(0);}
  virtual int Number_Of_Elements() {return(1);}

  virtual int Get_Data_Width() {assert(0);}

  virtual AaType* Get_Element_Type(int idx) 
  {
    assert(0);
  }
  virtual AaType* Get_Element_Type(int start_idx, vector<AaExpression*>& indices) 
  {
    assert(0);
  }

  virtual int Get_Start_Bit_Offset(int start_index, vector<AaExpression*>& indices)
  {
    assert(0);
  }

  virtual string CPointerDereference()
  {
    return("*");
  }
};

class AaVoidType: public AaType
{
   public:
	AaVoidType():AaType(NULL)
        {
	}

	AaVoidType(AaScope* s): AaType(s)
	{
	}

	void Print(ostream& ofile)
	{
		ofile << " $void " ;
	}

	int Size()
	{
		return(0);
	}

	virtual string Kind() {return("AaVoidType");}
	virtual string CDim() {return("");}

};

class AaScalarType: public AaType
{

 public:
  AaScalarType(AaScope* parent);
  ~AaScalarType();
  virtual string Kind() {return("AaScalarType");}
  virtual string CDim() {return("");}
};


class AaUintType: public AaScalarType
{

 protected:
  // width > 0
  unsigned int _width;

 public:
  virtual unsigned int Get_Width() {return(this->_width);}

  AaUintType(AaScope* scope, unsigned int width);
  ~AaUintType();
  void Print(ostream& ofile);

  virtual string Kind() {return("AaUintType");}
  virtual string CName() 
  {
    return("uint_" + IntToStr(this->Get_Width()));
  }
  virtual string CBaseName() 
  {
    int width;
    int raw_width = this->Get_Width();
    if(raw_width <= 8)
      width = 8;
    else if(raw_width <= 16)
      width = 16;
    else if(raw_width <= 32)
      width = 32;
    else
      width = 64;
    return("uint" + IntToStr(width) + "_t");
  }
  virtual int Size() {return(this->_width);}
  virtual int Get_Data_Width() {return(this->Size());}

  virtual void Write_VC_Model(ostream& ofile) 
  { 
    ofile << "$int<" << _width << ">";
  }

  virtual bool Is_Integer_Type() {return(true);}
  virtual bool Is_Uinteger_Type() {return(true);}
  virtual bool Is_Float_Type() {return(false);}


  virtual string Get_VC_Name() {return("$int<" + IntToStr(this->Get_Width()) + ">");}

};


class AaIntType: public AaUintType
{
  // gets width from Uint

 public:
  AaIntType(AaScope* scope,unsigned int width);
  ~AaIntType();
  void Print(ostream& ofile);
  virtual string Kind() {return("AaIntType");}
  virtual string CName() 
  {
    return("int_" + IntToStr(this->Get_Width()));
  }

  virtual string CBaseName() 
  {
    int width;
    int raw_width = this->Get_Width();
    if(raw_width <= 8)
      width = 8;
    else if(raw_width <= 16)
      width = 16;
    else if(raw_width <= 32)
      width = 32;
    else
      width = 64;
    return("int" + IntToStr(width) + "_t");
  }

  virtual bool Is_Uinteger_Type() {return(false);}
};

class AaPointerType: public AaUintType
{

  AaType* _ref_type;

 public :
  AaPointerType(AaScope* scope, AaType* ref_type);
  ~AaPointerType();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaPointerType");}

  virtual string CName()
  {
    return(_ref_type->CName() + "*");
  }

  virtual string CBaseName() 
  {
    return(this->_ref_type->CBaseName() + "*");
  }


  AaType* Get_Ref_Type() {return(this->_ref_type);}

  virtual void Write_VC_Model(ostream& ofile);

  virtual string Get_VC_Name() 
  {
    return(this->AaUintType::Get_VC_Name());
  }
  virtual bool Is_Pointer_Type() {return(true);}
  virtual AaType* Get_Element_Type(int start_idx, vector<AaExpression*>& indices);
};


class AaFloatType : public AaScalarType
{
  protected:
  // both > 0
  unsigned int _characteristic;
  unsigned int _mantissa;

 public:
  unsigned int Get_Characteristic() {return(this->_characteristic);}
  unsigned int Get_Mantissa() {return(this->_mantissa);}

  AaFloatType(AaScope* scope, unsigned int characteristic, unsigned int mantissa);
  ~AaFloatType();
  void Print(ostream& ofile);
  virtual string Kind() {return("AaFloatType");}

  virtual string CName()
  {
    return(string("float_") + IntToStr(this->_characteristic) +  "_" + IntToStr(this->_mantissa));
  }
  
  virtual string CBaseName() 
  {
    if(this->Size() == 32)
      return("float");
    else
      return("double");
  }

  virtual int Size() {return(this->_characteristic + this->_mantissa + 1);}

  virtual void Write_VC_Model(ostream& ofile) 
  { 
    ofile << "$float<" << _characteristic << "," << _mantissa << ">";
  }

  virtual string Get_VC_Name()
  {
    return("$float<" + IntToStr( _characteristic) +  "," + IntToStr( _mantissa) + ">");
  }

  virtual int Get_Data_Width() {return(this->Size());}

  virtual bool Is_Integer_Type() {return(false);}
  virtual bool Is_Uinteger_Type() {return(false);}
  virtual bool Is_Float_Type() {return(true);}
};

class AaArrayType: public AaType
{
  // multi-dimensional array types are possible
  vector<unsigned int> _dimension;
  
  // element type..
  AaType* _element_type;
 
 public:

  virtual bool Is_Array_Type() {return(true);}
  vector<unsigned int>& Get_Dimension_Vector() {return(this->_dimension);}

  unsigned int Get_Number_Of_Dimensions() {return(this->_dimension.size());}
  virtual AaType* Get_Element_Type() {return(this->_element_type);}
  virtual AaType* Get_Element_Type(int idx); // idx ranges from 0 to _dimension.size()-1

  AaArrayType(AaScope* scope, AaType* etype, vector<unsigned int>& dimensions);
  ~AaArrayType();

  unsigned int Get_Dimension(unsigned int dim_id);
  void Print(ostream& ofile);
  virtual string Kind() {return("AaArrayType");}
  virtual string CName()
  {
    string ret_string =  this->Get_Element_Type()->CName();
    return(ret_string);
  }

  virtual string CBaseName()
  {
    string ret_string =  this->Get_Element_Type()->CBaseName();
    return(ret_string);
  }
  virtual string CDim() 
  {
    string ret_string =  "";
    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
      ret_string +=  "[" + IntToStr(this->_dimension[i]) + "]";
    return(ret_string);
  }

  virtual int Size() 
  {
    int ret_val = this->Get_Element_Type()->Size();

    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
      ret_val =  ret_val * this->_dimension[i];

    return(ret_val);
  }


  virtual void Fill_LAU_Set(set<int>& s) {this->Get_Element_Type()->Fill_LAU_Set(s);}
  virtual int Get_Data_Width() {return(this->Get_Element_Type()->Get_Data_Width());}

  virtual int Number_Of_Elements()
  {
    int ret_val = 1;
    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
      ret_val = ret_val*(this->_dimension[i]);
    return(ret_val);
  }

  virtual void Write_VC_Model(ostream& ofile) 
  { 
    ofile << "$array[" << this->Number_Of_Elements() << "] $of ";
    this->Get_Element_Type()->Write_VC_Model(ofile);
  }

  virtual string Get_VC_Name() 
  { 
    return( "$array[" + IntToStr(this->Number_Of_Elements()) + "] $of " +
	    this->Get_Element_Type()->Get_VC_Name());
  }

  virtual string CPointerDereference()
  {
    string ret_string = this->Get_Element_Type()->CPointerDereference();
    for(int i = 0; i < this->Get_Number_Of_Dimensions(); i++)
      ret_string += "*";
    return(ret_string);
  }


  virtual AaType* Get_Element_Type(int start_idx, vector<AaExpression*>& indices);
  virtual int Get_Start_Bit_Offset(int start_index, vector<AaExpression*>& indices);
};


class AaRecordType: public AaType
{
  string _record_type_name;
  bool _is_named;
  vector<AaType*> _element_types;
 public:
  virtual bool Is_Record_Type() {return(true);}


  AaRecordType(AaScope* s, vector<AaType*>& element_types):AaType(s)
    {
      _is_named = false;
      _element_types = element_types;
    }
    
    AaRecordType(AaScope* s, string name);
    void Add_Element_Type(AaType* t)
    {
      _element_types.push_back(t);
    }
  
    void Print(ostream& ofile)
    {
      if(_is_named)
	{
	  ofile << " " << this->_record_type_name << " ";
	  return;
	}
      
      ofile << "$record ";
      for(int idx = 0; idx < _element_types.size(); idx++)
	{
	  // note the spaces before and after >
	  ofile << " < ";
	  _element_types[idx]->Print(ofile);
	  ofile << " > ";
	}
    }

    virtual void Write_VC_Model(ostream& ofile) 
    { 
      ofile << "$record ";
      for(int idx = 0; idx < _element_types.size(); idx++)
	{
	  // note the spaces before and after >
	  ofile << " < ";
	  _element_types[idx]->Write_VC_Model(ofile);
	  ofile << " > ";
	}
    }

    void Print_Declaration(ostream& ofile)
    {
      if(_is_named)
	{
	  ofile << "$record ";
	  ofile << "[" << this->_record_type_name << "] ";
	  for(int idx = 0; idx < _element_types.size(); idx++)
	    {
	      // note the spaces before and after >
	      ofile << " < ";
	      _element_types[idx]->Print(ofile);
	      ofile << " > ";
	    }
	  
	  ofile << endl;
	}
    }

    
    
    virtual string Get_VC_Name() 
    {
      string ret_val;
      ret_val =  "$record ";
      for(int idx = 0; idx < _element_types.size(); idx++)
	{
	  ret_val += " < ";
	  ret_val += _element_types[idx]->Get_VC_Name();
	  ret_val += " > ";
	}
      return(ret_val);
    }

    
    virtual string Kind() { return("AaRecordType"); }
    virtual int Size() 
    { 
      int ret_val = 0;
      for(int i = 0; i < this->_element_types.size(); i++)
	ret_val += this->_element_types[i]->Size();
      return(ret_val);
    }
    
    virtual AaType* Get_Element_Type(int idx) {return(this->_element_types[idx]);}
    AaType* Get_Element_Type(AaExpression* expr);

    int Get_Number_Of_Elements() {return(this->_element_types.size());}
    
    virtual void Fill_LAU_Set(set<int>& s) 
    {
      for(int idx = 0; idx < this->_element_types.size(); idx++)
	{
	  this->_element_types[idx]->Fill_LAU_Set(s);
	}
    }
    
    int Get_Data_Width(int idx) 
    {
      return(this->Get_Element_Type(idx)->Get_Data_Width());
    }
    
    virtual string CName() 
    {
      return("Struct_" + Int64ToStr(this->Get_Index()));
    }  
    
    virtual AaType* Get_Element_Type(int start_idx, vector<AaExpression*>& indices);
    virtual int Get_Start_Bit_Offset(int start_index, vector<AaExpression*>& indices);
    int Get_Start_Bit_Offset(AaExpression* expr);
    
    void PrintC_Declaration(ofstream& ofile)
    {
      ofile << "typedef struct __" << CName() << " { " << endl;
      for(int idx = 0; idx < this->_element_types.size(); idx++)
	{
	  AaType* t = this->_element_types[idx];
	  
	  if(t->Is_Array_Type())
	    {
	      AaArrayType* at = (AaArrayType*) t;
	      ofile << at->CBaseName() << " "
		    << "f_" << IntToStr(idx)
		    <<  at->CDim() << ";" << endl;
	    }
	  else
	    {
	      ofile << t->CName() << " ";
	      ofile << "f_" << IntToStr(idx) << ";" << endl;
	    }
	}
      ofile << "} " << CName() << ";" << endl;
    }
};


#endif
