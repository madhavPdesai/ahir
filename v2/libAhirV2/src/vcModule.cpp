#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcValue.hpp>
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
	this->_max_number_of_caller_tags_needed = 0;
	this->_foreign_flag = false;
	this->_pipeline_flag = false;
	this->_operator_flag = false;
	this->_volatile_flag = false;
	this->_pipeline_depth = 1;
	this->_is_function_library_module = false;
	this->_delay = 2;
}

void vcModule::Set_Data_Path(vcDataPath* dp)
{
	assert(dp != NULL);
	assert(this->_data_path == NULL);
	this->_data_path = dp;
}


void vcModule::Print(ostream& ofile)
{
	if(this->_foreign_flag)
		ofile << vcLexerKeywords[__FOREIGN] << " ";
	if(this->_pipeline_flag)
		ofile << vcLexerKeywords[__PIPELINE] << " ";
	if(this->_operator_flag)
		ofile << vcLexerKeywords[__OPERATOR] << " ";
	if(this->_volatile_flag)
		ofile << vcLexerKeywords[__VOLATILE] << " ";

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
			{
				if(dpe->Get_Ack(idx) != NULL)
					ofile << dpe->Get_Ack(idx)->Get_Hierarchical_Id() << " ";
				else
					ofile << vcLexerKeywords[__OPEN] << " ";
			}
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

	if(dpe->Get_Flow_Through())
	{
		vcSystem::Warning("control-path links to flow-through DPE " + dpe->Get_Id() + " ignored,  in module " + this->Get_Id());
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
		if(acks[idx] != NULL)
		{
			acks[idx]->Add_DP_Link(dpe,_IN_TRANSITION);
			this->_linked_transition_set.insert(acks[idx]);
		}
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

void vcModule::Add_Argument(string arg_name, string mode, vcType* t, vcValue* v)
{
	if(mode == "in")
	{
		this->_ordered_input_arguments.push_back(arg_name);
		this->_input_arguments[arg_name] = new vcInputWire(arg_name,t);
	}
	else
	{
		this->_ordered_output_arguments.push_back(arg_name);
		vcOutputWire* w = new vcOutputWire(arg_name,t);
		this->_output_arguments[arg_name] = w;
		w->Set_Value(v);
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
	if(this->_control_path)
		this->_control_path->Check_Structure();
}
void vcModule::Compute_Maximal_Groups()
{
	if(this->_data_path)
		this->_data_path->Compute_Maximal_Groups(this->_control_path);
}
void vcModule::Compute_Compatibility_Labels()
{
	if(this->_control_path)
		this->_control_path->Compute_Compatibility_Labels();
}
void vcModule::Print_Control_Structure(ostream& ofile)
{
	if(this->_control_path)
	{
		this->_control_path->Print_Structure(ofile);
		this->_control_path->Print_Groups(ofile);
		this->_control_path->Print_Compatibility_Labels(ofile);
		this->_control_path->Print_Compatibility_Map(ofile);
		this->Print_Compatible_Operator_Groups(ofile);
	}
}

void vcModule::Print_Compatible_Operator_Groups(ostream& ofile)
{
	if(this->_data_path)
		this->_data_path->Print_Compatible_Operator_Groups(ofile);
}

void vcModule::Print_VHDL(ostream& ofile)
{
	if(!this->_foreign_flag)
	{
		vcSystem::Print_VHDL_Inclusions(ofile);
		this->Print_VHDL_Entity(ofile);
		this->Print_VHDL_Architecture(ofile);
	}
}

void vcModule::Print_VHDL_Caller_Aggregate_Signals(ostream& ofile)
{
	if(this->_num_calls > 0)
	{
		string prefix = this->Get_VHDL_Id() + "_";
		// _num_calls is the total number of caller groups..
		ofile << "signal " << prefix << "call_reqs: std_logic_vector(" << _num_calls-1 << " downto 0);" << endl;
		ofile << "signal " << prefix << "call_acks: std_logic_vector(" << _num_calls-1 << " downto 0);" << endl;
		ofile << "signal " << prefix << "return_reqs: std_logic_vector(" << _num_calls-1 << " downto 0);" << endl;
		ofile << "signal " << prefix << "return_acks: std_logic_vector(" << _num_calls-1 << " downto 0);" << endl;

		if(this->Get_In_Arg_Width() > 0)
			ofile << "signal " << prefix << "call_data: std_logic_vector(" << (this->Get_In_Arg_Width()*_num_calls)-1 << " downto 0);" << endl;
		ofile << "signal " << prefix << "call_tag: std_logic_vector(" << (this->Get_Caller_Tag_Length()*_num_calls)-1 << " downto 0);" << endl;

		if(this->Get_Out_Arg_Width() > 0)
			ofile << "signal " << prefix << "return_data: std_logic_vector(" << (this->Get_Out_Arg_Width()*_num_calls)-1 << " downto 0);" 
				<< endl;          

		ofile << "signal " << prefix << "return_tag: std_logic_vector(" << (this->Get_Caller_Tag_Length()*_num_calls)-1 << " downto 0);" << endl;
	}
}

void vcModule::Print_VHDL_Argument_Signals(ostream& ofile)
{
	string prefix  = this->Get_VHDL_Id() + "_";

	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		assert(w != NULL);

		ofile << "signal " << prefix << w->Get_VHDL_Id() << " : " ;

		ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;
	}

	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{
		vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
		assert(w != NULL);

		ofile << "signal " <<  prefix << w->Get_VHDL_Id() << " : " ;

		ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;
	}

	if(this->Get_In_Arg_Width() > 0)
		ofile << "signal " <<  prefix << "in_args    : std_logic_vector(" << this->Get_In_Arg_Width()-1 << " downto 0);"  << endl;

	if(this->Get_Out_Arg_Width() > 0)
		ofile <<  "signal " << prefix << "out_args   : std_logic_vector(" << this->Get_Out_Arg_Width()-1 << " downto 0);"  << endl;

	ofile <<  "signal " << prefix << "tag_in    : std_logic_vector(" << this->Get_Caller_Tag_Length()+ this->Get_Callee_Tag_Length()-1 << " downto 0) := (others => '0');"  << endl;
	ofile <<  "signal " << prefix << "tag_out   : std_logic_vector(" << this->Get_Caller_Tag_Length() + this->Get_Callee_Tag_Length()-1 << " downto 0);"  << endl;
	ofile <<  "signal " << prefix << "start_req : std_logic;"  << endl;
	ofile <<  "signal " << prefix << "start_ack : std_logic;"  << endl;
	ofile <<  "signal " << prefix << "fin_req   : std_logic;" << endl;
	ofile <<  "signal " << prefix << "fin_ack : std_logic;"  << endl;
}

void  vcModule::Print_VHDL_System_Argument_Signals(ostream& ofile)
{
	string prefix = this->Get_VHDL_Id() +  "_";
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		assert(w != NULL);

		ofile << "signal " << prefix << w->Get_VHDL_Id() << " : " ;

		ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0) := (others => '0');" << endl;
	}

	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{
		vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
		assert(w != NULL);

		ofile << "signal " << prefix << w->Get_VHDL_Id() << " :  " ;

		ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;
	}

	ofile << "signal " <<  prefix << "tag_in: std_logic_vector(" 
		<< this->Get_Callee_Tag_Length()+this->Get_Caller_Tag_Length()-1 << " downto 0);" << endl;
	ofile << "signal " << prefix << "tag_out: std_logic_vector(" 
		<< this->Get_Callee_Tag_Length()+this->Get_Caller_Tag_Length()-1 << " downto 0);" << endl;
	ofile << "signal " << prefix <<  "start_req : std_logic := '0';"  << endl;
	ofile << "signal " << prefix <<  "start_ack : std_logic := '0';"  << endl;
	ofile << "signal " << prefix <<  "fin_req   : std_logic := '0';" << endl;
	ofile << "signal " << prefix <<  "fin_ack   : std_logic := '0';" << endl;

}

