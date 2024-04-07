//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
#include <signal.h>
#include <getopt.h>
#include <vcSystem.hpp>
#include <vcParser.hpp>
#include <vcLexer.hpp>

using namespace std;



void Handle_Segfault(int signal)
{
  vcSystem::Error("in vc2vhdl: segmentation fault! giving up!!");
  exit(-1);
}

void Usage_Vc2VHDL()
{

  cerr << "brief description: produces unformatted VHDL from specified VC files,  " << endl;
  cerr << "Usage: " << endl;
  cerr << "vc2vhdl ... options ... " << endl;
  cerr << " options " << endl;
  cerr <<  " -t mod-name: will make mod-name a top-level module which must" << endl
       <<  "              be started from outside the AHIR system.  Such a module can " << endl
       <<  "              have input/output arguments from/to the outside world" << endl
       <<  " Notes: " << endl
       <<  "   1. alternate form: --top mod-name" << endl
       <<  "   2. option can be repeated to specify multiple top-level modules" << endl;
  cerr << endl;  
  cerr <<  " -T mod-name: will make mod-name a free-running top-level module " << endl
       <<  "              which need not be started from outside.  Such a module cannot " << endl
       <<  "              have input/output arguments from/to the outside world" << endl
       <<  " Notes: " << endl
       <<  "   1. alternate form: --free_running_top mod-name" << endl
       <<  "   2. option can be repeated to specify multiple top-level modules." << endl;
  cerr << endl;
  cerr <<  " -O: try to compress the size of the VHDL file (no effect on synthesis).." << endl
       <<  " -C: the generated system testbench connects to foreign language testbench (Ctestbench). " << endl;
  cerr <<  " -a:  will try to produce a VHDL netlist with the minimum area possible (sort of)" << endl
       <<  " Notes: " << endl
       <<  "   1. alternate form: --min_area" << endl
       <<  "   2. if -a is absent, the goal will be to get the maximum speed (minimize number of cycles needed" << endl;
  cerr <<  " -S <bypass-stride>:  bypass-stride (increase to reduce clock-cycle count, but note that this will reduce clock frequency" << endl;
  cerr <<  " -q:  will try to produce a VHDL netlist with the minimum clock period (sort of)" << endl
       <<  " Notes: " << endl
       <<  "   1. alternate form: --min_clock_period" << endl
       <<  "   2. if -q is absent, the goal will be to get the minimize cycle count..." << endl;
  cerr <<  " -s ghdl/modelsim: specify the simulator with which one is going to simulate the system." << endl
       <<  "    -s ghdl: will produce a testbench which can be used in GHDL. " << endl
       <<  "    -s modelsim: will produce a testbench which can be used in Modelsim. " << endl
       <<  " Notes: " << endl
       <<  "   1. this option has an effect only when -C is also specified." << endl
       <<  "   2. the default is Modelsim." << endl;
  cerr << endl;
  cerr <<  " -f vcfile-name: specifies a VC file to be parsed.  Repetitions of this option can be" << endl
       <<  "                 used to specify more than one file.  Files are parsed in the order specified." << endl
       <<  " alternate form:  --file vcfile-name" << endl;
  cerr <<  " -L <file-name> :  the contents of file <file-name> wll be interpreted as pre-designed VHDL library elements." << endl;
  cerr <<  " alternate form:  --library.  Multiple files can be specified in this fashion." << endl;
  cerr <<  " -e <top-entity-name>:  the top-level system entity name will be top-entity-name.  The default is test_system." << endl;
  cerr <<  " alternate form:  --top_entity_name vcfile-name" << endl;
  cerr << endl;
  cerr <<  " -w :  the system and testbench will be printed into separate VHDL files. By default both are printed to stdout" << endl;
  cerr <<  " alternate form:  --write_files" << endl;
  cerr <<  " -D :  the generated VHDL will have logging assertions to help debug." << endl;
  cerr <<  " alternate form:  --debug" << endl;
  cerr <<  " -v :  lots of information will be printed to stderr during analysis." << endl;
  cerr <<  " alternate form:  --verbose" << endl;
  cerr <<  " -W <VHDL-work-library> : the generated VHDL will be kept in library VHDL-work-library." << endl;
  cerr <<  "     The default work library is work." << endl;
  cerr <<  " -U :  input/output pipes will be printed with depth 0. " << endl;
  cerr <<  " -H :  system interface in .hsys format will be printed. " << endl;
  cerr <<  " -I <n>:  deprecated " << endl;
  cerr <<  " alternate form:  --loop_pipeline_buffering_limit" << endl;
  cerr << endl;
  cerr << endl;
  cerr << "example: " << endl
       << "    vc2vhdl  -t foo -f file1.vc -f file2.vc -t bar" << endl;
  cerr << "file1.vc and file2.vc will be parsed in order, and the instantiated " << endl
       << "system will have modules foo and bar as top-modules, which are controllable  " << endl
       << "from outside the system." << endl;
}


