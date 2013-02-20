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
bool vcSystem::_min_area_flag = false;
bool vcSystem::_min_clock_period_flag = false;
bool vcSystem::_enable_logging = false;

// bypass stride.
// the maximum chain of joins with bypass
// (to control the clock-period).
int vcSystem::_bypass_stride = 1;

// uses library?
bool vcSystem::_uses_function_library = false;

// set on error.
bool vcSystem::_error_flag = false;

// always make it a memory subsystem... until we fix
// the ordering problem in register bank
int vcSystem::_register_bank_threshold = 0;

// standard simulator will be Modelsim_FLI
string vcSystem::_simulator_prefix = "Modelsim_FLI_";

string vcSystem::_tool_name;
string vcSystem::_top_entity_name = "ahir_system";


// for loop-pipelining.
// max iterations in flight.  make it 256 (an 8 bit number).
// this should be enough for most applications.
int vcSystem::_max_iterations_in_flight = 256;


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
  for(map<string,vcPipe*>::iterator piter = this->_pipe_map.begin();
      piter != this->_pipe_map.end();
      piter++)
    {

      (*piter).second->Print(ofile);

    }
}

void vcSystem::Register_Pipe_Read(string pipe_id, vcModule* m, int idx)
{
  vcPipe* p = this->Find_Pipe(pipe_id);
  if(p != NULL)
    p->Register_Pipe_Read(m,idx);
}

int vcSystem::Get_Num_Pipe_Reads(string pipe_id)
{
  vcPipe* p = this->Find_Pipe(pipe_id);
  if(p != NULL)
    return(p->Get_Pipe_Read_Count());
  else
    return(0);

}

void vcSystem::Register_Pipe_Write(string pipe_id, vcModule* m, int idx)
{
  vcPipe* p = this->Find_Pipe(pipe_id);
  if(p != NULL)
    p->Register_Pipe_Write(m,idx);
}

int vcSystem::Get_Num_Pipe_Writes(string pipe_id)
{
  vcPipe* p = this->Find_Pipe(pipe_id);
  if(p != NULL)
    return p->Get_Pipe_Write_Count();
  else 
    return(0);
}
void vcSystem::Deregister_Pipe_Accesses(vcModule* m)
{
  for(map<string,vcPipe*>::iterator iter = _pipe_map.begin(), iiter = _pipe_map.end();
      iter != iiter;
      iter++)
    {
      vcPipe* p = (*iter).second;
      p->Deregister_Pipe_Accesses(m);
    }
}


