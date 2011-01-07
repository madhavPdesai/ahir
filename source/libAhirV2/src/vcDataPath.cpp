#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcValue.hpp>
#include <vcControlPath.hpp>
#include <vcOperator.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>

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

vcInputWire::vcInputWire(string id, vcType* t): vcWire(id,t)
{
}

vcOutputWire::vcOutputWire(string id, vcType* t): vcWire(id,t)
{
}

vcDatapathElementTemplate::vcDatapathElementTemplate(vcDatapathElementLibrary* lib, string id):vcRoot(id)
{
  this->_library = lib;
}
 

bool vcDatapathElementTemplate::Is_Legal_Parameter_Value(string pname, int val)
{
  bool ret_val = false;
  map<string,pair<int,int> >::iterator iter = this->_parameter_limit_map.find(pname);
  if(iter != this->_parameter_limit_map.end())
    {
      ret_val = (((*iter).second.first <= val) && ((*iter).second.second >= val));
    }
  return(ret_val);
}

void vcDatapathElementTemplate::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__DPE] << " [" << this->Get_Id() << "] {" << endl;

  // parameters
  if(this->_parameter_limit_map.size() > 0)
    {
      ofile << vcLexerKeywords[__PARAMETER] << " ";
      for(map<string,pair<int,int> >::iterator iter = this->_parameter_limit_map.begin();
	  iter != this->_parameter_limit_map.end();
	  iter++)
	{
	  ofile << (*iter).first << " " << vcLexerKeywords[__MIN] << " " << ((*iter).second).first;
	  ofile << " " << vcLexerKeywords[__MAX] << " " << ((*iter).second).second << " ";
	}
      ofile << endl;
    }

  // input ports
  if(this->_input_port_map.size() > 0)
    {
      ofile << vcLexerKeywords[__IN] << " " ;
      for(map<string,vcScalarTypeTemplate* >::iterator iiter = this->_input_port_map.begin();
	  iiter != this->_input_port_map.end();
	  iiter++)
	{
	  ofile << (*iiter).first << vcLexerKeywords[__COLON] << " ";
	  (*iiter).second->Print(ofile);
	  ofile << " ";
	}
      
      ofile << endl;
    }

  // output ports
  if(this->_output_port_map.size() > 0)
    {
      ofile << vcLexerKeywords[__OUT] << " " ;
      for(map<string,vcScalarTypeTemplate* >::iterator oiter = this->_output_port_map.begin();
	  oiter != this->_output_port_map.end();
	  oiter++)
	{
	  ofile << (*oiter).first << vcLexerKeywords[__COLON] << " ";
	  (*oiter).second->Print(ofile);
	  ofile << " ";
	}
      
      ofile << endl;
    }

  // reqs
  if(this->_reqs.size() > 0)
    {
      ofile << vcLexerKeywords[__REQS] << " " ;
      for(set<string>::iterator siter = this->_reqs.begin();
	  siter != this->_reqs.end();
	  siter++)
	{
	  ofile << *siter << " ";
	}
      ofile << endl;
    }


  // acks
  if(this->_acks.size() > 0)
    {
      ofile << vcLexerKeywords[__ACKS] << " " ;
      for(set<string>::iterator aiter = this->_acks.begin();
	  aiter != this->_acks.end();
	  aiter++)
	{
	  ofile << *aiter << " ";
	}
      ofile << endl;
    }

  this->Print_Attributes(ofile);
  ofile << "}" << endl;
}


vcDatapathElementLibrary::vcDatapathElementLibrary(string id):vcRoot(id)
{
}
void vcDatapathElementLibrary::Add_Template(vcDatapathElementTemplate* t)
{
  assert(this->_templates.find(t->Get_Id()) == this->_templates.end());
  this->_templates[t->Get_Id()] = t;
}
vcDatapathElementTemplate* vcDatapathElementLibrary::Get_Template(string template_name)
{
  vcDatapathElementTemplate* rt = NULL;
  map<string,vcDatapathElementTemplate*>::iterator iter = this->_templates.find(template_name);
  if(iter != this->_templates.end())
    rt = (*iter).second;
  return(rt);
}
void vcDatapathElementLibrary::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__LIBRARY] << " [" << this->Get_Id() << "] {" << endl;
  for(map<string,vcDatapathElementTemplate*>::iterator iter = this->_templates.begin();
      iter != this->_templates.end();
      iter++)
    {
      ((*iter).second)->Print(ofile);
    }
  this->Print_Attributes(ofile);
  ofile << "}" << endl;
}


