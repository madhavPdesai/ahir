#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>

// optionflags 
bool vcSystem::_verbose_flag = false;
bool vcSystem::_opt_flag = false;
bool vcSystem::_vhpi_tb_flag = false;


// set on error.
bool vcSystem::_error_flag = false;

// if there are at most 16 addressable locations in a memory space, make
// it a register bank (instead of a memory subsystem)
int vcSystem::_register_bank_threshold = 16;

// standard simulator will be Modelsim_FLI
string vcSystem::_simulator_prefix = "Modelsim_FLI_";


vcSystem::vcSystem(string id):vcRoot(id)
{
}
void vcSystem::Print(ostream& ofile)
{
  this->Print_Pipes(ofile);

  // memory spaces
  for(map<string,vcMemorySpace*>::iterator msiter = _memory_space_map.begin();
      msiter != _memory_space_map.end();
      msiter++)
    {
      (*msiter).second->Print(ofile);
    }

  // modules
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Print(ofile);
    }

  // attributes
  this->Print_Attributes(ofile);
}


void vcSystem::Print_Pipes(ostream& ofile)
{
  for(map<string,int>::iterator piter = this->_pipe_map.begin();
      piter != this->_pipe_map.end();
      piter++)
    {
      int pipe_depth = this->Get_Pipe_Depth((*piter).first);

      ofile << vcLexerKeywords[__PIPE] << " [" << (*piter).first << "] " << (*piter).second << " " <<
	vcLexerKeywords[__DEPTH] << " " << pipe_depth << endl;
    }
}

void vcSystem::Add_Module(vcModule* module)
{
  assert(this->_modules.find(module->Get_Id()) == this->_modules.end());
  this->_modules[module->Get_Id()] = module;
}

void vcSystem::Add_Constant_Wire(string obj_name, vcValue* v)
{
  assert(this->_constant_map.find(obj_name) == this->_constant_map.end());
  this->_constant_map[obj_name] = new vcConstantWire(obj_name,v);
}

void vcSystem::Set_As_Top_Module(string module_name)
{
  vcModule* m = this->Find_Module(module_name);
  if(m == NULL)
    vcSystem::Error("did not find module " + module_name + " in the system");
  else
    this->Set_As_Top_Module(m);
}

void vcSystem::Set_As_Top_Module(vcModule* module)
{
  this->_top_module_set.insert(module);
}

bool vcSystem::Is_A_Top_Module(vcModule* m)
{
  return(this->_top_module_set.find(m) != this->_top_module_set.end());
}

void vcSystem::Set_As_Ever_Running_Top_Module(string module_name)
{
  vcModule* m = this->Find_Module(module_name);
  if(m == NULL)
    vcSystem::Error("did not find module " + module_name + " in the system");
  else
  {
    if((m->Get_Number_Of_Input_Arguments() == 0) &&
	(m->Get_Number_Of_Output_Arguments() == 0))
	{
    		this->Set_As_Ever_Running_Top_Module(m);
	}
    else
	{
    		vcSystem::Error("module " + module_name + " cannot be set as ever-running (such modules cannot have in/out arguments)");
	}
  }
}

void vcSystem::Set_As_Ever_Running_Top_Module(vcModule* module)
{
  this->_ever_running_top_module_set.insert(module);
}

bool vcSystem::Is_An_Ever_Running_Top_Module(vcModule* m)
{
  return(this->_ever_running_top_module_set.find(m) != this->_ever_running_top_module_set.end());
}

void vcSystem::Add_Memory_Space(vcMemorySpace* ms)
{
  assert(ms != NULL);
  string m_id = ms->Get_Id();
  
  assert(this->_memory_space_map.find(m_id) == this->_memory_space_map.end());
  this->_memory_space_map[m_id] = ms;
}

vcMemorySpace* vcSystem::Find_Memory_Space(string module_name, string ms_name)
{
  if(module_name == "")
    return(this->Find_Memory_Space(ms_name));

  vcModule* m = this->Find_Module(module_name);
  if(m==NULL)
    return(NULL);

  return(m->Find_Memory_Space(ms_name));
}

