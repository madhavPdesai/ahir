#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcOperator.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>

vcModule::vcModule(vcSystem* sys, string module_name):vcRoot(module_name)
{
  this->_parent = sys;
  this->_control_path = NULL;
  this->_data_path = NULL;
  this->_num_calls = 0;
}

void vcModule::Set_Data_Path(vcDataPath* dp)
{
  assert(dp != NULL);
  assert(this->_data_path == NULL);
  this->_data_path = dp;
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


  if(this->_linked_dpe_set.size() > 0)
    {
      for(set<vcDatapathElement*>::iterator iter = this->_linked_dpe_set.begin();
	  iter != this->_linked_dpe_set.end();
	  iter++)
	{
	  vcDatapathElement* dpe = (*iter);
	  ofile << dpe->Get_Id() << " ";
	  ofile << vcLexerKeywords[__EQUIVALENT] << " ";

	  ofile << vcLexerKeywords[__LPAREN];
	  for(int idx = 0; idx < dpe->Get_Number_Of_Reqs(); idx++)
	    ofile << dpe->Get_Req(idx)->Get_Hierarchical_Id() << " ";
	  ofile << vcLexerKeywords[__RPAREN];
	  ofile << " ";
	  ofile << vcLexerKeywords[__LPAREN];
	  for(int idx = 0; idx < dpe->Get_Number_Of_Acks(); idx++)
	    ofile << dpe->Get_Ack(idx)->Get_Hierarchical_Id() << " ";
	  ofile << vcLexerKeywords[__RPAREN];

	  ofile << endl;
	}
    }

  this->Print_Attributes(ofile);
  ofile << "}" << endl;
}

void vcModule::Add_Link(vcDatapathElement* dpe, vector<vcTransition*>& reqs, vector<vcTransition*>& acks)
{
  if(this->_linked_dpe_set.find(dpe) != this->_linked_dpe_set.end())
    {
      vcSystem::Error("multiple links to DPE " + dpe->Get_Id() + " in module " + this->Get_Id());
      return;
    }

  this->_linked_dpe_set.insert(dpe);

  dpe->Add_Reqs(reqs);
  for(int idx=0; idx < reqs.size(); idx++)
    {
      reqs[idx]->Add_DP_Link(dpe,_OUT_TRANSITION);
      this->_linked_transition_set.insert(reqs[idx]);
    }

  dpe->Add_Acks(acks);
  for(int idx=0; idx < acks.size(); idx++)
    {
      acks[idx]->Add_DP_Link(dpe,_IN_TRANSITION);
      this->_linked_transition_set.insert(acks[idx]);
    }
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


int vcModule::Get_In_Arg_Width()
{
  int ret_val = 0;
  for(map<string,vcWire*>::iterator iter = _input_arguments.begin();
      iter != _input_arguments.end();
      iter++)
    {
      ret_val += (*iter).second->Get_Type()->Size();
    }
  return(ret_val);
}

int vcModule::Get_Out_Arg_Width()
{
  int ret_val = 0;
  for(map<string,vcWire*>::iterator iter = _output_arguments.begin();
      iter != _output_arguments.end();
      iter++)
    {
	ret_val += (*iter).second->Get_Type()->Size();
    }
  return(ret_val);
}


void vcModule::Check_Control_Structure()
{
  this->_control_path->Check_Structure();
}
void vcModule::Compute_Maximal_Groups()
{
  this->_data_path->Compute_Maximal_Groups(this->_control_path);
}
void vcModule::Compute_Compatibility_Labels()
{
  this->_control_path->Compute_Compatibility_Labels();
}
void vcModule::Print_Control_Structure(ostream& ofile)
{
  this->_control_path->Print_Structure(ofile);
  this->_control_path->Print_Compatibility_Labels(ofile);
  this->Print_Compatible_Operator_Groups(ofile);
}

void vcModule::Print_Compatible_Operator_Groups(ostream& ofile)
{
  this->_data_path->Print_Compatible_Operator_Groups(ofile);
}

void vcModule::Print_VHDL(ostream& ofile)
{
  vcSystem::Print_VHDL_Inclusions(ofile);
  this->Print_VHDL_Entity(ofile);
  this->Print_VHDL_Architecture(ofile);
}

string vcModule::Print_VHDL_Argument_Ports(string semi_colon, ostream& ofile)
{
  
  ofile << semi_colon << endl;
  for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
    {
      ofile << semi_colon << endl;
      ofile << "     " << _ordered_input_arguments[idx] << " : in " ;
      vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
      assert(w != NULL);
      ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0)";
      semi_colon = ";";
    }

  for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
    {
      ofile << semi_colon << endl;
      ofile << "     " << _ordered_output_arguments[idx] << " : in " ;
      vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
      assert(w != NULL);
      ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0)";
      semi_colon = ";";
    }

  ofile << semi_colon << endl;
  ofile <<  "clock : in std_logic;" << endl ;
  ofile <<  "reset : in std_logic;"  << endl;
  ofile <<  "start : in std_logic;"  << endl;
  ofile <<  "fin   : out std_logic";
  return(semi_colon);
}

