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
  cerr <<  " -O: will lead to smaller VHDL files due to some compaction." << endl
       <<  " -C: the generated system testbench connects to foreign language testbench (Ctestbench). " << endl;
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
  cerr <<  " -e <top-entity-name>:  the top-level system entity name will be top-entity-name.  The default is test_system." << endl;
  cerr <<  " alternate form:  --top_entity_name vcfile-name" << endl;
  cerr << endl;
  cerr <<  " -w :  the system and testbench will be printed into separate VHDL files. By default both are printed to stdout" << endl;
  cerr <<  " alternate form:  --write_files" << endl;
  cerr << endl;
  cerr << "example: " << endl
       << "    vc2vhdl -O -t foo -f file1.vc -f file2.vc -t bar" << endl;
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

  // command-line parsing
  struct option long_options[] =
    {
      /* These options set a flag. */
      {"help", no_argument, 0, 'h'},
      {"optimize", no_argument,0, 'O'},
      {"ctestbench",  no_argument, 0, 'C'},
      {"simulator",  required_argument, 0, 's'},
      {"set_as_top",  required_argument, 0, 't'},
      {"set_as_free_running_top",  required_argument, 0, 'T'},
      {"top_entity_name",  required_argument, 0, 'e'},
      {"write_files",  no_argument, 0, 'w'},
      {"vcfile",    required_argument, 0, 'f'},
      {0, 0, 0, 0}
    };


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

  vcSystem::_opt_flag = false;
  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "t:T:f:OCs:a:he:w",
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
	case 't':
	  mod_name = string(optarg);	
	  top_modules.insert(mod_name);
	  cerr << "Info: module " << mod_name << " set as one of the top modules " << endl;
	  break;
	case 'T':
	  mod_name = string(optarg);	
	  always_running_top_modules.insert(mod_name);
	  top_modules.insert(mod_name);

	  cerr << "Info: module " << mod_name << " set as one of the ever-running top modules " << endl;
	  cerr << "   NOTE: " << mod_name << " cannot have any input/output arguments." << endl;
	  break;
	case 'O':
	  vcSystem::_opt_flag = true;
	  cerr << "Info: -O option selected: will flatten and reduce control path" << endl;
	  break;
	case 'e':
	  sys_name = string(optarg);
	  cerr << "Info: -e " << sys_name << " top-level VHDL entity will have name " << sys_name << ".unformatted_vhdl" << endl; 
	  break;
	case 'w':
	  write_files = true;
	  cerr << "Info: -w " << sys_name << " will write separate system and testbench VHDL files" << endl; 
	  break;
	case 'C':
	  vcSystem::_vhpi_tb_flag = true;
	  cerr << "Info: -C option selected: will generate testbench which connects to foreign link" << endl;
	  break;
	case 's':
	  sim_id = string(optarg);
	  if(sim_id == "ghdl")
	  {
	     cerr << "Info: -s ghdl option selected: will generate testbench with VHPI link" << endl;
	     vcSystem::_simulator_prefix = "Vhpi_";
	  }
	  else 
          {
	     cerr << "Info: -s modelsim option selected: will generate testbench with VHPI link" << endl;
          }
	  break;
        case 'h':
	  Usage_Vc2VHDL();
	  break;
	case '?':		  // incorrect option
	  opt_string = opt;
	  cerr << (string("Error: ") + " illegal option " + opt_string);
	  Usage_Vc2VHDL();
	  break;
	default:
	  break;
	}
    }


  vcSystem test_system(sys_name);

  for(int idx = 0; idx < file_list.size(); idx++)
    {

      string filename = file_list[idx];
      
      test_system.Parse(filename);
      
      if(vcSystem::Get_Error_Flag())
	{
	  cerr << "Error: there were errors during parsing, check the log" << endl;
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
	  ofstream sys_file;
	  string file_name = sys_name + ".unformatted_vhdl";
	  sys_file.open(file_name.c_str());
	  
	  cerr << "Info: printing top-level system VHDL file " << file_name << endl;
	  sys_file << "-- VHDL produced by vc2vhdl from virtual circuit (vc) description " << endl;
	  test_system.Print_VHDL(sys_file);
	  sys_file.close();

	  ofstream sys_tb_file;
	  string tb_file_name = sys_name + "_test_bench.unformatted_vhdl";
	  sys_tb_file.open(tb_file_name.c_str());

	  if(vcSystem::_vhpi_tb_flag)
	    test_system.Print_VHDL_Vhpi_Test_Bench(sys_tb_file);
	  else
	    test_system.Print_VHDL_Test_Bench(sys_tb_file);

	  sys_tb_file.close();
	}


    }

  return(0);
}