string vcModule::Print_VHDL_System_Argument_Ports(string semi_colon,ostream& ofile)
{
	string prefix = this->Get_VHDL_Id() +  "_";
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		ofile << semi_colon << endl;
		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		assert(w != NULL);

		ofile << prefix << w->Get_VHDL_Id() << " : in " ;

		ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0)";
		semi_colon = ";";
	}

	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{
		ofile << semi_colon << endl;

		vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
		assert(w != NULL);

		ofile << prefix << w->Get_VHDL_Id() << " : out " ;

		ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0)";
		semi_colon = ";";
	}

	ofile << semi_colon << endl;

	// tag ports..
	ofile << prefix << "tag_in: in std_logic_vector(" << this->Get_Callee_Tag_Length()+this->Get_Caller_Tag_Length()-1 << " downto 0);" << endl;
	ofile << prefix << "tag_out: out std_logic_vector(" << this->Get_Callee_Tag_Length()+this->Get_Caller_Tag_Length()-1 << " downto 0);" << endl;
	ofile << prefix <<  "start_req : in std_logic;"  << endl;
	ofile << prefix <<  "start_ack : out std_logic;"  << endl;
	ofile << prefix <<  "fin_req   : in std_logic;" << endl;
	ofile << prefix <<  "fin_ack   : out std_logic";
	semi_colon = ";";
	return(semi_colon);
}

string vcModule::Print_VHDL_System_Instance_Port_Map(string comma,ostream& ofile)
{
	string prefix = this->Get_VHDL_Id() +  "_";
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		ofile << comma << endl;
		ofile << prefix << To_VHDL(_ordered_input_arguments[idx]) 
			<< " => "
			<< prefix << To_VHDL(_ordered_input_arguments[idx]);
		comma = ",";
	}

	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{
		ofile << comma << endl;
		ofile << prefix << To_VHDL(_ordered_output_arguments[idx]) 
			<< " => " 
			<< prefix << To_VHDL(_ordered_output_arguments[idx]) ;
		comma = ",";
	}

	ofile << comma << endl;
	// tag ports..
	ofile << prefix <<  "tag_in => " << prefix << "tag_in," << endl;
	ofile << prefix <<  "tag_out => " << prefix << "tag_out," << endl;
	ofile << prefix <<  "start_req => " 	<< prefix <<  "start_req," 	<< endl;
	ofile << prefix <<  "start_ack => " 	<< prefix <<  "start_ack," 	<< endl;
	ofile << prefix <<  "fin_req  => " << prefix <<  "fin_req, " << endl;
	ofile << prefix <<  "fin_ack  => " << prefix <<  "fin_ack ";
	comma = ",";
	return(comma);
}

string vcModule::Print_VHDL_Argument_Ports(string semi_colon, ostream& ofile)
{

	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		ofile << semi_colon << endl;

		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		assert(w != NULL);

		ofile << "     " << w->Get_VHDL_Id() << " : in " ;
		ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0)";
		semi_colon = ";";
	}

	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{
		ofile << semi_colon << endl;
		vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
		assert(w != NULL);

		ofile << "     " << w->Get_VHDL_Id() << " : out " ;

		ofile << " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0)";
		semi_colon = ";";
	}

	return(semi_colon);
}

string vcModule::Print_VHDL_Control_Ports(string semi_colon, ostream& ofile)
{
	ofile << semi_colon << endl;
	ofile <<  "clk : in std_logic;" << endl ;
	ofile <<  "reset : in std_logic;"  << endl;
	ofile <<  "start_req : in std_logic;"  << endl;
	ofile <<  "start_ack : out std_logic;"  << endl;
	ofile <<  "fin_req : in std_logic;"  << endl;
	ofile <<  "fin_ack   : out std_logic";
	semi_colon = ";";
	return(semi_colon);
}

void vcModule::Print_VHDL_Ports(ostream& ofile)
{

	string semi_colon;
	ofile << "port ( -- {" << endl;

	// arguments
	semi_colon = this->Print_VHDL_Argument_Ports(semi_colon, ofile);

	// print external load/store ports.
	if(this->_data_path != NULL)
	{
		semi_colon = this->_data_path->Print_VHDL_Memory_Interface_Ports(semi_colon, ofile);

		// print external IO ports.
		semi_colon = this->_data_path->Print_VHDL_IO_Interface_Ports(semi_colon, ofile);

		// print call interface ports
		semi_colon = this->_data_path->Print_VHDL_Call_Interface_Ports(semi_colon, ofile);
	}

	// input and output tag
	semi_colon = this->Print_VHDL_Tag_Interface_Ports(semi_colon,ofile);

	// clock, reset etc.
	semi_colon = this->Print_VHDL_Control_Ports(semi_colon, ofile);

	ofile << "-- } " << endl << ");" << endl;
}


