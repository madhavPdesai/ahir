#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>


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

vcDatapathElementTemplate::vcDatapathElementTemplate(string id):vcRoot(id)
{
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
  for(map<string,pair<int,int> >::iterator iter = this->_parameter_limit_map.begin();
      iter != this->_parameter_limit_map.end();
      iter++)
    {
      ofile << vcLexerKeywords[__PARAMETER] << " " << vcLexerKeywords[__LPAREN] << " ";
      ofile << (*iter).first << " " << vcLexerKeywords[__MIN] << " " << ((*iter).second).first;
      ofile << " " << vcLexerKeywords[__MAX] << " " << ((*iter).second).second << vcLexerKeywords[__RPAREN] << endl;
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
	<<  vcLexerKeywords[__OF] 
	<< " [" << this->Get_Template()->Get_Id() << "] " << "{" << endl;
  
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
	  ofile << (*miter).first << " " << vcLexerKeywords[__IMPLIES] << " " << (*miter).second->Get_Id() << " " << endl;
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


vcDataPath::vcDataPath(string id):vcRoot(id)
{
}

void vcDataPath::Add_DPE(string dpe_name, vcDatapathElementTemplate* t)
{
  assert(this->_dpe_map.find(dpe_name) == this->_dpe_map.end());
  this->_dpe_map[dpe_name] = new vcDatapathElement(dpe_name,t);
}

vcDatapathElement* vcDataPath::Find_DPE(string dpe_name)
{
  map<string, vcDatapathElement*>::iterator iter = this->_dpe_map.find(dpe_name);
  if(iter != this->_dpe_map.end())
    return((*iter).second);
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
  map<string, vcWire*>::iterator iter = this->_wire_map.find(wname);
  if(iter != this->_wire_map.end())
    return((*iter).second);
  else
    return(NULL);
}

void vcDataPath::Add_Wire(string wname, vcType* t)
{
  assert(this->Find_Wire(wname) == NULL);
  this->_wire_map[wname] = new vcWire(wname, t);
}

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

void vcDataPath::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__DATAPATH] << " { " << endl;
  for(map<string,vcWire*>::iterator iter = this->_wire_map.begin();
      iter != this->_wire_map.end();
      iter++)
    {
      (*iter).second->Print(ofile);
    }

  for(map<string,vcDatapathElement*>::iterator iter = this->_dpe_map.begin();
      iter != this->_dpe_map.end();
      iter++)
    {
      (*iter).second->Print(ofile);
    }

  this->Print_Attributes(ofile);
  ofile << "} " << endl;
}