vcMemorySpace* vcSystem::Find_Memory_Space(string ms_name)
{
  vcMemorySpace* ret_space = NULL;
  map<string, vcMemorySpace*>::iterator iter = this->_memory_space_map.find(ms_name);
  if(iter != this->_memory_space_map.end())
    ret_space = (*iter).second;
  return(ret_space);
}
vcModule* vcSystem::Find_Module(string m_name)
{
  vcModule* ret_module = NULL;
  map<string, vcModule*>::iterator iter = this->_modules.find(m_name);
  if(iter != this->_modules.end())
    ret_module = (*iter).second;
  return(ret_module);
}

void vcSystem::Elaborate()
{
  this->Check_Control_Structure();
  this->Compute_Compatibility_Labels();
  this->Compute_Maximal_Groups();
  

}
 

void vcSystem::Error(string err_msg)
{
  cerr << "Error: " << err_msg << endl;
  vcSystem::_error_flag = true;
}

void vcSystem::Warning(string err_msg)
{
  cerr << "Warning: " << err_msg << endl;
}

void vcSystem::Info(string err_msg)
{
  cerr << "Info: " << err_msg << endl;
}


bool vcSystem::Get_Error_Flag()
{
  return(vcSystem::_error_flag);
}



void vcSystem::Check_Control_Structure()
{
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Check_Control_Structure();
    }
}
void vcSystem::Compute_Compatibility_Labels()
{
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Compute_Compatibility_Labels();
    }
}

void vcSystem::Compute_Maximal_Groups()
{
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Compute_Maximal_Groups();
    }
}

void vcSystem::Print_Control_Structure(ostream& ofile)
{
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Print_Control_Structure(ofile);
    }
}

void  vcSystem::Print_VHDL(ostream& ofile)
{

  cerr << "Info: printing VHDL model" << endl;

  // print types.
  ofile << "library ieee;" << endl
	<< "use ieee.std_logic_1164.all;" << endl;
  ofile << "package vc_system_package is -- { " << endl;
  this->Print_VHDL_Constant_Declarations(ofile);
  ofile << "-- } " << endl <<  "end package vc_system_package;" << endl;
  
  // print modules
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {

      cerr << "Info: printing VHDL model for module " << (*moditer).first << endl;
      (*moditer).second->Print_VHDL(ofile);
    }

  this->Print_VHDL_Inclusions(ofile);
  this->Print_VHDL_Entity(ofile);
  this->Print_VHDL_Architecture(ofile);

  cerr << "Info: finished printing VHDL model" << endl;
}

void vcSystem::Print_VHDL_Constant_Declarations(ostream& ofile)
{
  for(map<string,vcConstantWire*>::iterator iter = _constant_map.begin();
      iter != _constant_map.end();
      iter++)
    {
      (*iter).second->Print_VHDL_Constant_Declaration(ofile);
    }
}

void vcSystem::Print_VHDL_Test_Bench(ostream& ofile) 
{
  this->Print_VHDL_Inclusions(ofile);

  ofile << "entity " << this->Get_VHDL_Id() << "_Test_Bench is -- {" << endl;
  ofile << "-- }\n end entity;" << endl;

  ofile << "architecture Default of " << this->Get_VHDL_Id() << "_Test_Bench is -- {" << endl;
  this->Print_VHDL_Component(ofile);
  this->Print_VHDL_Test_Bench_Signals(ofile);
  ofile << "-- }\n begin --{" << endl;


  ofile << "-- clock/reset generation " << endl;
  ofile << "clk <= not clk after 5 ns;" << endl;
  ofile << "process" << endl;
  ofile << "begin --{" << endl;
  ofile << "wait until clk = '1';" << endl;
  ofile << "reset <= '0';" << endl;
  ofile << "wait;" << endl;
  ofile << "--}" << endl << "end process;" << endl << endl;

  ofile << "-- a rudimentary tb.. will start all the top-level modules .." << endl;
  for(set<vcModule*,vcRoot_Compare>::iterator iter = _top_module_set.begin();
      iter != _top_module_set.end();
      iter++)
    {
	// if ever-running, tb doesnt get into the picture..
      if(this->Is_An_Ever_Running_Top_Module(*iter))
	continue;

      string prefix = (*iter)->Get_VHDL_Id() + "_";
      string start = prefix + "start";
      string fin = prefix + "fin";

      ofile << "process" << endl;
      ofile << "begin --{" << endl;
      ofile << "wait until clk = '1';" << endl;
      ofile << start << " <= '1';" << endl;
      ofile << "wait until clk = '1';" << endl;
      ofile << start << " <= '0';" << endl;
      ofile << "while " << fin << " /= '1' loop -- {" << endl;
      ofile << "wait until clk = '1';" << endl;
      ofile << "-- } " << endl << "end loop;" << endl;
      ofile << "wait;" << endl;
      ofile << "--}" << endl << "end process;" << endl << endl;
    }


  this->Print_VHDL_Instance(ofile);
  ofile << "-- }\n end Default;" << endl;
}


