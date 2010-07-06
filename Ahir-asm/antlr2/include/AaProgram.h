#ifndef _Aa_Program__
#define _Aa_Program__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>
#include <AaModule.h>

// ******************************************* PROGRAM ************************************
// The program, a list of modules
class AaProgram : public AaScope
{

  vector<AaObject*> _objects;
  vector<AaModule*> _modules;

  static map<string,AaType*,StringCompare> _type_map;

 public:
  AaProgram();
  ~AaProgram();

  void Add_Module(AaModule* fn);

  void Add_Object(AaObject* obj) 
  { 
    assert(this->Find_Child(obj->Get_Name()) == NULL); 
    this->_objects.push_back(obj);
    this->Map_Child(obj->Get_Name(),obj);
  }

  virtual void Print(ostream& ofile);

  static AaUintType* Make_Uinteger_Type(unsigned int w)
  {
    AaUintType* ret_type = NULL;
    string tid = "uint<" + IntToStr(w) + ">";
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaUintType*) (*titer).second;
    else
      {
	ret_type = new AaUintType((AaScope*) NULL, w);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
  static AaIntType* Make_Integer_Type(unsigned int w)
  {
    AaIntType* ret_type = NULL;
    string tid = "int<" + IntToStr(w) + ">";
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaIntType*) (*titer).second;
    else
      {
	ret_type = new AaIntType((AaScope*) NULL, w);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
  static AaFloatType* Make_Float_Type(unsigned int c, unsigned int m)
  {
    AaFloatType* ret_type = NULL;
    string tid = "float<" + IntToStr(c) + "," + IntToStr(m) + ">";
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaFloatType*) (*titer).second;
    else
      {
	ret_type = new AaFloatType((AaScope*) NULL, c,m);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
  static AaArrayType* Make_Array_Type(AaScalarType* etype, vector<unsigned int>& dims)
  {
    AaArrayType* ret_type = NULL;
    string tid = "array";
    for(unsigned int i=0; i < dims.size(); i++)
	tid += "<" + IntToStr(dims[i]) + ">";
    tid += " of ";
    etype->Print(tid);
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaArrayType*) (*titer).second;
    else
      {
	ret_type = new AaArrayType((AaScope*) NULL,etype,dims);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
  static AaPointerType* Make_Pointer_Type(unsigned int w)
  {
    AaPointerType* ret_type = NULL;
    string tid = "pointer<" + IntToStr(w) + ">";
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaPointerType*) (*titer).second;
    else
      {
	ret_type = new AaPointerType((AaScope*) NULL, w);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }

  virtual string Kind() {return("AaProgram");}
};


#endif
