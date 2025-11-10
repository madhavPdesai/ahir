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
class vcPermutation;
class vcBranch;
class vcInport;
class vcOutport;
class vcOperator;
class vcSplitOperator;
class vcRegister;
class vcDatapathElement;
class vcModule;
class vcInterlockBuffer;
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
  bool _no_block_mode;
  bool _port;
  bool _in_flag;
  bool _out_flag;
  bool _signal;
  bool _p2p;
  bool _shift_reg;
  bool _full_rate;
  bool _bypass;
  bool _is_clock_enable;
public:

  
  vcPipe(vcModule* parent, string id, int w, int d, bool lifo_mode, bool noblock_mode):vcRoot(id)
  {
    _parent = parent;
    _width = w;
    _depth = d;
    _pipe_read_count = 0;
    _pipe_write_count = 0;
    _lifo_mode = lifo_mode;
    _no_block_mode = noblock_mode;
    _port = false;
    _in_flag = false;
    _out_flag = false;
    _signal = false;
    _p2p = false;
    _shift_reg = false;
    _full_rate = false;
    _is_clock_enable = false;
  }

  void Set_Port(bool v) { _port = v; }
  bool Get_Port() {return(_port);}

  void Set_P2P(bool v) { _p2p = v; }
  bool Get_P2P() {return(_p2p);}

  void Set_Full_Rate(bool v) { _full_rate = v; }
  bool Get_Full_Rate() {return(_full_rate);}

  void Set_Bypass(bool v) { _bypass = v; }
  bool Get_Bypass() {return(_bypass);}

  void Set_Is_Clock_Enable(bool v) { _is_clock_enable = v; }
  bool Get_Is_Clock_Enable() {return(_is_clock_enable);}

  void Set_Shift_Reg(bool v) { _shift_reg = v; }
  bool Get_Shift_Reg() {return(_shift_reg);}

  void Set_In_Flag(bool v) { _in_flag = v; }
  bool Get_In_Flag() {return(_in_flag);}

  void Set_Out_Flag(bool v) { _out_flag = v; }
  bool Get_Out_Flag() {return(_out_flag);}

  void Set_Signal(bool v) { _signal = v; }
  bool Get_Signal() {return(_signal);}

  vcModule* Get_Parent() {return(_parent);}
  int Get_Width() { return(this->_width);}
  int Get_Depth() { return(this->_depth);}
  bool Get_Lifo_Mode() {return(_lifo_mode);}
  bool Get_No_Block_Mode() {return(_no_block_mode);}

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
    else if(_no_block_mode)
    	ofile << vcLexerKeywords[__NOBLOCK]  << " ";

    if(_shift_reg)
	    ofile << vcLexerKeywords[__SHIFTREG]  << " ";

    ofile << vcLexerKeywords[__PIPE] 
	  << " [" << this->Get_Id() << "] " 
	  << this->Get_Width() << " " <<
      vcLexerKeywords[__DEPTH] << " " << this->Get_Depth() << " ";

    if(_port)
    	ofile << vcLexerKeywords[__PORT]  << " ";

    if(_in_flag)
    	ofile << vcLexerKeywords[__IN]  << " ";
    else if(_out_flag)
    	ofile << vcLexerKeywords[__OUT]  << " ";

    if(_signal)
	    ofile << vcLexerKeywords[__SIGNAL]  << " ";

    if(_p2p)
	    ofile << vcLexerKeywords[__P2P]  << " ";
    if(_full_rate)
	    ofile << vcLexerKeywords[__FULLRATE]  << " ";

    if(_bypass)
	    ofile << vcLexerKeywords[__BYPASS]  << " ";

    ofile << endl;
  }


  void Register_Pipe_Read(vcModule* m, int idx);
  void Register_Pipe_Write(vcModule* m, int idx);


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
  int _deterministic_level;

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
  virtual string Get_VHDL_Level_Rptr_In_Id() { return(this->Get_VHDL_Signal_Id() + "_in");}
  virtual string Get_VHDL_Deterministic_Delayed_Id(int slack) 
  {
	  if(slack == 0)
		  return(this->Get_VHDL_Signal_Id());
	  else
		  return(this->Get_VHDL_Signal_Id() + "_deterministic_delayed_" + IntToStr(slack));
  }

  void Set_Deterministic_Level(int v) {_deterministic_level = v;}
  int  Get_Deterministic_Level() {return(_deterministic_level);}

  int Get_Size();
  virtual bool Is_Constant() {return(false);}
  int Get_Number_Of_Receivers() {return(this->_receivers.size());}
  int Get_Number_Of_Drivers() {return((this->_driver != NULL) ? 1 : 0);}

  void Print_VHDL_Level_Repeater(string stall_sig, ostream& ofile);
  void Print_VHDL_Level_For_Wire(set<vcDatapathElement*>& printed_dpe_set, 
					map<vcWire*, set<int> >& wire_slack_map,
					vcWire* w, string stall_sig, ostream& ofile);

  void Print_Dot_Entry(ostream& ofile);
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
  virtual bool Is_Constant() {return(true);}
};

