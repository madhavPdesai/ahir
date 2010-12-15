
#ifndef _VC_TYPE_H
#define _VC_TYPE_H

#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType: public AaRoot
{

public:
  vcType();

  virtual string Kind()
  {
    return("vcType");
  }

  virtual void Print(ostream& ofile) {assert(0);}
  virtual int Size() { assert(0);}
};

class vcScalarTypeTemplate: public vcType
{
  bool int_flag;
  bool float_flag;
  string _width;
  string _characteristic;
  string _mantissa;
public:
  vcScalarTypeTemplate(string width); // int type
  vcScalarTypeTemplate(string characteristic, string mantissa); // float type

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
};

class vcPointerType: public vcScalarType
{
  string _memory_space_name;
  vcRoot* _memory_space;

public :
  vcPointerType(string mem_space_id);
  void Set_Memory_Space(vcRoot* ms);
  vcRoot* Get_Memory_Space();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcPointerType");}
  virtual int Size();
  /* 
     \todo move to .cpp file (incude memoryspace)
     assert(this->_memory_space != NULL); 
     return(this->_memory_space->Get_Pointer_Size());
  */
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
      ret_val += this->_element_types[i].Size();
    return(ret_val);
  }

  vcType* Get_Element_Type(int idx) {return(this->_element_types[idx]);}
  int Get_Number_Of_Elements() {return(this->_element_types.size());}
  
  
};

//\todo
vcIntType* Make_Integer_Type(int w);
vcFloatType* Make_Float_Type(int c, int m);
vcArrayType* Make_Array_Type(int dim, vcType* t);
vcRecordType* Make_Record_Type(vector<vcType*>& element_types);


#endif // vcType
