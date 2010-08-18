#ifndef _Aa_Value__
#define _Aa_Value__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>


class AaValue: public AaRoot
{
  AaScope* _scope;
 public:
  
    AaValue(AaScope* scope);
  ~AaValue();

  virtual string Get_Value_String() {assert(0);}
  virtual AaScope* Get_Scope() {return this->_scope;}
  virtual string Kind() {return("AaValue");}
};

class AaStringValue: public AaValue
{
  string _value;
 public:
  string Get_Value_String() {return(this->_value);}

  AaStringValue(AaScope* scope, string value);
  ~AaStringValue();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaStringValue");}
};

#endif
