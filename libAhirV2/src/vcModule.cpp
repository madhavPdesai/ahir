#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>

vcModule::vcModule(string module_name):vcRoot(module_name)
{
}
void vcModule::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__MODULE] << " " <<  this->Get_Label() << " {" << endl;
  if(this->_input_arguments.size() > 0)
    {
      ofile << vcLexerKeywords[__IN] << " " << vcLexerKeywords[__LPAREN] << " ";
      for(map<string,vcType*>::iterator iter = this->_input_arguments.begin();
	  iter != this->_input_arguments.end();
	  iter++)
	{
	  ofile << (*iter).first << vcLexerKeywords[__COLON];
	  (*iter).second->Print(ofile);
	  ofile << endl;
	}
      ofile << vcLexerKeywords[__RPAREN] << endl;
    }
  if(this->_output_arguments.size() > 0)
    {
      ofile << vcLexerKeywords[__OUT] << " " << vcLexerKeywords[__LPAREN] << " ";
      for(map<string,vcType*>::iterator iter = this->_output_arguments.begin();
	  iter != this->_output_arguments.end();
	  iter++)
	{
	  ofile << (*iter).first << vcLexerKeywords[__COLON];
	  (*iter).second->Print(ofile);
	  ofile << endl;
	}
      ofile << vcLexerKeywords[__RPAREN] << endl;
    }
  this->_control_path->Print(ofile);
  this->_data_path->Print(ofile);

  if(this->_link_map.size() > 0)
    {
      for(map<string,pair<string,string> >::iterator iter = this->_link_map.begin();
	  iter != this->_link_map.end();
	  iter++)
	{
	  ofile << vcLexerKeywords[__LINK] << " " << vcLexerKeywords[__LPAREN] << (*iter).first << " ";
	  ofile << (*iter).second.first << vcLexerKeywords[__COLON] << (*iter).second.second << vcLexerKeywords[__RPAREN] << endl;
	}
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

  this->Print_Attributes(ofile);
  ofile << "}" << endl;
}
void vcModule::Add_Link(string dpe_name, string dpe_req_ack_name, string transition_name)
{
  pair<string,string> add_pair;
  add_pair.first = dpe_name;
  add_pair.second = dpe_req_ack_name;
  this->_link_map[transition_name] = add_pair;

  vcTransition* trans = this->_control_path->Find_Transition(transition_name);
  vcDatapathElement* dpe = this->_data_path->Find_DPE(dpe_name);

  assert(trans != NULL && dpe != NULL);
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
  map<string,vcType*>::iterator iter;
  if(mode == "in")
    {
      iter = this->_input_arguments.find(arg_name);
      if(iter != this->_input_arguments.end())
	ret_type = (*iter).second;
    }
  else
    {
      iter = this->_output_arguments.find(arg_name);
      if(iter != this->_output_arguments.end())
	ret_type = (*iter).second;
    }
  return(ret_type);
}

void vcModule::Add_Argument(string arg_name, string mode, vcType* t)
{
  if(mode == "in")
    {
      this->_input_arguments[arg_name] = t;
    }
  else
    {
      this->_output_arguments[arg_name] = t;
    }
}