string vcModule::Print_VHDL_Tag_Interface_Ports(string semi_colon,ostream& ofile)
{
	ofile << semi_colon << endl;
	semi_colon = ";";
	ofile << "tag_in: in std_logic_vector(tag_length-1 downto 0);" << endl;
	ofile << "tag_out: out std_logic_vector(tag_length-1 downto 0) ";
	return(semi_colon);
}


void vcModule::Print_VHDL_Component(ostream& ofile)
{
	if(this->Get_Volatile_Flag())
		this->Print_VHDL_Volatile_Component(ofile);
	else if(this->Get_Operator_Flag())
		this->Print_VHDL_Operator_Component(ofile);
	else
	{
		ofile << "component " << this->Get_VHDL_Id() << " is -- {" << endl;
		ofile << " generic (tag_length : integer); " << endl;
		this->Print_VHDL_Ports(ofile);
		ofile << "-- }" << endl << "end component;" << endl;
	}
}

void vcModule::Print_VHDL_Entity(ostream& ofile)
{
	if(this->Get_Volatile_Flag())
		this->Print_VHDL_Volatile_Entity(ofile);
	else if(this->Get_Operator_Flag())
		this->Print_VHDL_Operator_Entity(ofile);
	else
	{
		ofile << "entity " << this->Get_VHDL_Id() << " is -- {" << endl;
		ofile << " generic (tag_length : integer); " << endl;
		this->Print_VHDL_Ports(ofile);
		ofile << "-- }" << endl << "end entity " << this->Get_VHDL_Id() << ";" << endl;
	}
}

