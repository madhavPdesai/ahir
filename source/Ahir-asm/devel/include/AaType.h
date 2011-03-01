#ifndef _Aa_Type__
#define _Aa_Type__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>


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
  virtual string CDim() {assert(0);}
  virtual int Size() {assert(0);}
  virtual void Write_VC_Model(ostream& ofile) { assert(0);}
  virtual bool Is_Integer_Type() {return(false);}
  virtual bool Is_Float_Type() {return(false);}
  virtual bool Is_Array_Type() {return(false);}
  virtual bool Is_Pointer_Type() {return(false);}

  virtual bool Is_Scalar_Type() {return (Is_Integer_Type() || Is_Float_Type());}
  
  virtual string Get_VC_Name() {assert(0);}
  virtual int Number_Of_Elements() {return(1);}

  virtual int Get_Data_Width() {assert(0);}
  virtual string CPointerDereference()
  {
    return("*");
  }
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
  virtual int Size() {return(this->_width);}
  virtual int Get_Data_Width() {return(this->Size());}

  virtual void Write_VC_Model(ostream& ofile) 
  { 
    ofile << "$int<" << _width << ">";
  }

  virtual bool Is_Integer_Type() {return(true);}
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

  AaType* Get_Ref_Type() {return(this->_ref_type);}

  virtual void Write_VC_Model(ostream& ofile) 
  { 
    // need to identify potential memory spaces!
    //\todo: this will change.
    ofile << "$pointer<default>";
  }

  virtual string Get_VC_Name() 
  {
    return("$pointer<default>");
  }
  virtual bool Is_Pointer_Type() {return(true);}
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
  virtual bool Is_Float_Type() {return(true);}
};

class AaArrayType: public AaType
{
  // multi-dimensional array types are possible
  vector<unsigned int> _dimension;
  
  // element type is a scalar
  AaScalarType* _element_type;
 
 public:

  virtual bool Is_Array_Type() {return(true);}
  vector<unsigned int>& Get_Dimension_Vector() {return(this->_dimension);}

  unsigned int Get_Number_Of_Dimensions() {return(this->_dimension.size());}
  AaType* Get_Element_Type() {return(this->_element_type);}

  AaArrayType(AaScope* scope, AaScalarType* stype, vector<unsigned int>& dimensions);
  ~AaArrayType();

  unsigned int Get_Dimension(unsigned int dim_id);
  void Print(ostream& ofile);
  virtual string Kind() {return("AaArrayType");}
  virtual string CName()
  {
    string ret_string =  this->Get_Element_Type()->CName();
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

};

#endif