class vcInputWire: public vcWire
{
public:
  vcInputWire(string id, vcType* t);
  virtual void Connect_Driver(vcRoot* d) {assert(0);}

  virtual string Kind() {return("vcInputWire");}
  virtual string Get_VHDL_Signal_Id() { return(this->Get_VHDL_Id() + "_buffer");}
};


class vcOutputWire: public vcWire
{
  vcValue* _value;
public:
  vcOutputWire(string id, vcType* t);
  virtual string Kind() {return("vcOutputWire");}
  virtual string Get_VHDL_Signal_Id() { return(this->Get_VHDL_Id() + "_buffer");}
  virtual bool Is_Constant() {return(_value != NULL);}

  void Set_Value(vcValue* v) {_value = v;}
  vcValue* Get_Value() {return(_value);}
};


class vcTransition;
class vcCompatibilityLabel;
class vcControlPath;
class vcDataPipeline;
class vcDataPath;
class vcModule;
class vcDatapathElement: public vcRoot
{
protected:
  vector<vcTransition*> _reqs;
  vector<vcTransition*> _acks;

  vcWire* _guard_wire;
  bool    _guard_complement;
  bool    _guard_war_flag;
  int     _guard_slack;

  map<vcWire*, int> _input_wire_buffering_map;
  map<vcWire*, int> _output_wire_buffering_map;

  int  _delay;
  bool _flow_through;
  bool _full_rate;

  vector<vcWire*>  _input_wires;
  vector<vcWire*>  _output_wires;
  vector<bool>     _input_war_flags;
  vector<int>	   _input_slacks;

  int _in_width;
  int _out_width;

  vcDataPipeline* _data_pipeline;
 public:

  vector<vcWire*>& Get_Input_Wires() { return _input_wires; }
  vector<vcWire*>& Get_Output_Wires() { return _output_wires; }

  vcDatapathElement(string id):vcRoot(id) 
	{
		_guard_wire = NULL; 
		_guard_complement = false; 
		_guard_war_flag = false;
		_flow_through = false;
		_full_rate = false;
		_delay = 1;
		_in_width = 0;
		_out_width = 0;
		_data_pipeline = NULL;
	}

  vcDatapathElement(string id, vector<vcWire*>& iwires, vector<vcWire*>& owires):vcRoot(id) 
  	{
		_guard_wire = NULL; 
		_guard_complement = false; 
		_flow_through = false;
		_full_rate = false;
		_delay = 1;
		_in_width = 0;
		_out_width = 0;
		_data_pipeline = NULL;
		this->Set_Input_Wires(iwires);
		this->Set_Output_Wires(owires);
	}


  void Set_Input_Wires(vector<vcWire*>& iwires)
  {
	  for(int idx = 0; idx < iwires.size(); idx++)
	  {
		  vcWire* w = iwires[idx];
		  _input_wires.push_back(w);
		  _in_width += w->Get_Size();
      		  w->Connect_Receiver(this);
	  }
  }
  void Get_Input_Wire_Indices(vcWire* w, vector<int>& indices)
  {
	  for(int idx = 0; idx < _input_wires.size(); idx++)
	  {
		  vcWire* u = _input_wires[idx];
		  if(w == u)
			  indices.push_back(idx);
	  }
  }

  void Set_Output_Wires(vector<vcWire*>& owires)
  {

	  for(int idx = 0; idx < owires.size(); idx++)
	  {
		  vcWire* w = owires[idx];
		  _output_wires.push_back(w);
		  _out_width += w->Get_Size();
      		  w->Connect_Driver(this);
	  }
  }
  void Get_Output_Wire_Indices(vcWire* w, vector<int>& indices)
  {
	  for(int idx = 0; idx < _output_wires.size(); idx++)
	  {
		  vcWire* u = _output_wires[idx];
		  if(w == u)
			  indices.push_back(idx);
	  }
  }

