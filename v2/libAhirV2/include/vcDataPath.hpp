#ifndef _VC_DATAPATH_H_
#define _VC_DATAPATH_H_
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType;
class vcValue;
class vcScalarTypeTemplate;
class vcPhi;
class vcCall;
class vcLoad;
class vcStore;
class vcSelect;
class vcSlice;
class vcBranch;
class vcInport;
class vcOutport;
class vcOperator;
class vcSplitOperator;
class vcRegister;
class vcDatapathElement;
class vcModule;
class vcPipe: public vcRoot
{

  vcModule* _parent;
  int _width;
  int _depth;
  
  // inports on modules connected to pipe.  
  map<vcModule*, vector<int> > _pipe_read_map;
  int _pipe_read_count;

  // inports on modules connected to pipe.  
  map<vcModule*, vector<int> > _pipe_write_map;
  int _pipe_write_count;
  bool _lifo_mode;
public:
  
  vcPipe(vcModule* parent, string id, int w, int d, bool lifo_mode):vcRoot(id)
  {
    _parent = parent;
    _width = w;
    _depth = d;
    _pipe_read_count = 0;
    _pipe_write_count = 0;
    _lifo_mode = lifo_mode;
  }

  vcModule* Get_Parent() {return(_parent);}
  int Get_Width() { return(this->_width);}
  int Get_Depth() { return(this->_depth);}
  bool Get_Lifo_Mode() {return(_lifo_mode);}

  map<vcModule*,vector<int> >& Get_Pipe_Read_Map()
  {
    return(_pipe_read_map);

  }
  int Get_Pipe_Read_Count() { return(this->_pipe_read_count); }

  map<vcModule*,vector<int> >& Get_Pipe_Write_Map()
  {
    return(_pipe_write_map);

  }
  int Get_Pipe_Write_Count() { return(this->_pipe_write_count); }

  virtual string Kind() {return("vcPipe");}
  virtual void Print(ostream& ofile)
  {
    if(_lifo_mode)
    	ofile << vcLexerKeywords[__LIFO]  << " ";

    ofile << vcLexerKeywords[__PIPE] 
	  << " [" << this->Get_Id() << "] " 
	  << this->Get_Width() << " " <<
      vcLexerKeywords[__DEPTH] << " " << this->Get_Depth() << endl;
  }


  void Register_Pipe_Read(vcModule* m, int idx)
  {
    _pipe_read_map[m].push_back(idx);
    _pipe_read_count++;
  }

  void Register_Pipe_Write(vcModule* m, int idx)
  {
    _pipe_write_map[m].push_back(idx);
    _pipe_write_count++;
  }

  void Deregister_Pipe_Accesses(vcModule* m)
  {
    if(_pipe_read_map.find(m)!= _pipe_read_map.end())
      {
	_pipe_read_count -= _pipe_read_map[m].size();
	_pipe_read_map.erase(m);
      }

    if(_pipe_write_map.find(m)!= _pipe_write_map.end())
      {
	_pipe_write_count -= _pipe_write_map[m].size();
	_pipe_write_map.erase(m);
      }
  }

  string Get_VHDL_Pipe_Interface_Port_Name(string pid)
  {
    return(this->Get_Id() + "_pipe_" + pid);
  }
  void Print_VHDL_Pipe_Port_Signals(ostream& ofile);
  void Print_VHDL_Pipe_Signals(ostream& ofile);
  void Print_VHDL_Instance(ostream& ofile);
  bool Get_Pipe_Module_Section(vcModule* caller_module, 
			       string read_or_write, 
			       int& hindex, 
			       int& lindex);
  string Get_Pipe_Aggregate_Section(string pid, 
				    int hindex, 
				    int lindex);
};

class vcWire: public vcRoot
{
protected:
  vcType* _type;
  vcDatapathElement* _driver;
  set<vcDatapathElement*> _receivers;

public:

  vcWire(string id, vcType* t);
  virtual void Print(ostream& ofile);

  virtual void Connect_Driver(vcDatapathElement* d) {this->_driver = d;}
  virtual void Connect_Receiver(vcDatapathElement* r) {this->_receivers.insert(r);}