void vcModule::Print_VHDL_Ports(ostream& ofile)
{
  string semi_colon;
  ofile << "port (" << endl;

  // arguments, clock, reset etc.
  semi_colon = this->Print_VHDL_Argument_Ports(semi_colon, ofile);

  // print external load/store ports.
  semi_colon = this->_data_path->Print_VHDL_Memory_Interface_Ports(semi_colon, ofile);

  // print external IO ports.
  semi_colon = this->_data_path->Print_VHDL_IO_Interface_Ports(semi_colon, ofile);

  // print call interface ports
  semi_colon = this->_data_path->Print_VHDL_Call_Interface_Ports(semi_colon, ofile);

  ofile << ");" << endl;
}


void vcModule::Print_VHDL_Component(ostream& ofile)
{
  ofile << "component " << this->Get_Id() << " is" << endl;
  this->Print_VHDL_Ports(ofile);
  ofile << "end component;" << endl;
}


void vcModule::Print_VHDL_Entity(ostream& ofile)
{
  ofile << "entity " << this->Get_Id() << " is" << endl;
  this->Print_VHDL_Ports(ofile);
  ofile << "end entity " << this->Get_Id() << ";" << endl;
}

void vcModule::Print_VHDL_Architecture(ostream& ofile)
{
  ofile << "architecture Default of " << this->Get_Id() << " is " << endl;

  // always true signal
  ofile << "signal " << this->_control_path->Get_Always_True_Symbol() << ": Boolean;" << endl;

  // print link signals between CP and DP
  ofile << "-- links between control-path and data-path" << endl;
  for(set<vcTransition*>::iterator iter = _linked_transition_set.begin();
      iter != _linked_transition_set.end();
      iter++)
    {
      if((*iter)->Get_Is_Input())
	ofile << "signal " << (*iter)->Get_CP_To_DP_Symbol() << " : boolean;" << endl;
      else if((*iter)->Get_Is_Output()) 
	ofile << "signal " << (*iter)->Get_DP_To_CP_Symbol() << " : boolean;" << endl;
    }
  ofile << endl;


  // print link signals between DP and Memories within the module
  for(map<string, vcMemorySpace*>::iterator iter = _memory_space_map.begin();
      iter != _memory_space_map.end();
      iter++)
    {
      (*iter).second->Print_VHDL_Interface_Signal_Declarations(ofile);
    }
  
  // print links between DP and Ports. todo
  ofile << "-- IN PROGRESS: signals to IO operators, signals to Call operators."
	<< endl;  

  ofile << "begin " << endl;

  ofile << "-- the control path" << endl;

  // the always true signal, tied to true..
  ofile << ((vcCPElement*)(this->_control_path))->Get_Always_True_Symbol() << " <= true; " << endl;

  this->_control_path->Print_VHDL(ofile);

  ofile << endl << endl;

  ofile << "-- the data path" << endl;
  this->_data_path->Print_VHDL(ofile);
  ofile << endl;

  ofile << "end Default;" << endl;

}