int vcSystem::Get_Pipe_Width(string pipe_id)
{
  assert(_pipe_map.find(pipe_id) != _pipe_map.end());
  return(_pipe_map[pipe_id]->Get_Width());
}
int vcSystem::Get_Pipe_Depth(string pipe_id)
{
  assert(_pipe_map.find(pipe_id) != _pipe_map.end());
  return(_pipe_map[pipe_id]->Get_Depth());
}
void vcSystem::Add_Pipe(string pipe_id, int width, int depth, bool lifo_mode) 
{
  assert(_pipe_map.find(pipe_id) == _pipe_map.end());
  assert(width > 0);
  assert(depth > 0);

  _pipe_map[pipe_id] = new vcPipe(NULL, pipe_id, width, depth, lifo_mode);
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


void vcSystem::Detach_Unreachable_Modules()
{
  set<vcModule*> reachable_modules;
  
  for(set<vcModule*,vcRoot_Compare>::iterator miter = _top_module_set.begin(), fmiter = _top_module_set.end();
      miter != fmiter;
      miter++)
    {
      (*miter)->Mark_Reachable_Modules(reachable_modules);
    }


  vector<string> removed_modules;
  for(map<string,vcModule*>::iterator miter = _modules.begin(), mfiter = _modules.end();
      miter != mfiter;
      miter++)
    {
      vcModule* m = (*miter).second;
      string mname = (*miter).first;

      if(reachable_modules.find(m) == reachable_modules.end())
	{
	  vcSystem::Warning("module " + mname + " is not reachable from a top-level module, ignored");
	  _unreachable_modules[mname] = m;
	  removed_modules.push_back(mname);

	  this->Deregister_Pipe_Accesses(m);
	  m->Delink_From_Modules_And_Memory_Spaces();
      	}
    }

  for(int idx = 0; idx < removed_modules.size(); idx++)
    {
      _modules.erase(removed_modules[idx]);
    }

}

void vcSystem::Elaborate()
{

  this->Detach_Unreachable_Modules();

  this->Check_Control_Structure();
  this->Compute_Compatibility_Labels();
  this->Compute_Maximal_Groups();
  

}
 

void vcSystem::Error(string err_msg)
{
  cerr << vcSystem::_tool_name << " Error: " << err_msg << endl;
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

void vcSystem::DebugInfo(string err_msg)
{
  if(vcSystem::_verbose_flag)
    cerr << "DebugInfo: " << err_msg << endl;
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

void vcSystem::Print_VHDL_Global_Package(ostream& ofile)
{
  cerr << "Info: printing VHDL global package" << endl;
  string sys_package = this->Get_Sys_Package_Name();
  ofile << "library ieee;" << endl
	<< "use ieee.std_logic_1164.all;" << endl;
  ofile << "package " << sys_package << " is -- { " << endl;
  this->Print_VHDL_Constant_Declarations(ofile);
  ofile << "-- } " << endl <<  "end package " << sys_package << ";" << endl;
}

void  vcSystem::Print_VHDL(ostream& ofile)
{

  cerr << "Info: printing VHDL model" << endl;

  // print modules
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {

      string mod_name = (*moditer).first;
      bool is_fn_mod = this->Is_Function_Library_Module(mod_name);

      if(!is_fn_mod)
	{
      		cerr << "Info: printing VHDL model for module " << (*moditer).first << endl;
      		(*moditer).second->Print_VHDL(ofile);
	}
       else
	{
      		cerr << "Info: skipped printing VHDL model for function library module " << (*moditer).first << endl;
	}
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
      string start = prefix + "start_req";
      string start_ack = prefix + "start_ack";
      string fin_req = prefix + "fin_req";
      string fin = prefix + "fin_ack";


      ofile << "process" << endl;
      ofile << "begin --{" << endl;
      ofile << "wait until clk = '1';" << endl;
      ofile << start << " <= '1';" << endl;
      ofile << "while true loop --{" << endl;
      ofile << "wait until clk = '1';" << endl;
      ofile << "if " << start_ack << " = '1' then exit; end if;--}" << endl;
      ofile << "end loop; " << endl;
      ofile << start << " <= '0';" << endl;
      ofile << fin_req << " <= '1';" << endl;
      ofile << "while true loop -- {" << endl;
      ofile << "wait until clk = '1';" << endl;
      ofile << "if " << fin << " = '1' then exit; end if; --  }" << endl;
      ofile << "end loop; " << endl;
      ofile << fin_req << " <= '0';" << endl;
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
      string start = prefix + "start_req";
      string start_ack = prefix + "start_ack";
      string fin_req = prefix + "fin_req";
      string fin = prefix + "fin_ack";

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

      ofile << "wait for 0 ns;" << endl;
      ofile << "if " << start << " = '1' then -- {" << endl;
      ofile << "while true loop --{" << endl;
      ofile << "wait until clk = '1';" << endl;
      ofile << "if " << start_ack << " = '1' then exit; end if;--}" << endl;
      ofile << "end loop; " << endl;
      ofile << start << " <= '0';" << endl;
      ofile << fin_req << " <= '1';" << endl;
      ofile << "while true loop -- {" << endl;
      ofile << "wait until clk = '1';" << endl;
      ofile << "if " << fin << " = '1' then exit; end if; --  }" << endl;
      ofile << "end loop; " << endl;
      ofile << fin_req << " <= '0';" << endl;
      ofile << "-- }" << endl << "end if; " << endl;
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
  for(map<string, vcPipe*>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      vcPipe* p = (*pipe_iter).second;
      string pipe_id = p->Get_Id();
      int pipe_width = p->Get_Width();
      
      int num_reads = p->Get_Pipe_Read_Count();
      int num_writes = p->Get_Pipe_Write_Count();
      
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
  for(map<string, vcPipe*>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      vcPipe* p = (*pipe_iter).second;
      string pipe_id = (*pipe_iter).first;
      int pipe_width = p->Get_Width();
      
      int num_reads = p->Get_Pipe_Read_Count();
      int num_writes = p->Get_Pipe_Write_Count();
     
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
  for(map<string, vcPipe*>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      vcPipe* p =(*pipe_iter).second;
      p->Print_VHDL_Pipe_Port_Signals(ofile);

    }
}

string vcSystem::Print_VHDL_Pipe_Ports(string semi_colon, ostream& ofile)
{
  for(map<string, vcPipe*>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {

      vcPipe* p =(*pipe_iter).second;
      string pipe_id = To_VHDL(p->Get_Id());
      int pipe_width = p->Get_Width();
      
      int num_reads = p->Get_Pipe_Read_Count();
      int num_writes = p->Get_Pipe_Write_Count();
     
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
  for(map<string, vcPipe*>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      vcPipe* p = (*pipe_iter).second;
      p->Print_VHDL_Pipe_Signals(ofile);

    }
}

bool vcSystem::Get_Pipe_Module_Section(string pipe_id, 
				       vcModule* caller_module, 
				       string read_or_write, 
				       int& hindex, 
				       int& lindex)
{
  bool ret_val = false;

  vcPipe* p = this->Find_Pipe(pipe_id);
  assert(p != NULL);

  return(p->Get_Pipe_Module_Section(caller_module,read_or_write,hindex,lindex));

}

string vcSystem::Get_VHDL_Pipe_Interface_Port_Name(string pipe_id, string pid)
{
  vcPipe* p = this->Find_Pipe(pipe_id);
  assert(p != NULL);

  return(p->Get_VHDL_Pipe_Interface_Port_Name(pid));

}

string vcSystem::Get_Pipe_Aggregate_Section(string pipe_id,
					    string pid, 
					    int hindex, 
					    int lindex) 
{
  vcPipe* p = this->Find_Pipe(pipe_id);
  assert(p != NULL);

  p->Get_Pipe_Aggregate_Section(pid,hindex,lindex);

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
      string mod_name = (*moditer).first;
      bool is_function_library_module = this->Is_Function_Library_Module(mod_name);

      ofile << "-- declarations related to module " << m->Get_VHDL_Id() << endl;

      // module component declarations
      if(!is_function_library_module)
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
  for(map<string, vcPipe*>::iterator pipe_iter = _pipe_map.begin();
      pipe_iter != _pipe_map.end();
      pipe_iter++)
    {
      vcPipe* p = (*pipe_iter).second;
      p->Print_VHDL_Instance(ofile);

    }
	
}

void  vcSystem::Print_VHDL_Inclusions(ostream& ofile)
{
  string sys_package = vcSystem::Get_Sys_Package_Name();
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

  if(vcSystem::_uses_function_library)
  {
	ofile << "use ahir.functionLibraryComponents.all;" << endl;
  }
  ofile << "library work;" << endl;
  ofile << "use work." << sys_package << ".all;" << endl;
}


//
// read library file, which contains a list
// of function library modules, one per line.
// These modules are not instantiated as entities 
// in the resulting VHDL file of the ahir-system.
//
void vcSystem::Add_Function_Library(string& file_name)
{
      if(file_name != "")
	{
	  std::ifstream ifile(file_name.c_str());
	  if (ifile.is_open()) {
	    
	    while (ifile.good()) {
	      std::string line;
	      std::getline(ifile, line);
              if(line[0] != '#')
	      {
	      	std::cerr << "Info: vcSystem::Add_Function_Library: added function library module: " << line << std::endl;
	      	_function_library_modules.insert(line);
		vcSystem::_uses_function_library = true;
	      }
	    }
	    ifile.close();
	  }
	}
}


// return true if mod_name is a function library
// module, false otherwise.
bool vcSystem::Is_Function_Library_Module(string& mod_name)
{
	if(_function_library_modules.find(mod_name) != _function_library_modules.end())
		return(true);
	else
		return(false);
}