void vcSystem::Print_VHDL_Vhpi_Test_Bench(ostream& ofile) 
{
  this->Print_VHDL_Inclusions(ofile);
  string simulator_prefix = vcSystem::_simulator_prefix;

  ofile << "use work.Utility_Package.all;" << endl;
  ofile << "use work." << simulator_prefix << "Foreign.all;" << endl;

  ofile << "entity " << this->Get_VHDL_Id() << "_Test_Bench is -- {" << endl;
  ofile << "-- }\n end entity;" << endl;

  ofile << "architecture VhpiLink of " << this->Get_VHDL_Id() << "_Test_Bench is -- {" << endl;
  this->Print_VHDL_Component(ofile);
  this->Print_VHDL_Test_Bench_Signals(ofile);
  ofile << "-- }\n begin --{" << endl;


  ofile << "-- clock/reset generation " << endl;
  ofile << "clk <= not clk after 5 ns;" << endl;
  ofile << "process" << endl;
  ofile << "begin --{" << endl;
  ofile << simulator_prefix << "Initialize;" << endl;
  ofile << "wait until clk = '1';" << endl;
  ofile << "reset <= '0';" << endl;
  ofile << "while true loop --{" << endl;
  ofile << "wait until clk = '0';" << endl;
  ofile << simulator_prefix << "Listen;" << endl;
  ofile << simulator_prefix << "Send;" << endl;
  ofile << "--}" << endl << "end loop;" << endl;
  ofile << "wait;" << endl;
  ofile << "--}" << endl << "end process;" << endl << endl;

  ofile << "-- connect all the top-level modules to Vhpi" << endl;
  for(set<vcModule*,vcRoot_Compare>::iterator iter = _top_module_set.begin();
      iter != _top_module_set.end();
      iter++)
    {
      vcModule* m = (*iter);

      if(this->Is_An_Ever_Running_Top_Module(m))
	continue;

      string prefix = m->Get_VHDL_Id() + "_";
      string start = prefix + "start";
      string fin = prefix + "fin";

      ofile << "process" << endl;
      ofile << "variable val_string, obj_ref: VhpiString;" << endl;
      ofile << "begin --{" << endl;
      ofile << "wait until reset = '0';" << endl;
      ofile << "while true loop -- {" << endl;
      ofile << "wait until clk = '0';" << endl;
      ofile << "wait for 1 ns;" << endl;
      // now read all inputs 
      // first the req.
      ofile << "obj_ref := Pack_String_To_VHPI_String("
	    << '"' << m->Get_Id() << " req" << '"' << ");" << endl;
      ofile << simulator_prefix << "Get_Port_Value(obj_ref,val_string,1);" << endl;
      ofile << start << " <= To_Std_Logic(val_string);" << endl;

      // the input arguments
      for(int idx = 0; idx < m->Get_Number_Of_Input_Arguments(); idx++)
	{
	  vcWire* w = m->Get_Argument(m->Get_Input_Argument(idx),"in");
	  ofile << "obj_ref := Pack_String_To_Vhpi_String("
		<< '"' << m->Get_Id() << " " << idx << '"' << ");" << endl;
	  ofile << simulator_prefix << "Get_Port_Value(obj_ref,val_string, " << w->Get_Size() << ");" << endl;

	  string arg_name = prefix + w->Get_VHDL_Id();

	  ofile << arg_name << " <= Unpack_String(val_string," << w->Get_Size() << ");" << endl;
	}

      ofile << "wait until clk = '1';" << endl;

      // first the ack.
      ofile << "obj_ref := Pack_String_To_Vhpi_String("
	    << '"' << m->Get_Id() << " ack" << '"' << ");" << endl;
      ofile << "val_string := To_String(" << fin << ");" << endl;
      ofile << simulator_prefix << "Set_Port_Value(obj_ref,val_string,1);" << endl;

      // the output arguments.
      for(int idx = 0; idx < m->Get_Number_Of_Output_Arguments(); idx++)
	{
	  vcWire* w = m->Get_Argument(m->Get_Output_Argument(idx),"out");
	  ofile << "obj_ref := Pack_String_To_Vhpi_String("
		<< '"' << m->Get_Id() << " " << idx << '"' << ");" << endl;

	  string arg_name = prefix + w->Get_VHDL_Id();

	  ofile << "val_string := Pack_SLV_To_Vhpi_String(" << arg_name << ");" << endl;

	  ofile << simulator_prefix << "Set_Port_Value(obj_ref,val_string," << w->Get_Size() << ");" << endl;
	}

      
      ofile << "-- }" << endl << "end loop;" << endl;
      ofile << "--}" << endl << "end process;" << endl << endl;
    }


  // connect all top-level ports to Vhpi..
  for(map<string, int>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      string pipe_id = (*pipe_iter).first;
      int pipe_width = (*pipe_iter).second;
      
      int num_reads = this->Get_Num_Pipe_Reads(pipe_id);
      int num_writes = this->Get_Num_Pipe_Writes(pipe_id);
      
      // skip internal pipes.
      if(num_reads > 0 && num_writes > 0)
	continue;

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
	  ofile << simulator_prefix << "Get_Port_Value(obj_ref,val_string,1);" << endl;
	  ofile << pipe_id  << "_pipe_write_req <= Unpack_String(val_string,1);" << endl;
	  
	  ofile << "obj_ref := Pack_String_To_Vhpi_String("
		<< '"' << pipe_id << " 0" << '"' << ");" << endl;
	  ofile << simulator_prefix << "Get_Port_Value(obj_ref,val_string," << pipe_width << ");" << endl;
	      
	  string arg_name = pipe_id + "_pipe_write_data";
	  ofile << arg_name << " <= Unpack_String(val_string," << pipe_width << ");" << endl;
	}
      else if(num_reads == 0 && num_writes >  0)
	{
	  ofile << "obj_ref := Pack_String_To_Vhpi_String("
		<< '"' << pipe_id << " req" << '"' << ");" << endl;
	  ofile << simulator_prefix << "Get_Port_Value(obj_ref,val_string,1);" << endl;
	  ofile << pipe_id  << "_pipe_read_req <= Unpack_String(val_string,1);" << endl;
	}


    
      ofile << "wait until clk = '1';" << endl;
      if(num_reads > 0 && num_writes ==  0)
	{
	  ofile << "obj_ref := Pack_String_To_Vhpi_String("
		<< '"' << pipe_id << " ack" << '"' << ");" << endl;
	  ofile << "val_string := Pack_SLV_To_Vhpi_String(" << pipe_id << "_pipe_write_ack" << ");" << endl;
	  ofile << simulator_prefix << "Set_Port_Value(obj_ref,val_string,1);" << endl;
	}
      else if(num_reads == 0 && num_writes >  0)
	{
	  ofile << "obj_ref := Pack_String_To_Vhpi_String("
		<< '"' << pipe_id << " ack" << '"' << ");" << endl;
	  ofile << "val_string := Pack_SLV_To_Vhpi_String(" << pipe_id << "_pipe_read_ack" << ");" << endl;
	  ofile << simulator_prefix << "Set_Port_Value(obj_ref,val_string,1);" << endl;

	  ofile << "obj_ref := Pack_String_To_Vhpi_String("
		<< '"' << pipe_id << " " << 0 << '"' << ");" << endl;
	  string arg_name = pipe_id + "_pipe_read_data";
	  ofile << "val_string := Pack_SLV_To_Vhpi_String(" << arg_name << ");" << endl;
	  ofile << simulator_prefix << "Set_Port_Value(obj_ref,val_string," << pipe_width << ");" << endl;
	}


      ofile << "-- }" << endl << "end loop;" << endl;
      ofile << "--}" << endl << "end process;" << endl << endl;
     
    }

  this->Print_VHDL_Instance(ofile);
  ofile << "-- }\n end VhpiLink;" << endl;
}

