#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlThread.h>

int root_object_counter = 0;
	
hierRoot::hierRoot(string id)
{
	_id = id;
	_error = false;

	root_object_counter++;
	_index = root_object_counter;	
}

hierRoot::hierRoot()
{
	_error = false;

	root_object_counter++;
	_index = root_object_counter;	
	_id = "anon_" + IntToStr(root_object_counter);
}

void hierSystem::Add_Thread(rtlThread* t)
{
  assert(_thread_map.find(t->Get_Id()) == _thread_map.end());
  _thread_map[t->Get_Id()]  = t;
}

void hierSystem::Add_String(rtlString* t)
{

	// need to check that no two instances
	// have the same instance-id.
  assert(0);

  _rtl_strings.push_back(t);

  // do nothing else for now.	
}

void hierSystem::List_In_Pipe_Names(vector<string>& pvec)
{
	listPipeMap(_in_pipes,pvec);
}
void hierSystem::List_Out_Pipe_Names(vector<string>& pvec)
{
	listPipeMap(_out_pipes,pvec);
}
void hierSystem::List_Internal_Pipe_Names(vector<string>& pvec)
{
	listPipeMap(_internal_pipes,pvec);
}

hierSystemInstance::hierSystemInstance(hierSystem* parent, hierSystem* base_sys, string id):hierRoot(id) 
{	
	_parent = parent;
	_base_system = base_sys; 
	if(parent != NULL)
		parent->Increment_Instance_Count();
}

bool hierSystemInstance::Add_Port_Mapping(string formal, string actual,
		map<string, pair<int,int> >& global_pipe_map,
		set<string>& global_signals)
{
	// check if actual exists?  If not check if it exists in the
	// visible pipes
	hierSystem* parent = this->_parent;

	if(parent->Get_Pipe_Width(actual) <= 0)
	{
		int w, d;
		bool is_sig;
		bool err = getPipeInfoFromGlobals(actual, global_pipe_map, global_signals,
				w, d, is_sig);	
		if(err)
		{
			this->Report_Error("Instance " + this->Get_Id() + " in " + parent->Get_Id() + 
					".. did not find actual " + actual);
			return(true);
		} 
		else
		{
			this->Report_Warning(string("Added internal ") + 
					(is_sig ? "signal " : "pipe " )  + actual + " to " + parent->Get_Id());
			parent->Add_Internal_Pipe(actual, w, d);
			if(is_sig)
				parent->Add_Signal(actual);
		}
	}	
	this->Add_Port_Mapping(formal, actual);
	return(false);
}

bool hierSystemInstance::Add_Port_Mapping(string formal, string actual)
{
	bool err = false;
	hierSystem* parent = _parent;

	bool formal_is_input = (_base_system->Get_Input_Pipe_Width(formal) > 0);
	bool formal_is_output = (_base_system->Get_Output_Pipe_Width(formal) > 0);
	bool actual_is_input = (parent->Get_Input_Pipe_Width(actual) > 0);
	bool actual_is_output = (parent->Get_Output_Pipe_Width(actual) > 0);

	bool conn_error = ((formal_is_input && actual_is_output) || 
			(formal_is_output && actual_is_input));
	if(conn_error)
	{
		hierRoot::Report_Error("connection mismatch: instance " + this->Get_Id() + " in " 
				+ parent->Get_Id() + " for " + formal  + " => " + actual);
		return(true);
	}

	if(formal_is_input)
		parent->Set_Driving_Pipe(actual);
	if(formal_is_output)
		parent->Set_Driven_Pipe(actual);

	if(_base_system->Has_Port(formal))
	{
		if(_port_map.find(formal) != _port_map.end())
		{
			this->Report_Error("formal port " + formal + " multiply mapped in instance " + _id);
		}
		_port_map[formal] = actual;

		if(_reverse_port_map.find(actual) != _reverse_port_map.end())
		{
			this->Report_Error(" actual port " + actual + " multiply mapped in instance " + _id);
		}	
		_reverse_port_map[actual] = formal;

	}
	else
		err = true;
	return(err);
}
	
