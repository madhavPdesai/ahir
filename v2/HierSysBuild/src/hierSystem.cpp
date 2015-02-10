#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>

void hierSystemInstance::Add_Port_Mapping(string formal, string actual)
{
	if(_base_system->Has_Port(formal))
	{
		if(_port_map.find(formal) != _port_map.end())
		{
			cerr << "Error: formal port " << formal << " multiply mapped in instance " << _id << endl;
			this->Set_Error(true);
		}
		_port_map[formal] = actual;

		if(_reverse_port_map.find(actual) != _reverse_port_map.end())
		{
			cerr << "Error: actual port " << actual << " multiply mapped in instance " << _id << endl;
			this->Set_Error(true);
		}	
		_reverse_port_map[actual] = formal;
	}
}

void hierSystemInstance::Print(ostream& ofile)
{
	ofile << "$compinst " << this->Get_Id() << " " << this->_base_system->Get_Id() << " " << endl;
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

		// check if actual is an input or output pipe.
		if(this->Get_Base_System()->Get_Input_Pipe_Width(formal) > 0)
		{
			if(this->Get_Parent()->Get_Input_Pipe_Width(actual) > 0)
			{
				// formal and actual are input pipes.
				ofile << formal << "_pipe_write_data => " << actual << "_pipe_write_data," << endl;
				ofile << formal << "_pipe_write_req => " << actual << "_pipe_write_req," << endl;
				ofile << formal << "_pipe_write_ack => " << actual << "_pipe_write_ack," << endl;
			}
			else
			{
				// formal is input  and actual is internal
				ofile << formal << "_pipe_write_data => " << actual << "_pipe_data," << endl;
				ofile << formal << "_pipe_write_req => " << actual << "_pipe_read_ack_write_req," << endl;
				ofile << formal << "_pipe_write_ack => " << actual << "_pipe_read_req_write_ack," << endl;
			}
		}	
		else if(this->Get_Base_System()->Get_Output_Pipe_Width(formal) > 0)
		{
			if(this->Get_Parent()->Get_Output_Pipe_Width(actual) > 0)
			{
				// formal  and actual are output pipes.
				ofile << formal << "_pipe_read_data => " << actual << "_pipe_read_data," << endl;
				ofile << formal << "_pipe_read_req => " << actual << "_pipe_read_req," << endl;
				ofile << formal << "_pipe_read_ack => " << actual << "_pipe_read_ack," << endl;
			}
			else
			{
				// formal is output  and actual is internal
				ofile << formal << "_pipe_read_data => " << actual << "_pipe_data," << endl;
				ofile << formal << "_pipe_read_req => " << actual << "_pipe_read_req_write_ack," << endl;
				ofile << formal << "_pipe_read_ack => " << actual << "_pipe_read_ack_write_req," << endl;
			}
		}
	}
	ofile << "clk => clk, reset => reset " << endl;
	ofile << "); -- }" << endl;
}


void hierSystem::Print(ostream& ofile)
{

	ofile << endl;
	ofile << "$system " << this->_id << endl;
	if(_in_pipes.size() > 0)
	{
		ofile << "$ipipe " ;
		this->Print_Pipe_Map(_in_pipes, ofile);
		ofile << endl; 
	}
	if(_out_pipes.size() > 0)
	{
		ofile << "$opipe " ;
		this->Print_Pipe_Map(_out_pipes, ofile);
		ofile << endl; 
	}
	ofile << "{" << endl;
	if(_internal_pipes.size() > 0)
	{
		ofile << "$pipe " ;
		this->Print_Pipe_Map(_internal_pipes, ofile);
		ofile << endl; 
	}

	// print subsystems.
	for(map<string, hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();
			iter != fiter; iter++)
	{
		(*iter).second->Print(ofile);
	}
	ofile << "}" << endl;
}