void vcSystem::Print_VHDL_Instance(ostream& ofile)
{
  ofile << this->Get_VHDL_Id() << "_instance: " << this->Get_VHDL_Id() << " -- {" << endl;
  ofile << "port map ( -- {" << endl;
  string comma;
  comma = this->Print_VHDL_Instance_Port_Map(comma,ofile);
  ofile << "); -- }}" << endl;
  
}

string vcSystem::Print_VHDL_Instance_Port_Map(string comma, ostream& ofile)
{
  for(set<vcModule*,vcRoot_Compare>::iterator iter = _top_module_set.begin();
      iter != _top_module_set.end();
      iter++)
    {
      if(!this->Is_An_Ever_Running_Top_Module(*iter))
      	comma = (*iter)->Print_VHDL_System_Instance_Port_Map(comma, ofile);
    }

  ofile << comma << endl << "clk => clk," << endl;
  ofile << "reset => reset";
  comma = ",";
  comma = this->Print_VHDL_System_Instance_Pipe_Port_Map(comma,ofile);
  return(comma);
}

string vcSystem::Print_VHDL_System_Instance_Pipe_Port_Map(string comma, ostream& ofile)
{
  for(map<string, int>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      string pipe_id = (*pipe_iter).first;
      int pipe_width = (*pipe_iter).second;
      
      int num_reads = this->Get_Num_Pipe_Reads(pipe_id);
      int num_writes = this->Get_Num_Pipe_Writes(pipe_id);
     
      if(num_reads > 0 && num_writes ==  0)
	{
	  // input pipe
	  ofile << comma << endl;
	  comma = ",";
	  ofile << pipe_id << "_pipe_write_data " 
		<< " => "
		<< pipe_id << "_pipe_write_data, "  << endl;

	  ofile << pipe_id << "_pipe_write_req "
		<< " => "
		<< pipe_id 
		<< "_pipe_write_req, " << endl;
	  ofile << pipe_id 
		<< "_pipe_write_ack "
		<< " => "
		<< pipe_id << "_pipe_write_ack";
	  
	}


      if(num_writes > 0 && num_reads == 0)
	{
	  // output
	  ofile << comma << endl;
	  comma = ",";
	  ofile << pipe_id << "_pipe_read_data "
		<< " => "
		<< pipe_id << "_pipe_read_data, " << endl;
	  ofile << pipe_id << "_pipe_read_req " 
		<< " => " 
		<< pipe_id << "_pipe_read_req, "  << endl;
	  ofile << pipe_id << "_pipe_read_ack "
		<< " => "
		<< pipe_id << "_pipe_read_ack ";
	}
    }
  return(comma);
}

