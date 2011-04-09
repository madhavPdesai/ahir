#ifndef _Aa_Root__
#define _Aa_Root__

#include <AaIncludes.h>
#include <AaUtil.h>


//****************************************** ROOT ***************************************

//
// base class for all objects.  Each object will have a parent scope
//
class AaType;
class AaValue;
class AaRoot
{
  // to get unique id's for anon objects
  static int64_t _root_counter;
  // set if there is an error
  static bool _error_flag;
  // set if there is a warning
  static bool _warning_flag;

  // fill from the parser at some point.
  unsigned int _line_number;

  string _file_name;

  int64_t _index;

 protected:

  // vector of references to this object from "anywhere"
  set<AaRoot*> _target_references; // objects that use this as a target
  set<AaRoot*> _source_references; // objects that use this as a source.

 public:

  static void Increment_Root_Counter();// { _root_counter += 1; }
  static int64_t Get_Root_Counter(); // { return _root_counter; }
  static void Error(string err_msg,AaRoot* r); // {_error_flag = true;}
  static void Warning(string err_msg,AaRoot* r); // {_warning_flag = true;}
  static void Info(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }
  static bool Get_Warning_Flag(); // { return _warning_flag; }
  void Set_Line_Number(int n) { this->_line_number = n; }
  unsigned int Get_Line_Number() { return(this->_line_number); }

  int64_t Get_Index() {return(_index);}

  AaRoot();
  ~AaRoot(); 

  virtual string Get_VC_Name() {assert(0);}

  virtual string Get_VC_Start_Transition_Name() {
    return(this->Get_VC_Name() + "_trigger_");
  }

  virtual string Get_VC_Active_Transition_Name() {
    return(this->Get_VC_Name() + "_active_");
  }

  virtual string Get_VC_Completed_Transition_Name() {
    return(this->Get_VC_Name() + "_completed_");
  }

  virtual AaType* Get_Type() {assert(0);}
  virtual AaValue* Get_Expression_Value() {assert(0);}

  // useful print versions
  virtual void Print(ostream& ofile); // override this in derived classes
  virtual void Print(ofstream& ofile);
  virtual void Print(string& ostring);
  virtual string Get_Name() {assert(0);}
  virtual AaRoot* Find_Child() {return(NULL);}
  virtual bool Is_Scope() {return(false); }

  virtual bool Is_Object() {return(false); }
  virtual bool Is_Storage_Object() {return(false); }
  virtual bool Is_Foreign_Storage_Object() {return(false); }
  virtual bool Is_Constant() {return(false);}

  virtual bool Is_Expression() {return(false); }
  virtual bool Is_Statement() {return(false); }

  // do we really need this? keep it for now
  virtual bool Is(string class_name);
  virtual string Kind();

  virtual void Add_Target_Reference(AaRoot* referrer);
  virtual void Add_Source_Reference(AaRoot* referrer);

  virtual unsigned int Get_Number_Of_Target_References()
  {
    return(this->_target_references.size());
  }

  virtual unsigned int Get_Number_Of_Source_References()
  {
    return(this->_source_references.size());
  }
  
  virtual string To_String() 
  {
    string ret_string;
    this->Print(ret_string);
    return(ret_string);
  }

  virtual string Get_C_Name() { assert(0); }
  virtual string Get_Struct_Dereference() { assert(0); }

  virtual string Get_File_Name() { return(this->_file_name);}

  virtual void Err_Check() {}

};

struct AaRootCompare:public binary_function
  <AaRoot*, AaRoot*, bool >
{
  bool operator() (AaRoot*, AaRoot*) const;
};

string Make_VC_Legal(string x);
#endif
