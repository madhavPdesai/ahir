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
				ofile << formal << "_pipe_read_data => " << actual << "_pipe_read_data," << endl;
				ofile << formal << "_pipe_read_req => " << actual << "_pipe_read_req," << endl;
				ofile << formal << "_pipe_read_ack => " << actual << "_pipe_read_ack," << endl;
			}
			else
			{
				// formal is input  and actual is internal
				ofile << formal << "_pipe_read_data => " << actual << "_pipe_data," << endl;
				ofile << formal << "_pipe_read_req => " << actual << "_pipe_read_req_write_ack," << endl;
				ofile << formal << "_pipe_read_ack => " << actual << "_pipe_read_ack_write_req," << endl;
			}
		}	
		else if(this->Get_Base_System()->Get_Output_Pipe_Width(formal) > 0)
		{
			if(this->Get_Parent()->Get_Output_Pipe_Width(actual) > 0)
			{
				// formal  and actual are output pipes.
				ofile << formal << "_pipe_write_data => " << actual << "_pipe_write_data," << endl;
				ofile << formal << "_pipe_write_req => " << actual << "_pipe_write_req," << endl;
				ofile << formal << "_pipe_write_ack => " << actual << "_pipe_write_ack," << endl;
			}
			else
			{
				// formal is output  and actual is internal
				ofile << formal << "_pipe_write_data => " << actual << "_pipe_data," << endl;
				ofile << formal << "_pipe_write_req => " << actual << "_pipe_read_ack_write_req," << endl;
				ofile << formal << "_pipe_write_ack => " << actual << "_pipe_read_req_write_ack," << endl;
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
	ofile << " port( -- {" ;
	ofile << " clk, reset: in std_logic; " << endl; 
	for(map<string, int>::iterator iter = _in_pipes.begin(), fiter = _in_pipes.end();
		iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second;

		ofile << pipe_name << "_pipe_read_data : in std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << pipe_name << "_pipe_read_req  : out std_logic_vector(0  downto 0);" << endl;
		ofile << pipe_name << "_pipe_read_ack  : in std_logic_vector(0  downto 0);" << endl;
	}
	for(map<string, int>::iterator iter = _out_pipes.begin(), fiter = _out_pipes.end();
		iter != fiter; iter++)
	{
		string pipe_name = (*iter).first;
		int pipe_width   = (*iter).second;

		ofile << pipe_name << "_pipe_write_data : out std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
		ofile << pipe_name << "_pipe_write_req  : out std_logic_vector(0  downto 0);" << endl;
		ofile << pipe_name << "_pipe_write_ack  : in std_logic_vector(0  downto 0);" << endl;
	}
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
		ofile << "signal " << pipe_name << "_pipe_read_ack_write_req  : std_logic_vector(0  downto 0);" << endl;
		ofile << "signal " << pipe_name << "_pipe_read_req_write_ack  : std_logic_vector(0  downto 0);" << endl;
	}
	ofile << "begin " << endl;
	for(map<string,hierSystemInstance*>::iterator iter = _child_map.begin(), fiter = _child_map.end();	
		iter != fiter; iter++)
	{
		(*iter).second->Print_Vhdl(ofile);
	}
	ofile << "end struct;" << endl;
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