void vcModule::Print_VHDL_Architecture(ostream& ofile)
{

	if(this->_foreign_flag)
		return;

	// operator form?
	if(this->Get_Operator_Flag())
	{
		this->Print_VHDL_Operator_Architecture(ofile);
		return;
	}

	bool volatile_form = this->Get_Volatile_Flag();

	assert(this->_control_path);

	string arch_name = this->Get_VHDL_Architecture_Name();
	string entity_name = this->Get_VHDL_Entity_Name();

	ofile << "architecture " << arch_name << " of " << entity_name << " is -- {" << endl;

	// always true signal
	ofile << "-- always true..." << endl;

	ofile << "signal " << this->_control_path->Get_Always_True_Symbol() << ": Boolean;" << endl;

	if(!volatile_form)
		ofile << "signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + " << this->Get_In_Arg_Width() << ")-1 downto 0);" << endl;
	else
		ofile << "signal in_buffer_data_in, in_buffer_data_out: std_logic_vector(" << this->Get_In_Arg_Width() << "-1 downto 0);" << endl;


	ofile << "signal default_zero_sig: std_logic;" << endl;

	if(!volatile_form)
	{
		// 
		// will use sample-req/ack in operator case.
		//
		ofile << "signal in_buffer_write_req: std_logic;" << endl;
		ofile << "signal in_buffer_write_ack: std_logic;" << endl;

		ofile << "signal in_buffer_unload_req_symbol: Boolean;" << endl;
		ofile << "signal in_buffer_unload_ack_symbol: Boolean;" << endl;

		ofile << "signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + " << this->Get_Out_Arg_Width() << ")-1 downto 0);" << endl;

		ofile << "signal out_buffer_read_req: std_logic;" << endl;
		ofile << "signal out_buffer_read_ack: std_logic;" << endl;
		ofile << "signal out_buffer_write_req_symbol: Boolean;" << endl;
		ofile << "signal out_buffer_write_ack_symbol: Boolean;" << endl;

		ofile << "signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);" << endl;
		ofile << "signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;" << endl;
		ofile << "signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;" << endl;
		ofile << "signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;" << endl;
		ofile << "signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; " << endl;
		ofile << "signal input_sample_reenable_symbol: Boolean;" << endl;
	}

	// input port buffer signals.
	ofile << "-- input port buffer signals" << endl;
	vector<vcWire*> inarg_wires;
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		int wsize = w->Get_Type()->Size();

		inarg_wires.push_back(w);

		ofile << "signal " << w->Get_VHDL_Signal_Id() << " : " 
			<<  " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;

		if(!volatile_form)
		{
		// all inarg_reenable signals must be joined
		// to produce input_sample_reenable!
		// input-sample-reenable will unload from the
		// input buffer.
		string ue_sig =  w->Get_VHDL_Id() + "_update_enable";
		ofile << "signal " << ue_sig << ": Boolean;" << endl;
		}

	}

	// output port buffer signals.
	ofile << "-- output port buffer signals" << endl;
	vector<vcWire*> outarg_wires;
	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{
		vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
		outarg_wires.push_back(w);

		ofile << "signal " << w->Get_VHDL_Signal_Id() << " : " 
			<<  " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;

		if(!volatile_form)
		{
		// exit of CP will trigger write to the output-buffer..
		// TODO: completion of write to output-buffer must
		//       be used to reenable all output updates in 
		//       pipelined body.
		ofile << "signal " << w->Get_VHDL_Id() << "_update_enable: Boolean;" << endl;
		}

	}




	// control-path start symbol
	string cp_entry_symbol = this->_control_path->Get_Start_Symbol();
	string cp_exit_symbol  = this->_control_path->Get_Exit_Symbol();

	if(!volatile_form)
	{
		ofile << "signal " << cp_entry_symbol << ": Boolean;" << endl;
		ofile << "signal " << cp_exit_symbol << ": Boolean;" << endl;
	}



	ofile << "-- volatile/operator module components. " << endl;
	for(set<vcModule*>::iterator mciter = _called_modules.begin(), fmciter = _called_modules.end();
			mciter != fmciter; mciter++)
	{
		vcModule* mc = *mciter;

		// if this is volatile, mc must be volatile.
		if(this->Get_Volatile_Flag() && !mc->Get_Volatile_Flag())
		{
			vcSystem::Error("module " + mc->Get_Label() + " called from volatile module " + this->Get_Label()
					+ " is not volatile");
		}

		mc->Print_VHDL_Component(ofile);
	}

	// print link signals between CP and DP
	if(!volatile_form)
	{
		ofile << "-- links between control-path and data-path" << endl;
		for(set<vcTransition*>::iterator iter = _linked_transition_set.begin();
				iter != _linked_transition_set.end();
				iter++)
		{
			if((*iter)->Get_Is_Input())
				ofile << "signal " << (*iter)->Get_DP_To_CP_Symbol() << " : boolean;" << endl;
			else if((*iter)->Get_Is_Output()) 
				ofile << "signal " << (*iter)->Get_CP_To_DP_Symbol() << " : boolean;" << endl;
		}
		ofile << endl;

		// print link signals between DP and Memories within the module
		// note: operators can also have internal memory spaces.
		for(map<string, vcMemorySpace*>::iterator iter = _memory_space_map.begin();
				iter != _memory_space_map.end();
				iter++)
		{
			// error checking will happen here.
			(*iter).second->Print_VHDL_Interface_Signal_Declarations(ofile);
		}
	}

	if(vcSystem::_enable_logging && !volatile_form)
	{
		ofile << "signal global_clock_cycle_count: integer := 0;" << endl;
	}

	ofile << "-- }" << endl << "begin --  {" << endl;

	if(vcSystem::_enable_logging && !volatile_form)
	{
		ofile << " ---------------------------------------------------------- " << endl;
		ofile << "process(clk)  " << endl;
		ofile << "begin -- { " << endl;
		ofile << "  if(clk'event and clk = '1') then -- { " << endl;
		ofile << "    if(reset = '1') then -- { " << endl;
		ofile << "       global_clock_cycle_count <= 0; --} " << endl;
		ofile << "    else -- { " << endl;
		ofile << "       global_clock_cycle_count <= global_clock_cycle_count + 1; -- }" << endl;
		ofile << "    end if; --} " << endl;
		ofile << "  end if; --} " << endl;
		ofile << "end process;" << endl;
		ofile << " ---------------------------------------------------------- " << endl;
	}



	ofile << "-- input handling ------------------------------------------------" << endl;
	if(volatile_form)
	{
		for(int idx = 0, fidx = inarg_wires.size(); idx < fidx; idx++)
		{
			vcWire* w = inarg_wires[idx];
			ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_VHDL_Id() << ";" << endl;
		}
	}
	else
	{
		//int input_buffering  = (this->_pipeline_flag ? 2 : 1);
		int input_buffering  = 1;
		ofile << "in_buffer: UnloadBuffer -- { " << endl;
		ofile << " generic map(name => \"" << this->Get_VHDL_Id() << "_input_buffer\", -- {" << endl
			<< " buffer_size => " << input_buffering << "," <<  endl 
			<< " data_width => tag_length + " << this->Get_In_Arg_Width() << ") -- } " << endl;
		ofile << " port map(write_req => in_buffer_write_req, -- { " << endl
			<< " write_ack => in_buffer_write_ack, " << endl
			<< " write_data => in_buffer_data_in," << endl
			<< " unload_req => in_buffer_unload_req_symbol, " << endl
			<< " unload_ack => in_buffer_unload_ack_symbol, " << endl
			<< " read_data => in_buffer_data_out," << endl
			<< " clk => clk, reset => reset); -- }}" << endl;

		int H=0;
		for(int idx = 0, fidx = inarg_wires.size(); idx < fidx; idx++)
		{
			vcWire* w = inarg_wires[idx];
			int wsize = w->Get_Type()->Size();
			ofile << "in_buffer_data_in(" << (H+wsize)-1 << " downto " << H << ") <= " << w->Get_VHDL_Id() << ";" << endl;
			ofile << w->Get_VHDL_Signal_Id() << " <= in_buffer_data_out(" << (H+wsize)-1 << " downto " << H << ");" << endl;
			H += wsize;
		}

		string hindex = (H > 0 ? "tag_length + " + IntToStr(H-1) : "tag_length-1");
		ofile << "in_buffer_data_in(" << hindex << " downto " << H << ") <= tag_in;" << endl;
		ofile << "tag_ub_out <= in_buffer_data_out(" << hindex <<  " downto " << H << ");" << endl;

		ofile << "in_buffer_write_req <= start_req;" << endl;
		ofile << "start_ack <= in_buffer_write_ack;" << endl;

		// In a non-volatile module, there are two distinct cases:
		//    In the pipeline case, 
		//             the unload_req_symbol is a join with the following predecessors
		//                  -  marked predecessor: unload_ack_symbol (self-release, 0-delay)
		//                  -  unmarked predecessor: input_update_enable  (in pipeline case only, 0-delay).
		//                  -  marked predecessor (with initial marking of pipeline-depth) input_sample_reenable_symbol
		//    The non-pipeline case
		//             the read_req_symbol is a join with the following predecessors
		//                  -  marked predecessor: unload_ack_symbol (self-release, 0-delay)
		//                  -  marked predecessor (with initial marking of 1) input_sample_reenable_symbol
		vector<string> preds;
		vector<int>    pred_markings;
		vector<int>    pred_capacities;
		vector<int>    pred_delays;

		if(this->_pipeline_flag)
		{
			for(int idx = 0, fidx = inarg_wires.size(); idx < fidx; idx++)
			{
				vcWire* w = inarg_wires[idx];

				// if wire is not used, then it is ignored.
				// because it's update is  never enabled..
				if(w->Get_Number_Of_Receivers() == 0) 
					continue;

				preds.push_back(w->Get_VHDL_Id() + "_update_enable");
				pred_capacities.push_back(this->Get_Pipeline_Depth());
				pred_markings.push_back(0);
				pred_delays.push_back(0); // revisit later..
			}
		}

		preds.push_back("in_buffer_unload_ack_symbol");
		pred_markings.push_back(1);
		pred_capacities.push_back(1);
		pred_delays.push_back(0);  // revisit later..

		preds.push_back("input_sample_reenable_symbol");
		pred_markings.push_back((this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1));
		pred_capacities.push_back((this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1));
		pred_delays.push_back(1);  // revisit later..

		string joined_symbol = "in_buffer_unload_req_symbol";
		Print_VHDL_Join(joined_symbol + "_join", 
				preds,
				pred_markings,
				pred_capacities, 
				pred_delays, 
				joined_symbol,
				ofile);

		ofile << endl;


		ofile << "-- join of all unload_ack_symbols.. used to trigger CP." << endl;
		ofile << cp_entry_symbol << " <= in_buffer_unload_ack_symbol;" << endl;


	}

	ofile << "-- output handling  -------------------------------------------------------" << endl;
	if(volatile_form)
	{
		for(int idx = 0, fidx = outarg_wires.size(); idx < fidx; idx++)
		{
			vcWire* w = outarg_wires[idx];
			ofile << w->Get_VHDL_Id() << " <= " << w->Get_VHDL_Signal_Id() << ";" << endl;
			vcValue* v = ((vcOutputWire*)w)->Get_Value();
			if(v != NULL)
			{
				ofile << w->Get_VHDL_Signal_Id() << " <= " << v->To_VHDL_String() << ";" << endl;
			}
		}
	}
	else
	{
		int output_buffering = (this->_pipeline_flag ? 2 : 1);
		// instantiate receive-buffer for each input.
		ofile <<  "out_buffer: ReceiveBuffer -- {" << endl
			<< " generic map(name => \"" << this->Get_VHDL_Id() << "_out_buffer\", -- {" << endl
			<< " buffer_size => " << output_buffering << "," << endl
			<< " data_width => tag_length + " << this->Get_Out_Arg_Width() << ") --} " << endl;
		ofile << " port map(write_req => out_buffer_write_req_symbol, -- {" << endl
			<< " write_ack => out_buffer_write_ack_symbol, " << endl
			<< " write_data => out_buffer_data_in," << endl
			<< " read_req => out_buffer_read_req, " << endl
			<< " read_ack => out_buffer_read_ack, " << endl
			<< " read_data => out_buffer_data_out," << endl
			<< " clk => clk, reset => reset); -- }}" << endl;


		int H = 0;
		for(int idx = 0, fidx = outarg_wires.size(); idx < fidx; idx++)
		{
			vcOutputWire* w = (vcOutputWire*) outarg_wires[idx];
			int wsize  = w->Get_Type()->Size();
			if(w->Is_Constant())
				ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_Value()->To_VHDL_String() << ";" << endl;

			ofile << "out_buffer_data_in(" << (H+wsize)-1 << " downto " << H << ") <= " << w->Get_VHDL_Signal_Id() << ";" << endl;
			ofile << w->Get_VHDL_Id() << " <= out_buffer_data_out(" << (H+wsize)-1 << " downto " << H << ");" << endl;
			H += wsize;
		}
		string hindex = (H > 0 ? "tag_length + " + IntToStr(H-1) : "tag_length-1");
		ofile << "out_buffer_data_in(" << hindex << " downto " << H << ") <= tag_ilock_out;" << endl;
		ofile << "tag_out <= out_buffer_data_out(" << hindex << " downto " << H << ");" << endl;


		// There are two distinct cases when the module is not volatile (as above)
		vector<string> preds;
		vector<int>    pred_markings;
		vector<int>    pred_capacities;
		vector<int>    pred_delays;

		//     for each output, the write_req_symbol is a join with 
		//      - marked predecessor: write_ack_symbol (self-release, 0-delay)
		//      - unmarked predecessor: cp_exit_symbol
		//     the write_ack-symbol is not used in any manner except to reenable
		//     the write_req symbol.
		preds.push_back(cp_exit_symbol);
		pred_capacities.push_back(this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1);
		pred_markings.push_back(0);
		pred_delays.push_back(0); // revisit later..

		preds.push_back("out_buffer_write_ack_symbol");
		pred_markings.push_back(1);
		pred_capacities.push_back(1);
		pred_delays.push_back(1);  // delay=1, it is a sample-reenable. 

		preds.push_back("tag_ilock_read_ack_symbol");
		pred_markings.push_back(0);
		pred_capacities.push_back(this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1);
		pred_delays.push_back(0); // no need for delay, unmarked. 

		string joined_symbol = "out_buffer_write_req_symbol";
		Print_VHDL_Join(joined_symbol + "_join", 
				preds,
				pred_markings,
				pred_capacities, 
				pred_delays, 
				joined_symbol,
				ofile);

		if(this->_pipeline_flag)
		{
			for(int idx = 0, fidx = outarg_wires.size(); idx < fidx; idx++)
			{
				vcWire* w = outarg_wires[idx];
				ofile << w->Get_VHDL_Id() + "_update_enable <= " << "out_buffer_write_ack_symbol;" << endl;
			}
		}
	}
	ofile << endl;

	if(!volatile_form)
	{
		ofile << "-- write-to output-buffer produces  reenable input sampling" << endl;
		ofile << "input_sample_reenable_symbol <= out_buffer_write_ack_symbol;" << endl;
	}

	if(!volatile_form)
	{
		ofile << "-- fin-req/ack level protocol.." << endl;
		ofile << "out_buffer_read_req <= fin_req;" << endl;
		ofile << "fin_ack <= out_buffer_read_ack;" << endl;

		// tag queue..
		ofile << "----- tag-queue --------------------------------------------------" << endl;
		this->Print_VHDL_Tag_Logic(ofile);
	}

	// logging.
	if(vcSystem::_enable_logging && !volatile_form)
	{
		ofile << "--- logging ------------------------------------------------------" << endl;
		string sreq_symbol_name =  '"'  +  this->Get_VHDL_Id() + " cp_entry_symbol " + '"';
		ofile << "LogCPEvent(clk,reset,global_clock_cycle_count," << cp_entry_symbol << "," <<  sreq_symbol_name << ");" << endl;


		string cack_symbol_name =  '"'  +  this->Get_VHDL_Id() + " cp_exit_symbol " + '"';
		ofile << "LogCPEvent(clk,reset,global_clock_cycle_count," << cp_exit_symbol << ", " <<  cack_symbol_name << ");" << endl;
	} 

	ofile << "-- the control path --------------------------------------------------" << endl;

	// the always true signal, tied to true..
	if(!volatile_form)
		ofile << ((vcCPElement*)(this->_control_path))->Get_Always_True_Symbol() << " <= true; " << endl;
	ofile << "default_zero_sig <= '0';" << endl;

	if(!volatile_form)
	{
		if(vcSystem::_opt_flag)
			this->_control_path->Print_VHDL_Optimized(ofile);
		else
			this->_control_path->Print_VHDL(ofile);

		ofile << endl << endl;
	}
	else
		ofile << "-- volatile module, no control path" << endl;

	assert(this->_data_path != NULL);
	ofile << "-- the data path" << endl;
	this->_data_path->Print_VHDL(ofile);

	ofile << endl;


	if(!volatile_form)
	{

		for(map<string,vcMemorySpace*>::iterator iter = _memory_space_map.begin();
				iter != _memory_space_map.end();
				iter++)
		{
			vcMemorySpace* ms  = (*iter).second;
			ms->Print_VHDL_Instance(ofile);
		}
	}
	else
	{
		if(_memory_space_map.size() > 0)
			vcSystem::Error("volatile module " + this->Get_Label() + " cannot have storage objects." );
	}

	ofile << "-- }" << endl << "end " << arch_name << ";" << endl;
}