  vcType* Get_Type() {return(this->_type);}
  vcDatapathElement* Get_Driver() {return(this->_driver);}
  const set<vcDatapathElement*>&  Get_Receivers() {return this->_receivers;}

  virtual string Kind() {return("vcWire");}
  virtual void Print_VHDL_Std_Logic_Declaration(ostream& ofile);

  virtual string Get_VHDL_Signal_Id() { return(this->Get_VHDL_Id());}

  int Get_Size();
};

class vcIntermediateWire: public vcWire
{
public:
  vcIntermediateWire(string id, vcType* t) : vcWire(id,t) {}
  virtual void Print(ostream& ofile)
  {
    ofile << vcLexerKeywords[__INTERMEDIATE] << " ";
    this->vcWire::Print(ofile);
  }

  virtual string Kind() {return("vcIntermediateWire");}
};

class vcConstantWire: public vcWire
{
  vcValue* _value;
public:
  vcConstantWire(string id, vcValue* v);
  virtual void Print(ostream& ofile);
  vcValue* Get_Value() {return(this->_value);}
  virtual void Connect_Driver(vcDatapathElement* d) {assert(0);}

  void Print_VHDL_Constant_Declaration(ostream& ofile);
  virtual string Kind() {return("vcConstantWire");}
};

class vcInputWire: public vcWire
{
public:
  vcInputWire(string id, vcType* t);
  virtual void Connect_Driver(vcRoot* d) {assert(0);}

  virtual string Kind() {return("vcInputWire");}
};


class vcOutputWire: public vcWire
{
public:
  vcOutputWire(string id, vcType* t);
  virtual string Kind() {return("vcOutputWire");}
  virtual string Get_VHDL_Signal_Id() { return(this->Get_VHDL_Id() + "_buffer");}
};


class vcTransition;
class vcCompatibilityLabel;
class vcControlPath;
class vcDataPath;
class vcDatapathElement: public vcRoot
{
protected:
  vector<vcTransition*> _reqs;
  vector<vcTransition*> _acks;

  vcWire* _guard_wire;
  bool    _guard_complement;
 public:
  vcDatapathElement(string id):vcRoot(id) {_guard_wire = NULL; _guard_complement = false;}

  virtual void Add_Reqs(vector<vcTransition*>& reqs) {assert(0);}
  virtual void Add_Acks(vector<vcTransition*>& acks) {assert(0);}

  int Get_Number_Of_Reqs() {return(this->_reqs.size());}
  int Get_Number_Of_Acks() {return(this->_acks.size());}

  vcTransition* Get_Req(int idx) {if(idx >= 0 && idx<_reqs.size()) return(this->_reqs[idx]); else return(NULL);}
  vcTransition* Get_Ack(int idx) {if(idx >= 0 && idx<_acks.size()) return(this->_acks[idx]); else return(NULL);}

  virtual bool Is_Pipelined_Operator() {return(false);}

  bool Is_Part_Of_Pipelined_Loop(int& depth, int& buffering);
  int Get_Buffering();

  int Get_Req_Index(vcTransition* t)
  {
    int ret_index = -1;
    for(int idx = 0; idx < _reqs.size(); idx++)
      {
	if(_reqs[idx] == t)
	  {
	    ret_index = idx;
	    break;
	  }
      }
    return(ret_index);
  }

