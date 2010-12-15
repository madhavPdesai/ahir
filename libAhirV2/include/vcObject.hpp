#ifndef _VC_STORAGE_OBJECT_
#define _VC_STORAGE_OBJECT_
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType;
class vcIntValue;

class vcStorageObject: public vcRoot
{
  vcType*  _type;
  vcValue* _value;
  vcIntValue* _base_address;

 public:
  vcStorageObject(string id, vcType* t);
  virtual void Print(ostream& ofile);

  vcType* Get_Type() { return(_type);}

  void Set_Value(vcValue* v);
  vcValue* Get_Value() {return(_value);}

  void Set_Base_Address(vcIntValue* v);
  vcIntValue* Get_Base_Address(); {return(_base_address);}


  virtual string Kind() {return("vcStorageObject");}
};

#endif // vcStorageObject
