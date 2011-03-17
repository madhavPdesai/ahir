#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcValue.hpp>
#include <vcControlPath.hpp>
#include <vcOperator.hpp>
#include <vcMemorySpace.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>

vcWire::vcWire(string id, vcType* t) :vcRoot(id)
{
  this->_type = t;
}

void vcWire::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__WIRE] << " " << this->Get_Id() << vcLexerKeywords[__COLON] << " " ;
  this->Get_Type()->Print(ofile);
  ofile << endl;
}

void vcWire::Print_VHDL_Std_Logic_Declaration(ostream& ofile)
{
  // wires MUST be scalars!
  assert(this->Get_Type()->Is("vcIntType") || 
	 this->Get_Type()->Is("vcFloatType") ||
	 this->Get_Type()->Is("vcPointerType"));

  ofile << "signal " << this->Get_VHDL_Id() << " : " << this->Get_Type()->Get_VHDL_Type_Name() << ";" << endl;
}

int vcWire::Get_Size() {return(this->_type->Size());}

vcConstantWire::vcConstantWire(string id, vcValue* v): vcWire(id,v->Get_Type())
{
  assert(!(v->Is("vcArrayType") || v->Is("vcRecordType")));
  this->_value = v;
};

void vcConstantWire::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__CONSTANT] << " ";
  ofile << vcLexerKeywords[__WIRE] << " " << this->Get_Id() << vcLexerKeywords[__COLON] << " " ;
  this->Get_Type()->Print(ofile);
  ofile << vcLexerKeywords[__ASSIGNEQUAL] << " ";
  this->_value->Print(ofile);
  ofile << endl;
}

void vcConstantWire::Print_VHDL_Constant_Declaration(ostream& ofile)
{
  ofile << "constant " << this->Get_VHDL_Id() << " : " ;
  ofile << this->Get_Type()->Get_VHDL_Type_Name()  << " := ";
  ofile << this->_value->To_VHDL_String() << ";" << endl;
}

vcInputWire::vcInputWire(string id, vcType* t): vcWire(id,t)
{
}

vcOutputWire::vcOutputWire(string id, vcType* t): vcWire(id,t)
{
}


vcDataPath::vcDataPath(vcModule* m, string id):vcRoot(id)
{
  this->_parent = m;
}

pair<vcCompatibilityLabel*,vcCompatibilityLabel*> vcDataPath::Get_Label_Interval(vcControlPath* cp, vcDatapathElement* dpe)
{
  if(_dpe_label_interval_map.find(dpe) != _dpe_label_interval_map.end())
    return(_dpe_label_interval_map[dpe]);

  pair<vcCompatibilityLabel*,vcCompatibilityLabel*> ret_pair(dpe->_reqs.front()->Get_Compatibility_Label(),
							     dpe->_acks.back()->Get_Compatibility_Label());
  for(int idx = 0; idx < dpe->_reqs.size(); idx++)
    {
      assert((ret_pair.first == dpe->_reqs[idx]->Get_Compatibility_Label()) || 
	     cp->Lesser(ret_pair.first,dpe->_reqs[idx]->Get_Compatibility_Label()));
      assert((ret_pair.second == dpe->_reqs[idx]->Get_Compatibility_Label()) || 
	     cp->Greater(ret_pair.second,dpe->_reqs[idx]->Get_Compatibility_Label()));
    }
  for(int idx = 0; idx < dpe->_acks.size(); idx++)
    {
      assert((ret_pair.first == dpe->_acks[idx]->Get_Compatibility_Label()) || 
	     cp->Lesser(ret_pair.first,dpe->_acks[idx]->Get_Compatibility_Label()));
      assert((ret_pair.second == dpe->_acks[idx]->Get_Compatibility_Label()) || 
	     cp->Greater(ret_pair.second,dpe->_acks[idx]->Get_Compatibility_Label()));
    }

  _dpe_label_interval_map[dpe] = ret_pair;
  return(ret_pair);
}

vcDatapathElement* vcDataPath::Find_DPE(string dpe_name)
{
  map<string, vcDatapathElement*>::iterator iter = this->_dpe_map.find(dpe_name);
  if(iter != this->_dpe_map.end())
    return((*iter).second);
  else
    return(NULL);
}

vcWire* vcDataPath::Find_Wire(string wname)
{
  vcWire* ret_wire = NULL;
  map<string, vcWire*>::iterator iter = this->_wire_map.find(wname);
  if(iter != this->_wire_map.end())
    ret_wire = ((*iter).second);
  else
    {
      if(this->Get_Parent() != NULL)
	{
	  ret_wire = this->Get_Parent()->Get_Argument(wname,"in");
	  if(ret_wire == NULL)
	    ret_wire = this->Get_Parent()->Get_Argument(wname,"out");
	}
    }

  if(ret_wire == NULL)
    {
      // perhaps it is a constant defined at the Program scope
      ret_wire = (vcWire*) this->Get_Parent()->Get_Parent()->Find_Constant_Wire(wname);
    }

  return(ret_wire);
}

void vcDataPath::Add_Wire(string wname, vcType* t)
{
  assert(this->Find_Wire(wname) == NULL);
  this->_wire_map[wname] = new vcWire(wname, t);
}

void vcDataPath::Add_Intermediate_Wire(string wname, vcType* t)
{
  assert(this->Find_Wire(wname) == NULL);
  this->_wire_map[wname] = new vcIntermediateWire(wname, t);
}

void vcDataPath::Add_Constant_Wire(string wname, vcValue* v)
{
  assert(v != NULL);
  vcType* t = v->Get_Type();
  assert(!(t->Is("vcArrayType") || t->Is("vcRecordType")));
  this->_wire_map[wname] = (vcWire*) ( new vcConstantWire(wname,v));
};

#define __PRINT_MAP(_map_id,_map_iter,ofile)  for(_map_iter=_map_id.begin();_map_iter!=_map_id.end();_map_iter++)\
    { (*_map_iter).second->Print(ofile);}

void vcDataPath::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__DATAPATH] << " { " << endl;

  map<string,vcWire*>::iterator wires;
  __PRINT_MAP(_wire_map,wires,ofile);

  map<string,vcPhi*>::iterator phis;
  __PRINT_MAP(_phi_map,phis,ofile);

  map<string,vcSelect*>::iterator selects;
  __PRINT_MAP(_select_map,selects,ofile);

  map<string,vcBranch*>::iterator branches;
  __PRINT_MAP(_branch_map,branches,ofile);

  map<string,vcLoad*>::iterator loads;
  __PRINT_MAP(_load_map,loads,ofile);

  map<string,vcStore*>::iterator stores;
  __PRINT_MAP(_store_map,stores,ofile);

  map<string,vcSplitOperator*>::iterator split_operators;
  __PRINT_MAP(_split_operator_map,split_operators,ofile);

  map<string,vcInport*>::iterator input_ports;
  __PRINT_MAP(_inport_map,input_ports,ofile);

  map<string,vcOutport*>::iterator output_ports;
  __PRINT_MAP(_outport_map,output_ports,ofile);

  this->Print_Attributes(ofile);
  ofile << "} " << endl;
}

#define _ADD(_map_id,_id,_ptr) _map_id[_id]=_ptr;\
  if(_dpe_map.find(_id)!=_dpe_map.end())\
    vcSystem::Error("multiple DPE instances with id " + _id);\
  else\
    _dpe_map[_id]=(vcDatapathElement*)_ptr;

#define __FIND(_map_id,_id) (_map_id.find(_id) != _map_id.end() ? _map_id[_id] : NULL) 

void vcDataPath::Add_Phi(vcPhi* p) {_ADD(_phi_map,p->Get_Id(), p);}
vcPhi* vcDataPath::Find_Phi(string id) {return(__FIND(_phi_map,id));}

void vcDataPath::Add_Load(vcLoad* ld) {_ADD(_load_map,ld->Get_Id(), ld);}
vcLoad* vcDataPath::Find_Load(string id) {return(__FIND(_load_map,id));}

void vcDataPath::Add_Store(vcStore* st) {_ADD(_store_map,st->Get_Id(), st);}
vcStore* vcDataPath::Find_Store(string id)  {return(__FIND(_store_map,id));}

void vcDataPath::Add_Call(vcCall* c)  {_ADD(_call_map,c->Get_Id(), c);}
vcCall* vcDataPath::Find_Call(string id) {return(__FIND(_call_map,id));}

void vcDataPath::Add_Inport(vcInport* p) 
{
  _ADD(_inport_map,p->Get_Id(), p);
  assert(p->Get_Data()->Get_Size() == this->Get_Parent()->Get_Parent()->Get_Pipe_Width(p->Get_Pipe_Id()));
}
vcInport* vcDataPath::Find_Inport(string id) {return(__FIND(_inport_map,id));}

void vcDataPath::Add_Outport(vcOutport* p) 
{
  _ADD(_outport_map,p->Get_Id(), p);
  assert(p->Get_Data()->Get_Size() == this->Get_Parent()->Get_Parent()->Get_Pipe_Width(p->Get_Pipe_Id()));

}
vcOutport* vcDataPath::Find_Outport(string id) {return(__FIND(_outport_map,id));}


void vcDataPath::Add_Split_Operator(vcSplitOperator* p)  {_ADD(_split_operator_map,p->Get_Id(), p);}
vcSplitOperator* vcDataPath::Find_Split_Operator(string id) {return(__FIND(_split_operator_map,id));}

void vcDataPath::Add_Select(vcSelect* p)   {_ADD(_select_map,p->Get_Id(), p);}
vcSelect* vcDataPath::Find_Select(string id) {return(__FIND(_select_map,id));}

void vcDataPath::Add_Branch(vcBranch* p)  {_ADD(_branch_map,p->Get_Id(), p);}
vcBranch* vcDataPath::Find_Branch(string id) {return(__FIND(_branch_map,id));}

void vcDataPath::Add_Register(vcRegister* p)  {_ADD(_register_map,p->Get_Id(), p);}
vcRegister* vcDataPath::Find_Register(string id) {return(__FIND(_register_map,id));}

void vcDataPath::Add_Equivalence(vcEquivalence* p)  {_ADD(_equivalence_map,p->Get_Id(), p);}
vcEquivalence* vcDataPath::Find_Equivalence(string id) {return(__FIND(_equivalence_map,id));}


