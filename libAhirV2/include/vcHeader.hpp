#ifndef _VC_ROOT_H_
#define _VC_ROOT_H_

class vcRoot
{
  string _id;
  map<string,string> _atttribute_map;

  static bool _err_flag;

 public:
  vcRoot(string id);

  static void Error(string err_msg); // {_error_flag = true;}
  static void Warning(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }
  static bool Get_Warning_Flag(); // { return _warning_flag; }

  void Add_Attribute(string tag, string value);

  string Get_Id() {return(this->_id);}

  virtual void Print(ostream& ofile);

  void Print(ofstream& ofile);
  void Print(string& ostring);

  virtual string Kind()
  {
    return("vcRoot");
  }

  bool Is(string class_name)
  {
    return(class_name == this->Kind());
  }
};

//  compare functor
struct vcRoot_Compare:public binary_function
  <vcRoot*, vcRoot*, bool >
{
  bool operator() (vcRoot*, vcRoot*) const;
};

#endif // vcRoot

#ifndef _VC_TYPE_H
#define _VC_TYPE_H


class vcType: public AaRoot
{

 public:
  vcType(string id);

  virtual string Kind()
  {
    return("vcType");
  }

  virtual void Print(ostream& ofile);
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
  vcScalarType(string id);
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
  vcIntType(string id, unsigned int width);

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
  
  // element type is a scalar
  vcScalarType* _element_type;
 
 public:

  vcScalarType* Get_Element_Type() {return(this->_element_type);}
  vcArrayType(vcScalarType* stype, int dimension);

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
  int Get_Number_Of_Elements() {return(this->_element_types.size();}


};

#endif // vcType


#ifndef _vc_Value__
#define _vc_Value__



class vcValue: public AaRoot
{
  vcType* _type;
 public:
  vcValue(vcType t);

  vcType* Get_Type() { return(this->_type);}
  virtual string Kind() {return("vcValue");}
};

class vcIntValue: public vcValue
{
  // value is a binary string of characters
  // each of which can be 0 or 1.
  vector<char> _value;
 public:

  vcIntValue(vcIntType* t, string value);
  vcIntValue(vcIntType* t, string value, string format);


  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcIntValue");}

  // assignment operator
  vcIntValue& operator=(const vcIntValue& v);

  // +=, *=, -=
  vcIntValue& operator+=(vcIntValue);
  vcIntValue& operator*=(vcIntValue);
  vcIntValue& operator-=(vcIntValue);
  vcIntValue& operator/=(vcIntValue);

  // friend operators
  friend vcIntValue operator+(vcIntValue, vcIntValue);
  friend vcIntValue operator-(vcIntValue, vcIntValue);
  friend vcIntValue operator*(vcIntValue, vcIntValue);
  friend vcIntValue operator/(vcIntValue, vcIntValue);

};
vcIntValue operator+(vcIntValue, vcIntValue);
vcIntValue operator-(vcIntValue, vcIntValue);
vcIntValue operator*(vcIntValue, vcIntValue);
vcIntValue operator/(vcIntValue, vcIntValue);

vcIntValue operator>(vcIntValue, vcIntValue);
vcIntValue operator<(vcIntValue, vcIntValue);
vcIntValue operator>=(vcIntValue, vcIntValue);
vcIntValue operator==(vcIntValue, vcIntValue);



class vcFloatValue: public vcValue
{
  char _sign;
  vcIntValue _characteristic;
  vcIntValue _mantissa;

 public:
  int Get_Value() { return(this->_value);}

  vcFloatValue(vcFloatType* t, char sgn, vcIntValue* cvalue, vcIntValue* mvalue);

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcFloatValue");}

  // assignment operator
  vcFloatValue& operator=(const vcFloatValue& v);

  // +=, *=, -=
  vcFloatValue& operator+=(vcFloatValue);
  vcFloatValue& operator*=(vcFloatValue);
  vcFloatValue& operator-=(vcFloatValue);
  vcFloatValue& operator/=(vcFloatValue);

