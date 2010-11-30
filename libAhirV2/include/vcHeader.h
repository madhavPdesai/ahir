#ifndef _VC_ROOT_H_
#define _VC_ROOT_H_

class vcRoot
{
  string _id;
  map<string,string> _atttribute_map;

 public:
  vcRoot(string id);
  ~vcRoot();

  void Add_Attribute(string tag, string value);

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
  <vcRoot&, vcRoot&, bool >
{
  bool operator() (vcRoot&, vcRoot&) const;
};

#endif // vcRoot

#ifndef _VC_TYPE_H
#define _VC_TYPE_H


class vcType: public AaRoot
{

 public:
  vcType(string id);
  ~vcType();

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
  ~vcScalarType();
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
  ~vcUintType();

  void Print(ostream& ofile);
  virtual string Kind() {return("vcIntType");}
  virtual int Size() { return(this->_width);}
};

class vcPointerType: public vcScalarType
{
  string _memory_space_name;
  vcRoot* _memory_space;

 public :
  vcPointerType(string id, string mem_space_id);
  ~vcPointerType();

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
  unsigned int _characteristic;
  unsigned int _mantissa;

 public:
  unsigned int Get_Characteristic() {return(this->_characteristic);}
  unsigned int Get_Mantissa() {return(this->_mantissa);}

  vcFloatType(string id, unsigned int characteristic, unsigned int mantissa);
  ~vcFloatType();
  void Print(ostream& ofile);

  virtual string Kind() {return("vcFloatType");}
  virtual int Size() { return(this->_characteristic + this->_mantissa + 1);}
};

class vcArrayType: public vcType
{
  // only single dimensional arrays.
  int _dimension;
  
  // element type is a scalar
  vcScalarType* _element_type;
 
 public:

  vcScalarType* Get_Element_Type() {return(this->_element_type);}
  vcArrayType(string id, AaScalarType* stype, int dimension);
  ~vcArrayType();

  void Print(ostream& ofile);
  virtual string Kind() {return("vcArrayType");}

  virtual int Size() { return(this->_dimension * this->_element_type->Size());}
};

class vcRecordType: public vcType
{
  vector<vcType> _element_types;
 public:
  vcRecordType(string id, vector<vcType>& element_types);
  ~vcRecordType();

  void Print(ostream& ofile);
  virtual string Kind() { return("vcRecordType"); }
  virtual int Size() 
  { 
    int ret_val = 0;
    for(int i = 0; i < this->_element_types.size(); i++)
      ret_val += this->_element_types[i].Size();
    return(ret_val);
  }
};

#endif // vcType


#ifndef _vc_Value__
#define _vc_Value__



class vcValue: public AaRoot
{
  vcType* _type;
 public:
  vcValue(vcType t);
  ~vcValue();

  vcType* Get_Type() { return(this->_type);}
  virtual string Kind() {return("vcValue");}
};

class vcIntValue: public vcValue
{
  // value is a binary string of characters
  // each of which can be 0 or 1.
  vector<char> _value;
 public:
  int Get_Value() { return(this->_value);}
  vcIntValue(vcIntType t, string value);

  ~vcIntValue();

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

class vcFloatValue: public vcValue
{
  vcIntValue _sign;
  vcIntValue _characteristic;
  vcIntValue _mantissa;

 public:
  int Get_Value() { return(this->_value);}

  vcFloatValue(vcFloatType t, string value);
  ~vcFloatValue();

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

class vcArrayValue: public vcValue
{
  vector<vcValue> _value_array;
 public:
  vcArrayValue(vcArrayType t, vector<vcValue>& values);
  ~vcArrayValue();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcArrayValue");}

  vcValue Slice(int lindex, int rindex);
  vcValue operator[](int index);

  // assignment operator
  vcArrayValue& operator=(const vcArrayValue& v);

  // concatenate
  friend vcArrayValue operator&&(vcFloatValue, vcFloatValue);
};

vcArrayValue operator&&(vcFloatValue, vcFloatValue);

class vcRecordValue: public vcValue
{
  vector<string>  _element_names;
  vector<vcValue> _element_values;
 public:
  vcRecordValue(vcArrayType t, vector<vcValue>& element_names, vector<vcValue>& values);
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
  vcType  _type;
  vcValue _value;
  vcIntValue _base_address;
 public:
  vcStorageObject(string id, vcType t);
  ~vcStorageObject();

  void Set_Value(const vcValue& v);
  vcValue& Get_Value();