  int Get_Ack_Index(vcTransition* t)
  {
    int ret_index = -1;
    for(int idx = 0; idx < _acks.size(); idx++)
      {
	if(_acks[idx] == t)
	  {
	    ret_index = idx;
	    break;
	  }
      }
    return(ret_index);
  }

  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}
  virtual string Kind() {return("vcDatapathElement");}
  virtual string Get_Operator_Type() {return(this->Kind());}

  virtual void Append_Inwires(vector<vcWire*>& inwires) {assert(0);}
  virtual void Append_Outwires(vector<vcWire*>& owires) {assert(0);}


  // if this operator refers to something inside the
  // datapath, then it is local to the datapath.
  // but if it is a load/store/call/io operator,
  // then it is not.
  virtual bool Is_Local_To_Datapath()
  {
    return(true);
  }

  virtual void Set_Guard_Wire(vcWire* gw) { _guard_wire = gw;}
  virtual vcWire* Get_Guard_Wire() { return(_guard_wire);}

  virtual bool Set_Guard_Complement(bool gw) { _guard_complement = gw;}
  virtual bool Get_Guard_Complement() { return(_guard_complement);}

  virtual void Append_Guard(vector<vcWire*>& guards, vector<bool>& guard_complements)
  {
	guards.push_back(this->Get_Guard_Wire());
	guard_complements.push_back(this->Get_Guard_Complement());
  }

  virtual void Print_Guard(ostream& ofile) 
  {
	if(this->Get_Guard_Wire() != NULL)
	{
		ofile << vcLexerKeywords[__GUARD] << " "
			<< vcLexerKeywords[__LPAREN] 
			<< (this->Get_Guard_Complement() ? vcLexerKeywords[__NOT_OP] : " ")
			<< this->Get_Guard_Wire()->Get_Id() 
			<< vcLexerKeywords[__RPAREN];
	}
  }

  virtual void Print_VHDL_Logger(ostream& ofile);
  friend class vcDataPath;

};


class vcModule;
class vcControlPath;
class vcMemorySpace;
class vcEquivalence;
class vcDataPath: public vcRoot
{
  vcModule* _parent;

  // lots of maps.
  map<string, vcDatapathElement*> _dpe_map; // all dpes are recorded here

  // separated maps for convenience
  map<string, vcPhi*> _phi_map;
  map<string, vcWire*> _wire_map;
  map<string, vcSelect*> _select_map;
  map<string, vcSlice*> _slice_map;
  map<string, vcBranch*> _branch_map;
  map<string, vcRegister*> _register_map;
  map<string, vcEquivalence*> _equivalence_map;

  // these operators can be shared..
  map<string, vcSplitOperator*> _split_operator_map;
  vector<set<vcDatapathElement*> > _compatible_split_operator_groups;

  map<string, vcLoad*> _load_map;
  vector<set<vcDatapathElement*> > _compatible_load_groups;

  map<string, vcStore*> _store_map;
  vector<set<vcDatapathElement*> > _compatible_store_groups;

  map<string, vcCall*> _call_map;
  vector<set<vcDatapathElement*> > _compatible_call_groups;

  map<string, vcOutport*> _outport_map;
  vector<set<vcDatapathElement*> > _compatible_outport_groups;

  map<string, vcInport*> _inport_map;
  vector<set<vcDatapathElement*> > _compatible_inport_groups;

  map<vcDatapathElement*, pair<vcCompatibilityLabel*, vcCompatibilityLabel*> > _dpe_label_interval_map;

  // pipe-name to vector of groups which use pipe name.
  map<vcPipe*, vector<int> > _inport_group_map;
  map<vcPipe*, vector<int> > _outport_group_map;

 public:
  vcDataPath(vcModule* m, string id);

  void Add_Load(vcLoad* ld);
  vcLoad* Find_Load(string id);

  void Add_Store(vcStore* st);
  vcStore* Find_Store(string id);

  void Add_Call(vcCall* c);
  vcCall* Find_Call(string id);

  void Add_Inport(vcInport* p);
  vcInport* Find_Inport(string id);

  void Add_Outport(vcOutport* p);
  vcOutport* Find_Outport(string id);

  void Add_Split_Operator(vcSplitOperator* p);
  vcSplitOperator* Find_Split_Operator(string id);

  void Add_Select(vcSelect* p);
  vcSelect* Find_Select(string id);

  void Add_Slice(vcSlice* p);
  vcSlice* Find_Slice(string id);

  void Add_Branch(vcBranch* p);
  vcBranch* Find_Branch(string id);

  void Add_Register(vcRegister* p);
  vcRegister* Find_Register(string id);

  void Add_Equivalence(vcEquivalence* p);
  vcEquivalence* Find_Equivalence(string id);

  vcDatapathElement* Find_DPE(string dpe_name);

  void Add_Phi(vcPhi* p);
  vcPhi* Find_Phi(string pname);