  // friend operators
  friend vcFloatValue operator+(vcFloatValue, vcFloatValue);
  friend vcFloatValue operator-(vcFloatValue, vcFloatValue);
  friend vcFloatValue operator*(vcFloatValue, vcFloatValue);
  friend vcFloatValue operator/(vcFloatValue, vcFloatValue);

};

vcFloatValue operator+(vcFloatValue, vcFloatValue);
vcFloatValue operator-(vcFloatValue, vcFloatValue);
vcFloatValue operator*(vcFloatValue, vcFloatValue);
vcFloatValue operator/(vcFloatValue, vcFloatValue);

vcIntValue operator>(vcFloatValue, vcFloatValue);
vcIntValue operator<(vcFloatValue, vcFloatValue);
vcIntValue operator>=(vcFloatValue, vcFloatValue);
vcIntValue operator==(vcFloatValue, vcFloatValue);

class vcArrayValue: public vcValue
{
  vector<vcValue> _value_array;
 public:
  vcArrayValue(vcArrayType* t, vector<vcValue*>& values);
  ~vcArrayValue();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcArrayValue");}

  vcValue Slice(int lindex, int rindex);
  vcValue operator[](int index);

  // assignment operator
  vcArrayValue& operator=(const vcArrayValue& v);

  // concatenate
  friend vcArrayValue operator&&(vcArrayValue, vcArrayValue);
};

// concatenate arrays.
vcArrayValue operator&&(vcArrayValue, vcArrayValue);

class vcRecordValue: public vcValue
{
  vector<vcValue*> _element_values;
 public:
  vcRecordValue(vcRecordType* t, vector<vcValue*>& values);
  ~vcRecordValue();

  int Get_Number_Of_Elements();
  vcValue Get_Element(int index);
  vcValue Get_Element(string field_name);

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcRecordValue");}

  vcValue Section(string element_name);

  // assignment operator
  vcRecordValue& operator=(const vcRecordValue& v);
};


#endif // vcValue

#ifndef _VC_STORAGE_OBJECT_
#define _VC_STORAGE_OBJECT_

class vcStorageObject: public vcRoot
{
  vcType*  _type;
  vcValue* _value;
  vcIntValue* _base_address;

 public:
  vcStorageObject(string id, vcType* t);
  ~vcStorageObject();

  vcType* Get_Type() { return(_type);}

  void Set_Value(vcValue* v);
  vcValue* Get_Value() {return(_value);}

  void Set_Base_Address(vcIntValue* v);
  vcIntValue* Get_Base_Address(); {return(_base_address);}

  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcStorageObject");}
};

#endif // vcStorageObject

#ifndef _VC_MEMORY_SPACE_H__
#define _VC_MEMORY_SPACE_H__

class vcMemorySpace
{
  vector<vcStorageObject*> objects;
  
  unsigned int _capacity;
  unsigned int _word_size;
  unsigned int _address_width;

 public:
  vcMemorySpace(string id);
  ~vcMemorySpace();

  void Set_Capacity(unsigned int c) { this->_capacity = c;}
  void Set_Word_Size(unsigned int c) { this->_word_size = c;}
  void Set_Address_Width(unsigned int c) { this->_address_width = c;}

  int Set_Capacity() { return this->_capacity;}
  int Set_Word_Size() { return this->_word_size;}
  int Set_Address_Width() {return this->_address_width;}


  void Add_Storage_Object(vcStorageObject* obj);
  void Get_Number_Of_Storage_Objects();
  vcStorageObject* Get_Storage_Object(int index);

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcMemorySpace");}
};
#endif // vcMemorySpace

#ifndef _vC_CP_H_
#define _vC_CP_H_

enum vcTransitionType
  {
    _IN,
    _OUT,
    _HIDDEN
  };

class vcCPElement: public vcRoot
{
  vector<vcCPElement*> _predecessors;
  vector<vcCPElement*> _successors;

 public:
  vcCPElement(string id);
  ~vcCPElement();

  void Add_Successor(vcCPElement* cpe);
  void Add_Predecessor(vcCPElement* cpe);

  virtual string Kind() {return("vcCPElement");}

};


class vcTransition: public vcCPElement
{
  vcTransitionType _transition_type;

 public:
  vcTransition(string id, vcTransitionType t);

  virtual string Kind() {return("vcTransition");}

};

class vcPlace: public vcCPElement
{
  unsigned int _initial_marking;
 public:
  vcPlace(string id, unsigned int init_marking);