vcDatapathElement::vcDatapathElement(string id, vcDatapathElementTemplate* t):vcRoot(id)
{
  assert(t != NULL);
  this->_template = t;
}

void vcDatapathElement::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__DPEINSTANCE] 
	<< " [" << this->Get_Id()<< "] " 
	<<  vcLexerKeywords[__LIBRARY] << " " << this->Get_Template()->Get_Library()->Get_Id() << " " 
	<< vcLexerKeywords[__DPE] << " " << this->Get_Template()->Get_Id() << " " << "{" << endl;
  
  if(this->_parameter_value_map.size() > 0)
    {
      ofile << vcLexerKeywords[__PARAMETER] << " " << vcLexerKeywords[__MAP] << " ";
      for(map<string,int>::iterator miter = this->_parameter_value_map.begin();
	  miter != this->_parameter_value_map.end();
	  miter++)
	{
	  ofile << (*miter).first << " " << vcLexerKeywords[__IMPLIES] << " " << (*miter).second << " " << endl;
	}
    }

  if(this->_port_map.size() > 0)
    {
      ofile << vcLexerKeywords[__PORT] << " " << vcLexerKeywords[__MAP] << " ";
      for(map<string,vcWire*>::iterator miter = this->_port_map.begin();
	  miter != this->_port_map.end();
	  miter++)
	{
	  ofile << (*miter).first << " " << vcLexerKeywords[__IMPLIES] << " " << (*miter).second->Get_Id() << " " ;
	}
    }

  this->Print_Attributes(ofile);
  ofile << "}" << endl;
}


bool vcDatapathElement::Is_Parameter(string id)
{
  return(this->_template->Is_Parameter(id));
}

void vcDatapathElement::Set_Parameter(string id, int val)
{
  if(this->_template->Is_Parameter(id) && this->_template->Is_Legal_Parameter_Value(id,val))
    {
      this->_parameter_value_map[id] = val;
    }
}

int  vcDatapathElement::Get_Parameter(string id)
{
  map<string,int>::iterator iter = this->_parameter_value_map.find(id);
  if(iter != this->_parameter_value_map.end())
    return((*iter).second);
  else
    return(-1);
}

vcWire* vcDatapathElement::Get_Connected_Wire(string port_name)
{
  map<string,vcWire*>::iterator iter = this->_port_map.find(port_name);
  if(iter != this->_port_map.end())
    return((*iter).second);
  else
    return(NULL);
}

string vcDatapathElement::Get_Connected_Port(vcWire* w)
{
  map<vcWire*,string, vcRoot_Compare>::iterator iter = this->_reverse_port_map.find(w);
  if(iter != this->_reverse_port_map.end())
    return((*iter).second);
  else
    return("");
}


vcDataPath::vcDataPath(vcModule* m, string id):vcRoot(id)
{
  this->_parent = m;
}



void vcDataPath::Add_DPE(vcDatapathElement* t)
{
  assert(t != NULL);
  assert(this->_dpe_map.find(t->Get_Id()) == this->_dpe_map.end());
  this->_dpe_map[t->Get_Id()] = t;
}

vcDatapathElement* vcDataPath::Find_DPE(string dpe_name)
{
  map<string, vcDatapathElement*>::iterator iter = this->_dpe_map.find(dpe_name);
  if(iter != this->_dpe_map.end())
    return((*iter).second);
  else
    return(NULL);
}

void vcDataPath::Add_Phi(vcPhi* p)
{
  assert(p != NULL);
  assert(this->_phi_map.find(p->Get_Id()) == this->_phi_map.end());

  this->_phi_map[p->Get_Id()] = p;
}
vcPhi* vcDataPath::Find_Phi(string pname)
{
  if(this->_phi_map.find(pname) != this->_phi_map.end())
    return((*(this->_phi_map.find(pname))).second);
  else
    return(NULL);
}
void vcDataPath::Set_DPE_Parameter(string dpe_name, string param_name, int param_value)
{
  vcDatapathElement* dpe = this->Find_DPE(dpe_name);
  if(dpe != NULL)
    {
      dpe->Set_Parameter(param_name,param_value);
    }
}
int vcDataPath::Get_DPE_Parameter(string dpe_name, string param_name)
{
  vcDatapathElement* dpe = this->Find_DPE(dpe_name);
  if(dpe != NULL)
    {
      return(dpe->Get_Parameter(param_name));
    }
  else
    return(-1);
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
  return(ret_wire);
}

void vcDataPath::Add_Wire(string wname, vcType* t)
{
  assert(this->Find_Wire(wname) == NULL);
  this->_wire_map[wname] = new vcWire(wname, t);
}