  virtual int Estimate_Buffering_Bits();

  void Set_Input_WAR_Flags(vector<bool>& war_flags)
  {
	//assert(war_flags.size() == _input_wires.size());	
	for(int idx = 0; idx < war_flags.size(); idx++)
		_input_war_flags.push_back(war_flags[idx]);
	
  }
  bool Get_Input_WAR_Flag(int idx)
  {
	assert((idx >= 0) && (idx < _input_war_flags.size()));
	return(_input_war_flags[idx]);
  }

  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile) {assert(0);}

  void Clear_Input_Slacks() {_input_slacks.clear();}
  void Push_Back_Input_Slack(int slack) {_input_slacks.push_back(slack);}
  int  Get_Input_Slack(int idx) 
  { 
	  if((idx >= 0) && (idx < _input_slacks.size())) 
		  return(_input_slacks[idx]);
	  else
		  return(0);
  }

  void Set_Guard_Slack(int slack) {_guard_slack = slack;}
  int  Get_Guard_Slack() {return(_guard_slack);}


  void Set_Guard_WAR_Flag(bool v) {_guard_war_flag = v;}
  bool Get_Guard_WAR_Flag() {return _guard_war_flag;}

  vcDataPipeline* Get_Data_Pipeline () {return (_data_pipeline);}
  void Set_Data_Pipeline (vcDataPipeline* p) {_data_pipeline = p;}

  int Get_Input_Width() {return(_in_width);}
  int Get_Output_Width() { return(_out_width);}

  void Set_Delay(int d) {_delay = d;}
  virtual int Get_Delay() {return(_delay);}
  virtual int Get_Deterministic_Pipeline_Delay()
  {
	return(this->_flow_through ? 0 : 1);
  } 

  virtual void Print_Delay(ostream& ofile)
  {
	  if(_delay > 1)
		  ofile << vcLexerKeywords[__DELAY] << " " << this->Get_Id() <<  " " << _delay << endl;
  }
  virtual void Add_Reqs(vector<vcTransition*>& reqs) 
  {
	  _reqs  = reqs;
  }
  virtual void Add_Acks(vector<vcTransition*>& acks) 
  {
	  _acks = acks;
  }

  void Set_Flow_Through(bool v) {_flow_through = v;}
  bool Get_Flow_Through() {return(_flow_through);}

  virtual void Set_Full_Rate(bool v) {_full_rate = v;}
  bool Get_Full_Rate() {return(_full_rate);}

  int Get_Number_Of_Reqs() {return(this->_reqs.size());}
  int Get_Number_Of_Acks() {return(this->_acks.size());}

  vcTransition* Get_Req(int idx) {if(idx >= 0 && idx<_reqs.size()) return(this->_reqs[idx]); else return(NULL);}
  vcTransition* Get_Ack(int idx) {if(idx >= 0 && idx<_acks.size()) return(this->_acks[idx]); else return(NULL);}

  virtual int Get_Number_Of_Input_Wires() {return(_input_wires.size());}
  virtual int Get_Number_Of_Output_Wires() {return(_output_wires.size());}

  virtual vcWire* Get_Input_Wire(int idx)
  {
	  if((idx >= 0) && (idx < _input_wires.size()))
		  return(_input_wires[idx]);
	  else
		  return(NULL);
  }
  virtual vcWire* Get_Output_Wire(int idx)
  {
	  if((idx >= 0) && (idx < _output_wires.size()))
		  return(_output_wires[idx]);
	  else
		  return(NULL);
  }



  virtual bool Is_Pipelined_Operator() {return(false);}
  virtual bool Is_Float_To_Float_Operator() {return(false);}

  bool Is_Part_Of_Pipelined_Loop(int& depth, int& buffering);

  virtual bool Is_Part_Of_Pipeline()
  {
	int B,D; 
        bool ret_val = this->Is_Part_Of_Pipelined_Loop(D,B);
	return(ret_val);
  }
  int Get_Buffering();

  virtual bool Is_Part_Of_Full_Rate_Pipeline ();

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


  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    for(int idx = 0; idx < _input_wires.size(); idx++)
      inwires.push_back(_input_wires[idx]);
  }
 
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    for(int idx = 0; idx < _output_wires.size(); idx++)
      outwires.push_back(_output_wires[idx]);
  }

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering) {}
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering, int num_reqs) {}

  // if this operator refers to something inside the
  // datapath, then it is local to the datapath.
  // but if it is a load/store/call/io operator,
  // then it is not.
  virtual bool Is_Local_To_Datapath()
  {
    return(true);
  }

  virtual void Set_Guard_Wire(vcWire* gw) 
	{ 
		_guard_wire = gw;
		if(gw != NULL)
			gw->Connect_Receiver(this);
	}
  virtual vcWire* Get_Guard_Wire() { return(_guard_wire);}

  virtual bool Set_Guard_Complement(bool gw) { _guard_complement = gw; return true;}
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

  virtual void Print_Flow_Through(ostream& ofile) 
  {
	if(this->Get_Flow_Through())
		ofile << " $flowthrough ";
  }

  void Set_Input_Buffering(vcWire* w, int buffering)
  {
	_input_wire_buffering_map[w] = buffering;
  }
 
  int Get_Input_Buffering(vcWire* w)
  {
 	if(_input_wire_buffering_map.find(w) != _input_wire_buffering_map.end())
		return(_input_wire_buffering_map[w]);
	else
		return(0);
  }

  void Set_Output_Buffering(vcWire* w, int buffering)
  {
	_output_wire_buffering_map[w] = buffering;
  }
 
  int Get_Output_Buffering(vcWire* w);
  int Get_Output_Buffering(vcWire* w, int num_reqs);


  void Generate_Input_Log_Strings(string& log_string);
  void Generate_Output_Log_Strings(string& log_string);
  void Generate_Flowthrough_Logger_Sensitivity_List(string& log_string);

  virtual void Print_VHDL_Logger(vcModule* parent_module, ostream& ofile);
  virtual bool Is_Floating_Point_Dpe() {return(false);}

  virtual bool Is_Deterministic_Pipeline_Operator() {return(false);}
				
  virtual void Print_Deterministic_Pipeline_Operator_VHDL(string stall_sig, ostream& ofile) {assert(0);}

  virtual void Print_Dot_Entry(ostream& ofile);
		
  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors);	

  virtual bool Is_Split_Operator() {return(false);}
  friend class vcDataPath;

};