void vcSystem::Print_VHDL_Test_Bench_Signals(ostream& ofile)
{
  ofile << "signal clk: std_logic := '0';" << endl;
  ofile << "signal reset: std_logic := '1';" << endl;
  for(set<vcModule*,vcRoot_Compare>::iterator iter = _top_module_set.begin();
      iter != _top_module_set.end();
      iter++)
    {
      (*iter)->Print_VHDL_System_Argument_Signals(ofile);
    }

  this->Print_VHDL_Pipe_Port_Signals(ofile);
}

void vcSystem::Print_VHDL_Component(ostream& ofile)
{
  ofile << "component " << this->Get_VHDL_Id() << " is -- { " << endl;
  string semi_colon;
  semi_colon = this->Print_VHDL_System_Ports(semi_colon, ofile);
  ofile << "-- }\n end component;" << endl;
  
}

string vcSystem::Print_VHDL_System_Ports(string semi_colon, ostream& ofile)
{
  ofile << "port (-- {";
  for(set<vcModule*,vcRoot_Compare>::iterator iter = _top_module_set.begin();
      iter != _top_module_set.end();
      iter++)
    {
	if(!this->Is_An_Ever_Running_Top_Module(*iter))
      		semi_colon = (*iter)->Print_VHDL_System_Argument_Ports(semi_colon, ofile);
    }

  ofile << semi_colon << endl << "clk : in std_logic;" << endl;
  ofile << "reset : in std_logic";
  semi_colon = ";" ;
  this->Print_VHDL_Pipe_Ports(semi_colon,ofile);
  ofile << "); -- }" << endl;
  return(semi_colon);
}