void vcDataPath::Compute_Maximal_Groups(vcControlPath* cp)
{
  for(map<string, vcDatapathElement*>::iterator dpe_iter = _dpe_map.begin();
      dpe_iter != _dpe_map.end();
      dpe_iter++)
    {
      if((*dpe_iter).second->Kind() == "vcUnarySplitOperator" ||
	 (*dpe_iter).second->Kind() == "vcBinarySplitOperator")
	{
	  this->Update_Maximal_Groups(cp,(*dpe_iter).second, _compatible_split_operator_groups);
	}
      else if((*dpe_iter).second->Kind() == "vcLoad")
	{
	  this->Update_Maximal_Groups(cp, (*dpe_iter).second, _compatible_load_groups);
	}
      else if((*dpe_iter).second->Kind() == "vcStore")
	{
	  this->Update_Maximal_Groups(cp, (*dpe_iter).second, _compatible_store_groups);
	}
      else if((*dpe_iter).second->Kind() == "vcCall")
	{
	  this->Update_Maximal_Groups(cp, (*dpe_iter).second, _compatible_call_groups);
	}
      else if((*dpe_iter).second->Kind() == "vcOutport")
	{
	  this->Update_Maximal_Groups(cp, (*dpe_iter).second, _compatible_outport_groups);
	}
      else if((*dpe_iter).second->Kind() == "vcInport")
	{
	  this->Update_Maximal_Groups(cp, (*dpe_iter).second, _compatible_inport_groups);
	}
    }

  // load, store and call groups linked with the respective 
  // objects.
  for(int idx = 0; idx < this->_compatible_load_groups.size(); idx++)
    {
      vcMemorySpace* ms = ((vcLoad*) (*(_compatible_load_groups[idx].begin())))->Get_Memory_Space();
      ms->Register_Load_Group(this->_parent, idx, _compatible_load_groups[idx].size());
    }

  for(int idx = 0; idx < this->_compatible_store_groups.size(); idx++)
    {
      vcMemorySpace* ms = ((vcStore*) (*(_compatible_store_groups[idx].begin())))->Get_Memory_Space();
      ms->Register_Store_Group(this->_parent, idx, _compatible_store_groups[idx].size());
    }

  for(int idx = 0; idx < this->_compatible_call_groups.size(); idx++)
    {
      vcModule* cm = ((vcCall*) (*(_compatible_call_groups[idx].begin())))->Get_Called_Module();
      cm->Register_Call_Group(this->_parent, idx, _compatible_call_groups[idx].size());
    }

  for(int idx = 0; idx < this->_compatible_inport_groups.size(); idx++)
    {
      string pipe_id = ((vcInport*) (*(_compatible_inport_groups[idx].begin())))->Get_Pipe_Id();
      _inport_group_map[pipe_id].push_back(idx);
      this->_parent->Get_Parent()->Register_Pipe_Read(pipe_id,this->_parent,idx);
    }

  for(int idx = 0; idx < this->_compatible_outport_groups.size(); idx++)
    {
      string pipe_id = ((vcOutport*) (*(_compatible_outport_groups[idx].begin())))->Get_Pipe_Id();
      _outport_group_map[pipe_id].push_back(idx);
      this->_parent->Get_Parent()->Register_Pipe_Write(pipe_id, this->_parent,idx);
    }

}


void vcDataPath::Update_Maximal_Groups(vcControlPath* cp, 
				       vcDatapathElement* dpe, 
				       vector<set<vcDatapathElement*> >& dpe_group)
{
  pair<vcCompatibilityLabel*, vcCompatibilityLabel*> I1 = this->Get_Label_Interval(cp,dpe);

  bool new_group = true;
  for(int idx = 0; idx < dpe_group.size(); idx++)
    {
      if(dpe->Is_Shareable_With(*(dpe_group[idx].begin())))
	{
	  bool is_compatible = true;
	  for(set<vcDatapathElement*>::iterator dpe_iter = dpe_group[idx].begin();
	      dpe_iter != dpe_group[idx].end();
	      dpe_iter++)
	    {
	      pair<vcCompatibilityLabel*, vcCompatibilityLabel*> I2 = this->Get_Label_Interval(cp,*dpe_iter);

	      if(!((I1.second == I2.first) || cp->Lesser(I1.second, I2.first) ||
		   (I2.second == I1.first) || cp->Lesser(I2.second, I1.first)))
		{
		  is_compatible = false;
		  break;
		}
	    }
	  if(is_compatible)
	    {
	      new_group = false;
	      dpe_group[idx].insert(dpe);
	      break;
	    }
	}
    }

  if(new_group)
    {
      set<vcDatapathElement*> nset;
      nset.insert(dpe);
      dpe_group.push_back(nset);
    }
}


void vcDataPath::Print_Compatible_Operator_Groups(ostream& ofile)
{
  ofile << "Compatible share-able operator groups " << endl;
  this->Print_Compatible_Operator_Groups(ofile,_compatible_split_operator_groups);
  this->Print_Compatible_Operator_Groups(ofile,_compatible_load_groups);
  this->Print_Compatible_Operator_Groups(ofile,_compatible_store_groups);
  this->Print_Compatible_Operator_Groups(ofile,_compatible_call_groups);
  this->Print_Compatible_Operator_Groups(ofile,_compatible_outport_groups);
  this->Print_Compatible_Operator_Groups(ofile,_compatible_inport_groups);
}

void vcDataPath::Print_Compatible_Operator_Groups(ostream& ofile, vector<set<vcDatapathElement*> >& dpe_groups)
{

  for(int idx = 0; idx < dpe_groups.size(); idx++)
    {
      ofile << "Operator " << (*(dpe_groups[idx].begin()))->Get_Operator_Type() << endl;
      ofile << "{ " << endl;
      for(set<vcDatapathElement*>::iterator iter = dpe_groups[idx].begin();
	  iter != dpe_groups[idx].end();
	  iter++)
	{
	  ofile << (*iter)->Get_Id() << endl;
	}
      
      ofile << "} " << endl;
    }
}



//
// for each memory space accessed by this module
// add interface ports.
//
// the width of the interface ports is determined by number
// of load/store groups associated with the memory space.
string vcDataPath::Print_VHDL_Memory_Interface_Ports(string semi_colon, ostream& ofile)
{
  map<vcMemorySpace*, vector<int> > ms_to_load_group_map;
  vcMemorySpace* ms = NULL;


  // Each load group to a memory space contributes one request 
  // and one complete bundle.
  for(int idx = 0; idx < _compatible_load_groups.size(); idx++)
    {
      ms = ((vcLoad*) (*(_compatible_load_groups[idx].begin())))->Get_Memory_Space();
      if(ms->Get_Scope() == NULL)
	ms_to_load_group_map[ms].push_back(idx);
    }

  // for each memory space, add a port with the appropriate
  // width..
  for(map<vcMemorySpace*,vector<int> >::iterator ms_iter = ms_to_load_group_map.begin();
      ms_iter != ms_to_load_group_map.end();
      ms_iter++)
    {
      ofile << semi_colon << endl;

      ms = (*ms_iter).first;

      int num_reqs = (*ms_iter).second.size();
      int tag_width = ms->Get_Tag_Length();

      // load ports to this memory space from this module
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lr_req") 
	    << " : out  std_logic_vector(" << num_reqs-1  << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lr_ack") 
	    << " : in   std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lr_addr") 
	    << " : out  std_logic_vector(" << (num_reqs*ms->Get_Address_Width())-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lr_tag") 
	    << " :  out  std_logic_vector(" << (num_reqs* tag_width)-1  << " downto 0);" << endl;

      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lc_req") 
	    << " : out  std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lc_ack") 
	    << " : in   std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lc_data") 
	    << " : in   std_logic_vector(" << (num_reqs*ms->Get_Word_Size())-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lc_tag") 
	    << " :  in  std_logic_vector("  << (num_reqs*tag_width)-1  << " downto 0)";
      semi_colon = ";";
    }

  map<vcMemorySpace*, vector<int> > ms_to_store_group_map;

  // Each load group to a memory space contributes one request 
  // and one complete bundle.
  for(int idx = 0; idx < _compatible_store_groups.size(); idx++)
    {
      ms = ((vcStore*) (*(_compatible_store_groups[idx].begin())))->Get_Memory_Space();
      if(ms->Get_Scope() == NULL)
	ms_to_store_group_map[ms].push_back(idx);
    }

  // for each memory space, add a port with the appropriate
  // width..
  for(map<vcMemorySpace*,vector<int> >::iterator ms_iter = ms_to_store_group_map.begin();
      ms_iter != ms_to_store_group_map.end();
      ms_iter++)
    {
      ofile << semi_colon << endl;

      int num_stores = (*ms_iter).first->Get_Num_Stores();

      ms = (*ms_iter).first;

      int num_reqs = (*ms_iter).second.size();
      int tag_width = ms->Get_Tag_Length();

      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_req") 
	    << " : out  std_logic_vector(" << num_reqs-1  << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_ack") 
	    << " : in   std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_addr") 
	    << " : out  std_logic_vector(" << (num_reqs*ms->Get_Address_Width())-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_data") 
	    << " : out  std_logic_vector(" << (num_reqs*ms->Get_Word_Size())-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_tag") 
	    << " :  out  std_logic_vector(" << (num_reqs* tag_width)-1  << " downto 0);" << endl;

      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sc_req") 
	    << " : out  std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sc_ack") 
	    << " : in   std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sc_tag") 
	    << " :  in  std_logic_vector("  << (num_reqs*tag_width)-1  << " downto 0)";
      semi_colon = ";";
    }
  return(semi_colon);
}