// unmapped ports will be mapped to default
// pipes in parent if they exist.
bool hierSystemInstance::Map_Unmapped_Ports_To_Defaults( map<string, pair<int,int> >& pmap, set<string>& signals)
{
	bool err = false;
	vector<string> ports;

	_base_system->List_In_Pipe_Names(ports);
	_base_system->List_Out_Pipe_Names(ports);

	for(int I = 0, fI = ports.size(); I < fI; I++)
	{
		string f = ports[I];
		if(_port_map.find(f) == _port_map.end())
		{
			this->Report_Warning("mapping unmapped formal in instance " + this->Get_Id() + " to default: " + f);
			bool lerr = this->Add_Port_Mapping(f,f,pmap, signals);
			if(lerr)
				this->Report_Warning( "in mapping unmapped formal in instance " + this->Get_Id() + " to default (not found): " + f);
		
			err = err || lerr;
		}	
	}
	return(err);
}

void hierSystemInstance::Print(ostream& ofile)
{
	

	ofile << "$instance " << this->Get_Id() << " " <<  this->_base_system->Get_Library() << " : "
		<< this->_base_system->Get_Id() << " " << endl;
	for(map<string,string>::iterator iter = _port_map.begin(), fiter = _port_map.end(); iter != fiter; iter++)
		ofile << "   " << (*iter).first << " => " << (*iter).second << " " << endl;	
	ofile << endl;
}

void hierSystemInstance::Print_Vhdl(ostream& ofile)
{
	ofile << this->Get_Id() << ": " << this->Get_Base_System()->Get_Id() << endl;
	ofile << "port map ( --{ " << endl;
	for(map<string,string>::iterator iter = _port_map.begin(), fiter = _port_map.end(); iter != fiter; iter++)
	{
		string formal = (*iter).first;
		string actual = (*iter).second;

		bool formal_is_signal = this->Get_Base_System()->Is_Signal(formal);
		bool actual_is_signal = this->Get_Parent()->Is_Signal(actual);

		if(formal_is_signal != actual_is_signal)
		{
			this->Report_Error("port map mismatch.. signal-mode conflict.");
			continue;
		}

		if(formal_is_signal)
		{
			ofile << formal << " => " << actual << "," << endl;
			continue;
		}

		if(this->Get_Base_System()->Get_Input_Pipe_Width(formal) > 0)
		{ // formal is an input pipe?
			if(this->Get_Parent()->Get_Input_Pipe_Width(actual) > 0)
			{
				ofile << formal << "_pipe_write_data => " << actual << "_pipe_write_data," << endl;
				ofile << formal << "_pipe_write_req => " << actual << "_pipe_write_req," << endl;
				ofile << formal << "_pipe_write_ack => " << actual << "_pipe_write_ack," << endl;
			}
			else if(this->Get_Parent()->Get_Internal_Pipe_Width(actual) > 0)
			{
				// note cross-over.
				ofile << formal << "_pipe_write_data => " << actual << "_pipe_read_data," << endl;
				ofile << formal << "_pipe_write_req => " << actual << "_pipe_read_ack," << endl;
				ofile << formal << "_pipe_write_ack => " << actual << "_pipe_read_req," << endl;
			}
			else
			{
				this->Report_Error("appropriate actual " + actual + " not found.");
			}
		}	
		else if(this->Get_Base_System()->Get_Output_Pipe_Width(formal) > 0)
		{
			if(this->Get_Parent()->Get_Output_Pipe_Width(actual) > 0)
			{
				ofile << formal << "_pipe_read_data => " << actual << "_pipe_read_data," << endl;
				ofile << formal << "_pipe_read_req => " << actual << "_pipe_read_req," << endl;
				ofile << formal << "_pipe_read_ack => " << actual << "_pipe_read_ack," << endl;
			}
			else if(this->Get_Parent()->Get_Internal_Pipe_Width(actual) > 0)
			{
				// note cross-over.
				ofile << formal << "_pipe_read_data => " << actual << "_pipe_write_data," << endl;
				ofile << formal << "_pipe_read_req => " << actual << "_pipe_write_ack," << endl;
				ofile << formal << "_pipe_read_ack => " << actual << "_pipe_write_req," << endl;
			}
			else 
			{
				this->Report_Error("appropriate actual " + actual + " not found.");
			}
		}
	}
	ofile << "clk => clk, reset => reset " << endl;
	ofile << "); -- }" << endl;
}