void vcModule::Print_VHDL_Tag_Logic(ostream& ofile)
{
	int ilock_depth = (this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1);

	ofile << "-- interlock buffer for TAG.. to provide required buffering." << endl;
	ofile << "tagIlock: InterlockBuffer -- { " << endl
		<< " generic map(name => \"tag-interlock-buffer\", -- {" << endl
		<< " buffer_size => " << ilock_depth << "," << endl
		<< " in_data_width => tag_length," << endl
		<< " out_data_width => tag_length) -- }" << endl;
	ofile << " port map(write_req => " << "tag_ilock_write_req_symbol, -- {" << endl
		<< " write_ack => "  << "tag_ilock_write_ack_symbol, " << endl
		<< " write_data => tag_ub_out," << endl
		<< " read_req => "   << "tag_ilock_read_req_symbol, " << endl
		<< " read_ack => "   << "tag_ilock_read_ack_symbol, " << endl
		<< " read_data => tag_ilock_out, " << endl
		<< " clk => clk, reset => reset); -- }}" << endl;

	ofile << "-- tag ilock-buffer control logic. " << endl;

	string cp_entry_symbol  = this->_control_path->Get_Start_Symbol();
	vector<string> preds;
	vector<int>    pred_markings;
	vector<int>    pred_capacities;
	vector<int>    pred_delays;

	preds.push_back(cp_entry_symbol);
	pred_capacities.push_back(this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1);
	pred_markings.push_back(0);
	pred_delays.push_back(0); // revisit later..

	preds.push_back("tag_ilock_write_ack_symbol");
	pred_capacities.push_back(1);
	pred_markings.push_back(1);
	pred_delays.push_back(1); // revisit later..

	string joined_symbol =  "tag_ilock_write_req_symbol";
	Print_VHDL_Join(joined_symbol + "_join", 
			preds,
			pred_markings,
			pred_capacities, 
			pred_delays, 
			joined_symbol,
			ofile);

	preds.clear(); pred_capacities.clear(); pred_markings.clear(); pred_delays.clear();

	preds.push_back(cp_entry_symbol);
	pred_capacities.push_back(this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1);
	pred_markings.push_back(0);
	pred_delays.push_back(0); // revisit later..

	preds.push_back("tag_ilock_read_ack_symbol");
	pred_capacities.push_back(1);
	pred_markings.push_back(1);
	pred_delays.push_back(0); // delay=0, an update-reenable. 

	preds.push_back("out_buffer_write_ack_symbol");
	pred_capacities.push_back(1);
	pred_markings.push_back(1);
	pred_delays.push_back(0); // revisit later..

	joined_symbol =  "tag_ilock_read_req_symbol";
	Print_VHDL_Join(joined_symbol + "_join", 
			preds,
			pred_markings,
			pred_capacities, 
			pred_delays, 
			joined_symbol,
			ofile);
}