string vcDataPath::Print_VHDL_IO_Interface_Ports(string semi_colon, ostream& ofile)
{
  map<string, vector<int> > pipe_to_inport_group_map;
  string pipe_id;
  int word_size;

  for(int idx = 0; idx < _compatible_inport_groups.size(); idx++)
    {
      pipe_id = ((vcInport*) (*(_compatible_inport_groups[idx].begin())))->Get_Pipe_Id();
      pipe_to_inport_group_map[pipe_id].push_back(idx);
    }

  for(map<string,vector<int> >::iterator ms_iter = pipe_to_inport_group_map.begin();
      ms_iter != pipe_to_inport_group_map.end();
      ms_iter++)
    {
      pipe_id = (*ms_iter).first;
      word_size = this->_parent->Get_Parent()->Get_Pipe_Width(pipe_id);

      int num_reqs = (*ms_iter).second.size();
      ofile << semi_colon << endl;

      ofile << this->Get_VHDL_IOport_Interface_Port_Name(pipe_id,"read_req")
	    << " : out  std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << this->Get_VHDL_IOport_Interface_Port_Name(pipe_id,"read_ack")
	    << " : in   std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << this->Get_VHDL_IOport_Interface_Port_Name(pipe_id,"read_data")
	    << " : in   std_logic_vector(" << (num_reqs * word_size)-1 << " downto 0)";

      semi_colon = ";";
    }


  map<string, vector<int> > pipe_to_outport_group_map;
  for(int idx = 0; idx < _compatible_outport_groups.size(); idx++)
    {
      pipe_id = ((vcOutport*) (*(_compatible_outport_groups[idx].begin())))->Get_Pipe_Id();
      pipe_to_outport_group_map[pipe_id].push_back(idx);
    }

  for(map<string,vector<int> >::iterator ms_iter = pipe_to_outport_group_map.begin();
      ms_iter != pipe_to_outport_group_map.end();
      ms_iter++)
    {
      pipe_id = (*ms_iter).first;
      word_size = this->_parent->Get_Parent()->Get_Pipe_Width(pipe_id);

      ofile << semi_colon << endl;

      int num_reqs = (*ms_iter).second.size();
      ofile << this->Get_VHDL_IOport_Interface_Port_Name(pipe_id,"write_req")
	    << " : out  std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << this->Get_VHDL_IOport_Interface_Port_Name(pipe_id,"write_ack")
	    << " : in   std_logic_vector(" << num_reqs-1 << " downto 0);" << endl;
      ofile << this->Get_VHDL_IOport_Interface_Port_Name(pipe_id,"write_data")
	    << " : out  std_logic_vector(" << (num_reqs * word_size)-1 << " downto 0)";
      semi_colon = ";";
    }
  return(semi_colon);
}

string  vcDataPath::Print_VHDL_Call_Interface_Ports(string semi_colon, ostream& ofile)
{
  map<vcModule*, vector<int> > called_module_to_call_group_map;
  vcModule* called_module;

  // Each call group to a module contributes one request 
  // and one complete bundle.
  for(int idx = 0; idx < _compatible_call_groups.size(); idx++)
    {
      called_module = ((vcCall*) (*(_compatible_call_groups[idx].begin())))->Get_Called_Module();
      called_module_to_call_group_map[called_module].push_back(idx);
    }

  // for each call group
  // width..
  for(map<vcModule*,vector<int> >::iterator called_module_iter = called_module_to_call_group_map.begin();
      called_module_iter != called_module_to_call_group_map.end();
      called_module_iter++)
    {

      ofile << semi_colon << endl;

      called_module = (*called_module_iter).first;

      int num_reqs = (*called_module_iter).second.size();
      int tag_width = called_module->Get_Caller_Tag_Length();
      
      ofile << called_module->Get_VHDL_Call_Interface_Port_Name("call_reqs")
	    << " : out  std_logic_vector(" << num_reqs-1 <<  " downto 0);" << endl;
      ofile << called_module->Get_VHDL_Call_Interface_Port_Name("call_acks") 
	    << " : in   std_logic_vector(" << num_reqs-1 <<  " downto 0);" << endl;

      if(called_module->Get_In_Arg_Width() > 0)
	ofile << called_module->Get_VHDL_Call_Interface_Port_Name("call_data") 
	      << " : out  std_logic_vector(" << (num_reqs * called_module->Get_In_Arg_Width())-1 << " downto 0);" << endl;

      ofile << called_module->Get_VHDL_Call_Interface_Port_Name("call_tag") 
	    << "  :  out  std_logic_vector(" << (num_reqs * tag_width)-1 << " downto 0);" << endl;
      
      ofile << called_module->Get_VHDL_Call_Interface_Port_Name("return_reqs") 
	    << " : out  std_logic_vector(" << num_reqs-1 <<  " downto 0);" << endl;
      ofile << called_module->Get_VHDL_Call_Interface_Port_Name("return_acks") 
	    << " : in   std_logic_vector(" << num_reqs-1 <<  " downto 0);" << endl;
      if(called_module->Get_Out_Arg_Width() > 0)
	ofile << called_module->Get_VHDL_Call_Interface_Port_Name("return_data") 
	      << " : in   std_logic_vector(" << (num_reqs * called_module->Get_Out_Arg_Width())-1 << " downto 0);" << endl;
      ofile << called_module->Get_VHDL_Call_Interface_Port_Name("return_tag") 
	    << " :  in   std_logic_vector(" << (num_reqs * tag_width)-1 << " downto 0)";
      semi_colon = ";";
    }
  return(semi_colon);

}


void vcDataPath::Print_VHDL(ostream& ofile)
{
  ofile << "data_path: Block -- { " << endl;

  // print wires.
  for(map<string, vcWire*>::iterator iter = _wire_map.begin();
      iter != _wire_map.end();
      iter++)
    {
      (*iter).second->Print_VHDL_Std_Logic_Declaration(ofile);
    }

    
  ofile << "-- }" << endl << "begin -- { " << endl;

  // tie constant wires to their values.
  for(map<string, vcWire*>::iterator iter = _wire_map.begin();
      iter != _wire_map.end();
      iter++)
    {
      if((*iter).second->Is("vcConstantWire"))
	ofile << (*iter).first << " <= " << ((vcConstantWire*)((*iter).second))->Get_Value()->To_VHDL_String() << ";" << endl;
    }

  // now instantiate each group. 
  this->Print_VHDL_Phi_Instances(ofile); // done
  this->Print_VHDL_Select_Instances(ofile); // done
  this->Print_VHDL_Register_Instances(ofile); // done
  this->Print_VHDL_Equivalence_Instances(ofile); // todo
  this->Print_VHDL_Branch_Instances(ofile); // done
  this->Print_VHDL_Split_Operator_Instances(ofile); //done
  this->Print_VHDL_Load_Instances(ofile);
  this->Print_VHDL_Store_Instances(ofile);
  this->Print_VHDL_Inport_Instances(ofile);
  this->Print_VHDL_Outport_Instances(ofile);
  this->Print_VHDL_Call_Instances(ofile);

  ofile << "-- }" << endl << "end Block; -- data_path" << endl;
}


void vcDataPath::Print_VHDL_Phi_Instances(ostream& ofile)
{ 
  for(map<string, vcPhi*>::iterator iter = _phi_map.begin();
      iter != _phi_map.end();
      iter++)
    {
      vcPhi* p = (*iter).second;
      int odata_width = p->Get_Outwire()->Get_Type()->Size();
      int num_reqs = p->Get_Inwires().size();
      int idata_width = num_reqs*odata_width;

      assert(p->Get_Number_Of_Reqs() == num_reqs);
      assert(p->Get_Number_Of_Acks() == 1);
      
      ofile << p->Get_VHDL_Id() << ": Block -- phi operator {" << endl;
      ofile << "signal idata: std_logic_vector(" << idata_width-1 << " downto 0);" << endl;
      ofile << "signal req: BooleanArray(" << num_reqs-1 << " downto 0);" << endl;
      ofile << "--}\n begin -- {" << endl;
      ofile << "idata <= ";
      for(int idx = 0; idx < p->Get_Inwires().size(); idx++)
	{
	  if(idx > 0)
	    ofile << " & ";
	  ofile << p->Get_Inwires()[idx]->Get_VHDL_Id();
	}
      ofile << ";" << endl;

      ofile << "req <= ";
      for(int idx = 0; idx < p->Get_Number_Of_Reqs(); idx++)
	{
	  if(idx > 0)
	    ofile << " & ";
	  ofile << p->Get_Req(idx)->Get_CP_To_DP_Symbol();
	}
      ofile << ";" << endl;
      
      ofile << "phi: PhiBase -- {" << endl
	    << "generic map( -- { " << endl 
	    << "num_reqs => " << p->Get_Number_Of_Reqs() << "," << endl
	    << "data_width => " << odata_width << ") -- }"  << endl
	    << "port map( -- { "<< endl 
	    << "req => req, " << endl
	    << "ack => " << p->Get_Ack(0)->Get_DP_To_CP_Symbol()  << "," << endl
	    << "idata => idata," << endl
	    << "odata => " << p->Get_Outwire()->Get_VHDL_Id() << "," << endl
	    << "clk => clk," << endl
	    << "reset => reset ); -- }}" << endl;
      ofile << "-- }\n end Block; -- phi operator " << p->Get_VHDL_Id() << endl;
    }
}




void vcDataPath::Print_VHDL_Select_Instances(ostream& ofile)
{ 
  for(map<string, vcSelect*>::iterator iter = _select_map.begin();
      iter != _select_map.end();
      iter++)
    {
      vcSelect* s = (*iter).second;
      ofile << s->Get_VHDL_Id() << ": SelectBase generic map(data_width => " << s->_z->Get_Size() << ") -- {" << endl;
      ofile << " port map( x => " << s->_x->Get_VHDL_Id() << ", y => " << s->_y->Get_VHDL_Id() << ", => " 
	    << s->_sel->Get_VHDL_Id() << ", z => " << s->_z->Get_VHDL_Id() 
	    << ", req => " << s->Get_Req(0)->Get_CP_To_DP_Symbol() 
	    << ", ack => " << s->Get_Ack(0)->Get_DP_To_CP_Symbol() << ", clk => clk, reset => reset); -- }" << endl;
    }
}

void vcDataPath::Print_VHDL_Register_Instances(ostream& ofile)
{ 
  for(map<string, vcRegister*>::iterator iter = _register_map.begin();
      iter != _register_map.end();
      iter++)
    {
      vcRegister* s = (*iter).second;
      ofile << s->Get_VHDL_Id() << ": RegisterBase generic map(in_data_width => " << s->_din->Get_Size()  << "," 
	    << "out_data_width => " << s->_dout->Get_Size() << ") -- {" << endl;
      ofile << " port map( din => " << s->_din->Get_VHDL_Id() << "," 
	    << " dout => " << s->_dout->Get_VHDL_Id() << ","
	    << " req => " << s->Get_Req(0)->Get_CP_To_DP_Symbol()  << ","
	    << " ack => " << s->Get_Ack(0)->Get_DP_To_CP_Symbol() << ", clk => clk, reset => reset); -- }" << endl;
    }
}