void vcDataPath::Add_Constant_Wire(string wname, vcValue* v)
{
  assert(v != NULL);
  vcType* t = v->Get_Type();
  assert(!(t->Is("vcArrayType") || t->Is("vcRecordType")));
  this->_wire_map[wname] = (vcWire*) ( new vcConstantWire(wname,v));
};

void vcDataPath::Connect_Wire(string dpe_name, string port_name, vcWire* w)
{
  vcDatapathElement* dpe = this->Find_DPE(dpe_name);
  assert(dpe != NULL);

  if(dpe->Get_Template()->Is_Input_Port(port_name))
    {
      dpe->Connect_Wire(port_name,w);
      w->Connect_Receiver(dpe);
    }
  else   if(dpe->Get_Template()->Is_Output_Port(port_name))
    {
      dpe->Connect_Wire(port_name,w);
      w->Connect_Driver(dpe);
    }
}

#define __PRINT_MAP(_map_id,_map_iter,ofile)  for(_map_iter=_map_id.begin();_map_iter!=_map_id.end();_map_iter++)\
    { (*_map_iter).second->Print(ofile);}

void vcDataPath::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__DATAPATH] << " { " << endl;

  map<string,vcWire*>::iterator wires;
  __PRINT_MAP(_wire_map,wires,ofile);

  map<string,vcDatapathElement*>::iterator dpes;
  __PRINT_MAP(_dpe_map,dpes,ofile);

  map<string,vcPhi*>::iterator phis;
  __PRINT_MAP(_phi_map,phis,ofile);

  map<string,vcPhi*>::iterator selects;
  __PRINT_MAP(_select_map,selects,ofile);

  map<string,vcPhi*>::iterator branches;
  __PRINT_MAP(_branch_map,branches,ofile);

  map<string,vcLoad*>::iterator loads;
  __PRINT_MAP(_load_map,loads,ofile);

  map<string,vcStore*>::iterator stores;
  __PRINT_MAP(_store_map,stores,ofile);

  map<string,vcStore*>::iterator operators;
  __PRINT_MAP(_operator_map,operators,ofile);

  map<string,vcStore*>::iterator split_operators;
  __PRINT_MAP(_split_operator_map,split_operators,ofile);

  this->Print_Attributes(ofile);
  ofile << "} " << endl;
}

#define _ADD(_map_id,_id,_ptr) _map_id[_id]=_ptr
#define __FIND(_map_id,_id) (_map_id.find(_id) != _map_id.end() ? _map_id[_id] : NULL) 

void vcDataPath::Add_Load(vcLoad* ld) {_ADD(_load_map,ld->Get_Id(), ld);}
vcLoad* vcDataPath::Find_Load(string id) {return(__FIND(_load_map,id));}

void vcDataPath::Add_Store(vcStore* st) {_ADD(_store_map,st->Get_Id(), st);}
vcStore* vcDataPath::Find_Store(string id)  {return(__FIND(_store_map,id));}


void vcDataPath::Add_Call(vcCall* c)  {_ADD(_call_map,c->Get_Id(), c);}
vcCall* vcDataPath::Find_Call(string id) {return(__FIND(_call_map,id));}

void vcDataPath::Add_Inport(vcInport* p) {_ADD(_inport_map,p->Get_Id(), p);}
vcInport* vcDataPath::Find_Inport(string id) {return(__FIND(_inport_map,id));}

void vcDataPath::Add_Outport(vcOutport* p) {_ADD(_outport_map,p->Get_Id(), p);}
vcOutport* vcDataPath::Find_Outport(string id) {return(__FIND(_outport_map,id));}

void vcDataPath::Add_Operator(vcOperator* p)  {_ADD(_operator_map,p->Get_Id(), p);}
vcOperator* vcDataPath::Find_Operator(string id){return(__FIND(_operator_map,id));}

void vcDataPath::Add_Split_Operator(vcSplitOperator* p)  {_ADD(_split_operator_map,p->Get_Id(), p);}
vcSplitOperator* vcDataPath::Find_Split_Operator(string id) {return(__FIND(_split_operator_map,id));}

void vcDataPath::Add_Select(vcSelect* p)   {_ADD(_select_map,p->Get_Id(), p);}
vcSelect* vcDataPath::Find_Select(string id) {return(__FIND(_select_map,id));}

void vcDataPath::Add_Branch(vcBranch* p)  {_ADD(_branch_map,p->Get_Id(), p);}
vcBranch* vcDataPath::Find_Branch(string id) {return(__FIND(_branch_map,id));}