void hierSystem::Print_Vhdl_Port_Declarations(ostream& ofile)
{
	ofile << " port( -- {" << endl ;
	for(map<string, int>::iterator iter = _in_pipes.begin(), fiter = _in_pipes.end();
		iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second;

		ofile << pipe_name << "_pipe_write_data : in std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << pipe_name << "_pipe_write_req  : out std_logic_vector(0  downto 0);" << endl;
		ofile << pipe_name << "_pipe_write_ack  : in std_logic_vector(0  downto 0);" << endl;
	}
	for(map<string, int>::iterator iter = _out_pipes.begin(), fiter = _out_pipes.end();
		iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second;

		ofile << pipe_name << "_pipe_read_data : out std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << pipe_name << "_pipe_read_req  : out std_logic_vector(0  downto 0);" << endl;
		ofile << pipe_name << "_pipe_read_ack  : in std_logic_vector(0  downto 0);" << endl;
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

	ofile << "library work;" << endl;
	ofile << "use work.HierSysComponentPackage.all;" << endl;
	ofile << "library ieee;" << endl;
	ofile << "use ieee.std_logic_1164.all;" << endl;
	// library refs..
	for(map<string,hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();	
		iter != fiter; iter++)
	{
		hierSystemInstance* inst = (*iter).second;
		if(inst->Get_Base_System()->Is_Leaf() && (inst->Get_Base_System()->Get_Library() != "work"))
		{
			ofile << "library " << inst->Get_Base_System()->Get_Library() << ";" << endl;
		}
	}

	// Entity..
	ofile << "entity " << this->Get_Id() << " is -- {" << endl;
	this->Print_Vhdl_Port_Declarations(ofile);
	ofile << "--} " << endl << "end entity " << this->Get_Id() << ";" << endl;

	ofile << "architecture struct of " << this->Get_Id() << " is " << endl;
	for(map<string, int>::iterator iter = _internal_pipes.begin(), fiter = _internal_pipes.end();
		iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second;

		ofile << "signal " << pipe_name << "_pipe_data : std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_read_req_write_ack  : std_logic_vector(0  downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_read_ack_write_req  : std_logic_vector(0  downto 0);" << endl;
	}

	// configuration specifications.
	for(map<string,hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();	
		iter != fiter; iter++)
	{
		hierSystemInstance* inst = (*iter).second;
		if(inst->Get_Base_System()->Is_Leaf() && (inst->Get_Base_System()->Get_Library() != "work"))
		{
			ofile << "for " << inst->Get_Id() << " :  " << inst->Get_Base_System()->Get_Id() << " -- { " << endl;
			ofile << "   use entity " << inst->Get_Base_System()->Get_Library() << "." 
				<< inst->Get_Base_System()->Get_Id() << "; -- } " << endl;
		}
	}
	ofile << "begin " << endl;
	for(map<string,hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();	
		iter != fiter; iter++)
	{
		(*iter).second->Print_Vhdl(ofile);
	}
	ofile << "end struct;" << endl;
}

void hierSystem::Print_Vhdl_Instance_In_Testbench(string inst_name, ostream& ofile)
{
	ofile << inst_name << ": " << this->Get_Id() << endl;
	ofile << "port map ( --{ " << endl;
	for(map<string,int>::iterator iter = _in_pipes.begin(), fiter = _in_pipes.end(); iter != fiter; iter++)
	{
		string pipe_id = (*iter).first;
		int pipe_width = (*iter).second;

		ofile << pipe_id << "_pipe_write_data => " << pipe_id << "_pipe_write_data," << endl;
		ofile << pipe_id << "_pipe_write_req => " << pipe_id << "_pipe_write_req," << endl;
		ofile << pipe_id << "_pipe_write_ack => " << pipe_id << "_pipe_write_ack," << endl;
	}
	for(map<string,int>::iterator iter = _out_pipes.begin(), fiter = _out_pipes.end(); iter != fiter; iter++)
	{
		string pipe_id = (*iter).first;
		int pipe_width = (*iter).second;

		ofile << pipe_id << "_pipe_read_data => " << pipe_id << "_pipe_read_data," << endl;
		ofile << pipe_id << "_pipe_read_req => " << pipe_id << "_pipe_read_req," << endl;
		ofile << pipe_id << "_pipe_read_ack => " << pipe_id << "_pipe_read_ack," << endl;
	}
	ofile << "clk => clk, reset => reset " << endl;
	ofile << "); -- }" << endl;
}

// utility function.
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
	ofile << "library " << sim_link_library << ";"  << endl;
	ofile << "use "     << sim_link_library << ".Utility_Package.all;"  << endl;
	ofile << "use "     << sim_link_library << "." 
		<<   sim_link_prefix << "Foreign.all;" << endl;

	ofile << "entity " << this->Get_Id() << "_Test_Bench is -- {" << endl;
	ofile << "-- }\n end entity;" << endl;

	ofile << "architecture VhpiLink of " << this->Get_Id() << "_Test_Bench is -- {" << endl;
	this->Print_Vhdl_Component_Declaration(ofile);
	// signals
	for(map<string, int>::iterator iter = _in_pipes.begin(), fiter = _in_pipes.end();
			iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second;

		ofile << "signal " << pipe_name << "_pipe_read_data : std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_read_req  : std_logic_vector(0  downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_read_ack  : std_logic_vector(0  downto 0);" << endl;
	}
	for(map<string, int>::iterator iter = _out_pipes.begin(), fiter = _out_pipes.end();
			iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second;

		ofile << "signal " << pipe_name << "_pipe_write_data : std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_write_req  : std_logic_vector(0  downto 0);" << endl;
		ofile << "signal " <<  pipe_name << "_pipe_write_ack  : std_logic_vector(0  downto 0);" << endl;
	}
	ofile << "signal clk, reset: std_logic; " << endl; 
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
	for(map<string, int>::iterator pipe_iter = _in_pipes.begin(), fpiter = _in_pipes.end();
			pipe_iter != fpiter; pipe_iter++)
	{
		string pipe_id = (*pipe_iter).first;
		int pipe_width = (*pipe_iter).second;
		int num_reads = 1;
		int num_writes = 0;

		Write_Pipe_Access_Process(sim_link_prefix, pipe_id, pipe_width, num_reads, num_writes,ofile); 
	}

	// output pipe related code.
	for(map<string, int>::iterator pipe_iter = _in_pipes.begin(), fpiter = _in_pipes.end();
			pipe_iter != fpiter; pipe_iter++)
	{
		string pipe_id = (*pipe_iter).first;
		int pipe_width = (*pipe_iter).second;
		int num_reads = 0;
		int num_writes = 1;

		Write_Pipe_Access_Process(sim_link_prefix, pipe_id, pipe_width, num_reads, num_writes,ofile); 
	}

	this->Print_Vhdl_Instance_In_Testbench("dut", ofile);
	ofile << "-- }\n end VhpiLink;" << endl;
}


// check if connections are well formed.
bool hierSystem::Check_For_Errors()
{
	bool ret_val = false;
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
				cerr << "Error: mismatched width between formal " << formal << " and actual " << actual << endl;
				ret_val = true;
			}

			if(hi->Get_Base_System()->Get_Input_Pipe_Width(actual) > 0)
			{ // if actual is input pipe, then formal must be either 
				// internal or an input pipe.
				if(this->Get_Output_Pipe_Width(formal) > 0)
				{
					cerr << "Error: formal out-pipe " <<  formal 
						<< " mapped to actual in-pipe in instance " << hi->Get_Id() << endl;
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
}