  virtual string Kind() {return("vcPlace");}
};

class vcCPBlock: public vcCPElement
{
  map<string, vcCPElement*> _element_map;
  vector<vcCPElement*> _elements;
 public:
  vcCPSeriesBlock(string id);
  virtual void Add_CPElement(vcCPElement* cpe);
  virtual string Kind() {return("vcCPBlock");}

  vcCPElement* Find_CPElement(string cname);
};

class vcCPSeriesBlock: public vcBlock
{
 public:
  vcCPSeriesBlock(string id);
  virtual string Kind() {return("vcCPSeriesBlock");}
};

class vcCPParallelBlock: public vcBlock
{
 public:
  vcCPParallelBlock(string id);
  virtual string Kind() {return("vcCPSeriesBlock");}
};

class vcCPBranchBlock: public vcCPSeriesBlock
{
  map<vcCPPlace*, vector<vcCPElement*>, vcRoot_Compare > _branch_map;
  map<vcCPPlace*, vector<pair<vcCPElement*,vcCPElement*> >, vcRoot_Compare > _merge_map;

 public:
  vcCPBranchBlock(string id);
  virtual string Kind() {return("vcCPBranchBlock");}

  void Add_Branch_Point(string bp_name, vector<string>& choice_cpe_vec);
  void Add_Merge_Point(string merge_place, string merge_from, string merge_region);
};

class vcCPForkBlock: public vcCPParallelBlock
{
  map<vcCPTransition*, vector<vcCPElement*>, vcRoot_Compare > _fork_map;
  map<vcCPTransition*, vector<vcCPElement*>, vcRoot_Compare > _join_map;

 public:
  vcCPForkBlock(string id);
  virtual string Kind() {return("vcCPForkBlock");}

  void Add_Fork_Point(string& fork_name, vector<string>& fork_cpe_vec);
  void Add_Join_Point(string& join_name, vector<string>& join_cpe_vec);
};


class vcControlPath: public vcSeriesBlock
{

 public:
  vcControlPath(string id);

  vcTransition* Find_Transition(string tname);
  vcPlace* Find_Place(string pname);

  virtual string Kind() {return("vcControlPath");}
};

#endif

#ifndef _VC_WIRE_H_
#define _VC_WIRE_H_

class vcWire: public vcRoot
{
  vcType* _type;
  vcRoot* _driver;
  set<vcRoot*> _receivers;

 public:
  vcWire(string id, vcType* t);
 
  void Connect_Driver(vcRoot* d);
  void Connect_Receiver(vcRoot* r);

  vcRoot* Get_Driver();
  int Get_Receivers(vector<vcRoot*>& receivers);

  virtual string Kind() {return("vcWire");}
};

#endif // vcWire

#ifndef _VC_DATAPATH_H_
#define _VC_DATAPATH_H_

class vcDatapathElementTemplate: public vcRoot
{
  map<string, pair<int,int>> _parameter_limit_map;
  
  set<string> _reqs;
  set<string> _acks;
  
  map<string, vcScalarTypeTemplate*> _input_port_map;
  map<string, vcScalarTypeTemplate*> _output_port_map;

 public:

  vcDatapathElementTemplate(string id);
  void Add_Parameter(string param_val, int min_val, int max_val);
  void Add_Req(string req_name);
  void Add_Ack(string ack_name);
  
  void Add_Input_Port(string pname, vcScalarTypeTemplate* t);
  void Add_Output_Port(string pname, vcScalarTypeTemplate* t);

  bool Is_Req(string req_name);
  bool Is_Ack(string ack_name);
  
  bool Is_Input_Port(string pname);
  bool Is_Output_Port(string pname);

  bool Is_Parameter(string pname);
  bool Is_Legal_Parameter_Value(string pname, int val);
  virtual string Kind() {return("vcDatapathElementTemplate");}
};

class vcDatapathElementLibrary: public vcRoot
{
  set<vcDatapathElementTemplate*,vcRoot_Compare> _templates;
 public:
  vcDatapathElementLibrary(string id);
  void Add_Template(vcDatapathElementTemplate* t);
  vcDatapathElementTemplate* Get_Template(string template_name);
};

class vcDatapathElement: public vcRoot
{
  string _template_name;
  vcDatapathElementTemplate* _template;

