
#ifndef _VC_TYPE_H
#define _VC_TYPE_H

#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType: public vcRoot
{
  unsigned int _index;

public:

  vcType();

  virtual string Kind()
  {
    return("vcType");
  }

  void Set_Index(unsigned int w) {this->_index = w;}
  unsigned int Get_Index() {return(this->_index);}

  virtual void Print(ostream& ofile) {assert(0);}
  virtual int Size() { assert(0);}
  virtual bool Is_Int_Type() {return(false);}

  virtual string Get_VHDL_Type_Name() {return("std_logic_vector(" + IntToStr(this->Size()-1) + " downto 0)");}

};

class vcScalarTypeTemplate: public vcType
{
  bool _int_flag;
  bool _float_flag;
  string _width;
  string _characteristic;
  string _mantissa;
public:
  vcScalarTypeTemplate(string width); // int type
  vcScalarTypeTemplate(string characteristic, string mantissa); // float type

  virtual void Print(ostream& ofile);
  virtual int Size() {return(-1);}
};

class vcScalarType: public vcType
{

public:
  vcScalarType();
  virtual string Kind() {return("vcScalarType");}
  virtual int Size() { assert(0);}
};


class vcIntType: public vcScalarType
{

protected:
  // width > 0
  unsigned int _width;

public:
  virtual unsigned int Get_Width() {return(this->_width);}
  vcIntType(unsigned int width);

  void Print(ostream& ofile);
  virtual string Kind() {return("vcIntType");}
  virtual int Size() { return(this->_width);}
  virtual bool Is_Int_Type() {return(true);}

};

class vcMemorySpace;
class vcPointerType: public vcIntType
{
  vcMemorySpace* _memory_space;

public :
  vcPointerType(vcMemorySpace* mem_space);
  vcMemorySpace* Get_Memory_Space();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcPointerType");}
  virtual int Size();
};


class vcFloatType : public vcScalarType
{
protected:
  // both > 0
  vcIntType* _characteristic_type;
  vcIntType* _mantissa_type;

public:
  unsigned int Get_Characteristic_Width() {return(this->_characteristic_type->Get_Width());}
  unsigned int Get_Mantissa_Width() {return(this->_mantissa_type->Get_Width());}

  vcIntType* Get_Characteristic_Type() {return(this->_characteristic_type);}
  vcIntType* Get_Mantissa_Type() {return(this->_mantissa_type);}

  vcFloatType(vcIntType* ctype, vcIntType* mtype);
  void Print(ostream& ofile);

  virtual string Kind() {return("vcFloatType");}
  virtual int Size() { return(this->Get_Characteristic_Width() + this->Get_Mantissa_Width() + 1);}

};

class vcArrayType: public vcType
{
  // only single dimensional arrays.
  int _dimension;
  
  // element type can be arbitrary
  vcType* _element_type;
 
public:

  int Get_Dimension() {return(this->_dimension);}
  vcType* Get_Element_Type() {return(this->_element_type);}
  vcArrayType(vcType* stype, int dimension);
  void Print(ostream& ofile);
  virtual string Kind() {return("vcArrayType");}

  virtual int Size() { return(this->_dimension * this->_element_type->Size());}

};

class vcRecordType: public vcType
{
  vector<vcType*> _element_types;
public:
  vcRecordType(vector<vcType*>& element_types);
  void Print(ostream& ofile);
  virtual string Kind() { return("vcRecordType"); }
  virtual int Size() 
  { 
    int ret_val = 0;
    for(int i = 0; i < this->_element_types.size(); i++)
      ret_val += this->_element_types[i]->Size();
    return(ret_val);
  }

  vcType* Get_Element_Type(int idx) {return(this->_element_types[idx]);}
  int Get_Number_Of_Elements() {return(this->_element_types.size());}
  
};

void Add_Type(string tid, vcType* t);
vcIntType* Make_Integer_Type(unsigned int w);
vcFloatType* Make_Float_Type(unsigned int c, unsigned int m);
vcArrayType* Make_Array_Type(vcType* etype, unsigned int dim);
vcRecordType* Make_Record_Type(vector<vcType*>& etypes);


class vcSystem;
vcPointerType* Make_Pointer_Type(vcSystem* sys, string scope_id, string space_id);

#endif // vcType
