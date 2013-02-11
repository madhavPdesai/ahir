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

  AaConstantLiteralReference* Get_Value() {return(this->_value);}
  void Set_Value(AaConstantLiteralReference* v);

  virtual string Get_Name() {return(this->_name);}
  virtual string Get_Hierarchical_Name();
  virtual string Get_VC_Name() {return(this->_name);}

  virtual AaScope* Get_Scope() {return(this->_scope);}
  virtual string Tab();

  AaObject(AaScope* scope_tpr, string oname, AaType* object_type);
  ~AaObject();

  virtual void Print(ostream& ofile);  
  virtual string Kind() {return("AaObject");}
  virtual bool Is_Object() {return(true); }

  virtual void PrintC(ofstream& ofile, string tab_string);

  virtual string CRef()
  {
    if(this->Get_Scope())
      return(this->Get_Scope()->Get_Struct_Dereference() + this->Get_Name() + ".__val");
    else
      return(this->Get_Name() + ".__val");
  }

  virtual void Write_Initialization(ofstream& ofile)
  {
    if(this->_value)
      {
	ofile << this->CRef() << " = ";
	this->_value->PrintC(ofile,"");
	ofile << ";" << endl;
      }
  }

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
};

// interface object: function arguments
class AaStatement;
class AaInterfaceObject: public AaObject
{
  // arguments can be input or output
  string _mode; // "in" or "out"

  bool _is_input;

  AaStatement* _unique_driver_statement;
 public:
  string Get_Mode() {return(this->_mode);}
  bool Get_Is_Input() {return(_is_input);}

  AaInterfaceObject(AaScope* scope_tpr, string oname, AaType* otype, string mode);
  ~AaInterfaceObject();
  virtual string Get_Name();
  virtual string Kind() {return("AaInterfaceObject");}
  virtual bool Is_Interface_Object() {return(true);}
  // uses AaObject::Print method

  void Set_Unique_Driver_Statement(AaStatement* stmt)
  {
    if(_unique_driver_statement == NULL)
      _unique_driver_statement = stmt;

  }
  AaStatement* Get_Unique_Driver_Statement()
  {
    return(_unique_driver_statement);
  }
  
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
 public:

  
  AaPipeObject(AaScope* scope_tpr,string oname, AaType* otype);
  ~AaPipeObject();

  void Set_Depth(int d) {_depth = d; }
  int Get_Depth() {return(_depth); }

  void Set_Lifo_Mode(bool v) { _lifo_mode = v; }
  bool Get_Lifo_Mode() {return(_lifo_mode);}

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaPipeObject");}
  virtual string Get_Valid_Flag_Name() { return(this->Get_Name() + "_valid__");}
  virtual string Get_Valid_Flag_Name_Ref() 
  {
    if(this->Get_Scope() == NULL)
      return(this->Get_Valid_Flag_Name());
    else
      return(this->Get_Scope()->Get_Struct_Dereference() + this->Get_Valid_Flag_Name());
  }

  virtual void PrintC(ofstream& ofile, string tab_string)
  {
    this->AaObject::PrintC(ofile,tab_string);
    ofile << tab_string 
	  << "unsigned int " 
	  << this->Get_Valid_Flag_Name() 
	  << " : 1; " 
	  << endl;
  }

   virtual void Write_VC_Model(ostream& ofile);
   virtual string Get_VC_Name();

   void Add_Reader(AaModule* m) {_reader_modules.insert(m);}
   void Add_Writer(AaModule* m) {_writer_modules.insert(m);}

   virtual bool Is_Pipe_Object() {return(true); }

};

void Print_Storage_Object_Set(set<AaStorageObject*>& ss, ostream& ofile);
#endif