void vcSystem::Print_VHDL_Entity(ostream& ofile)
{
  ofile << "entity " << this->Get_VHDL_Id() << " is  -- system {" << endl;
  string semi_colon;
  semi_colon = this->Print_VHDL_System_Ports(semi_colon, ofile);
  ofile << "-- }\n end entity; " << endl;
}

void vcSystem::Print_VHDL_Pipe_Port_Signals(ostream& ofile)
{
  for(map<string, int>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      string pipe_id = To_VHDL((*pipe_iter).first);
      int pipe_width = (*pipe_iter).second;
      
      int num_reads = this->Get_Num_Pipe_Reads(pipe_id);
      int num_writes = this->Get_Num_Pipe_Writes(pipe_id);
     
      if(num_reads > 0 && num_writes ==  0)
	{
	  ofile << "-- write to pipe " << pipe_id << endl;
	  ofile << "signal " 
		<< pipe_id 
		<< "_pipe_write_data: std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
	  ofile << "signal " << pipe_id << "_pipe_write_req : std_logic_vector(0 downto 0) := (others => '0');" << endl;
	  ofile << "signal " << pipe_id << "_pipe_write_ack : std_logic_vector(0 downto 0);" << endl;
	}


      if(num_writes > 0 && num_reads == 0)
	{
	  ofile << "-- read from pipe " << pipe_id << endl;
	  ofile << "signal "
		<< pipe_id << "_pipe_read_data: std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
	  ofile << "signal " << pipe_id << "_pipe_read_req : std_logic_vector(0 downto 0) := (others => '0');" << endl;
	  ofile << "signal " << pipe_id << "_pipe_read_ack : std_logic_vector(0 downto 0);" << endl;
	}
    }
}

string vcSystem::Print_VHDL_Pipe_Ports(string semi_colon, ostream& ofile)
{
  for(map<string, int>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      string pipe_id = To_VHDL((*pipe_iter).first);
      int pipe_width = (*pipe_iter).second;
      
      int num_reads = this->Get_Num_Pipe_Reads(pipe_id);
      int num_writes = this->Get_Num_Pipe_Writes(pipe_id);
     
      if(num_reads > 0 && num_writes ==  0)
	{
	  // input pipe
	  ofile << semi_colon << endl;
	  semi_colon = ";";
	  ofile << pipe_id << "_pipe_write_data: in std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
	  ofile << pipe_id << "_pipe_write_req : in std_logic_vector(0 downto 0);" << endl;
	  ofile << pipe_id << "_pipe_write_ack : out std_logic_vector(0 downto 0)";
	}


      if(num_writes > 0 && num_reads == 0)
	{
	  // output
	  ofile << semi_colon << endl;
	  semi_colon = ";";
	  ofile << pipe_id << "_pipe_read_data: out std_logic_vector(" << pipe_width-1 << " downto 0);" << endl;
	  ofile << pipe_id << "_pipe_read_req : in std_logic_vector(0 downto 0);" << endl;
	  ofile << pipe_id << "_pipe_read_ack : out std_logic_vector(0 downto 0)";
	}
    }

  return(semi_colon);
}