  map<string, int> _parameter_value_map;
  map<string, vcWire*> _port_map;
  map<string, vcTransition*> _control_link_map;

 public:

  vcDatapathElement(string id, string template_name);
  ~vcDatapathElement();

  bool Is_Parameter(string id);

  void Set_Parameter(string id, int val);
  int  Get_Parameter(string id);

  void Connect_Wire(string port_name, vcWire* w);
  vcWire* Get_Connected_Wire(string port_name);

  void Add_Link(string trans_name, string dpe_inst_id, string req_ack_id);

  void Set_Template(vcDatapathElementTemplate* t) { this->_template = t;}
  vcDatapathElementTemplate* Get_Template() {return(this->_template);}

  virtual string Kind() {return("vcDatapathElement");}
};


class vcDataPath: public vcRoot
{
  map<string, vcDatapathElement*> _dpe_map;
  map<string, vcWire*> _wire_map;
 public:
  vcDatapath(string id);
  ~vcDatapath();

  void Add_DPE(string dpe_name, string dpe_template_name);
  void Set_DPE_Parameter(string dpe_name, string param_name, int param_value);
  int Get_DPE_Parameter(string dpe_name, string param_name);

  vcWire* Get_Wire(string wname);
  void Add_Wire(string wname, vcType* t);
  void Drive_Wire(string dpe_name, string port_name, vcWire* w);
  void Tap_Wire(string dpe_name, string port_name, vcWire* v);

  virtual string Kind() {return("vcDatapath");}
};
#endif // vcDatapath

#ifndef VC_LINK_H_
#define VC_LINK_H_
class vcLink: public vcRoot
{
  map<vcCPTransition*,pair<vcDatapathElement*,string>,vcRoot_Compare> _link_map;

 public:
  vcLink();
  void Add_Link(vcCPTransition* cpe, vcDatapathElement* dpe, string req_or_ack_name);
  pair<vcDatapathElement*, string>& Get_Link(vcCPTransition* cpe);

  virtual string Kind() {return("vcLink");}

};
#endif // vcLink

#ifndef VC_MODULE_H
#define VC_MODULE_H

class vcModule
{
  set<vcMemorySpace*, vcRoot_Compare> _memory_space_set;

  map<string, vcType*> _input_arguments;
  map<string, vcType*> _output_arguments;

  vcControlPath* _control_path;
  vcDataPath*    _data_path;

  bool _inline;

 public:
  vcModule(string module_name);
  ~vcModule();

  void Set_Inline(bool v) { this->_inline = v;}
  bool Get_Inline() { return this->_inline;}

  void Add_DPE(string dpe_name, string dpe_template_name);
  void Connect_Wire(string dpe_name, string port_name, string wire_name);

  void Add_Link(string dpe_name, string dpe_req_ack_name, string transition_name);
  virtual string Kind() {return("vcModule");}

  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string ms_name);

  void Set_Control_Path(vcControlPath* cp) { this->_control_path = cp;}
  vcControlPath* Get_Control_Path() { return(this->_control_path);}

  void Set_Data_Path(vcDataPath* cp) { this->_data_path = cp;}
  vcDataPath* Get_Data_Path() { return(this->_data_path);}

  vcType* Get_Argument_Type(string arg_name, string mode /* "in" or "out" */);
  void Add_Argument(string arg_name, string mode, vcType* t);
};

#endif // vcModule

#ifndef _VC_System_H_
#define _VC_System_H_

class vcSystem: public vcRoot
{

  set<vcMemorySpace*, vcRoot_Compare> _memory_space_set;

  vector<vcModule*> _top_modules;
  map<string, vcModule*> _modules;
  map<string, vcDatapathElementLibrary*> _dpe_libraries;

 public:
  vcSystem(string id);
  
  void Add_Module(string m_id, vcModule* module);
  void Add_Library(string m_id, vcModule* module);

  void Set_As_Top_Module(vcModule* module);
  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string ms_name);

  void Elaborate(); // elaborate the system...

  void Print_VHDL(ostream& ofile);
  void Print_VHDL(ofstream& ofile);
};
#endif