void vcDataPath::Print_VHDL_Equivalence_Instances(ostream& ofile)
{ 
  for(map<string, vcEquivalence*>::iterator iter = _equivalence_map.begin();
      iter != _equivalence_map.end();
      iter++)
    {
      vcEquivalence* s = (*iter).second;
      ofile << s->Get_VHDL_Id() << ": Block -- { " << endl;
      ofile << "signal aggregated_sig: std_logic_vector("
	    << s->_width-1 << " downto 0); --}" << endl;
      ofile << "begin -- {" << endl;
      ofile << s->Get_Ack(0)->Get_DP_To_CP_Symbol()  
	    << " <= "
	    << s->Get_Req(0)->Get_CP_To_DP_Symbol() 
	    << ";" << endl;
      ofile << " aggregated_sig <= ";
      for(int idx = 0; idx < s->_inwires.size(); idx++)
	{
	  if(idx > 0)
	    ofile << " & ";
	  ofile << s->_inwires[idx]->Get_VHDL_Id();
	}
      ofile << ";" << endl;
      int top_index = s->_width-1;
      for(int idx = 0; idx < s->_outwires.size(); idx++)
	{
	  ofile << s->_outwires[idx]->Get_VHDL_Id() 
		<< " <= aggregate_sig("
		<< top_index
		<< " downto "
		<< (top_index - s->_outwires[idx]->Get_Size())+1
		<< ");" << endl;
	  top_index -= s->_outwires[idx]->Get_Size();
	}
      ofile << "--}" << endl;
      ofile << "end Block;" << endl;
    }
}

void vcDataPath::Print_VHDL_Branch_Instances(ostream& ofile)
{ 
  for(map<string, vcBranch*>::iterator iter = _branch_map.begin();
      iter != _branch_map.end();
      iter++)
    {
      vcBranch* s = (*iter).second;

      int in_width = 0;
      for(int idx = 0; idx < s->_inwires.size(); idx++)
	in_width += s->_inwires[idx]->Get_Size();

      ofile << s->Get_VHDL_Id() << ": Block -- { -- branch-block" << endl;
      ofile << "signal condition_sig : std_logic_vector(" << in_width-1 << " downto 0);" << endl;
      ofile << "begin " << endl;
      ofile << "condition_sig <= ";
      for(int idx = 0; idx < s->_inwires.size(); idx++)
	{
	  if(idx > 0)
	    ofile << " & ";
	  ofile << s->_inwires[idx]->Get_VHDL_Id();
	}
      ofile << ";" << endl;
      ofile << "branch_instance: BranchBase -- {" << endl;
      ofile << " generic map( condition_width => " << in_width << ")" << endl;
      ofile << " port map( -- { " << endl << " condition => condition_sig";
      ofile << "," << endl;
      ofile << "req => " << s->Get_Req(0)->Get_CP_To_DP_Symbol() << "," <<  endl
	    << "ack0 => " << ((s->Get_Ack(0) != NULL) ? s->Get_Ack(0)->Get_DP_To_CP_Symbol() : 
			      "open" )
	    << "," << endl
	    << "ack1 => " << ((s->Get_Ack(1) != NULL) ? s->Get_Ack(1)->Get_DP_To_CP_Symbol() : 
			      "open" )
	    << "," << endl
	    << "clk => clk," << endl
	    << "reset => reset); -- }}" << endl;
      ofile << "--}\n end Block; -- branch-block" << endl;
    }
}

// A hell of an ugly function.. Can it be improved?
void vcDataPath::Print_VHDL_Split_Operator_Instances(ostream& ofile)
{
  for(int idx = 0; idx < this->_compatible_split_operator_groups.size(); idx++)
    { // for each operator group.

      bool is_unary_operator = false;
      // number of requesters.
      int num_reqs = _compatible_split_operator_groups[idx].size();

      // to collect inwires, outwires and reqs/acks.
      vector<vcWire*> inwires;
      vector<vcTransition*> reqL;
      vector<vcTransition*> ackL;
      vector<vcTransition*> reqR;
      vector<vcTransition*> ackR;
      vector<vcWire*> outwires;

      // to get the operation id, we need the vc operator as well as the input and output 
      // types. (e.g. + (float float) (float) or + (int int) (int) ?
      vcType* input_type =   ((vcSplitOperator*)(*(_compatible_split_operator_groups[idx].begin())))->Get_Input_Type();
      vcType* output_type =   ((vcSplitOperator*)(*(_compatible_split_operator_groups[idx].begin())))->Get_Output_Type();

      
      string vc_op_id = ((vcSplitOperator*)(*(_compatible_split_operator_groups[idx].begin())))->Get_Op_Id();
      string vhdl_op_id = Get_VHDL_Op_Id(vc_op_id,
					 input_type,
					 output_type);
      

      // the number of inputs and outputs on each operator in the current group.
      int num_ips = ((vcSplitOperator*)(*(_compatible_split_operator_groups[idx].begin())))->Get_Number_Of_Input_Wires();
      int num_ops = ((vcSplitOperator*)(*(_compatible_split_operator_groups[idx].begin())))->Get_Number_Of_Output_Wires();
					 
      // to keep track of the ids of the operators in this group.
      vector<string> elements;

      // ok. collect all the information..
      for(set<vcDatapathElement*>::iterator iter = _compatible_split_operator_groups[idx].begin();
	  iter != _compatible_split_operator_groups[idx].end();
	  iter++)
	{

	  vcSplitOperator* so = (vcSplitOperator*) (*iter);
	  is_unary_operator = Is_Unary_Op(so->Get_Op_Id());

	  elements.push_back(so->Get_VHDL_Id());
	  so->Append_Inwires(inwires);
	  so->Append_Outwires(outwires);
	  reqL.push_back(so->Get_Req(0));
	  ackL.push_back(so->Get_Ack(0));
	  reqR.push_back(so->Get_Req(1));
	  ackR.push_back(so->Get_Ack(1));
	}


      // is the second input a constant?
      bool use_constant = false;
      string const_operand;
      if(num_ips == 2 && inwires[1]->Is("vcConstantWire"))
	{
	  num_ips = 1; // has only one input, we will be using one constant operand.
	  use_constant = true;
	  const_operand = ((vcConstantWire*)inwires[1])->Get_Value()->To_VHDL_String();
	}
      else
	{
	  const_operand += "\"0\"";
	}


      // total in-width 
      int in_width = 0;
      vector<vcWire*> concat_in_wires;
      for(int u = 0; u < inwires.size(); u++)
	{
	  if(!use_constant || (u%2 == 0))
	    {
	      // do not count if inwire is
	      // an even operand and if it is
	      // a constant.
	      in_width += inwires[u]->Get_Size();
	      concat_in_wires.push_back(inwires[u]);
	    }
	}


      // total out-width..
      int out_width = 0;
      for(int u = 0; u < outwires.size(); u++)
	{
	  out_width += outwires[u]->Get_Size();
	}


      // VHDL code for this shared group
      ofile << "-- shared split operator group (" << idx << ") : " ;
      for(int u = 0; u < elements.size(); u++)
	ofile << elements[u] << " ";
      ofile << endl;


      // make a block
      ofile << "SplitOperatorGroup" << idx << ": Block -- {" << endl;
      // in and out data.
      ofile << "signal data_in: std_logic_vector(" << in_width-1 << " downto 0);" << endl;
      ofile << "signal data_out: std_logic_vector(" << out_width-1 << " downto 0);" << endl;
      // in and out acks.
      ofile << "signal reqR, ackR, reqL, ackL : BooleanArray( " << num_reqs-1 << " downto 0);" << endl;

      ofile << "-- }\n begin -- {" << endl;

      // concatenate data_in
      this->Print_VHDL_Concatenation(string("data_in"), concat_in_wires,ofile);

      // disconcatenate data_out
      this->Print_VHDL_Disconcatenation(string("data_out"), out_width, outwires,ofile);


      // input types 
      vcType* input_type_1 = inwires[0]->Get_Type();
      vcType* input_type_2 = input_type_1;

      if(num_ips == 2)
	input_type_2 = inwires[1]->Get_Type();
      

      // now the operator instance.
      // it can be an instance either of a shared operator or of an unshared
      // operator.
      
      if(num_reqs > 1)
	{
	  // ok, a shared operator
	  this->Print_VHDL_Concatenate_Req("reqL",reqL,ofile);
	  this->Print_VHDL_Disconcatenate_Ack("ackL",ackL,ofile);
	  this->Print_VHDL_Concatenate_Req("reqR",reqR,ofile);
	  this->Print_VHDL_Disconcatenate_Ack("ackR",ackR,ofile);
	  
	  ofile << "SplitOperator: SplitOperatorShared -- {" << endl;
	  ofile << "generic map ( -- { " ;
	  
	  // a ton of generics..
	  ofile << " operator_id => " << vhdl_op_id << "," << endl  // operator-id
		<< " input1_is_int => " << (input_type_1->Is_Int_Type() ? "true" : "false") << ", " << endl  // first op is int?
		<< " input1_characteristic_width => " 
		<< (input_type_1->Is("vcFloatType") ? ((vcFloatType*)input_type_1)->Get_Characteristic_Width() : 0) << ", " << endl // char 1
		<< " input1_mantissa_width    => " 
		<< (input_type_1->Is("vcFloatType") ? ((vcFloatType*)input_type_1)->Get_Mantissa_Width() : 0) << ", " << endl // mantissa 1
		<< " iwidth_1  => " << input_type_1->Size() << "," << endl // width 1
		<< " input2_is_int => " << (input_type_2->Is_Int_Type() ? "true" : "false") << ", " << endl  // second op is int?
		<< " input2_characteristic_width => " 
		<< (input_type_2->Is("vcFloatType") ? ((vcFloatType*)input_type_2)->Get_Characteristic_Width() : 0) << ", " << endl // char 2
		<< " input2_mantissa_width => "
		<< (input_type_2->Is("vcFloatType") ? ((vcFloatType*)input_type_2)->Get_Mantissa_Width() : 0) << ", " << endl // mantissa 2
		<< " iwidth_2      => " << (num_ips == 2 ? input_type_2->Size() : 0) << ", " << endl // width 2
		<< " num_inputs    => " << num_ips << ","  << endl // number of inputs
		<< " output_is_int => " << (output_type->Is_Int_Type() ? "true" : "false") << "," << endl // output is int?
		<< " output_characteristic_width  => " 
		<< (output_type->Is("vcFloatType") ? ((vcFloatType*)output_type)->Get_Characteristic_Width() : 0) << ", " << endl // char op
		<< " output_mantissa_width => " 
		<< (output_type->Is("vcFloatType") ? ((vcFloatType*)output_type)->Get_Mantissa_Width() : 0) << ", " << endl // mantissa op
		<< " owidth => " << output_type->Size() << "," << endl  // output width
		<< " constant_operand => " << const_operand << "," << endl // constant operand?
		<< " use_constant  => " << (use_constant ? "true" : "false") << "," << endl // use constant?
		<< " zero_delay => false, " << endl // single cycle delay
		<< " no_arbitration => true, " << endl // no arbitration within group.
		<< " num_reqs => " << num_reqs << "--} \n ) -- }" << endl; // number of requesters..
	  ofile << "port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);" << endl;
	}
      else
	{
	  // an unshared operator.
	  bool flow_through_flag  = outwires[0]->Is("vcIntermediateWire") &&
	    (Is_Trivial_Op(vc_op_id)  ||
	     (use_constant && Is_Shift_Op(vc_op_id)));

	  ofile << "UnsharedOperator: UnsharedOperatorBase -- {" << endl;
	  ofile << "generic map ( -- { " ;
	  
	  // a ton of generics..
	  ofile << " operator_id => " << vhdl_op_id << "," << endl  // operator-id
		<< " input1_is_int => " << (input_type_1->Is_Int_Type() ? "true" : "false") << ", " << endl  // first op is int?
		<< " input1_characteristic_width => " 
		<< (input_type_1->Is("vcFloatType") ? ((vcFloatType*)input_type_1)->Get_Characteristic_Width() : 0) << ", " << endl // char 1
		<< " input1_mantissa_width    => " 
		<< (input_type_1->Is("vcFloatType") ? ((vcFloatType*)input_type_1)->Get_Mantissa_Width() : 0) << ", " << endl // mantissa 1
		<< " iwidth_1  => " << input_type_1->Size() << "," << endl // width 1
		<< " input2_is_int => " << (input_type_2->Is_Int_Type() ? "true" : "false") << ", " << endl  // second op is int?
		<< " input2_characteristic_width => " 
		<< (input_type_2->Is("vcFloatType") ? ((vcFloatType*)input_type_2)->Get_Characteristic_Width() : 0) << ", " << endl // char 2
		<< " input2_mantissa_width => "
		<< (input_type_2->Is("vcFloatType") ? ((vcFloatType*)input_type_2)->Get_Mantissa_Width() : 0) << ", " << endl // mantissa 2
		<< " iwidth_2      => " << (num_ips == 2 ? input_type_2->Size() : 0) << ", " << endl // width 2
		<< " num_inputs    => " << num_ips << ","  << endl // number of inputs
		<< " output_is_int => " << (output_type->Is_Int_Type() ? "true" : "false") << "," << endl // output is int?
		<< " output_characteristic_width  => " 
		<< (output_type->Is("vcFloatType") ? ((vcFloatType*)output_type)->Get_Characteristic_Width() : 0) << ", " << endl // char op
		<< " output_mantissa_width => " 
		<< (output_type->Is("vcFloatType") ? ((vcFloatType*)output_type)->Get_Mantissa_Width() : 0) << ", " << endl // mantissa op
		<< " owidth => " << output_type->Size() << "," << endl  // output width
		<< " constant_operand => " << const_operand << "," << endl // constant operand?
		<< " use_constant  => " << (use_constant ? "true" : "false") << "," << endl // use constant?
		<< " zero_delay => false, " << endl // single cycle delay
		<< " flow_through => " << (flow_through_flag ? "true" : "false")
		<< "--} \n ) " << endl; // number of requesters..
	  ofile << "port map ( -- { " << endl
		<< "reqL => " << reqL[0]->Get_CP_To_DP_Symbol() << "," << endl
		<< "ackL => " << ackL[0]->Get_DP_To_CP_Symbol() << "," << endl
		<< "reqR => " << reqR[0]->Get_CP_To_DP_Symbol() << "," << endl
		<< "ackR => " << ackR[0]->Get_DP_To_CP_Symbol() << "," << endl
		<< "dataL => data_in, " << endl
		<< "dataR => data_out," << endl
		<< "clk => clk," << endl
		<< "reset => reset); -- }}" << endl;
	}
      ofile << "-- } \n end Block; -- split operator group " << idx << endl; // thats it..
    }
}