void vcSystem::Print_VHDL_Pipe_Signals(ostream& ofile)
{
  for(map<string, int>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      string pipe_id = To_VHDL((*pipe_iter).first);
      int pipe_width = (*pipe_iter).second;
      
      int num_reads = this->Get_Num_Pipe_Reads(pipe_id);
      int num_writes = this->Get_Num_Pipe_Writes(pipe_id);
     
      if(num_writes >  0)
	{
	  ofile << "-- aggregate signals for write to pipe " << pipe_id << endl;
	  ofile << "signal " << pipe_id << "_pipe_write_data: std_logic_vector(" << (num_writes*pipe_width)-1 << " downto 0);" << endl;
	  ofile << "signal " << pipe_id << "_pipe_write_req: std_logic_vector(" << num_writes-1 << " downto 0);" << endl;
	  ofile << "signal " << pipe_id << "_pipe_write_ack: std_logic_vector(" << num_writes-1 << " downto 0);" << endl;
	}

      if(num_reads > 0)
	{
	  ofile << "-- aggregate signals for read from pipe " << pipe_id << endl;
	  ofile << "signal " << pipe_id << "_pipe_read_data: std_logic_vector(" << (num_reads*pipe_width)-1 << " downto 0);" << endl;
	  ofile << "signal " << pipe_id << "_pipe_read_req: std_logic_vector(" << num_reads-1 << " downto 0);" << endl;
	  ofile << "signal " << pipe_id << "_pipe_read_ack: std_logic_vector(" << num_reads-1 << " downto 0);" << endl;
	}
    }
}

bool vcSystem::Get_Pipe_Module_Section(string pipe_id, 
				       vcModule* caller_module, 
				       string read_or_write, 
				       int& hindex, 
				       int& lindex)
{
  bool ret_val = false;
  hindex = ((read_or_write == "read") ? this->Get_Num_Pipe_Reads(pipe_id)-1 : this->Get_Num_Pipe_Writes(pipe_id) -1);
  map<vcModule*,vector<int> >& module_map = ((read_or_write == "read") ? _pipe_read_map[pipe_id] :
					     _pipe_write_map[pipe_id]);
  for(map<vcModule*, vector<int> >::iterator iter = module_map.begin();
      iter != module_map.end();
      iter++
      )
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

string vcSystem::Get_VHDL_Pipe_Interface_Port_Name(string pipe_id, string pid)
{
  return(pipe_id + "_pipe_" + pid);
}

string vcSystem::Get_Pipe_Aggregate_Section(string pipe_id,
					    string pid, 
					    int hindex, 
					    int lindex) 
{
  int data_width;
  string ret_string = this->Get_VHDL_Pipe_Interface_Port_Name(pipe_id,pid);

  // find data_width.
  if((pid.find("req") != string::npos) || (pid.find("ack") != string::npos))
    data_width = 1;
  else if(pid.find("data") != string::npos)
    data_width = this->Get_Pipe_Width(pipe_id);
  else
    assert(0); // fatal

  ret_string += "(";
  ret_string += IntToStr(((hindex+1)*data_width)-1);
  ret_string += " downto ";
  ret_string += IntToStr(lindex*data_width);
  ret_string += ")";
  return(ret_string);
}


void vcSystem::Print_VHDL_Architecture(ostream& ofile)
{

  ofile << "architecture Default of " << this->Get_VHDL_Id() << " is -- system-architecture {" << endl;

  for(map<string,vcMemorySpace*>::iterator iter = _memory_space_map.begin();
      iter != _memory_space_map.end();
      iter++)
    {
      vcMemorySpace* ms  = (*iter).second;
      ofile << " -- interface signals to connect to memory space " << ms->Get_VHDL_Id() << endl;
      ms->Print_VHDL_Interface_Signal_Declarations(ofile);
    }

  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
 
      vcModule* m = (*moditer).second;

      ofile << "-- declarations related to module " << m->Get_VHDL_Id() << endl;
      // module component declarations
      m->Print_VHDL_Component(ofile);

      if(!this->Is_A_Top_Module(m) || this->Is_An_Ever_Running_Top_Module(m))
	{

	  if(m->Get_Num_Calls() == 0 && !this->Is_A_Top_Module(m))
	    {
	      std::cerr << "Warning:  module " << m->Get_Label() << " is not called from within the system, and is not marked as a top-module!" << std::endl;
	    }


	  ofile << "-- argument signals for module " << (*moditer).second->Get_VHDL_Id() << endl;
	  (*moditer).second->Print_VHDL_Argument_Signals(ofile);
	  if((*moditer).second->Get_Num_Calls() > 0)
	    {
	      ofile << endl << "-- caller side aggregated signals for module " << (*moditer).second->Get_VHDL_Id() << endl;
	      (*moditer).second->Print_VHDL_Caller_Aggregate_Signals(ofile);
	    }
	}
      else if(this->Is_A_Top_Module(m) && m->Get_Num_Calls() > 0)
	{
	  vcSystem::Error("top-module " + (*moditer).second->Get_VHDL_Id() + " cannot be called from within the system!");
	}
    }

  this->Print_VHDL_Pipe_Signals(ofile);

  ofile << "-- } " << endl << "begin -- {" << endl;
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      ofile << "-- module " << (*moditer).second->Get_VHDL_Id() << endl;
      if(!this->Is_A_Top_Module((*moditer).second))
	{
	  if((*moditer).second->Get_Num_Calls() > 0)
	    {
	      (*moditer).second->Print_VHDL_In_Arg_Disconcatenation(ofile);
	      (*moditer).second->Print_VHDL_Out_Arg_Concatenation(ofile);
	      (*moditer).second->Print_VHDL_Call_Arbiter_Instantiation(ofile);
	    }
	}



      (*moditer).second->Print_VHDL_Instance(ofile);
      if(this->Is_An_Ever_Running_Top_Module((*moditer).second))
  	{
		(*moditer).second->Print_VHDL_Auto_Run_Instance(ofile);
	}
    }

  this->Print_VHDL_Pipe_Instances(ofile);

  for(map<string,vcMemorySpace*>::iterator iter = _memory_space_map.begin();
      iter != _memory_space_map.end();
      iter++)
    {
      vcMemorySpace* ms  = (*iter).second;
      ms->Print_VHDL_Instance(ofile);
    }

  ofile << "-- } " << endl << "end Default;" << endl;
}


