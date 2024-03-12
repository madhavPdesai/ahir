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

  virtual unsigned int Get_Width() {assert(0);}
  AaType(AaScope* parent);
  ~AaType();
  virtual string Kind() {return("AaType");}
  virtual int Size() {assert(0);}
  virtual void Fill_LAU_Set(set<int>& s) {s.insert(this->Size());}

  // C related stuff.
  //
  // base-name: e.g. for array types, base-name
  // is the element-type.
  //
  virtual string C_Base_Name() {assert(0);}
  // name by which this type is referred to.
  virtual string C_Name() {return(this->C_Base_Name());}
  //
  // dimension string, for array types.
  //
  virtual string C_Dimension_String() {return ("");}
  //
  // Print C declaration.  Blank unless specified by derived class.
  //
  virtual void PrintC_Declaration(ofstream& ofile) {}

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

  virtual bool Is_Scalar_Type() {return (Is_Pointer_Type() || Is_Integer_Type() || Is_Float_Type());}

  virtual bool Is_A_Native_C_Type() {return(false);}
  virtual string Native_C_Name() {assert(0);}

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

	virtual string C_Base_Name() { return("void");}

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
   
  // C related stuff.
  virtual string C_Base_Name()
  {
	return("bit_vector");
  }

  virtual bool Is_A_Native_C_Type() 
  {
    return( (_width == 8) || (_width == 16) || (_width == 32) || (_width == 64));
  }
  virtual string Native_C_Name() 
  {
    return("uint" + IntToStr(_width) + "_t");
  }

  // print nothing.  bit_vector is provided by C library.
  virtual void PrintC_Declaration(ofstream& ofile) {}
  
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

  // C related stuff
  virtual string C_Base_Name() 
  {
	return("bit_vector");
  } 
  virtual void PrintC_Declaration(ofstream& ofile)
  {
	// do nothing.  sized_int is provided by C library.
  }

  virtual string Native_C_Name() 
  {
    return("int" + IntToStr(_width) + "_t");
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

  // C related stuff.
  virtual string C_Base_Name() 
  {
    return(this->_ref_type->C_Name() + "*" );
  } 

  virtual void PrintC_Declaration(ofstream& ofile)
  {
	//
	// pointer types are a bit of a problem in C because the
	// dimensions are attached to the object ^%*(@
	//
	ofile << "typedef " << this->C_Name() << " " << _ref_type->C_Name() << "*;" << endl;
  } 


  AaType* Get_Ref_Type() {return(this->_ref_type);}

  virtual void Write_VC_Model(ostream& ofile);

  virtual string Get_VC_Name() 
  {
    return(this->AaUintType::Get_VC_Name());
  }

  virtual bool Is_Pointer_Type() {return(true);}
  virtual bool Is_Integer_Type() {return(false);}
  virtual bool Is_Uinteger_Type() {return(false);}

  // no pointer passing across boundary.
  virtual bool Is_A_Native_C_Type()  {return(false);}

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

  virtual unsigned int Get_Width() {
	return(this->Get_Characteristic() + this->Get_Mantissa() + 1);
  }
  
  virtual string C_Base_Name() 
  {
    	if(this->Size() == 32)
      		return("float");
    	else if(this->Size() == 64)
    	  	return("double");
	else
		assert(0);
  }
  virtual void PrintC_Declaration(ofstream& ofile) {} // built-in C types, no need to declare.
  
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
  virtual bool Is_A_Native_C_Type() 
  {
    return( ((_characteristic == 8) && (_mantissa == 23)) ||
	    ((_characteristic == 11) && (_mantissa == 52)));
  }
  virtual string Native_C_Name() 
  {
    if(this->Size() == 32)
      return("float");
    else if(this->Size() == 64)
      return("double");
    else 
      assert(0);
  }

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
  virtual string C_Name()
  {
    string ret_string =  this->Get_Element_Type()->C_Base_Name();
    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
	ret_string += "*";
    return(ret_string);
  }

  virtual string C_Base_Name()
  {
    string ret_string =  this->Get_Element_Type()->C_Name();
    return(ret_string);
  }


  virtual string C_Dimension_String() 
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

    bool Get_Is_Named() {return(_is_named);}

    void Print_Group_Function   (ostream& ofile);
    void Print_Ungroup_Function (ostream& ofile);

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

    
    int Get_Index_Value(AaExpression* expr);
    
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
    
    virtual string C_Base_Name() 
    {
      return("Struct_" + Int64ToStr(this->Get_Index()));
    }  

    
    virtual void PrintC_Declaration(ofstream& ofile)
    {
      ofile << "typedef struct __" << this->C_Name() << " { " << endl;
      for(int idx = 0; idx < this->_element_types.size(); idx++)
	{
	  AaType* t = this->_element_types[idx];
	  
	  if(t->Is_Array_Type())
	    {
	      AaArrayType* at = (AaArrayType*) t;
	      ofile << at->C_Base_Name() << " "
		    << "f_" << IntToStr(idx)
		    <<  at->C_Dimension_String() << ";" << endl;
	    }
	  else
	    {
	      ofile << t->C_Name() << " ";
	      ofile << "f_" << IntToStr(idx) << ";" << endl;
	    }
	}
      ofile << "} " << C_Name() << ";" << endl;
    }
    
    virtual unsigned int Get_Width();
    virtual AaType* Get_Element_Type(int start_idx, vector<AaExpression*>& indices);
    virtual int Get_Start_Bit_Offset(int start_index, vector<AaExpression*>& indices);
    int Get_Start_Bit_Offset(AaExpression* expr);

    virtual bool Is_Single_Level_Record_Type()
    {
	bool ret_val = true;
      	for(int idx = 0; idx < this->_element_types.size(); idx++)
	{
		if(!this->Get_Element_Type(idx)->Is_Scalar_Type())
		{
			ret_val = false;
			break;
		}
	}
	return(ret_val);
    }
    
};


#endif