void vcDataPath::Print_VHDL_Concatenate_Req(string req_id, vector<vcTransition*>& reqs,  ostream& ofile)
{
	
  for(int rI = 0; rI < reqs.size(); rI++)
    {
      ofile << req_id <<  "(" << (reqs.size()-1)-rI << ") <= " 
	    << reqs[rI]->Get_CP_To_DP_Symbol() << ";" << endl;
    }
}


void vcDataPath::Print_VHDL_Disconcatenate_Ack(string ack_id, vector<vcTransition*>& acks,  ostream& ofile)
{
  // disconcatenate ackL
  for(int aI = 0; aI < acks.size(); aI++)
    {
      if(acks[aI] != NULL)
	ofile << acks[aI]->Get_DP_To_CP_Symbol() << " <= "
	      << ack_id << "(" << (acks.size()-1) - aI << ");" << endl;
    }
}



void vcDataPath::Print_VHDL_Concatenation(string target, vector<vcWire*> wires, ostream& ofile)
{
  ofile << target << " <= ";
  for(int u = 0; u < wires.size(); u++)
    {
      if(u > 0)
	ofile << " & ";
      ofile << wires[u]->Get_VHDL_Id();
    }
  ofile << ";" << endl;
}



void vcDataPath::Print_VHDL_Disconcatenation(string source, int total_width, vector<vcWire*> wires, ostream& ofile)
{
  int lindex = total_width-1;
  for(int u = 0; u < wires.size(); u++)
    {
      ofile << wires[u]->Get_VHDL_Id() << " <= " << source << "(";
      ofile << lindex << " downto " << (lindex - (wires[u]->Get_Size()-1)) << ");" << endl;
      lindex -= wires[u]->Get_Size();
    }
}


void vcDataPath::Print_VHDL_Load_Instances(ostream& ofile)
{ 
  // print LoadReqShared instance and LoadCompleteShared instance.
  for(int idx = 0; idx < this->_compatible_load_groups.size(); idx++)
    { // for each operator group.

      // number of requesters.
      int num_reqs = _compatible_load_groups[idx].size();

      // to collect inwires, outwires and reqs/acks.
      vector<vcWire*> inwires;
      vector<vcTransition*> reqL;
      vector<vcTransition*> ackL;
      vector<vcTransition*> reqR;
      vector<vcTransition*> ackR;
      vector<vcWire*> outwires;

      // to keep track of the ids of the operators in this group.
      vector<string> elements;

      vcMemorySpace* ms = NULL;

      // ok. collect all the information..
      for(set<vcDatapathElement*>::iterator iter = _compatible_load_groups[idx].begin();
	  iter != _compatible_load_groups[idx].end();
	  iter++)
	{

	  assert((*iter)->Is("vcLoad"));
	  vcLoad* so = (vcLoad*) (*iter);

	  if(ms == NULL)
	    ms = ((vcLoad*) so)->Get_Memory_Space();
	  else
	    assert(ms == ((vcLoad*) so)->Get_Memory_Space());

	  elements.push_back(so->Get_VHDL_Id());
	  so->Append_Inwires(inwires);
	  so->Append_Outwires(outwires);
	  reqL.push_back(so->Get_Req(0));
	  ackL.push_back(so->Get_Ack(0));
	  reqR.push_back(so->Get_Req(1));
	  ackR.push_back(so->Get_Ack(1));
	}
      assert(ms != NULL);

      // address, data
      int addr_width = ((vcLoadStore*)(*_compatible_load_groups[idx].begin()))->Get_Address()->Get_Size();
      int data_width = ((vcLoadStore*)(*_compatible_load_groups[idx].begin()))->Get_Data()->Get_Size();
      
      // tag-length
      int tag_length = ms->Get_Tag_Length();

      // total in-width 
      int in_width = 0;
      for(int u = 0; u < inwires.size(); u++)
	{
	  in_width += inwires[u]->Get_Size();
	}

      // total out-width..
      int out_width = 0;
      for(int u = 0; u < outwires.size(); u++)
	{
	  out_width += outwires[u]->Get_Size();
	}

      // VHDL code for this shared group
      ofile << "-- shared load operator group (" << idx << ") : " ;
      for(int u = 0; u < elements.size(); u++)
	ofile << elements[u] << " ";
      ofile << endl;


      // make a block
      ofile << "LoadGroup" << idx << ": Block -- {" << endl;
      // in and out data.
      ofile << "signal data_in: std_logic_vector(" << in_width-1 << " downto 0);" << endl;
      ofile << "signal data_out: std_logic_vector(" << out_width-1 << " downto 0);" << endl;
      // in and out acks.
      ofile << "signal reqR, ackR, reqL, ackL : BooleanArray( " << num_reqs-1 << " downto 0);" << endl;

      ofile << "-- }\n begin -- {" << endl;

      this->Print_VHDL_Concatenate_Req("reqL",reqL,ofile);
      this->Print_VHDL_Disconcatenate_Ack("ackL",ackL,ofile);
      this->Print_VHDL_Concatenate_Req("reqR",reqR,ofile);
      this->Print_VHDL_Disconcatenate_Ack("ackR",ackR,ofile);
	
      // concatenate data_in
      this->Print_VHDL_Concatenation(string("data_in"), inwires,ofile);

      // disconcatenate data_out
      this->Print_VHDL_Disconcatenation(string("data_out"), out_width, outwires,ofile);

      vcModule* m = this->Get_Parent();

      // now the operator instances 
      ofile << "LoadReq: LoadReqShared -- {" << endl;
      ofile << "generic map (addr_width => " << addr_width << ","
	    << "  num_reqs => " << num_reqs << ","
	    << "  tag_length => " << tag_length << ","
	    << "  no_arbitration => true)" << endl;
      ofile << "port map ( -- { \n reqL => reqL " << ", " <<  endl
	    << "    ackL => ackL " << ", " <<  endl
	    << "    dataL => data_in, " << endl
	    << "    mreq => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"load", "lr_req", idx)  << "," << endl
	    << "    mack => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m, "load", "lr_ack", idx)  << "," << endl
	    << "    maddr => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m, "load", "lr_addr",idx) << "," << endl
	    << "    mtag => "  
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m , "load", "lr_tag",idx) << "," << endl
	    << "  clk => clk, reset => reset -- }\n); -- }" << endl;

      ofile << "LoadComplete: LoadCompleteShared -- {" << endl;
      ofile << "generic map ( data_width => " << data_width << ","
	    << "  num_reqs => " << num_reqs << ","
	    << "  tag_length => " << tag_length << ","
	    << "  no_arbitration => true)" << endl;
      ofile << "port map ( -- {\n reqR => reqR " << ", " <<  endl
	    << "    ackR => ackR " << ", " <<  endl
	    << "    dataR => data_out, " << endl
	    << "    mreq => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"load", "lc_req", idx)  
	    << "," << endl
	    << "    mack => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"load", "lc_ack", idx)  
	    << "," << endl
	    << "    mdata => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"load", "lc_data", idx)  << "," << endl
	    << "    mtag => "  
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m, "load", "lc_tag", idx)  << "," << endl
	    << "  clk => clk, reset => reset -- }\n); -- }" << endl;
      ofile << "-- }\n end Block; -- load group " << idx << endl; // thats it..
    }
}

