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
#ifndef _Aa_Object__
#define _Aa_Object__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>

class AaModule;

/*****************************************  OBJECT  ****************************/
// base object
// Each object has a type, a name, a value and a parent
class AaObject: public AaRoot
{

 protected:
  string _name;
  AaConstantLiteralReference* _value;
  AaType* _type;
  AaScope* _scope;

  AaStorageObject* _addressed_object_representative;
  set<AaStorageObject*> _addressed_objects;

  bool _is_dereferenced;

 public:

  AaType* Get_Type() {return(this->_type);}
  virtual AaModule* Get_Module();

  AaConstantLiteralReference* Get_Value() {return(this->_value);}
  void Set_Value(AaConstantLiteralReference* v);

  virtual string Get_Name() {return(this->_name);}
  virtual string Get_Hierarchical_Name();
  virtual string Get_VC_Name() {return(this->_name);}
  virtual string Get_C_Name() {return(this->_name);}

  virtual AaScope* Get_Scope() {return(this->_scope);}
  virtual string Tab();

  AaObject(AaScope* scope_tpr, string oname, AaType* object_type);
  ~AaObject();

  virtual void Print(ostream& ofile);  
  virtual string Kind() {return("AaObject");}
  virtual bool Is_Object() {return(true); }

  // C related stuff.
  virtual string C_Reference_String();
  virtual void PrintC_Declaration(ofstream& ofile);
  virtual void PrintC(ofstream& ofile);


  virtual void Write_VC_Model(ostream& ofile);

  virtual bool Is_Constant() {return(false);}
  virtual string Get_VC_Memory_Space_Name() {assert(0);}

  virtual bool Set_Addressed_Object_Representative(AaStorageObject* obj);
  void Propagate_Addressed_Object_Representative(AaStorageObject* obj, AaRoot* from_where);
  void Coalesce_Storage();

  AaStorageObject* Get_Addressed_Object_Representative() 
    {
      return(this->_addressed_object_representative);
    }

  virtual AaValue* Get_Expression_Value() {return(NULL);}

  set<AaStorageObject*>& Get_Addressed_Objects()
    {
      return(this->_addressed_objects);
    }
  
  bool Get_Is_Dereferenced() {return(_is_dereferenced);}
  void Set_Is_Dereferenced(bool v) {_is_dereferenced = v;}

  virtual void PrintC_Global_Declaration(ofstream& ofile);
  virtual void PrintC_Global_Initialization(ofstream& ofile);

};

// interface object: function arguments
class AaStatement;
class AaInterfaceObject: public AaObject
{
  // arguments can be input or output
  string _mode; // "in" or "out"

  bool _is_input;

  AaStatement* _unique_driver_statement;
  AaValue* _expr_value;
 public:
  string Get_Mode() {return(this->_mode);}
  bool Get_Is_Input() {return(_is_input);}

  AaInterfaceObject(AaScope* scope_tpr, string oname, AaType* otype, string mode);
  ~AaInterfaceObject();
  virtual string Get_Name();
  virtual string Kind() {return("AaInterfaceObject");}
  virtual bool Is_Interface_Object() {return(true);}
  // uses AaObject::Print method

  virtual void Write_VC_Model(ostream& ofile);
  // values on outputs.
  void Set_Expr_Value(AaValue* v) {_expr_value = v;}
  AaValue* Get_Expr_Value() {return(_expr_value);}

  
  void Set_Unique_Driver_Statement(AaStatement* stmt)
  {
    if(_unique_driver_statement == NULL)
      _unique_driver_statement = stmt;

  }
  AaStatement* Get_Unique_Driver_Statement()
  {
    return(_unique_driver_statement);
  }
  
  virtual void PrintC_Declaration(ofstream& ofile)
  {
	// will be declared explicitly..
  }
  
  virtual string Get_VC_Sample_Start_Transition_Name();
  virtual string Get_VC_Sample_Completed_Transition_Name();
  virtual string Get_VC_Update_Start_Transition_Name();
  virtual string Get_VC_Update_Completed_Transition_Name();
  virtual string Get_VC_Unmarked_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements);

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

  virtual bool Is_Constant() {return(true);}

  // todo: this is different from the base Object..
  virtual void Write_VC_Model(ostream& ofile);

  void Evaluate();
  AaValue* Get_Expression_Value();

  virtual string Get_VC_Name();
};

class AaStorageObject: public AaObject
{

 protected:
  // objects will be stored in memory
  //
  int _base_address;    // location of "base" of object.
  int _word_size;       // minimum addressable unit
  int _address_width;   // address-width of the memory-space.

  int _mem_space_index;
  

  set<int> _access_widths;

  bool _is_written_into;
  bool _is_read_from;
  bool _register_flag;

 public:

  AaStorageObject(AaScope* scope_tpr, string oname, AaType* otype, AaConstantLiteralReference* initial_value);
  ~AaStorageObject();

  virtual void Print(ostream& ofile); 
  virtual string Kind() {return("AaStorageObject");}

  virtual void Set_Mem_Space_Index(int id) { _mem_space_index = id;}
  virtual int Get_Mem_Space_Index() {return(_mem_space_index);}

  virtual void Set_Base_Address(int a) { _base_address = a; }
  virtual int Get_Base_Address() {return(_base_address);}

  virtual void Set_Word_Size(int a) { _word_size = a; }
  virtual int Get_Word_Size() {return(_word_size);}
  