class vcModule;
class vcControlPath;
class vcMemorySpace;
class vcEquivalence;
class vcDataPipeline: public vcDatapathElement 
{
	string pipeline_name;
	set<vcDatapathElement*> dpe_set;
	public:
	vcDataPipeline (string pname): vcDatapathElement(pname) {}
	void Add_Dpe(vcDatapathElement* dpe) { dpe_set.insert(dpe); }

	friend class vcDataPath;
};

class vcDataPath: public vcRoot
{
  vcModule* _parent;

  // lots of maps.
  map<string, vcDatapathElement*> _dpe_map; // all dpes are recorded here (except for pipelines).

  // lots of maps.
  map<string, vcDataPipeline*> _dpipeline_map; // all dpipelines are recorded here

  // separated maps for convenience
  map<string, vcPhi*> _phi_map;
  map<string, vcWire*> _wire_map;
  map<string, vcSelect*> _select_map;
  map<string, vcSlice*> _slice_map;
  map<string, vcPermutation*> _permutation_map;
  map<string, vcBranch*> _branch_map;
  map<string, vcRegister*> _register_map;
  map<string, vcEquivalence*> _equivalence_map;
  map<string, vcInterlockBuffer*> _interlock_buffer_map;

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

  int _estimated_buffering_bits;
 public:
  vcDataPath(vcModule* m, string id);

  map<string, vcDatapathElement*>& Get_DPE_Map() { return _dpe_map; }

  vcDataPipeline* Find_Or_Add_DataPipeline(string dpipeline);
  void Add_To_DataPipeline(string pname, string dpe_name);
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

  void Add_Permutation(vcPermutation* p);
  vcPermutation* Find_Permutation(string id);

  void Add_Branch(vcBranch* p);
  vcBranch* Find_Branch(string id);

  void Add_Register(vcRegister* p);
  vcRegister* Find_Register(string id);

  void Add_Interlock_Buffer(vcInterlockBuffer* p);
  vcInterlockBuffer* Find_Interlock_Buffer(string id);

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