  void Set_Base_Address(vcIntValue v);
  vcIntValue& Get_Base_Address();

  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcStorageObject");}
};

#endif // vcStorageObject

#ifndef _VC_MEMORY_SPACE_H__
#define _VC_MEMORY_SPACE_H__

class vcMemorySpace
{
  vector<vcStorageObject> objects;
 public:
  vcMemorySpace(string id);
  ~vcMemorySpace();

  void Add_Storage_Object(vcStorageObject& obj);
  void Get_Number_Of_Storage_Objects();
  vcStorageObject& Get_Storage_Object(int index);

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
  set<vcCPElement*> _predecessors;
  set<vcCPElement*> _successors;
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
  ~vcTransition();

  virtual string Kind() {return("vcTransition");}

};

class vcPlace: public vcCPElement
{
  unsigned int _initial_marking;
 public:
  vcPlace(string id, unsigned int init_marking);
  ~vcPlace();

  virtual string Kind() {return("vcPlace");}
};


class vcControlPath: public vcRoot
{
  map<string, vcCPElement*> _cp_element_map;
 public:
  vcControlPath(string id);
  ~vcControlPath();
  
  void Add_Transition(string transition_name, vcTransitionType t);
  void Add_Place(string place_name, unsigned int init_marking);
  void Add_Dependency(vcCPElement* from, vcCPElement* to);

  vcTransition* Find_Transition(string tname);
  vcPlace* Find_Place(string pname);
  vcCPElement* Find_CPElement(string cname);

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
  ~vcWire();
 
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
  
  map<string, vcScalarTypeTemplate> _input_port_map;
  map<string, vcScalarTypeTemplate> _output_port_map;

 public:

  vcDatapathElementTemplate(string id);
  void Add_Parameter(string param_val, int min_val, int max_val);
  void Add_Req(string req_name);
  void Add_Ack(string ack_name);
  
  void Add_Input_Port(string pname, vcScalarTypeTemplate& t);
  void Add_Output_Port(string pname, vcScalarTypeTemplate& t);

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
  map<string, vcDatapathElementTemplate&> _template_map;
 public:
  vcDatapathElementLibrary(string id);
  void Add_Template(string template_name, vcDatapathElementTemplate& t);
  vcDatapathElementTemplate& Get_Template(string template_name);
};

class vcDatapathElement: public vcRoot
{
  string _template_name;

  map<string, int> _parameter_value_map;
  map<vcDPTemplatePort*,vcWire*> _port_map;
  map<string, vcTransition*> _control_link_map;

 public:

  vcDatapathElement(string id, string template_name);
  ~vcDatapathElement();

  bool Is_Parameter(string id);

  void Set_Parameter(string id, int val);
  int  Get_Parameter(string id);

  void Connect_Wire(string port_name, vcWire* w);
  vcWire* Get_Connected_Wire(string port_name);

  void Add_Link(string req_ack_name, vcTransition* t);
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

  void Drive_Wire(string dpe_name, string port_name, vcWire* w);
  void Tap_Wire(string dpe_name, string port_name, vcWire* v);

  virtual string Kind() {return("vcDatapath");}
};
#endif // vcDatapath

#ifndef VC_LINK_H_
#define VC_LINK_H_
class vcLink: public vcRoot
{
  map<vcCPElement&,pair<vcDatapathElement&,string>,vcRoot_Compare> _link_map;

 public:
  vcLink();
  void Add_Link(vcCPElement& cpe, vcDatapathElement& dpe, string& req_or_ack_name);
  pair<vcDatapathElement&, string>& Get_Link(vcCPElement& cpe);

  virtual string Kind() {return("vcLink");}

};
#endif // vcLink

#ifndef VC_MODULE_H
#define VC_MODULE_H

class vcModule
{
  set<vcMemorySpace&, vcRoot_Compare> _memory_space_set;
  vcControlPath* _control_path;
  vcDataPath*    _data_path;

 public:
  vcModule(string module_name);
  ~vcModule();

  void Add_Transition(string tname, vcTransitionType t);
  void Add_Place(string place, unsigned int init_marking);
  void Add_Dependency(string cpe_name_1, string cpe_name_2);

  void Add_DPE(string dpe_name, string dpe_template_name);
  void Connect_Wire(string dpe_name, string port_name, string wire_name);

  void Add_Link(string dpe_name, string dpe_req_ack_name, string transition_name);
  virtual string Kind() {return("vcModule");}

};

#endif // vcModule

#ifndef _VC_PROGRAM_H_
#define _VC_PROGRAM_H_

class vcProgram
{
  
};
#endif
