#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcOperator.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>

vcModule::vcModule(string module_name):vcRoot(module_name)
{
  this->_control_path = NULL;
  this->_data_path = NULL;
}
void vcModule::Set_Data_Path(vcDataPath* dp)
{
  assert(dp != NULL);
  assert(this->_data_path == NULL);
  this->_data_path = dp;
}

void vcModule::Add_Phi_Link(vcPhi* phi, vector<vcTransition*>& inreqs, vcTransition* outack)
{
  this->_phi_link_map[phi].first = inreqs;
  this->_phi_link_map[phi].second = outack;
}

void vcModule::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__MODULE] << " " <<  this->Get_Label() << " {" << endl;
  if(this->_input_arguments.size() > 0)
    {
      ofile << vcLexerKeywords[__IN] << " ";
      for(map<string,vcWire*>::iterator iter = this->_input_arguments.begin();
	  iter != this->_input_arguments.end();
	  iter++)
	{
	  ofile << (*iter).first << vcLexerKeywords[__COLON];
	  (*iter).second->Get_Type()->Print(ofile);
	  ofile << " ";
	}
      ofile << endl;
    }
  if(this->_output_arguments.size() > 0)
    {
      ofile << vcLexerKeywords[__OUT] << " ";
      for(map<string,vcWire*>::iterator iter = this->_output_arguments.begin();
	  iter != this->_output_arguments.end();
	  iter++)
	{
	  ofile << (*iter).first << vcLexerKeywords[__COLON];
	  (*iter).second->Get_Type()->Print(ofile);
	  ofile << " ";
	}
      ofile << endl;
    }

  if(this->_memory_space_map.size() > 0)
    {
      for(map<string,vcMemorySpace*>::iterator iter = this->_memory_space_map.begin();
	  iter != this->_memory_space_map.end();
	  iter++)
	{
	  (*iter).second->Print(ofile);
	}
    }

  if(this->_control_path != NULL)
    this->_control_path->Print(ofile);

  if(this->_data_path != NULL)
    this->_data_path->Print(ofile);


  if(this->_link_map.size() > 0)
    {
      for(map<vcTransition*,pair<vcDatapathElement*,string> >::iterator iter = this->_link_map.begin();
	  iter != this->_link_map.end();
	  iter++)
	{
	  ofile << vcLexerKeywords[__LINK] << " " << (*iter).first->Get_Hierarchical_Id() << " ";
	  ofile << vcLexerKeywords[__EQUIVALENT] << " ";
	  ofile << (*iter).second.first->Get_Id() << vcLexerKeywords[__SLASH] << (*iter).second.second << endl;
	}
    }

  if(this->_phi_link_map.size() > 0)
    {
      for(map<vcPhi*,pair<vector<vcTransition*>, vcTransition*> >::iterator iter = this->_phi_link_map.begin();
	  iter != this->_phi_link_map.end();
	  iter++)
	{
	  ofile << vcLexerKeywords[__PHI] << " " << vcLexerKeywords[__LINK] << " " 
		<< (*iter).first->Get_Id() << " ";
	  ofile << vcLexerKeywords[__REQS] << " ";
	  for(int idx = 0; idx < (*iter).second.first.size(); idx++)
	    {
	      ofile << (*iter).second.first[idx]->Get_Hierarchical_Id() << " ";
	    }
	  ofile << vcLexerKeywords[__ACKS] << " ";
	  ofile << (*iter).second.second->Get_Hierarchical_Id() << endl;
	}
    }

  this->Print_Attributes(ofile);
  ofile << "}" << endl;
}

void vcModule::Add_Link(vector<string>& transition_ref, string dpe_name, string dpe_req_ack_name)
{
  pair<vcDatapathElement*,string> add_pair;
  vcTransition* trans = this->_control_path->Find_Transition(transition_ref);
  vcDatapathElement* dpe = this->_data_path->Find_DPE(dpe_name);

  assert(trans != NULL && dpe != NULL && dpe->Get_Template() != NULL);

  if(trans->Get_Transition_Type() == _IN_TRANSITION)
    assert(dpe->Get_Template()->Is_Ack(dpe_req_ack_name));
  else if(trans->Get_Transition_Type() == _OUT_TRANSITION)
    assert(dpe->Get_Template()->Is_Req(dpe_req_ack_name));
  else
    assert(0 && "link cannot be made with a hidden transition");


  add_pair.first = dpe;
  add_pair.second = dpe_req_ack_name;

  this->_link_map[trans] = add_pair;
  dpe->Add_Link(trans,dpe_req_ack_name);
}

void vcModule::Add_Memory_Space(vcMemorySpace* ms)
{
  assert(ms != NULL && (this->_memory_space_map.find(ms->Get_Id())  == this->_memory_space_map.end()));
  this->_memory_space_map[ms->Get_Id()] = ms;
}
vcMemorySpace* vcModule::Find_Memory_Space(string ms_name)
{
  map<string, vcMemorySpace*>::iterator iter = this->_memory_space_map.find(ms_name);
  if(iter != this->_memory_space_map.end())
    return((*iter).second);
  else
    return(NULL);
}
vcType* vcModule::Get_Argument_Type(string arg_name, string mode /* "in" or "out" */)
{
  vcType* ret_type = NULL;
  map<string,vcWire*>::iterator iter;
  if(mode == "in")
    {
      iter = this->_input_arguments.find(arg_name);
      if(iter != this->_input_arguments.end())
	ret_type = (*iter).second->Get_Type();
    }
  else
    {
      iter = this->_output_arguments.find(arg_name);
      if(iter != this->_output_arguments.end())
	ret_type = (*iter).second->Get_Type();
    }
  return(ret_type);
}

void vcModule::Add_Argument(string arg_name, string mode, vcType* t)
{
  if(mode == "in")
    {
      this->_ordered_input_arguments.push_back(arg_name);
      this->_input_arguments[arg_name] = new vcInputWire(arg_name,t);
    }
  else
    {
      this->_ordered_output_arguments.push_back(arg_name);
      this->_output_arguments[arg_name] = new vcOutputWire(arg_name,t);
    }
}


vcWire* vcModule::Get_Argument(string arg_name, string mode)
{
  vcWire* ret_wire = NULL;
  map<string,vcWire*>::iterator iter;
  if(mode == "in")
    {
      iter = this->_input_arguments.find(arg_name);
      if(iter != this->_input_arguments.end())
	{
	  ret_wire = ((*iter).second);
	}
    }
  else 
    {
      iter = this->_output_arguments.find(arg_name);
      if(iter != this->_output_arguments.end())
	{
	  ret_wire = ((*iter).second);
	}
    }
  return(ret_wire);
}

void vcModule::Check_Control_Structure()
{
  this->_control_path->Check_Structure();
}
void vcModule::Compute_Compatibility_Labels()
{
  this->_control_path->Compute_Compatibility_Labels();
}
void vcModule::Print_Control_Structure(ostream& ofile)
{
  this->_control_path->Print_Structure(ofile);
  this->_control_path->Print_Compatibility_Labels(ofile);
}
void vcModule::Print_VHDL(ostream& ofile)
{
  assert(0);
}