string vcModule::Get_VHDL_Call_Interface_Port_Name(string pid)
{
	return(this->Get_VHDL_Id() + "_" + pid);
}

// given a module, and type of operation,
// find the section of the port of type pid
// from the module memory interface ports
// for this memory space.
//
// algorithm: find the position of idx (from the left)
// Then, calculate the section using the word-size.
string vcModule::Get_VHDL_Call_Interface_Port_Section(vcModule* m,
		string call_or_return,
		string pid,
		int idx)
{
	map<vcModule*,vector<int> >::iterator iter;
	iter = _call_group_map.find(m);
	assert(iter != _call_group_map.end());


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

	if((pid.find("req") != string::npos) || (pid.find("ack") != string::npos))
		return(this->Get_VHDL_Id() + "_" + pid + "(" + IntToStr(down_index) + ")");
	else if(pid.find("data") != string::npos)
	{
		int word_size;
		if(call_or_return == "call")
			word_size = this->Get_In_Arg_Width();
		else
			word_size = this->Get_Out_Arg_Width();

		return(this->Get_VHDL_Id() + "_" + pid + "(" 
				+ IntToStr(((down_index+1)*word_size)-1) + " downto "
				+ IntToStr(down_index*word_size) + ")");
	}
	else if(pid.find("tag") != string::npos)
		return(this->Get_VHDL_Id() + "_" + pid + "(" 
				+ IntToStr(((down_index+1)*this->Get_Caller_Tag_Length())-1) + " downto "
				+ IntToStr(down_index*this->Get_Caller_Tag_Length()) + ")");
	else
		assert(0); // fatal
}


void vcModule::Print_VHDL_In_Arg_Disconcatenation(ostream& ofile)
{
	string prefix = this->Get_VHDL_Id() + "_";

	int lindex = this->Get_In_Arg_Width() - 1;
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		assert(w != NULL);

		ofile << prefix << w->Get_VHDL_Id() << " <= " 
			<< prefix << "in_args(" << lindex << " downto " << ((lindex+1) - w->Get_Size()) << ");" << endl;
		lindex = lindex - w->Get_Size();
	}
}

void vcModule::Print_VHDL_Out_Arg_Concatenation(ostream& ofile)
{
	string prefix = this->Get_VHDL_Id() + "_";

	if(this->Get_Out_Arg_Width() > 0)
	{
		ofile << prefix << "out_args <= ";
		for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
		{
			if(idx > 0)
				ofile << "& ";

			vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
			assert(w != NULL);

			ofile << prefix << w->Get_VHDL_Id() << " ";
		}
		ofile << ";" << endl;
	}
}