  vcWire* Find_Wire(string wname);
  void Add_Wire(string wname, vcType* t);
  void Add_Intermediate_Wire(string wname, vcType* t);

  void Add_Constant_Wire(string wname, vcValue* v);

  void Connect_Wire(string dpe_name, string port_name, vcWire* w);
  
  void Set_Parent(vcModule* m) {this->_parent = m;}
  vcModule* Get_Parent() {return(this->_parent);}

  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcDatapath");}

  pair<vcCompatibilityLabel*,vcCompatibilityLabel*> Get_Label_Interval(vcControlPath* cp, vcDatapathElement* dpe);

  void Compute_Maximal_Groups(vcControlPath* cp);
  void Update_Maximal_Groups(vcControlPath* cp,
			     vcDatapathElement* dpe, 
			     vector<set<vcDatapathElement*> >& dpe_group);
  void Print_Compatible_Operator_Groups(ostream& ofile);
  void Print_Compatible_Operator_Groups(ostream& ofile, vector<set<vcDatapathElement*> >& dpe_groups);

  string Print_VHDL_Memory_Interface_Ports(string semi_colon, ostream& ofile);
  string Print_VHDL_IO_Interface_Ports(string semi_colon, ostream& ofile);
  string Print_VHDL_Call_Interface_Ports(string semi_colon, ostream& ofile);

  string Print_VHDL_Memory_Interface_Port_Map(string comma, ostream& ofile);
  string Print_VHDL_IO_Interface_Port_Map(string comma, ostream& ofile);
  string Print_VHDL_Call_Interface_Port_Map(string comma, ostream& ofile);

  void Print_VHDL(ostream& ofile);

  void Print_VHDL_Phi_Instances(ostream& ofile);
  void Print_VHDL_Select_Instances(ostream& ofile);
  void Print_VHDL_Slice_Instances(ostream& ofile);
  void Print_VHDL_Register_Instances(ostream& ofile);
  void Print_VHDL_Equivalence_Instances(ostream& ofile);
  void Print_VHDL_Branch_Instances(ostream& ofile);
  void Print_VHDL_Split_Operator_Instances(ostream& ofile);
  void Print_VHDL_Load_Instances(ostream& ofile);
  void Print_VHDL_Store_Instances(ostream& ofile);
  void Print_VHDL_Inport_Instances(ostream& ofile);
  void Print_VHDL_Outport_Instances(ostream& ofile);
  void Print_VHDL_Call_Instances(ostream& ofile);

  void Print_VHDL_Concatenation(string target, vector<vcWire*> wires, ostream& ofile);
  void Print_VHDL_Disconcatenation(string source, int total_width, vector<vcWire*> wires, ostream& ofile);

  void Print_VHDL_Concatenate_Req(string req_id, vector<vcTransition*>& reqs,  ostream& ofile);
  void Print_VHDL_Disconcatenate_Ack(string ack_id, vector<vcTransition*>& acks,  ostream& ofile);

  void Print_VHDL_Guard_Concatenation(int num_reqs, string guard_vector, vector<vcWire*>& guard_wires, vector<bool>& guard_complements,ostream& ofile);
  void Print_VHDL_Guard_Instance(string inst_id, int num_reqs,string guards, string req_unguarded, string ack_unguarded, string req, string ack, ostream& ofile);

  void Generate_Buffering_String(vector<vcDatapathElement*>& dpe_elements, string& buf_string);
  void Print_VHDL_Regulator_Instance(string inst_id, 
			int num_reqs, 
			string reqs, string acks,
			string regulated_reqs, string regulated_acks, 
			string release_reqs, string release_acks,
			vector<vcDatapathElement*>& dpe_els,
			 ostream& ofile);
   
  void Generate_Buffering_Constant_Declaration(vector<vcDatapathElement*>& dpe_elements, 
							string& buffering_string);

  string Get_VHDL_IOport_Interface_Port_Name(string pipe_id, string pid);
  string Get_VHDL_IOport_Interface_Port_Section(vcPipe* p,
						string in_or_out,
						string pid,
						int idx);

};
#endif // vcDataPath