void hierSystem::Print(ostream& ofile)
{

	ofile << endl;
	ofile << "$system " <<  this->_id << endl;
	ofile << "$library " << this->_library << endl;
	ofile << "$in " << endl;
	if(_in_pipes.size() > 0)
	{
		this->Print_Pipe_Map(_in_pipes, ofile);
		ofile << endl; 
	}
	ofile << "$out " << endl;
	if(_out_pipes.size() > 0)
	{
		this->Print_Pipe_Map(_out_pipes, ofile);
		ofile << endl; 
	}
	ofile << "{" << endl;
	if(_internal_pipes.size() > 0)
	{
		this->Print_Pipe_Map(_internal_pipes, ofile);
		ofile << endl; 
	}

	// print subsystems.
	for(map<string, hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();
			iter != fiter; iter++)
	{
		(*iter).second->Print(ofile);
	}

	// print threads.
	for(map<string, rtlThread*>::iterator titer = _thread_map.begin(), ftiter = _thread_map.end();
		titer != ftiter; titer++)
	{
		(*titer).second->Print(ofile);
	}

	// print thread instances.
	for(int iT=0, fiT = _rtl_strings.size(); iT < fiT; iT++)
	{
		_rtl_strings[iT]->Print(ofile);
	}

	ofile << "}" << endl;
}

