//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
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

  int _delay; // delay through expression/statement/module etc..

  bool _c_declaration_printed;
  bool _is_on_collect_root_sources_stack; 
  bool _is_on_search_for_non_trivial_refs_stack; 
 protected:

  // vector of references to this object from "anywhere"
  set<AaRoot*> _target_references; // objects that use this as a target
  set<AaRoot*> _source_references; // objects that use this as a source.

 public:

   void Set_Is_On_Collect_Root_Sources_Stack(bool v) { _is_on_collect_root_sources_stack = v;}
   bool Get_Is_On_Collect_Root_Sources_Stack() {return (_is_on_collect_root_sources_stack);}

   void Set_Is_On_Search_For_Non_Trivial_Refs_Stack(bool v) { _is_on_search_for_non_trivial_refs_stack = v;}
   bool Get_Is_On_Search_For_Non_Trivial_Refs_Stack() {return (_is_on_search_for_non_trivial_refs_stack);}

  void Set_C_Declaration_Printed(bool v) { _c_declaration_printed = v;}
  bool Get_C_Declaration_Printed() {return (_c_declaration_printed);}
  void Set_Delay(int d) {_delay = d;}
  virtual int Get_Delay() {return(_delay);}

  set<AaRoot*>& Get_Target_References() {return(_target_references);}
  set<AaRoot*>& Get_Source_References() {return(_source_references);}

  //
  // search forward until you find non-trivial 
  // expressions or statements which use this 
  // as a source.
  //
  virtual void Get_Non_Trivial_Source_References(set<AaRoot*>&, set<AaRoot*>& visited_elements);

  static void Increment_Root_Counter();// { _root_counter += 1; }
  static int64_t Get_Root_Counter(); // { return _root_counter; }
  static void Error(string err_msg,AaRoot* r); // {_error_flag = true;}
  static void Warning(string err_msg,AaRoot* r); // {_warning_flag = true;}
  static void Info(string err_msg); // {_warning_flag = true;}
  static void DebugInfo(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }
  static bool Get_Warning_Flag(); // { return _warning_flag; }
  void Set_Line_Number(int n) { this->_line_number = n; }
  unsigned int Get_Line_Number() { return(this->_line_number); }

  int64_t Get_Index() {return(_index);}

  AaRoot();
  ~AaRoot(); 

  // C related stuff.
  // return string by which this node is referred to in the C code.
  virtual string C_Reference_String() {assert(0);}
  //
  // print C code for this node.
  //
  virtual void  PrintC(ofstream& ofile) {assert(0);}
  // 
  // print C declaration for this node.
  virtual void  PrintC_Declaration(ofstream& ofile) {assert(0);}


  // VC related stuff.
  virtual string Get_VC_Name() {assert(0);}
  virtual string Get_VC_Sample_Start_Transition_Name() {
    return(this->Get_VC_Name() + "_sample_start_");
  }

  virtual string Get_VC_Sample_Completed_Transition_Name() {
    return(this->Get_VC_Name() + "_sample_completed_");
  }

  virtual string Get_VC_Update_Start_Transition_Name() {
    return(this->Get_VC_Name() + "_update_start_");
  }

  virtual string Get_VC_Update_Completed_Transition_Name() {
    return(this->Get_VC_Name() + "_update_completed_");
  }

  // Note: the base class provides a conservative definition for
  // the reenable transitions.  This should be modified by
  // derived classes based on their implementation of the VC 
  // control schemes.
  virtual string Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements) {
    return(this->Get_VC_Update_Start_Transition_Name());    
  }
  virtual string Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements) {
    return(this->Get_VC_Sample_Start_Transition_Name());    
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
  virtual bool Is_Pipe_Object() {return(false); }
  virtual bool Is_Signal() {return(false); }
  virtual bool Is_Foreign_Storage_Object() {return(false); }
  virtual bool Is_Constant() {return(false);}
  virtual bool Is_Interface_Object() {return(false);}
  virtual bool Is_Module() {return(false);}

  virtual bool Is_Expression() {return(false); }
  virtual bool Is_Statement() {return(false); }
  virtual bool Is_Phi_Statement() {return(false); }
  virtual bool Is_Null_Like_Statement() {return(false); }
  virtual bool Is_Assignment_Statement() {return(false); }
  virtual bool Is_Call_Statement() {return(false); }

  // do we really need this? keep it for now
  virtual bool Is(string class_name);
  virtual string Kind();


  virtual int Get_Buffering () {assert(0);}
  virtual void Set_Buffering (int u) {assert(0);}

  virtual void Add_Target_Reference(AaRoot* referrer);
  virtual void Add_Source_Reference(AaRoot* referrer);
  virtual void Remove_Target_Reference(AaRoot* referrer);
  virtual void Remove_Source_Reference(AaRoot* referrer);

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

  virtual string Get_Source_Info() 
  {
     return(string(" file ") 
	   + this->Get_File_Name() 
	   + ", line " 
	   + 
	   IntToStr(this->Get_Line_Number())); 
  }

  virtual string Debug_Info()
  {
    return(this->Get_Source_Info());
  };

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
  {
	// do nothing.
  }


  virtual string C_Address() { assert(0); }
  virtual string C_Value()   { assert(0); }
  
};


void __InsMap(map<AaRoot*,vector< pair<AaRoot*, int> > >& amap, AaRoot* src, AaRoot* dest, int Distance);

struct AaRootCompare:public binary_function
  <AaRoot*, AaRoot*, bool >
{
  bool operator() (AaRoot*, AaRoot*) const;
};

class AaRootPair
{
    public:
	AaRoot* _element;
	int     _distance_from_root;
	AaRootPair(AaRoot* ele, int d) { _element = ele; _distance_from_root = d;}
};

struct AaRootPairCompare:public binary_function
  <AaRootPair*, AaRootPair*, bool >
{
  bool operator() (AaRootPair*, AaRootPair*) const;
};
 
string Make_VC_Legal(string x);
#endif