int main(int argc, char* argv[])
{


  bool write_files = false;
  string sys_name = "test_system";
  
  vector<string> file_list;
  set<string> file_set;

  set<string> top_modules;
  set<string> always_running_top_modules;

  set<string> function_libraries;
  string lib_location;

  // command-line parsing
  struct option long_options[] =
    {
      /* These options set a flag. */
      {"help", no_argument, 0, 'h'},
      {"debug", no_argument, 0, 'D'},
      {"optimize", no_argument,0, 'O'},
      {"min_area", no_argument,0, 'a'},
      {"min_clock_period", no_argument,0, 'q'},
      {"ctestbench",  no_argument, 0, 'C'},
      {"simulator",  required_argument, 0, 's'},
      {"set_as_top",  required_argument, 0, 't'},
      {"set_as_free_running_top",  required_argument, 0, 'T'},
      {"top_entity_name",  required_argument, 0, 'e'},
      {"treat_errors_as_warnings",  no_argument, 0, 'I'},
      {"bypass_stride",  required_argument, 0, 'S'},
      {"write_files",  no_argument, 0, 'w'},
      {"vcfile",    required_argument, 0, 'f'},
      {"library",   required_argument, 0, 'L'},
      {"work_library",   required_argument, 0, 'W'},
      {"verbose",  no_argument, 0, 'v'},
      {"suppress_io_pipes",  no_argument, 0, 'U'},
      {"generate_hsys_file",  no_argument, 0, 'H'},
      {0, 0, 0, 0}
    };


  vcSystem::_tool_name = "vc2vhdl";

  extern int optind;
  extern char *optarg;
  int opt;
  int option_index = 0;

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 3)
    {
      Usage_Vc2VHDL();
      exit(1);
    }



  string fname;
  string mod_name;
  string opt_string;
  string sim_id;
  string work_library = "work";
  int it_limit;
  int bypass_stride;
  int errors_as_warnings = 0;

  vcSystem::_opt_flag = false;
  vcSystem::_suppress_io_pipes = false;
  vcSystem::_generate_hsys_file = false;

  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "t:T:f:OCs:he:waqDL:vIS:W:HU",
		      long_options, &option_index)) != -1)
    {
      switch (opt)
	{
	case 'f':
	  fname = string(optarg);	
	  if(file_set.find(fname) != file_set.end())
	    {
	      cerr << "Error: multiple occurences of VC file " << fname << " in argument list" << endl;
	    }
	  else
	    {
	      file_set.insert(fname);
	      file_list.push_back(fname);
	    }
	  break;
	case 'H':
		vcSystem::_generate_hsys_file = true;
		cerr << "Info: hierarchical system file (.hsys) printing turned on." << endl;
		break;
	case 'I':
		errors_as_warnings = true;
		cerr << "Info: -I will treat errors as warnings." << endl;
		break;
	case 't':
	  mod_name = string(optarg);	
	  top_modules.insert(mod_name);
	  cerr << "Info: module " << mod_name << " set as one of the top modules. " << endl;
	  break;
	case 'T':
	  mod_name = string(optarg);	
	  always_running_top_modules.insert(mod_name);
	  top_modules.insert(mod_name);

	  cerr << "Info: module " << mod_name << " set as one of the ever-running top modules. " << endl;
	  cerr << "   NOTE: " << mod_name << " cannot have any input/output arguments." << endl;
	  break;
	case 'O':
	  cerr << "Info: -O option selected, will try to compress control-path.." << endl;
	  vcSystem::_opt_flag = true;
	  break;
	case 'a':
	  vcSystem::_min_area_flag = true;
	  cerr << "Info: -a option selected: will try for minimum overall circuit area." << endl;
	  break;
	case 'q':
	  vcSystem::_min_clock_period_flag = true;
	  cerr << "Info: -q option selected: will try for minimum clock cycle time (by inserting repeaters)." << endl;
	  break;
	case 'e':
	  sys_name = string(optarg);
          vcSystem::_top_entity_name = sys_name;
	  cerr << "Info: -e " << sys_name << " top-level VHDL entity will have name " << sys_name << ".unformatted_vhdl" << endl; 
	  break;
	case 'w':
	  write_files = true;
	  cerr << "Info: -w " << sys_name << " will write separate system and testbench VHDL files." << endl; 
	  break;

	case 'C':
	  vcSystem::_vhpi_tb_flag = true;
	  cerr << "Info: -C option selected: will generate testbench which connects to foreign link." << endl;
	  break;
	case 'v':
	  vcSystem::_verbose_flag = true;
	  cerr << "Info: -v option selected: lots of info will be printed (to stderr, and also dot-files of control-paths if -O option is selected)." << endl;
	  break;
	case 'U':
	  vcSystem::_suppress_io_pipes = true;
	  cerr << "Info: -U option selected: suppress i/o pipes (set their depth = 0)." << endl;
	  break;
	case 'W':
	  vcSystem::_vhdl_work_library = string(optarg);
	  cerr << "Info: -W option selected: generated VHDL will be in library " << vcSystem::_vhdl_work_library << endl;
	  break;
	case 'S':
          bypass_stride = atoi(optarg);
	  if(bypass_stride < 0)
	  {
		cerr << "Error: bypass_stride must be > 0 (it is specified as " 
			<< bypass_stride 
			<< ")." << endl;
		vcSystem::_bypass_stride = 1;
	  }
	  else
	  {
	  	cerr << "Info: -S option selected: bypass stride will be set to " 
			<< bypass_stride << "." << endl;
	  	vcSystem::_bypass_stride = bypass_stride;
	  }
	  break;
	case 's':
	  sim_id = string(optarg);
	  if(sim_id == "ghdl")
	  {
	     cerr << "Info: -s ghdl option selected: will generate testbench with VHPI link." << endl;
	     vcSystem::_simulator_link_prefix = "Vhpi_";
	     vcSystem::_simulator_link_library = "GhdlLink";
	  }
	  else if(sim_id == "modelsim") 
          {
	     cerr << "Info: -s modelsim option selected: will generate testbench with VHPI link." << endl;
	     vcSystem::_simulator_link_prefix = "Modelsim_FLI_";
	     vcSystem::_simulator_link_library = "ModelsimLink";
          }
	  else
	  {
		cerr << "Error: unsupported simulator option " << sim_id << endl;
		return(1);
	  }
	  break;
        case 'h':
	  Usage_Vc2VHDL();
	  break;
        case 'D':
	  cerr << "Info: -D option selected: VHDL will have debug assertions.." << endl;
	  vcSystem::_enable_logging = true;
	  break;
	case 'L':
	  lib_location = string(optarg);	
	  function_libraries.insert(lib_location);
	  cerr << "Info: will add library  " << lib_location  << "." <<endl;
	  break;

	case '?':		  // incorrect option
	  opt_string = opt;
	  cerr << (string("Error: ") + " illegal option " + opt_string + ".");
	  Usage_Vc2VHDL();
	  break;
	default:
	  break;
	}
    }


  vcSystem test_system(sys_name);

  for(set<string>::iterator iter = function_libraries.begin();
		  iter != function_libraries.end();
		  iter++)
  {
	  string tmp = *iter;
	  test_system.Add_Function_Library(tmp);
  }

  for(int idx = 0; idx < file_list.size(); idx++)
  {

      string filename = file_list[idx];
      
      test_system.Parse(filename);
      
      if(vcSystem::Get_Error_Flag())
	{
	  cerr << "Error: there were errors during parsing, check the log" << endl;
	  if(!errors_as_warnings)
	  	return(1);
	}
    }

  if(!vcSystem::Get_Error_Flag())
    {
      for(set<string>::iterator iter = top_modules.begin();
	  iter != top_modules.end();
	  iter++)
	{
	  test_system.Set_As_Top_Module(*iter);
	}

      for(set<string>::iterator iter = always_running_top_modules.begin();
	  iter != always_running_top_modules.end();
	  iter++)
	{
	  test_system.Set_As_Ever_Running_Top_Module(*iter);
	}


      test_system.Elaborate();
      if(vcSystem::_error_flag)
      {
	cerr << "There were errors during elaboration ... will not print VHDL" << endl;
	// if(!errors_as_warnings)
	//     return(1);
      }

      if(!write_files)
	{
	  cout << "-- VHDL produced by vc2vhdl from virtual circuit (vc) description " << endl;
	  test_system.Print_VHDL(cout);

	  if(vcSystem::_vhpi_tb_flag)
	    test_system.Print_VHDL_Vhpi_Test_Bench(cout);
	  else
	    test_system.Print_VHDL_Test_Bench(cout);
	}
      else
	{
	  ofstream sys_package_file;
	  string file_name = sys_name + "_global_package.unformatted_vhdl";
	  sys_package_file.open(file_name.c_str());
	  sys_package_file << "-- VHDL global package produced by vc2vhdl from virtual circuit (vc) description " << endl;
	  test_system.Print_VHDL_Global_Package(sys_package_file);
	  sys_package_file.close();

	  ofstream sys_file;
	  file_name = sys_name + ".unformatted_vhdl";
	  sys_file.open(file_name.c_str());
	  
	  cerr << "Info: printing top-level system VHDL file " << file_name << endl;
	  sys_file << "-- VHDL produced by vc2vhdl from virtual circuit (vc) description " << endl;
	  test_system.Print_VHDL(sys_file);
	  sys_file.close();
	  cerr << "Info: number of register bits used in FIFO's = " << vcSystem::_fifo_register_count << endl;

	  cerr << "Info: number of marked arcs removed during redundancy removal = " <<
			vcSystem::_number_of_marked_arcs_saved << endl;	

	  ofstream sys_tb_file;
	  string tb_file_name = sys_name + "_test_bench.unformatted_vhdl";
	  sys_tb_file.open(tb_file_name.c_str());

	  if(vcSystem::_vhpi_tb_flag)
	    test_system.Print_VHDL_Vhpi_Test_Bench(sys_tb_file);
	  else
	    test_system.Print_VHDL_Test_Bench(sys_tb_file);

	  sys_tb_file.close();
	}

	if(vcSystem::_opt_flag && vcSystem::_verbose_flag)
	{
		test_system.Print_Reduced_Control_Paths_As_Dot_Files();
		test_system.Print_Data_Paths_As_Dot_Files();
	}

	if(vcSystem::_generate_hsys_file)
	{
  		string hsys_file_name = sys_name + ".hsys";
		test_system.Print_Hsys_File(hsys_file_name);
	}
    }

  return(0);
}