void vcDataPath::Print_VHDL_Store_Instances(ostream& ofile)
{ 
  for(int idx = 0; idx < this->_compatible_store_groups.size(); idx++)
    { // for each operator group.

      // number of requesters.
      int num_reqs = _compatible_store_groups[idx].size();

      vector<vcWire*> addrwires;
      vector<vcWire*> datawires;
      vector<vcTransition*> reqL;
      vector<vcTransition*> ackL;
      vector<vcTransition*> reqR;
      vector<vcTransition*> ackR;

      // to keep track of the ids of the operators in this group.
      vector<string> elements;

      vcMemorySpace* ms = NULL;

      // ok. collect all the information..
      for(set<vcDatapathElement*>::iterator iter = _compatible_store_groups[idx].begin();
	  iter != _compatible_store_groups[idx].end();
	  iter++)
	{
	  assert((*iter)->Is("vcStore"));
	  vcStore* so = (vcStore*) (*iter);

	  if(ms == NULL)
	    ms = so->Get_Memory_Space();
	  else
	    assert(ms == so->Get_Memory_Space());

	  elements.push_back(so->Get_VHDL_Id());
	  addrwires.push_back(so->Get_Address());
	  datawires.push_back(so->Get_Data());

	  reqL.push_back(so->Get_Req(0));
	  ackL.push_back(so->Get_Ack(0));
	  reqR.push_back(so->Get_Req(1));
	  ackR.push_back(so->Get_Ack(1));
	}
      assert(ms != NULL);

      // address, data
      int addr_width = ((vcLoadStore*)(*_compatible_store_groups[idx].begin()))->Get_Address()->Get_Size();
      assert(addr_width == ms->Get_Address_Width());
      int data_width = ((vcLoadStore*)(*_compatible_store_groups[idx].begin()))->Get_Data()->Get_Size();
      assert(data_width == ms->Get_Word_Size());
      
      // tag-length
      int tag_length = ms->Get_Tag_Length();

      // total addr-width 
      int total_addr_width = addrwires.size() * addr_width;
      int total_data_width = datawires.size() * data_width;
      
      // VHDL code for this shared group
      ofile << "-- shared store operator group (" << idx << ") : " ;
      for(int u = 0; u < elements.size(); u++)
	ofile << elements[u] << " ";
      ofile << endl;


      // make a block
      ofile << "StoreGroup" << idx << ": Block -- {" << endl;
      // in and out data.
      ofile << "signal addr_in: std_logic_vector(" << total_addr_width-1 << " downto 0);" << endl;
      ofile << "signal data_in: std_logic_vector(" << total_data_width-1 << " downto 0);" << endl;
      // in and out acks.
      ofile << "signal reqR, ackR, reqL, ackL : BooleanArray( " << num_reqs-1 << " downto 0);" << endl;

      ofile << "-- }\n begin -- {" << endl;

      this->Print_VHDL_Concatenate_Req("reqL",reqL,ofile);
      this->Print_VHDL_Disconcatenate_Ack("ackL",ackL,ofile);
      this->Print_VHDL_Concatenate_Req("reqR",reqR,ofile);
      this->Print_VHDL_Disconcatenate_Ack("ackR",ackR,ofile);

      // concatenate addr_in and data_in
      this->Print_VHDL_Concatenation(string("addr_in"), addrwires,ofile);
      this->Print_VHDL_Concatenation(string("data_in"), datawires,ofile);

      vcModule* m = this->Get_Parent();

      // now the operator instances 
      ofile << "StoreReq: StoreReqShared -- {" << endl;
      ofile << "generic map ( addr_width => " << addr_width << "," << endl
	    << "  data_width => " << data_width << "," << endl
	    << "  num_reqs => " << num_reqs << "," << endl
	    << "  tag_length => " << tag_length << "," << endl
	    << "  no_arbitration => true)" << endl;
      ofile << "port map (--{\n reqL => reqL " << ", " <<  endl
	    << "    ackL => ackL " << ", " <<  endl
	    << "    addr => addr_in, " << endl
	    << "    data => data_in, " << endl
	    << "    mreq => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"store", "sr_req", idx)  << "," << endl
	    << "    mack => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"store", "sr_ack", idx)  << "," << endl
	    << "    maddr => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"store","sr_addr",idx) << "," << endl
	    << "    mdata => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"store","sr_data",idx) << "," << endl
	    << "    mtag => "  
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"store","sr_tag",idx) << "," << endl
	    << "  clk => clk, reset => reset -- }\n);--}" << endl;

      ofile << "StoreComplete: StoreCompleteShared -- { " << endl;
      ofile << "generic map ( -- { "
	    << "  num_reqs => " << num_reqs << "," << endl
	    << "  tag_length => " << tag_length << " -- } \n)" << endl;

      ofile << "port map ( -- { reqR => reqR " << ", " <<  endl
	    << "    ackR => ackR " << ", " <<  endl
	    << "    mreq => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"store", "sc_req", idx)  << "," << endl
	    << "    mack => " 
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"store", "sc_ack", idx)  << "," << endl
	    << "    mtag => "  
	    << ms->Get_VHDL_Memory_Interface_Port_Section(m,"store", "sc_tag", idx)  << "," << endl
	    << "  clk => clk, reset => reset -- }); -- }" << endl;

      ofile << "-- }\n end Block; -- store group " << idx << endl; // thats it..
    }
}

void vcDataPath::Print_VHDL_Inport_Instances(ostream& ofile)
{

  for(int idx = 0; idx < this->_compatible_inport_groups.size(); idx++)
    { // for each operator group.

      // number of requesters.
      int num_reqs = _compatible_inport_groups[idx].size();

      vector<vcTransition*> req;
      vector<vcTransition*> ack;
      vector<vcWire*> outwires;

      // to keep track of the ids of the operators in this group.
      vector<string> elements;

      string pipe_id;
      int data_width = -1;

      // ok. collect all the information..
      for(set<vcDatapathElement*>::iterator iter = _compatible_inport_groups[idx].begin();
	  iter != _compatible_inport_groups[idx].end();
	  iter++)
	{

	  assert((*iter)->Is("vcInport"));
	  vcInport* so = (vcInport*) (*iter);

	  if(pipe_id == "")
	    pipe_id = ((vcInport*) so)->Get_Pipe_Id();
	  else
	    assert(pipe_id == ((vcInport*) so)->Get_Pipe_Id());

	  if(data_width < 0)
	    data_width = so->Get_Data()->Get_Size();
	  else
	    assert(data_width == so->Get_Data()->Get_Size());

	  elements.push_back(so->Get_VHDL_Id());
	  so->Append_Outwires(outwires);
	  req.push_back(so->Get_Req(0));
	  ack.push_back(so->Get_Ack(0));
	}
      assert(pipe_id != "");
      assert(data_width > 0);

      // total out-width..
      int out_width = 0;
      for(int u = 0; u < outwires.size(); u++)
	{
	  out_width += outwires[u]->Get_Size();
	}

      // VHDL code for this shared group
      ofile << "-- shared inport operator group (" << idx << ") : " ;
      for(int u = 0; u < elements.size(); u++)
	ofile << elements[u] << " ";
      ofile << endl;


      // make a block
      ofile << "InportGroup" << idx << ": Block -- {" << endl;
      // in and out data.
      ofile << "signal data_out: std_logic_vector(" << out_width-1 << " downto 0);" << endl;
      // in and out acks.
      ofile << "signal req, ack : BooleanArray( " << num_reqs-1 << " downto 0);" << endl;

      ofile << "-- }\n begin -- {" << endl;

      this->Print_VHDL_Concatenate_Req("req",req,ofile);
      this->Print_VHDL_Disconcatenate_Ack("ack",ack, ofile);

      // disconcatenate data_out
      this->Print_VHDL_Disconcatenation(string("data_out"), out_width, outwires,ofile);

      // now the operator instances 
      ofile << "Inport: InputPort -- { " << endl;
      ofile << "generic map ( data_width => " << data_width << ","
	    << "  num_reqs => " << num_reqs << ","
	    << "  no_arbitration => true)" << endl;
      ofile << "port map (-- {\n req => req " << ", " <<  endl
	    << "    ack => ack " << ", " <<  endl
	    << "    data => data_out, " << endl
	    << "    oreq => " 
	    << this->Get_VHDL_IOport_Interface_Port_Section(pipe_id, "in" , "read_req", idx)  << "," << endl
	    << "    oack => " 
	    << this->Get_VHDL_IOport_Interface_Port_Section(pipe_id,"in",  "read_ack", idx)  << "," << endl
	    << "    odata => " 
	    << this->Get_VHDL_IOport_Interface_Port_Section(pipe_id,"in", "read_data", idx)  << "," << endl
	    << "  clk => clk, reset => reset -- }\n ); -- }" << endl;
      ofile << "-- }\n end Block; -- inport group " << idx << endl; // thats it..
    }
}