  virtual void Set_Address_Width(int a) { _address_width = a; }
  virtual int Get_Address_Width() {return(_address_width);}

  virtual void Set_Is_Written_Into(bool v) { _is_written_into = v; }
  virtual bool Get_Is_Written_Into() { return(_is_written_into); }

  virtual void Set_Is_Read_From(bool v) { _is_read_from = v; }
  virtual bool Get_Is_Read_From() { return(_is_read_from); }

  virtual bool Is_Storage_Object() {return(true);}

  bool Get_Register_Flag() {return(_register_flag);}
  void Set_Register_Flag(bool v) { _register_flag = v;}



  // todo: this is the same as object, but keep it here
  //      because the initial value needs to be 
  //      updated..
  virtual void Write_VC_Model(ostream& ofile);

  virtual string Get_VC_Name();
  virtual string Get_VC_Memory_Space_Name();
  
  void Write_VC_Load_Store_Constants(ostream& ofile);


  string Get_VC_Base_Address_Name()
  {
    return(this->Get_VC_Name() + "_base_address");
  }


  void Add_Access_Width(int w)
  {
    _access_widths.insert(w);
  }

  set<int>& Get_Access_Widths()
    {
      return(_access_widths);
    }

};


class AaForeignStorageObject: public AaStorageObject
{

 public:
  AaForeignStorageObject(AaType* otype, int word_size, int address_width);

  virtual void Print(ostream& ofile) {assert(0);}
  virtual string Kind() {return("AaForeignStorageObject");}

  virtual void Set_Mem_Space_Index(int id) {assert(0);}
  virtual int Get_Mem_Space_Index() { assert(0); }

  virtual bool Is_Storage_Object() {return(true);}
  virtual bool Is_Foreign_Storage_Object() {return(true); }

  virtual string Get_VC_Memory_Space_Name()
  {
    return("FOREIGN_MEMORY_SPACE");
  }
  
  virtual void Write_VC_Load_Store_Constants(ostream& ofile)
  {
    // nothing.
  }

  virtual bool Set_Addressed_Object_Representative(AaStorageObject* obj);

};

class AaModule;
class AaPipeObject: public AaObject
{
  
  set<AaModule*> _reader_modules;
  set<AaModule*> _writer_modules;

  int _depth;
  bool _lifo_mode;
  bool _no_block_mode;
  bool _full_rate;

  bool _in_mode;
  bool _out_mode;
  bool _signal;
  bool _port;
  bool _synch;
  bool _p2p;
  bool _shift_reg;
 public:

  
  AaPipeObject(AaScope* scope_tpr,string oname, AaType* otype);
  ~AaPipeObject();

  void Set_Depth(int d);
  int Get_Depth() {return(_depth); }

  void Set_Lifo_Mode(bool v) { _lifo_mode = v; }
  bool Get_Lifo_Mode() {return(_lifo_mode);}

  void Set_Full_Rate(bool v) { _full_rate = v; }
  bool Get_Full_Rate() {return(_full_rate);}

  void Set_No_Block_Mode(bool v) { _no_block_mode = v; }
  bool Get_No_Block_Mode() {return(_no_block_mode);}

  void Set_In_Mode(bool v) { _in_mode = v; }
  bool Get_In_Mode() {return(_in_mode);}

  void Set_Out_Mode(bool v) { _out_mode = v; }
  bool Get_Out_Mode() {return(_out_mode);}

  void Set_Signal(bool v) { _signal = v; }
  bool Get_Signal() {return(_signal);}

  void Set_Synch(bool v) { _synch = v; }
  bool Get_Synch() {return(_synch);}

  void Set_P2P(bool v) { _p2p = v; }
  bool Get_P2P() {return(_p2p);}

  void Set_Shift_Reg(bool v) { _shift_reg = v; }
  bool Get_Shift_Reg() {return(_shift_reg);}

  virtual void Print(ostream& ofile);

  //
  // C related stuff.  Pipes are not declared
  // in C. references to pipes are replaced by 
  // calls to special functions write_*, read_*
  // 
  void PrintC_Pipe_Registration(ofstream& ofile);
  virtual void PrintC_Declaration(ofstream& ofile) {this->PrintC_Pipe_Registration(ofile);}
  virtual void PrintC(ofstream& ofile) {}
  virtual void PrintC_Global_Declaration(ofstream& ofile) {}
  virtual void PrintC_Global_Initialization(ofstream& ofile) {this->PrintC_Pipe_Registration(ofile);}

  virtual string Kind() {return("AaPipeObject");}
  virtual string Get_Valid_Flag_Name() { return(this->Get_Name() + "_valid__");}
  virtual string Get_Valid_Flag_Name_Ref() 
  {
    if(this->Get_Scope() == NULL)
      return(this->Get_Valid_Flag_Name());
    else
      return(this->Get_Scope()->Get_Struct_Dereference() + this->Get_Valid_Flag_Name());
  }


   virtual void Write_VC_Model(ostream& ofile);
   virtual string Get_VC_Name();

   void Add_Reader(AaModule* m);
   void Add_Writer(AaModule* m);

   virtual bool Is_Pipe_Object() {return(true); }
   virtual bool Is_Signal() {return(_signal); }

};

void Print_Storage_Object_Set(set<AaStorageObject*>& ss, ostream& ofile);
#endif