  void Get_Label_Interval(vcControlPath* cp, vcDatapathElement* dpe, vector<vcCompatibilityLabel*>& ret_vector);

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
  void Print_VHDL_Level(string stall_sig, ostream& ofile);
  void Print_VHDL_Level_For_Wire(set<vcDatapathElement*>& printed_dpe_set, 
					map<vcWire*,set<int> >& wire_slack_map,
					vcWire* w, string stall_sig, ostream& ofile);

  void Print_VHDL_Phi_Instances(ostream& ofile);
  void Print_VHDL_Select_Instances(ostream& ofile);
  void Print_VHDL_Slice_Instances(ostream& ofile);
  void Print_VHDL_Permutation_Instances(ostream& ofile);
  void Print_VHDL_Register_Instances(ostream& ofile);
  void Print_VHDL_Interlock_Buffer_Instances(ostream& ofile);
  void Print_VHDL_Binary_Logical_Operator_Instances(ostream& ofile);
  void Print_VHDL_Equivalence_Instances(ostream& ofile);
  void Print_VHDL_Branch_Instances(ostream& ofile);
  void Print_VHDL_Split_Operator_Instances(ostream& ofile);
  void Print_VHDL_Load_Instances(ostream& ofile);
  void Print_VHDL_Store_Instances(ostream& ofile);
  void Print_VHDL_Inport_Instances(ostream& ofile);
  void Print_VHDL_Outport_Instances(ostream& ofile);
  void Print_VHDL_Call_Instances(ostream& ofile);



  void Generate_Buffering_Constant_Declaration(vector<vcDatapathElement*>& dpe_elements, string& buf_string);
  int Generate_Buffering_String(string const_name, vector<int>& buf_sizes, string& buf_string);
  int Generate_Pipeline_Slot_Demands(vector<vcDatapathElement*>& dpe_elements,
				vector<int>& slot_demands);


  void Print_VHDL_Regulator_Instance(string inst_id, 
			int num_reqs, 
			string reqs, string acks,
			string regulated_reqs, string regulated_acks, 
			string release_reqs, string release_acks,
			vector<vcDatapathElement*>& dpe_els,
			 ostream& ofile);
   

  string Get_VHDL_IOport_Interface_Port_Name(string pipe_id, string pid);
  string Get_VHDL_IOport_Interface_Port_Section(vcPipe* p,
						string in_or_out,
						string pid,
						int idx);

   int Get_Driving_Dpe_Buffering(vcWire* w);
   bool Is_Legal_In_Level_Module(vcDatapathElement* dpe);
   void Build_Data_Pipelines ();
   int Calculate_Longest_Paths_From_Inputs();
   void Calculate_Wire_Slacks(std::map<vcWire*, std::set<int> >& wire_slack_map);
   int Estimate_Buffering_Bits();

   void Rationalize_Outwire_Buffering(vector<int>& obuf, bool is_part_of_pipeline);
	
   void Print_Data_Path_As_Dot_File(ostream& dp_file);
};

void Generate_Guard_Constants(string& buffering_const, string& guard_flag_const,
		vector<vcDatapathElement*>& ops, vector<vcWire*>& guard_wires);
void Print_VHDL_Concatenation(string target, vector<vcWire*> wires, ostream& ofile);
void Print_VHDL_Disconcatenation(string source, int total_width, vector<vcWire*> wires, ostream& ofile);

void Print_VHDL_Concatenate_Req(string req_id, vector<vcTransition*>& reqs,  ostream& ofile);
void Print_VHDL_Disconcatenate_Ack(string ack_id, vector<vcTransition*>& acks,  ostream& ofile);

void Print_VHDL_Guard_Concatenation(int num_reqs, string guard_vector, vector<vcWire*>& guard_wires, vector<bool>& guard_complements,ostream& ofile);
void Print_VHDL_Guard_Instance(string inst_id, int num_reqs,string guards, string req_unguarded, string ack_unguarded, 
		string req, string ack, bool delay_flag, ostream& ofile);

void Print_VHDL_Guard_Instance(bool sample_only, bool update_only,
		string inst_id, int num_reqs, string buffering, string guard_flags, string guards, 
		string sr_in, string sa_out,  string sr_out, string sa_in,
		string cr_in, string ca_out,  string cr_out, string ca_in, ostream& ofile);
#endif // vcDataPath