void vcModule::Print_VHDL_Call_Arbiter_Instantiation(ostream& ofile)
{
	ofile << "-- call arbiter for module " << this->Get_VHDL_Id() << endl;
	string prefix = this->Get_VHDL_Id() + "_";

	string call_arbiter_id;
	bool in_args = false;
	bool out_args = false;
	if(this->Get_In_Arg_Width() > 0)
	{
		in_args = true;
		if(this->Get_Out_Arg_Width() > 0)
		{
			call_arbiter_id = "SplitCallArbiter";
			out_args = true;
		}
		else
			call_arbiter_id = "SplitCallArbiterNoOutargs";
	}
	else
	{
		if(this->Get_Out_Arg_Width() > 0)
		{
			call_arbiter_id = "SplitCallArbiterNoInargs";
			out_args = true;
		}
		else
			call_arbiter_id = "SplitCallArbiterNoInargsNoOutargs";
	}
	ofile << prefix << "arbiter: " << call_arbiter_id << " -- {" << endl;
	ofile << "generic map( --{\n num_reqs => " << this->_num_calls << "," << endl;
	if(in_args)
		ofile << " call_data_width => " << (this->Get_In_Arg_Width()) << "," << endl;
	if(out_args)
		ofile << " return_data_width => " << (this->Get_Out_Arg_Width()) << "," << endl;

	ofile << " callee_tag_length => " << (this->Get_Callee_Tag_Length()) << "," << endl;
	ofile << " caller_tag_length => " << (this->Get_Caller_Tag_Length()) << "--}\n )" << endl;
	ofile << "port map(-- {\n call_reqs => " << prefix << "call_reqs," << endl
		<< " call_acks => " << prefix << "call_acks," << endl
		<< " return_reqs => " << prefix << "return_reqs," << endl
		<< " return_acks => " << prefix << "return_acks," << endl;

	if(in_args)
		ofile << " call_data  => " << prefix << "call_data," << endl;

	ofile << " call_tag  => " << prefix << "call_tag," << endl
		<< " return_tag  => " << prefix << "return_tag," << endl
		<< " call_mtag => " << prefix << "tag_in," << endl
		<< " return_mtag => "<< prefix << "tag_out," << endl;

	if(out_args)
		ofile << " return_data =>" << prefix << "return_data," << endl;

	ofile << " call_mreq => " << prefix << "start_req," << endl;
	ofile << " call_mack => " << prefix << "start_ack," << endl;
	ofile << " return_mreq => " << prefix << "fin_req," << endl
		<< " return_mack => " << prefix << "fin_ack," << endl;
	if(in_args)
		ofile << " call_mdata => " << prefix << "in_args," << endl;
	if(out_args)
		ofile << " return_mdata => " << prefix << "out_args," << endl;
	ofile << " clk => clk, " << endl
		<< " reset => reset --}\n); --}" << endl;
}


void vcModule::Print_VHDL_Instance(ostream& ofile)
{

	if((this->Get_Num_Calls() == 0) && !this->Get_Parent()->Is_A_Top_Module(this))
	{
		std::cerr << "Warning:  tying the init signal for module " << this->Get_Label() 
			<< " to 0" << endl;
		string prefix  = this->Get_VHDL_Id() + "_";
		ofile << prefix << "start_req <= '0';" << endl;
	}

	string instance_id = this->Get_VHDL_Id() + "_instance";
	ofile << instance_id << ":" << this->Get_VHDL_Id() << "-- {" << endl;
	ofile << " generic map(tag_length => "  << this->Get_Callee_Tag_Length()+this->Get_Caller_Tag_Length() << ")" << endl;
	ofile << "port map(-- {\n ";

	this->Print_VHDL_Instance_Port_Map(ofile);
	ofile << "-- }\n ); -- }" << endl;
}

void vcModule::Print_VHDL_Auto_Run_Instance(ostream& ofile)
{
	string prefix = this->Get_VHDL_Id() +  "_";
	ofile << "-- module will be run forever " << endl;
	ofile << prefix << "tag_in <= (others => '0');" << endl;
	string instance_id = this->Get_VHDL_Id() + "_auto_run";
	ofile << instance_id << ": auto_run generic map(use_delay => true)  ";
	ofile << "port map(";
	ofile << "clk => clk, reset => reset, start_req => "
		<< prefix << "start_req, "  
		<< "start_ack => " << prefix << "start_ack, "
		<< " fin_req => " << prefix << "fin_req, " 
		<< " fin_ack => " << prefix << "fin_ack);" << endl;
}

void vcModule::Print_VHDL_Instance_Port_Map(ostream& ofile)
{

	string comma;
	comma = this->Print_VHDL_Argument_Port_Map(comma, ofile);

	if(this->_data_path)
	{
		comma = this->_data_path->Print_VHDL_Memory_Interface_Port_Map(comma, ofile);
		comma = this->_data_path->Print_VHDL_IO_Interface_Port_Map(comma, ofile);
		comma = this->_data_path->Print_VHDL_Call_Interface_Port_Map(comma, ofile);
	}

	comma = this->Print_VHDL_Tag_Interface_Port_Map(comma, ofile);
}


string vcModule::Print_VHDL_Argument_Port_Map(string  comma, ostream& ofile)
{
	string prefix = this->Get_VHDL_Id() +  "_";
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{ 
		ofile << comma << endl;
		ofile << To_VHDL(_ordered_input_arguments[idx]) << " => " 
			<<  prefix << To_VHDL(_ordered_input_arguments[idx]);
		comma = ",";
	}

	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{ 
		ofile << comma << endl;
		ofile << To_VHDL(_ordered_output_arguments[idx]) << " => " 
			<<  prefix << To_VHDL(_ordered_output_arguments[idx]);
		comma = ",";
	}

	ofile << comma << endl 
		<< "start_req => " << prefix << "start_req," << endl
		<< "start_ack => " << prefix << "start_ack," << endl
		<< "fin_req => " << prefix << "fin_req," << endl;
	ofile << "fin_ack => " << prefix << "fin_ack," << endl; 
	ofile << "clk => clk,\n reset => reset";
	comma = ",";
	return(comma);
}


string  vcModule::Print_VHDL_Tag_Interface_Port_Map(string comma, ostream& ofile)
{
	string prefix = this->Get_VHDL_Id() + "_";
	ofile << comma << endl;
	ofile << "tag_in => " << prefix << "tag_in," << endl;
	ofile << "tag_out => " << prefix << "tag_out" ;
	comma = ",";
	return(comma);
}