void vcDataPath::Print_VHDL_Outport_Instances(ostream& ofile)
{ 
  for(int idx = 0; idx < this->_compatible_outport_groups.size(); idx++)
    { // for each operator group.

      // number of requesters.
      int num_reqs = _compatible_outport_groups[idx].size();

      vector<vcTransition*> req;
      vector<vcTransition*> ack;
      vector<vcWire*> inwires;

      // to keep track of the ids of the operators in this group.
      vector<string> elements;

      string pipe_id;
      int data_width = -1;

      // ok. collect all the information..
      for(set<vcDatapathElement*>::iterator iter = _compatible_outport_groups[idx].begin();
	  iter != _compatible_outport_groups[idx].end();
	  iter++)
	{

	  assert((*iter)->Is("vcOutport"));
	  vcOutport* so = (vcOutport*) (*iter);

	  if(pipe_id == "")
	    pipe_id = ((vcOutport*) so)->Get_Pipe_Id();
	  else
	    assert(pipe_id == ((vcOutport*) so)->Get_Pipe_Id());

	  if(data_width < 0)
	    data_width = so->Get_Data()->Get_Size();
	  else
	    assert(data_width == so->Get_Data()->Get_Size());

	  elements.push_back(so->Get_VHDL_Id());
	  so->Append_Inwires(inwires);
	  req.push_back(so->Get_Req(0));
	  ack.push_back(so->Get_Ack(0));
	}
      assert(pipe_id != "");
      assert(data_width > 0);

      int in_width = 0;
      for(int u = 0; u < inwires.size(); u++)
	{
	  in_width += inwires[u]->Get_Size();
	}

      // VHDL code for this shared group
      ofile << "-- shared outport operator group (" << idx << ") : " ;
      for(int u = 0; u < elements.size(); u++)
	ofile << elements[u] << " ";
      ofile << endl;


      // make a block
      ofile << "OutportGroup" << idx << ": Block -- { " << endl;
      // in and out data.
      ofile << "signal data_in: std_logic_vector(" << in_width-1 << " downto 0);" << endl;
      // in and out acks.
      ofile << "signal req, ack : BooleanArray( " << num_reqs-1 << " downto 0);" << endl;

      ofile << "-- }\n begin -- {" << endl;

      this->Print_VHDL_Concatenate_Req("req",req,ofile);
      this->Print_VHDL_Disconcatenate_Ack("ack",ack, ofile);

      // concatenate data_in
      this->Print_VHDL_Concatenation(string("data_in"), inwires,ofile);

      // now the operator instances 
      ofile << "outport: OutputPort -- { " << endl;
      ofile << "generic map ( data_width => " << data_width << ","
	    << "  num_reqs => " << num_reqs << ","
	    << "  no_arbitration => true)" << endl;
      ofile << "port map (--{\n req => req " << ", " <<  endl
	    << "    ack => ack " << ", " <<  endl
	    << "    data => data_in, " << endl
	    << "    oreq => " 
	    << this->Get_VHDL_IOport_Interface_Port_Section(pipe_id, "out" , "write_req", idx)  << "," << endl
	    << "    oack => " 
	    << this->Get_VHDL_IOport_Interface_Port_Section(pipe_id,"out",  "write_ack", idx)  << "," << endl
	    << "    odata => " 
	    << this->Get_VHDL_IOport_Interface_Port_Section(pipe_id,"out", "write_data", idx)  << "," << endl
	    << "  clk => clk, reset => reset -- }\n);-- }" << endl;
      ofile << "-- }\n end Block; -- outport group " << idx << endl; // thats it..
    }
}


string vcDataPath::Get_VHDL_IOport_Interface_Port_Name(string pipe_id, string pid)
{
  return(this->Get_Parent()->Get_Parent()->Get_VHDL_Pipe_Interface_Port_Name(pipe_id,pid));
}

string vcDataPath::Get_VHDL_IOport_Interface_Port_Section(string pipe_id, 
							  string in_or_out,
							  string pid,
							  int idx)
{

  string port_name = this->Get_VHDL_IOport_Interface_Port_Name(pipe_id,pid);

  vcModule* m = this->Get_Parent();
  vcSystem* sys = m->Get_Parent();

  map<string,vector<int> >::iterator iter;
  if(in_or_out == "in")
    {
      iter = _inport_group_map.find(pipe_id);
      assert(iter != _inport_group_map.end());
    }
  else
    {
      iter = _outport_group_map.find(pipe_id);
      assert(iter != _outport_group_map.end());
    }

  int down_index;
  // left to right 
  for(int index = 0; index < (*iter).second.size(); index++)
    {
      down_index = ((*iter).second.size()-1) - index; // position from left.
      if(idx == (*iter).second[index])
	break;
      if(index == (*iter).second.size() - 1)
	assert(0);
    }

  assert(sys->Has_Pipe(pipe_id));
  int pipe_width = sys->Get_Pipe_Width(pipe_id);

  if((pid.find("req") != string::npos) || (pid.find("ack") != string::npos))
    return(port_name +  "(" + IntToStr(down_index) + ")");
  else if(pid.find("data") != string::npos)
    return(port_name + "(" 
	   + IntToStr(((down_index+1)*pipe_width)-1) + " downto "
	   + IntToStr(down_index*pipe_width) + ")");
  else
    assert(0); // fatal
}


void vcDataPath::Print_VHDL_Call_Instances(ostream& ofile)
{ 
  // print LoadReqShared instance and LoadCompleteShared instance.
  for(int idx = 0; idx < this->_compatible_call_groups.size(); idx++)
    { // for each operator group.

      // number of requesters.
      int num_reqs = _compatible_call_groups[idx].size();

      // to collect inwires, outwires and reqs/acks.
      vector<vcWire*> inwires;
      vector<vcTransition*> reqL;
      vector<vcTransition*> ackL;
      vector<vcTransition*> reqR;
      vector<vcTransition*> ackR;
      vector<vcWire*> outwires;

      // to keep track of the ids of the operators in this group.
      vector<string> elements;

      vcModule* called_module = NULL;

      // ok. collect all the information..
      for(set<vcDatapathElement*>::iterator iter = _compatible_call_groups[idx].begin();
	  iter != _compatible_call_groups[idx].end();
	  iter++)
	{

	  assert((*iter)->Is("vcCall"));
	  vcCall* so = (vcCall*) (*iter);

	  if(called_module == NULL)
	    called_module = so->Get_Called_Module();
	  else
	    assert(called_module == so->Get_Called_Module());

	  elements.push_back(so->Get_VHDL_Id());
	  so->Append_Inwires(inwires);
	  so->Append_Outwires(outwires);
	  reqL.push_back(so->Get_Req(0));
	  ackL.push_back(so->Get_Ack(0));
	  reqR.push_back(so->Get_Req(1));
	  ackR.push_back(so->Get_Ack(1));
	}
      assert(called_module != NULL);

      int tag_length = called_module->Get_Caller_Tag_Length();

      // total in-width 
      int in_width = 0;
      for(int u = 0; u < inwires.size(); u++)
	{
	  in_width += inwires[u]->Get_Size();
	}
      assert(in_width == called_module->Get_In_Arg_Width() * num_reqs);

      // total out-width..
      int out_width = 0;
      for(int u = 0; u < outwires.size(); u++)
	{
	  out_width += outwires[u]->Get_Size();
	}
      assert(out_width == called_module->Get_Out_Arg_Width() * num_reqs);

      // VHDL code for this shared group
      ofile << "-- shared call operator group (" << idx << ") : " ;
      for(int u = 0; u < elements.size(); u++)
	ofile << elements[u] << " ";
      ofile << endl;


      // make a block
      ofile << "CallGroup" << idx << ": Block -- {" << endl;
      // in and out data.
      ofile << "signal data_in: std_logic_vector(" << in_width-1 << " downto 0);" << endl;
      ofile << "signal data_out: std_logic_vector(" << out_width-1 << " downto 0);" << endl;
      // in and out acks.
      ofile << "signal reqR, ackR, reqL, ackL : BooleanArray( " << num_reqs-1 << " downto 0);" << endl;

      ofile << "-- }\n begin -- {" << endl;

      this->Print_VHDL_Concatenate_Req("reqL",reqL,ofile);
      this->Print_VHDL_Disconcatenate_Ack("ackL",ackL,ofile);
      this->Print_VHDL_Concatenate_Req("reqR",reqR,ofile);
      this->Print_VHDL_Disconcatenate_Ack("ackR",ackR,ofile);
	
      // concatenate data_in
      this->Print_VHDL_Concatenation(string("data_in"), inwires,ofile);
      // disconcatenate data_out
      this->Print_VHDL_Disconcatenation(string("data_out"), out_width, outwires,ofile);

      vcModule* m = this->Get_Parent();
      // now the operator instances 
      string imux_name = ((called_module->Get_In_Arg_Width() > 0) ?
			  "InputMuxBase" : "InputMuxBaseNoData");

      ofile << "CallReq: " << imux_name << " -- {" << endl;
      ofile << "generic map ( ";

      if(called_module->Get_In_Arg_Width() > 0)
	{
	  ofile << " iwidth => " << in_width << ","
		<< " owidth => " << in_width/num_reqs << ",";
	}

      ofile << " twidth => " << tag_length << ","
	    << " nreqs => " << num_reqs << ","
	    << "  no_arbitration => true)" << endl;
      ofile << "port map ( -- { \n reqL => reqL " << ", " <<  endl
	    << "    ackL => ackL " << ", " <<  endl;

      if(called_module->Get_In_Arg_Width() > 0)
	ofile << "    dataL => data_in, " << endl;

      ofile << "    reqR => " 
	    << called_module->Get_VHDL_Call_Interface_Port_Section(m,"call", "call_reqs", idx)  << "," << endl
	    << "    ackR => " 
	    << called_module->Get_VHDL_Call_Interface_Port_Section(m, "call", "call_acks", idx)  << "," << endl;

      if(called_module->Get_In_Arg_Width() > 0)
	ofile << "    dataR => " 
	      << called_module->Get_VHDL_Call_Interface_Port_Section(m, "call", "call_data",idx) << "," << endl;

      
      ofile << "    tagR => "  
	    << called_module->Get_VHDL_Call_Interface_Port_Section(m , "call", "call_tag",idx) << "," << endl
	    << "  clk => clk, reset => reset -- }\n); -- }" << endl;


      string omux_name = ((called_module->Get_Out_Arg_Width() > 0) ?
			  "OutputDemuxBase" : "OutputDemuxBaseNoData");
      ofile << "CallComplete: " << omux_name << " -- {" << endl;
      ofile << "generic map ( " << endl;
      if(called_module->Get_Out_Arg_Width() > 0)
	{
	  ofile << "iwidth => " << out_width/num_reqs << ","
		<< " owidth => " << out_width << ","; 
	}

      ofile << " twidth => " << tag_length << ","
	    << " nreqs => " << num_reqs << ","
	    << "  no_arbitration => true)" << endl;
      ofile << "port map ( -- {\n reqR => reqR " << ", " <<  endl
	    << "    ackR => ackR " << ", " <<  endl;

      if(called_module->Get_Out_Arg_Width() > 0)
	ofile << "    dataR => data_out, " << endl;

      ofile << "    reqL => " 
	    << called_module->Get_VHDL_Call_Interface_Port_Section(m,"return", "return_acks", idx)  << ", -- cross-over" << endl
	    << "    ackL => " 
	    << called_module->Get_VHDL_Call_Interface_Port_Section(m,"return", "return_reqs", idx)  << ", -- cross-over" << endl;

      if(called_module->Get_Out_Arg_Width() > 0)
	{
	  ofile << "    dataL => " 
		<< called_module->Get_VHDL_Call_Interface_Port_Section(m,"return", "return_data", idx)  << "," << endl;
	}

      ofile << "    tagL => "  
	    << called_module->Get_VHDL_Call_Interface_Port_Section(m, "return", "return_tag", idx)  << "," << endl
	    << "  clk => clk," << endl
	    << " reset => reset -- }\n); -- }" << endl;
      ofile << "-- }\n end Block; -- call group " << idx << endl; // thats it..
    }
}


