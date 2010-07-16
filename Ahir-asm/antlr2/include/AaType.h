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
};

class AaScalarType: public AaType
{

 public:
  AaScalarType(AaScope* parent);
  ~AaScalarType();
  virtual string Kind() {return("AaScalarType");}
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
  void Write_C(ofstream& header, ofstream& source)
  {
    source << "uint_" << this->_width;
  }

  virtual string Kind() {return("AaUintType");}
};

class AaIntType: public AaUintType
{
  // gets width from Uint

 public:
  AaIntType(AaScope* scope,unsigned int width);
  ~AaIntType();
  void Print(ostream& ofile);
  virtual string Kind() {return("AaIntType");}
  void Write_C(ofstream& header, ofstream& source)
  {
    source << "int_" << this->_width;
  }
};

class AaPointerType: public AaUintType
{
 public :
  AaPointerType(AaScope* scope, unsigned int _object_width);
  ~AaPointerType();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaPointerType");}

  void Write_C(ofstream& header, ofstream& source)
  {
    source << "void*";
  }

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

  void Write_C(ofstream& header, ofstream& source)
  {
    source << "float_" << this->_characteristic << "_" << this->_mantissa;
  }

};

class AaArrayType: public AaType
{
  // multi-dimensional array types are possible
  vector<unsigned int> _dimension;
  
  // element type is a scalar
  AaScalarType* _element_type;
 
 public:

  unsigned int Get_Number_Of_Dimensions() {return(this->_dimension.size());}
  AaScalarType* Get_Element_Type() {return(this->_element_type);}


  AaArrayType(AaScope* scope, AaScalarType* stype, vector<unsigned int>& dimensions);
  ~AaArrayType();

  unsigned int Get_Dimension(unsigned int dim_id);
  void Print(ostream& ofile);
  virtual string Kind() {return("AaArrayType");}
  void Write_C(ofstream& header, ofstream& source)
  {
    this->_element_type->Write_C(header,source);
    for(unsigned int i=0; i < this->Get_Number_Of_Dimensions(); i++)
      source << "[" << this->_dimension[i] << "]";
  }

};

#endif