bool vcModule::Get_Caller_Module_Section(vcModule* caller_module, int& hindex, int& lindex)
{
	bool ret_val = false;
	hindex = this->_num_calls-1;
	for(map<vcModule*,vector<int> >::iterator iter = _call_group_map.begin();
			iter != _call_group_map.end();
			iter++)
	{
		if(caller_module == (*iter).first)
		{
			lindex = (hindex + 1) - (*iter).second.size();
			ret_val = true;
			break;
		}
		else
		{
			hindex -= (*iter).second.size();
		}
	}
	return(ret_val);
}

string vcModule::Get_Aggregate_Section(string pid, int hindex, int lindex)
{
	int data_width;
	string ret_string = this->Get_VHDL_Id() + "_" + pid;

	// find data_width.
	if((pid.find("req") != string::npos) || (pid.find("ack") != string::npos))
		data_width = 1;
	else if(pid.find("call_data") != string::npos)
		data_width = this->Get_In_Arg_Width();
	else if(pid.find("return_data") != string::npos)
		data_width = this->Get_Out_Arg_Width();
	else if(pid.find("tag") != string::npos)
		data_width = this->Get_Caller_Tag_Length();
	else
		assert(0); // fatal

	ret_string += "(";
	ret_string += IntToStr(((hindex+1)*data_width)-1);
	ret_string += " downto ";
	ret_string += IntToStr(lindex*data_width);
	ret_string += ")";
	return(ret_string);
}



void vcModule::Mark_Reachable_Modules(set<vcModule*>& reachable_modules)
{
	if(reachable_modules.find(this) == reachable_modules.end())
	{
		reachable_modules.insert(this);
		for(set<vcModule*>::iterator citer = _called_modules.begin(), fciter = _called_modules.end();
				citer != fciter;
				citer++)
		{
			(*citer)->Mark_Reachable_Modules(reachable_modules);
		}
	}
}

void vcModule::Delink_From_Modules_And_Memory_Spaces()
{

	for(set<vcModule*>::iterator citer = _called_modules.begin(), fciter = _called_modules.end();
			citer != fciter;
			citer++)
	{
		(*citer)->Deregister_Call_Groups(this);
	}

	for(set<vcMemorySpace*>::iterator citer = _accessed_memory_spaces.begin(), fciter = _accessed_memory_spaces.end();
			citer != fciter;
			citer++)
	{
		(*citer)->Deregister_Loads_And_Stores(this);
	}
}


void vcModule::Print_Pipes(ostream& ofile)
{
	for(map<string,vcPipe*>::iterator piter = this->_pipe_map.begin();
			piter != this->_pipe_map.end();
			piter++)
	{

		(*piter).second->Print(ofile);

	}
}

void vcModule::Register_Pipe_Read(string pipe_id, int idx)
{
	vcPipe* p = this->Find_Pipe(pipe_id);
	if(p != NULL)
	{
		p->Register_Pipe_Read(this,idx);
	}
	else
		this->Get_Parent()->Register_Pipe_Read(pipe_id, this, idx);    
}


void vcModule::Register_Pipe_Write(string pipe_id,int idx)
{
	vcPipe* p = this->Find_Pipe(pipe_id);

	if(p != NULL)
	{
		p->Register_Pipe_Write(this,idx);
	}
	else
		this->Get_Parent()->Register_Pipe_Write(pipe_id, this, idx);
}

vcPipe* vcModule::Find_Pipe(string pipe_id)
{
	vcPipe* ret_pipe = this->Find_Pipe_Here(pipe_id);
	if(ret_pipe == NULL)
		ret_pipe =  this->Get_Parent()->Find_Pipe(pipe_id);
	return(ret_pipe);
}

void vcModule::Add_Pipe(string pipe_id, int width, int depth, bool lifo_mode, bool noblock_mode,
					 bool in_flag, bool out_flag, bool signal_flag, bool p2p_flag, bool shiftreg_flag) 
{
	assert(_pipe_map.find(pipe_id) == _pipe_map.end());
	assert(width > 0);
	assert(depth >= 0);

	vcPipe* np =  new vcPipe(this, pipe_id, width, depth, lifo_mode, noblock_mode);
	_pipe_map[pipe_id] = np;

	np->Set_In_Flag(in_flag);
	np->Set_Out_Flag(out_flag);
	np->Set_Signal(signal_flag);
	np->Set_P2P(p2p_flag);
	np->Set_Shift_Reg(shiftreg_flag);
}

void vcModule::Print_VHDL_Pipe_Signals(ostream& ofile)
{
	for(map<string,vcPipe*>::iterator piter = this->_pipe_map.begin();
			piter != this->_pipe_map.end();
			piter++)
	{
		if(((*piter).second->Get_Pipe_Read_Count() > 0) && 
				((*piter).second->Get_Pipe_Write_Count() > 0))
			(*piter).second->Print_VHDL_Pipe_Signals(ofile);
	}
}

void vcModule::Print_VHDL_Pipe_Instances(ostream& ofile)
{
	for(map<string,vcPipe*>::iterator piter = this->_pipe_map.begin();
			piter != this->_pipe_map.end();
			piter++)
	{
		vcPipe* p = (*piter).second;
		if(p->Get_Pipe_Read_Count() > 0 && p->Get_Pipe_Write_Count() == 0)
		{
			vcSystem::Error("in module " + this->Get_Id() + ", pipe "
					+ (*piter).second->Get_Id() + " is read from, but not written into..");
		}
		else if(p->Get_Pipe_Read_Count() == 0 && p->Get_Pipe_Write_Count() > 0)
		{
			vcSystem::Error("in module " + this->Get_Id() + ", pipe "
					+ (*piter).second->Get_Id() + " is written into, but not read from..");
		}
		else if(p->Get_Pipe_Read_Count() > 0 && p->Get_Pipe_Write_Count() > 0)
			(*piter).second->Print_VHDL_Instance(ofile);
	}
}

void vcModule::Print_Reduced_CP_As_Dot_File()
{
	string cp_file_name = this->Get_VHDL_Id() + "_CP.dot";
	ofstream cp_file;
	cp_file.open(cp_file_name.c_str());
	this->_control_path->Print_Reduced_Control_Path_As_Dot_File(cp_file);
	cp_file.close();	
}