string vcDataPath::Print_VHDL_Memory_Interface_Port_Map(string comma, ostream& ofile)
{
  // in progress
  set<vcMemorySpace*,vcRoot_Compare> ms_set;
  vcMemorySpace* ms;
  vcModule* parent_module = this->Get_Parent();

  // first the loads
  for(int idx = 0; idx < _compatible_load_groups.size(); idx++)
    {
      ms = ((vcLoad*) (*(_compatible_load_groups[idx].begin())))->Get_Memory_Space();
      ms_set.insert(ms);
    }

  for(set<vcMemorySpace*,vcRoot_Compare>::iterator iter = ms_set.begin();
      iter != ms_set.end();
      iter++)
    {
      ms = (*iter);

      int hindex, lindex;
      if(ms->Get_Caller_Module_Section(parent_module,"load",hindex,lindex))
	{
	  ofile << comma << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lr_req") << " => " <<
	    ms->Get_Aggregate_Section("lr_req", hindex, lindex) << "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lr_ack") << " => " <<
	    ms->Get_Aggregate_Section("lr_ack", hindex, lindex) << "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lr_addr") << " => " << 
	    ms->Get_Aggregate_Section("lr_addr", hindex, lindex) << "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lr_tag") << " => " << 
	    ms->Get_Aggregate_Section("lr_tag", hindex, lindex) << "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lc_req") << " => " << 
	    ms->Get_Aggregate_Section("lc_req", hindex, lindex)<< "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lc_ack") << " => " << 
	    ms->Get_Aggregate_Section("lc_ack", hindex, lindex)<< "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lc_data") << " => " << 
	    ms->Get_Aggregate_Section("lc_data", hindex, lindex)<< "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("lc_tag") << " => " << 
	    ms->Get_Aggregate_Section("lc_tag", hindex, lindex);
	  comma = ",";
	}
    }
  

  ms_set.clear();

  // now the stores
  for(int idx = 0; idx < _compatible_store_groups.size(); idx++)
    {
      ms = ((vcLoad*) (*(_compatible_store_groups[idx].begin())))->Get_Memory_Space();
      ms_set.insert(ms);
    }

  for(set<vcMemorySpace*,vcRoot_Compare>::iterator iter = ms_set.begin();
      iter != ms_set.end();
      iter++)
    {
      ms = (*iter);

      int hindex, lindex;
      if(ms->Get_Caller_Module_Section(parent_module,"store",hindex,lindex))
	{
	  ofile << comma << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_req") << " => " <<
	    ms->Get_Aggregate_Section("sr_req", hindex, lindex) << "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_ack") << " => " <<
	    ms->Get_Aggregate_Section("sr_ack", hindex, lindex) << "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_addr") << " => " << 
	    ms->Get_Aggregate_Section("sr_addr", hindex, lindex) << "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_data") << " => " << 
	    ms->Get_Aggregate_Section("sr_data", hindex, lindex)<< "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sr_tag") << " => " << 
	    ms->Get_Aggregate_Section("sr_tag", hindex, lindex) << "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sc_req") << " => " << 
	    ms->Get_Aggregate_Section("sc_req", hindex, lindex)<< "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sc_ack") << " => " << 
	    ms->Get_Aggregate_Section("sc_ack", hindex, lindex)<< "," << endl;
	  ofile << ms->Get_VHDL_Memory_Interface_Port_Name("sc_tag") << " => " << 
	    ms->Get_Aggregate_Section("sc_tag", hindex, lindex);
	  comma = ",";
	}
    }
  return(comma);
}

string vcDataPath::Print_VHDL_IO_Interface_Port_Map(string comma, ostream& ofile)
{
  set<string> pipe_id_set;
  string pipe_id;
  vcModule* parent_module = this->Get_Parent();

  for(int idx = 0; idx < _compatible_inport_groups.size(); idx++)
    {
      pipe_id = ((vcInport*) (*(_compatible_inport_groups[idx].begin())))->Get_Pipe_Id();
      pipe_id_set.insert(pipe_id);
    }

  for(set<string>::iterator iter = pipe_id_set.begin();
      iter != pipe_id_set.end();
      iter++)
    {
      pipe_id = (*iter);

      int hindex, lindex;
      if(parent_module->Get_Parent()->Get_Pipe_Module_Section(pipe_id, parent_module,"read", hindex,lindex))
	{
	  ofile << comma << endl;
	  ofile << parent_module->Get_Parent()->Get_VHDL_Pipe_Interface_Port_Name(pipe_id,
										  "read_req") 
		<< " => " 
		<< parent_module->Get_Parent()->Get_Pipe_Aggregate_Section(pipe_id,
									   "read_req", 
									   hindex, 
									   lindex) 
		<< "," << endl;
	  ofile << parent_module->Get_Parent()->Get_VHDL_Pipe_Interface_Port_Name(pipe_id,"read_ack") 
		<< " => " 
		<< parent_module->Get_Parent()->Get_Pipe_Aggregate_Section(pipe_id,
									   "read_ack", 
									   hindex, 
									   lindex) 
		<< "," << endl;
	  ofile << parent_module->Get_Parent()->Get_VHDL_Pipe_Interface_Port_Name(pipe_id,"read_data") 
		<< " => " 
		<< parent_module->Get_Parent()->Get_Pipe_Aggregate_Section(pipe_id,
									   "read_data", 
									   hindex, 
									   lindex);
	  comma = ",";
	}
    }

  pipe_id_set.clear();
  for(int idx = 0; idx < _compatible_outport_groups.size(); idx++)
    {
      pipe_id = ((vcOutport*) (*(_compatible_outport_groups[idx].begin())))->Get_Pipe_Id();
      pipe_id_set.insert(pipe_id);
    }

  for(set<string>::iterator iter = pipe_id_set.begin();
      iter != pipe_id_set.end();
      iter++)
    {
      pipe_id = (*iter);

      int hindex, lindex;
      if(parent_module->Get_Parent()->Get_Pipe_Module_Section(pipe_id, parent_module,"write",hindex,lindex))
	{
	  ofile << comma << endl;
	  ofile << parent_module->Get_Parent()->Get_VHDL_Pipe_Interface_Port_Name(pipe_id,"write_req") 
		<< " => " 
		<< parent_module->Get_Parent()->Get_Pipe_Aggregate_Section(pipe_id,
									   "write_req", 
									   hindex, 
									   lindex) 
		<< "," << endl;
	  ofile << parent_module->Get_Parent()->Get_VHDL_Pipe_Interface_Port_Name(pipe_id,"write_ack") 
		<< " => " 
		<< parent_module->Get_Parent()->Get_Pipe_Aggregate_Section(pipe_id,
									   "write_ack", 
									   hindex, 
									   lindex) 
		<< "," << endl;
	  ofile << parent_module->Get_Parent()->Get_VHDL_Pipe_Interface_Port_Name(pipe_id,"write_data") 
		<< " => " 
		<< parent_module->Get_Parent()->Get_Pipe_Aggregate_Section(pipe_id,
									   "write_data", 
									   hindex, 
									   lindex);

	  comma = ",";
	}
    }

  return(comma);
}

string vcDataPath::Print_VHDL_Call_Interface_Port_Map(string comma, ostream& ofile)
{
  set<vcModule*,vcRoot_Compare> called_module_set;
  vcModule* called_module;
  vcModule* parent_module = this->Get_Parent();

  for(int idx = 0; idx < _compatible_call_groups.size(); idx++)
    {
      called_module = ((vcCall*) (*(_compatible_call_groups[idx].begin())))->Get_Called_Module();
      called_module_set.insert(called_module);
    }

  for(set<vcModule*,vcRoot_Compare>::iterator iter = called_module_set.begin();
      iter != called_module_set.end();
      iter++)
    {
      called_module = (*iter);

      int hindex, lindex;
      if(called_module->Get_Caller_Module_Section(parent_module,hindex,lindex))
	{
	  ofile << comma << endl;
	  ofile << called_module->Get_VHDL_Call_Interface_Port_Name("call_reqs") << " => " <<
	    called_module->Get_Aggregate_Section("call_reqs", hindex, lindex) << "," << endl;
	  ofile << called_module->Get_VHDL_Call_Interface_Port_Name("call_acks") << " => " <<
	    called_module->Get_Aggregate_Section("call_acks", hindex, lindex) << "," << endl;

	  if(called_module->Get_In_Arg_Width() > 0)
	    {
	      ofile << called_module->Get_VHDL_Call_Interface_Port_Name("call_data") << " => " << 
		called_module->Get_Aggregate_Section("call_data", hindex, lindex) << "," << endl;
	    }

	  ofile << called_module->Get_VHDL_Call_Interface_Port_Name("call_tag") << " => " << 
	    called_module->Get_Aggregate_Section("call_tag", hindex, lindex) << "," << endl;
	  ofile << called_module->Get_VHDL_Call_Interface_Port_Name("return_reqs") << " => " << 
	    called_module->Get_Aggregate_Section("return_reqs", hindex, lindex)<< "," << endl;
	  ofile << called_module->Get_VHDL_Call_Interface_Port_Name("return_acks") << " => " << 
	    called_module->Get_Aggregate_Section("return_acks", hindex, lindex)<< "," << endl;

	  if(called_module->Get_Out_Arg_Width() > 0)
	    {
	      ofile << called_module->Get_VHDL_Call_Interface_Port_Name("return_data") << " => " << 
		called_module->Get_Aggregate_Section("return_data", hindex, lindex)<< "," << endl;
	    }


	  ofile << called_module->Get_VHDL_Call_Interface_Port_Name("return_tag") << " => " << 
	    called_module->Get_Aggregate_Section("return_tag", hindex, lindex);
	  comma = ",";
	}
    }
  return(comma);
}
