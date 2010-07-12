#ifndef _Aa_Root__
#define _Aa_Root__

#include <AaIncludes.h>
#include <AaUtil.h>


//****************************************** ROOT ***************************************

//
// base class for all objects.  Each object will have a parent scope
//
class AaRoot
{
  // the containing scope
  AaRoot* _scope;

  // to get unique id's for anon objects
  static int _root_counter;
  // set if there is an error
  static bool _error_flag;

  // fill from the parser at some point.
  unsigned int _line_number;

  // vector of references to this object from "anywhere"
  set<AaRoot*> _target_references;
  set<AaRoot*> _source_references;

 public:

  static void Increment_Root_Counter();// { _root_counter += 1; }
  static int Get_Root_Counter(); // { return _root_counter; }
  static void Error(); // {_error_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }
  void Set_Line_Number(int n) { this->_line_number = n; }
  unsigned int Get_Line_Number() { return(this->_line_number); }

  AaRoot();
  ~AaRoot(); 

  // useful print versions
  virtual void Print(ostream& ofile); // override this in derived classes
  virtual void Print(ofstream& ofile);
  virtual void Print(string& ostring);
  virtual string Get_Name() {assert(0);}
  virtual AaRoot* Find_Child() {return(NULL);}
  virtual bool Is_Scope() {return(false); }

  // do we really need this? keep it for now
  virtual bool Is(string class_name);
  virtual string Kind();

  virtual void Add_Target_Reference(AaRoot* referrer)
  {
    this->_target_references.insert(referrer);
  }

  virtual void Add_Source_Reference(AaRoot* referrer)
  {
    this->_source_references.insert(referrer);
  }

  virtual unsigned int Get_Number_Of_Target_References()
  {
    return(this->_target_references.size());
  }

  virtual unsigned int Get_Number_Of_Source_References()
  {
    return(this->_source_references.size());
  }

};

#endif