void vcSystem::Print_VHDL_Pipe_Instances(ostream& ofile)
{
  for(map<string, int>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      string pipe_id = To_VHDL((*pipe_iter).first);
      int pipe_width = (*pipe_iter).second;
      int pipe_depth = this->Get_Pipe_Depth(pipe_id);

      int num_reads = this->Get_Num_Pipe_Reads(pipe_id);
      int num_writes = this->Get_Num_Pipe_Writes(pipe_id);
     
      if(num_reads > 0 || num_writes > 0)
      {
        num_reads = MAX(num_reads,1);
        num_writes = MAX(num_writes,1);

        ofile << pipe_id << "_Pipe: PipeBase -- {" << endl;
        ofile << "generic map( -- { " << endl;
	    ofile << "num_reads => " << num_reads << "," << endl;
	    ofile << "num_writes => " << num_writes << "," << endl;
	    ofile << "data_width => " << pipe_width << "," << endl;
	    ofile << "depth => " << pipe_depth << " --}\n)" << endl;
	    ofile << "port map( -- { " << endl;
	    ofile << "read_req => " << pipe_id << "_pipe_read_req," << endl 
		  << "read_ack => " << pipe_id << "_pipe_read_ack," << endl 
		  << "read_data => "<< pipe_id << "_pipe_read_data," << endl 
		  << "write_req => " << pipe_id << "_pipe_write_req," << endl 
		  << "write_ack => " << pipe_id << "_pipe_write_ack," << endl 
		  << "write_data => "<< pipe_id << "_pipe_write_data," << endl 
		  << "clk => clk,"
		  << "reset => reset -- }\n ); -- }" << endl;
       }
       else
 	{
		vcSystem::Warning("pipe " + pipe_id + " not used in the system, ignored");
	}
    }
	
}

void  vcSystem::Print_VHDL_Inclusions(ostream& ofile)
{
  ofile << "library ieee;\n\
use ieee.std_logic_1164.all;\n			\
library ahir;\n					\
use ahir.memory_subsystem_package.all;\n	\
use ahir.types.all;\n				\
use ahir.subprograms.all;\n			\
use ahir.components.all;\n			\
use ahir.basecomponents.all;\n			\
use ahir.operatorpackage.all;\n  \
use ahir.utilities.all;\n";
  ofile << "library work;" << endl;
  ofile << "use work.vc_system_package.all;" << endl;
}