void hierSystem::Print_Vhdl_Port_Declarations(ostream& ofile)
{
	ofile << " port( -- {" << endl ;
	for(map<string, pair<int,int> >::iterator iter = _in_pipes.begin(), fiter = _in_pipes.end();
		iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second.first;
		int pipe_depth   = (*iter).second.second;

		if(!this->Is_Signal(pipe_name))
		{
			ofile << pipe_name << "_pipe_write_data : in std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
			ofile << pipe_name << "_pipe_write_req  : in std_logic_vector(0  downto 0);" << endl;
			ofile << pipe_name << "_pipe_write_ack  : out std_logic_vector(0  downto 0);" << endl;
		}
		else
		{
			ofile << pipe_name << " : in std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		}
	}
	for(map<string, pair<int,int> >::iterator iter = _out_pipes.begin(), fiter = _out_pipes.end();
		iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second.first;
		int pipe_depth   = (*iter).second.second;

		if(!this->Is_Signal(pipe_name))
		{
			ofile << pipe_name << "_pipe_read_data : out std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
			ofile << pipe_name << "_pipe_read_req  : in std_logic_vector(0  downto 0);" << endl;
			ofile << pipe_name << "_pipe_read_ack  : out std_logic_vector(0  downto 0);" << endl;
		}
		else
		{
			ofile << pipe_name << " : out std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		}
	}
	ofile << " clk, reset: in std_logic " << endl; 
	ofile << " -- }" << endl;
	ofile << ");" <<endl;
}

void hierSystem::Print_Vhdl_Component_Declaration(ostream& ofile)
{
	ofile << "component " << this->Get_Id() << " is -- {" << endl;
	this->Print_Vhdl_Port_Declarations(ofile);
	ofile << "--}" << endl << "end component;" << endl;
}

void hierSystem::Print_Vhdl_Entity_Architecture(ostream& ofile)
{
        if(this->_child_map.size() == 0)
		return;

	ofile << "library ahir;" << endl;
	ofile << "use ahir.BaseComponents.all;" << endl;
	ofile << "library ieee;" << endl;
	ofile << "use ieee.std_logic_1164.all;" << endl;
	// library refs..
	for(map<string,hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();	
		iter != fiter; iter++)
	{
		hierSystemInstance* inst = (*iter).second;
		if(inst->Get_Base_System()->Get_Library() != "work")
		{
			ofile << "library " << inst->Get_Base_System()->Get_Library() << ";" << endl;
		}
	}

	// Entity..
	ofile << "entity " << this->Get_Id() << " is -- {" << endl;
	this->Print_Vhdl_Port_Declarations(ofile);
	ofile << "--} " << endl << "end entity " << this->Get_Id() << ";" << endl;

	ofile << "architecture struct of " << this->Get_Id() << " is -- {" << endl;
	for(map<string, pair<int,int> >::iterator iter = _internal_pipes.begin(), fiter = _internal_pipes.end();
		iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second.first;
		int pipe_depth   = (*iter).second.second;

		if(!this->Is_Signal(pipe_name))
		{
			ofile << "signal " << pipe_name << "_pipe_write_data : std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
			ofile << "signal " << pipe_name << "_pipe_write_req  : std_logic_vector(0  downto 0);" << endl;
			ofile << "signal " << pipe_name << "_pipe_write_ack  : std_logic_vector(0  downto 0);" << endl;

			ofile << "signal " << pipe_name << "_pipe_read_data : std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
			ofile << "signal " << pipe_name << "_pipe_read_req  : std_logic_vector(0  downto 0);" << endl;
			ofile << "signal " << pipe_name << "_pipe_read_ack  : std_logic_vector(0  downto 0);" << endl;
		}	
		else
		{
			ofile << "signal " << pipe_name << " : std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		}
	}

	// configuration specifications.
	for(map<string,hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();	
		iter != fiter; iter++)
	{
		hierSystemInstance* inst = (*iter).second;
		inst->Get_Base_System()->Print_Vhdl_Component_Declaration(ofile);
		if(inst->Get_Base_System()->Get_Library() != "work")
		{
			ofile << "for " << inst->Get_Id() << " :  " << inst->Get_Base_System()->Get_Id() << " -- { " << endl;
			ofile << "   use entity " << inst->Get_Base_System()->Get_Library() << "." 
				<< inst->Get_Base_System()->Get_Id() << "; -- } " << endl;
		}
	}
	ofile << "-- } " << endl;
	ofile << "begin -- { " << endl;
	for(map<string,hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();	
		iter != fiter; iter++)
	{
		(*iter).second->Print_Vhdl(ofile);
	}

	// print internal pipe instances.
	for(map<string, pair<int,int> >::iterator piter = _internal_pipes.begin(), fpiter = _internal_pipes.end();
		piter != fpiter; piter++)
	{
		bool signal_mode = this->Is_Signal((*piter).first);

		// signals are not printed as pipes..
		if(!signal_mode)
			this->Print_Vhdl_Pipe_Instance((*piter).first, (*piter).second.first, (*piter).second.second, ofile);
	}	
	ofile << "-- }" << endl;
	ofile << "end struct;" << endl;
}

void hierSystem::Print_Vhdl_Pipe_Instance(string pipe_name, int pipe_width, int pipe_depth, ostream& ofile)
{
	string inst_name = pipe_name + "_inst";
	ofile << inst_name << ": ";
	ofile << " PipeBase -- { " << endl;
	ofile << "generic map( -- { " << endl;
	ofile << "name => " << '"' << "pipe " << pipe_name << '"' << "," << endl;
	ofile << "num_reads => 1," << endl;
	ofile << "num_writes => 1," << endl;
	ofile << "data_width => " << pipe_width << "," << endl;
	ofile << "lifo_mode => false," << endl;
	ofile << "signal_mode => false," << endl;
	ofile << "depth => " << pipe_depth << " --}\n)" << endl;
	ofile << "port map( -- { " << endl;
	ofile << "read_req => " << pipe_name << "_pipe_read_req," << endl 
		<< "read_ack => " << pipe_name << "_pipe_read_ack," << endl 
		<< "read_data => "<< pipe_name << "_pipe_read_data," << endl 
		<< "write_req => " << pipe_name << "_pipe_write_req," << endl 
		<< "write_ack => " << pipe_name << "_pipe_write_ack," << endl 
		<< "write_data => "<< pipe_name << "_pipe_write_data," << endl 
		<< "clk => clk,"
		<< "reset => reset -- }\n ); -- }" << endl;
}


void hierSystem::Print_Vhdl_Instance_In_Testbench(string inst_name, ostream& ofile)
{
	ofile << inst_name << ": " << this->Get_Id() << endl;
	ofile << "port map ( --{ " << endl;
	for(map<string,pair<int,int> >::iterator iter = _in_pipes.begin(), fiter = _in_pipes.end(); iter != fiter; iter++)
	{
		string pipe_id = (*iter).first;
		int pipe_width = (*iter).second.first;

		if(!this->Is_Signal(pipe_id))
		{
			ofile << pipe_id << "_pipe_write_data => " << pipe_id << "_pipe_write_data," << endl;
			ofile << pipe_id << "_pipe_write_req => " << pipe_id << "_pipe_write_req," << endl;
			ofile << pipe_id << "_pipe_write_ack => " << pipe_id << "_pipe_write_ack," << endl;
		}
		else
		{
			ofile << pipe_id << " => " << pipe_id << "," << endl;
		}
	}
	for(map<string,pair<int,int> >::iterator iter = _out_pipes.begin(), fiter = _out_pipes.end(); iter != fiter; iter++)
	{
		string pipe_id = (*iter).first;
		int pipe_width = (*iter).second.first;


		if(!this->Is_Signal(pipe_id))
		{
			ofile << pipe_id << "_pipe_read_data => " << pipe_id << "_pipe_read_data," << endl;
			ofile << pipe_id << "_pipe_read_req => " << pipe_id << "_pipe_read_req," << endl;
			ofile << pipe_id << "_pipe_read_ack => " << pipe_id << "_pipe_read_ack," << endl;
		}
		else
		{
			ofile << pipe_id << " => " << pipe_id << "," << endl;
		}

	}
	ofile << "clk => clk, reset => reset " << endl;
	ofile << "); -- }" << endl;
}

// utility functions.

// write signal interfacing assignments in testbench.
// note: signals are pipes which behave like flags..
//
void Write_Signal_Interface_Assignments(int num_reads, int num_writes, string pipe_id, ostream& ofile)
{
	// skip internal pipes.
	if(num_reads > 0 && num_writes > 0)
		return;

	if(num_reads > 0 && num_writes ==  0)
	{
		ofile << pipe_id << "_pipe_write_ack(0) <= '1';" << endl;
		ofile << "TruncateOrPad(" << pipe_id << "_pipe_write_data," << pipe_id << ");" << endl;	
	}
	else if(num_writes > 0 && num_reads == 0)
	{
		ofile << pipe_id << "_pipe_read_ack(0) <= '1';" << endl;
		ofile << "TruncateOrPad(" << pipe_id << ", " << pipe_id << "_pipe_read_data);" << endl;	
	}
}

void Write_Pipe_Access_Process(string sim_link_prefix, string pipe_id, int pipe_width, int num_reads, int num_writes, ostream& ofile)
{
	if(num_reads > 0 && num_writes > 0)
		return;

	ofile << "process" << endl;
	ofile << "variable val_string, obj_ref: VhpiString;" << endl;
	ofile << "begin --{" << endl;
	ofile << "wait until reset = '0';" << endl;
	ofile << "while true loop -- {" << endl;
	ofile << "wait until clk = '0';" << endl;
	ofile << "wait for 1 ns; " << endl;

	// read the inputs from the outside...
	if(num_reads > 0 && num_writes ==  0)
	{
		ofile << "obj_ref := Pack_String_To_Vhpi_String("
			<< '"' << pipe_id << " req" << '"' << ");" << endl;
		ofile << sim_link_prefix << "Get_Port_Value(obj_ref,val_string,1);" << endl;
		ofile << pipe_id  << "_pipe_write_req <= Unpack_String(val_string,1);" << endl;

		ofile << "obj_ref := Pack_String_To_Vhpi_String("
			<< '"' << pipe_id << " 0" << '"' << ");" << endl;
		ofile << sim_link_prefix << "Get_Port_Value(obj_ref,val_string," << 
			pipe_width << ");" << endl;


		string arg_name = pipe_id + "_pipe_write_data";
		ofile << arg_name << " <= Unpack_String(val_string," <<  pipe_width << ");" << endl;
	}
	else if(num_reads == 0 && num_writes >  0)
	{

		ofile << "obj_ref := Pack_String_To_Vhpi_String("
			<< '"' << pipe_id << " req" << '"' << ");" << endl;
		ofile << sim_link_prefix << "Get_Port_Value(obj_ref,val_string,1);" << endl;
		ofile << pipe_id  << "_pipe_read_req <= Unpack_String(val_string,1);" << endl;
	}



	ofile << "wait until clk = '1';" << endl;
	if(num_reads > 0 && num_writes ==  0)
	{
		ofile << "obj_ref := Pack_String_To_Vhpi_String("
			<< '"' << pipe_id << " ack" << '"' << ");" << endl;
		ofile << "val_string := Pack_SLV_To_Vhpi_String(" << pipe_id << "_pipe_write_ack" << ");" << endl;
		ofile << sim_link_prefix << "Set_Port_Value(obj_ref,val_string,1);" << endl;
	}
	else if(num_reads == 0 && num_writes >  0)
	{
		ofile << "obj_ref := Pack_String_To_Vhpi_String("
			<< '"' << pipe_id << " ack" << '"' << ");" << endl;
		ofile << "val_string := Pack_SLV_To_Vhpi_String(" << pipe_id << "_pipe_read_ack" << ");" << endl;
		ofile << sim_link_prefix << "Set_Port_Value(obj_ref,val_string,1);" << endl;

		ofile << "obj_ref := Pack_String_To_Vhpi_String("
			<< '"' << pipe_id << " " << 0 << '"' << ");" << endl;
		string arg_name = pipe_id + "_pipe_read_data";
		ofile << "val_string := Pack_SLV_To_Vhpi_String(" << arg_name << ");" << endl;
		ofile << sim_link_prefix << "Set_Port_Value(obj_ref,val_string," << pipe_width << ");" << endl;
	}

	ofile << "-- }" << endl << "end loop;" << endl;
	ofile << "--}" << endl << "end process;" << endl << endl;
}

//
// generate a Vhpi-enabled--testbench so that the assembled system can be
// verified.  This reuses the existing code in vc2vhdl..
//
void hierSystem::Print_Vhdl_Test_Bench(string sim_link_library, string sim_link_prefix,  ostream& ofile)
{
        ofile 	<< "library ahir;\n" 
		<< "use ahir.memory_subsystem_package.all;\n"
		<< "use ahir.types.all;\n"
		<< "use ahir.subprograms.all;\n"
		<< "use ahir.components.all;\n"
		<< "use ahir.basecomponents.all;\n"
		<< "use ahir.operatorpackage.all;\n"
		<< "use ahir.utilities.all;\n";

	ofile << "library " << sim_link_library << ";"  << endl;
	ofile << "use "     << sim_link_library << ".Utility_Package.all;"  << endl;
	ofile << "use "     << sim_link_library << "." 
		<<   sim_link_prefix << "Foreign.all;" << endl;

	ofile << "library " << this->Get_Library() << ";"  << endl;

	ofile << "entity " << this->Get_Id() << "_Test_Bench is -- {" << endl;
	ofile << "-- }\n end entity;" << endl;

	ofile << "architecture VhpiLink of " << this->Get_Id() << "_Test_Bench is -- {" << endl;
	// signals
	for(map<string, pair<int,int> >::iterator iter = _in_pipes.begin(), fiter = _in_pipes.end();
			iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second.first;

		ofile << "signal " << pipe_name << "_pipe_write_data : std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_write_req  : std_logic_vector(0  downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_write_ack  : std_logic_vector(0  downto 0);" << endl;

		if(this->Is_Signal(pipe_name))
		{
			ofile << "signal " << pipe_name << ": std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		}

	}
	for(map<string, pair<int,int> >::iterator iter = _out_pipes.begin(), fiter = _out_pipes.end();
			iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second.first;

		ofile << "signal " << pipe_name << "_pipe_read_data : std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_read_req  : std_logic_vector(0  downto 0);" << endl;
		ofile << "signal " <<  pipe_name << "_pipe_read_ack  : std_logic_vector(0  downto 0);" << endl;

		if(this->Is_Signal(pipe_name))
		{
			ofile << "signal " << pipe_name << ": std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		}
	}
	ofile << "signal clk : std_logic := '0'; " << endl; 
	ofile << "signal reset: std_logic := '1'; " << endl; 
	this->Print_Vhdl_Component_Declaration(ofile);
	ofile << "for " << "dut :  " << this->Get_Id() << " -- { " << endl;
	ofile << "   use entity " << this->Get_Library() << "." 
			<< this->Get_Id() << "; -- } " << endl;

	ofile << "-- }\n begin --{" << endl;
	ofile << "-- clock/reset generation " << endl;
	ofile << "clk <= not clk after 5 ns;" << endl;
	ofile << "process" << endl;
	ofile << "begin --{" << endl;
	ofile << sim_link_prefix << "Initialize;" << endl;
	ofile << "wait until clk = '1';" << endl;
	ofile << "reset <= '0';" << endl;
	ofile << "while true loop --{" << endl;
	ofile << "wait until clk = '0';" << endl;
	ofile << sim_link_prefix << "Listen;" << endl;
	ofile << sim_link_prefix << "Send;" << endl;
	ofile << "--}" << endl << "end loop;" << endl;
	ofile << "wait;" << endl;
	ofile << "--}" << endl << "end process;" << endl << endl;

	// input pipe related code.
	for(map<string, pair<int,int> >::iterator pipe_iter = _in_pipes.begin(), fpiter = _in_pipes.end();
			pipe_iter != fpiter; pipe_iter++)
	{
		string pipe_id = (*pipe_iter).first;
		int pipe_width = (*pipe_iter).second.first;
		int num_reads = 1;
		int num_writes = 0;

		if(this->Is_Signal(pipe_id))
			Write_Signal_Interface_Assignments(num_reads, num_writes, pipe_id, ofile);

		Write_Pipe_Access_Process(sim_link_prefix, pipe_id, pipe_width, num_reads, num_writes,ofile); 
	}

	// output pipe related code.
	for(map<string, pair<int,int> >::iterator pipe_iter = _out_pipes.begin(), fpiter = _out_pipes.end();
			pipe_iter != fpiter; pipe_iter++)
	{
		string pipe_id = (*pipe_iter).first;
		int pipe_width = (*pipe_iter).second.first;
		int num_reads = 0;
		int num_writes = 1;

		if(this->Is_Signal(pipe_id))
			Write_Signal_Interface_Assignments(num_reads, num_writes, pipe_id, ofile);

		Write_Pipe_Access_Process(sim_link_prefix, pipe_id, pipe_width, num_reads, num_writes,ofile); 
	}

	this->Print_Vhdl_Instance_In_Testbench("dut", ofile);
	ofile << "-- }\n end VhpiLink;" << endl;
}


// check if connections are well formed.
bool hierSystem::Check_For_Errors()
{
	bool ret_val = false;
	if(this->Is_Leaf())
		return(ret_val);

	// check if all instances are connected ok..
	for(map<string, hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();
			iter != fiter; iter++)
	{
		hierSystemInstance* hi = (*iter).second;
		for(int J = 0, fJ = _subsystem_pipe_connection_map[hi].size(); J < fJ; J++)
		{
			string formal = _subsystem_pipe_connection_map[hi][J];
			string actual = hi->Get_Actual(formal);

			int formal_width = this->Get_Pipe_Width(formal);
			int actual_width = hi->Get_Base_System()->Get_Pipe_Width(actual);

			if(formal_width != actual_width)
			{
				this->Report_Error("Error: mismatched width between formal " + formal + " and actual " + actual);
				ret_val = true;
			}

			if(hi->Get_Base_System()->Get_Input_Pipe_Width(actual) > 0)
			{ // if actual is input pipe, then formal must be either 
				// internal or an input pipe.
				if(this->Get_Output_Pipe_Width(formal) > 0)
				{
					this->Report_Error("Error: formal out-pipe " +  formal 
						+ " mapped to actual in-pipe in instance " + hi->Get_Id());
					ret_val = true;
				}
				else 
				{
					formal_width = this->Get_Pipe_Width(formal);
				}
			}
			else if(hi->Get_Base_System()->Get_Output_Pipe_Width(actual) > 0)
			{
				if(this->Get_Input_Pipe_Width(formal) > 0)
				{
					cerr << "Error: formal in-pipe " <<  formal 
						<< " mapped to actual out-pipe in instance " << hi->Get_Id() << endl;
					ret_val = true;
				}
			}
			else if(hi->Get_Base_System()->Get_Internal_Pipe_Width(actual) > 0)
			{
				cerr << "Error: "
					<< " to actual internal-pipe is mapped in instance " << hi->Get_Id() << endl;
				ret_val = true;
			}
		}	

	}


	// check that all internal pipes are mapped as both drivers
	// and driven.
	vector<string> internal_pipes;
	this->List_Internal_Pipe_Names(internal_pipes);
	for(int I = 0, fI = internal_pipes.size(); I < fI; I++)
	{
		string pname = internal_pipes[I];
		if(!this->Is_Driving_Pipe(pname))
		{
			hierRoot::Report_Error("in " + this->Get_Id() + ", internal pipe " + pname + " does not drive anything.");
			ret_val = true;
		}
		if(!this->Is_Driven_Pipe(pname))
		{
			hierRoot::Report_Error("in " + this->Get_Id() + ", internal pipe " + pname + " is not driven.");
			ret_val = true;
		}
	}

	vector<string> in_pipes;
	this->List_In_Pipe_Names(internal_pipes);
	for(int I = 0, fI = in_pipes.size(); I < fI; I++)
	{
		string pname = in_pipes[I];
		if(!this->Is_Driving_Pipe(pname))
		{
			hierRoot::Report_Error("in " + this->Get_Id() + ", in pipe " + pname + " does not drive anything.");
			ret_val = true;
		}
		
	}

	vector<string> out_pipes;
	this->List_Out_Pipe_Names(out_pipes);
	for(int I = 0, fI = out_pipes.size(); I < fI; I++)
	{
		string pname = out_pipes[I];
		if(!this->Is_Driven_Pipe(pname))
		{
			this->Report_Error("in " + this->Get_Id() + ", out pipe " + pname + " is not driven by anything.");
			ret_val = true;
		}
		
	}
	return(ret_val);
}

void listPipeMap(map<string, pair<int,int> >& pmap, vector<string>& pvec)
{
	for(map<string, pair<int,int> >::iterator iter = pmap.begin(), fiter = pmap.end();
		iter != fiter; 
		iter++)
	{
		pvec.push_back((*iter).first);
	}
}

bool getPipeInfoFromGlobals(string pname, map<string, pair<int,int> >& pmap, 
	set<string>& signals, int& width, int& depth, bool& is_signal)
{
	if(pmap.find(pname) == pmap.end())
		return(true);

	width = pmap[pname].first;
	depth = pmap[pname].second;

	is_signal = (signals.find(pname) != signals.end());
	return(false);
}
	

void addPipeToGlobalMaps(string oname, map<string, pair<int,int> >& pipe_map, 
				set<string>& signals, int pipe_width, int pipe_depth, bool is_signal)
{
		std::cerr << "Info: adding pipe " << oname << " width = " << pipe_width << ", depth = " 
			<< pipe_depth << " to global map " << endl;

		pipe_map[oname].first  = pipe_width;
		pipe_map[oname].second = pipe_depth;

		if(is_signal)
		{
			std::cerr << "Info: marking pipe " << oname << " as a signl in global set." << endl;
			signals.insert(oname);
		}
}

