#ifndef _Aa_Object__
#define _Aa_Object__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>


/*****************************************  OBJECT  ****************************/
// base object
// Each object has a type, a name, a value and a parent

class AaObject: public AaRoot
{
  string _name;
  AaConstantLiteralReference* _value;
  AaType* _type;
  AaScope* _scope;

 public:

  AaType* Get_Type() {return(this->_type);}

  AaConstantLiteralReference* Get_Value() {return(this->_value);}
  void Set_Value(AaConstantLiteralReference* v) {this->_value = v;}
  virtual string Get_Name() {return(this->_name);}
  virtual AaScope* Get_Scope() {return(this->_scope);}
  virtual string Tab();

  AaObject(AaScope* scope_tpr, string oname, AaType* object_type);
  ~AaObject();

  virtual void Print(ostream& ofile);  
  virtual string Kind() {return("AaObject");}
  virtual bool Is_Object() {return(true); }

};

// interface object: function arguments
class AaInterfaceObject: public AaObject
{
  // arguments can be input or output
  string _mode; // "in" or "out"

 public:
  string Get_Mode() {return(this->_mode);}

  AaInterfaceObject(AaScope* scope_tpr, string oname, AaType* otype, string mode);
  ~AaInterfaceObject();
  virtual string Kind() {return("AaInterfaceObject");}
  // uses AaObject::Print method
};

class AaConstantObject: public AaObject
{
  // 
 // constants are visible only in pure ancestors
  // or pure descendants.
  //
 public:
  AaConstantObject(AaScope* scope_tpr, string oname, AaType* otype, AaConstantLiteralReference* value);
  ~AaConstantObject();

  virtual void Print(ostream& ofile); 
  virtual string Kind() {return("AaConstantObject");}
};

class AaStorageObject: public AaObject
{
  // objects will be stored in memory
  //
 public:

  AaStorageObject(AaScope* scope_tpr, string oname, AaType* otype, AaConstantLiteralReference* initial_value);
  ~AaStorageObject();

  virtual void Print(ostream& ofile); 
  virtual string Kind() {return("AaStorageObject");}
};

class AaPipeObject: public AaObject
{
  //
 public:
  AaPipeObject(AaScope* scope_tpr,string oname, AaType* otype);
  ~AaPipeObject();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaPipeObject");}
};

#endif
