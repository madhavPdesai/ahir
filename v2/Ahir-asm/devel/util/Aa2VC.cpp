#include <signal.h>
#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>
#include <Aa2C.h>
#include <getopt.h>

using namespace std;
using namespace antlr;

// command-line parsing
extern int optind;
extern char *optarg;
int opt;
int option_index = 0;




void Handle_Segfault(int signal)
{
  AaRoot::Error("in Aa2VC: segmentation fault! giving up!!", NULL);
  exit(-1);
}


void Usage_Aa2VC()
{
  cerr << "brief description: reads source Aa program, analyzes it,\n and writes out vC program.  " << endl;
  cerr << "Usage: Aa2VC [-O] [-C] [-I <extmem-obj-name>] <filename> (<filename>) ... " << endl;
  cerr << " options " << endl;
  cerr <<  " -h (or --help): print help and quit.. " << endl
       <<  " -I (or --internal_ext_mem_pool)  <mem-pool-name> : all orphan memory references (which cannot be resolved" << endl
       <<  "              as pointing to an internally declared object in ths program) are assumed to" << endl
       <<  "              point to an external memory object whose name is mem-pool-name.  This external" << endl
       <<  "              memory object must be declared in the source Aa program." << endl;
  cerr <<  " -O (or --optimize): try to parallelize sequences of statements by using dependency analysis" << endl;
  cerr <<  " -U (or --unordered): memory subsystems will be unordered (ordered is default) " << endl;
  cerr <<  " -C (or --c_stubs): generate C stubs for all modules. These can be used later in mixed C-VHDL simulation." << endl;
  cerr <<  " -r (or --root_module) <mod-name>:  mod-name will be marked as a root-module." << endl;

  cerr << endl;
  cerr << "example: " << endl
       << "    Aa2VC -O -C -I mempool file1.aa  file2.aa" << endl;
  cerr << "file1.aa and file2.aa will be parsed in order, the Aa program will " << endl
       << "be analyzed, and a vC program will be printed.  The declared storage object  " << endl
       << "mempool will be the target of all orphan memory accesses.  The generated vC program" << endl
       << "will have serial code parallelized to the maximum extent possible.  Also, C-stubs" << endl
       << "will be generated for every module in the source program." << endl;


}

int main(int argc, char* argv[])
{

  bool write_vhdl_c_stubs = false;
  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      Usage_Aa2VC();
      return(1);
    }


  // command-line parsing
  struct option long_options[] =
    {
      /* These options set a flag. */
      {"help", no_argument, 0, 'h'},
      {"optimize", no_argument,0, 'O'},
      {"unordered", no_argument,0, 'U'},
      {"c_stubs",  no_argument, 0, 'C'},
      {"internal_ext_mem_pool",  required_argument, 0, 'I'},
      {"root_module",  required_argument, 0, 'r'},
      {0, 0, 0, 0}
    };


  AaProgram::_tool_name = "Aa2VC";

  string fname;
  string mod_name;
  string opt_string;
  bool opt_flag = false;

  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "OUCI:hr:",
		      long_options, &option_index)) != -1)
    {
      switch (opt)
	{
	case 'O':
	  opt_flag = true;
	  AaProgram::_optimize_flag = true;
	  std::cerr << "Info: -O option selected, will parallelize straight-line sequences" << endl;
	  break;
	case 'U':
	  AaProgram::_unordered_memory_flag = true;
	  std::cerr << "Info: -U option selected, memory subsystem will be unordered." << endl;
	  break;
	case 'C':
	  write_vhdl_c_stubs = true;
	  std::cerr << "Info: -C option selected, will generate C-stubs for mixed C-VHDL simulation" << endl;
	  break;
	case 'I':
	  AaProgram::_keep_extmem_inside  = true;
	  AaProgram::_extmem_object_name = optarg;
	  break;
	case 'r':
          mod_name = optarg;
	  AaProgram::Mark_As_Root_Module(mod_name);
	  std::cerr << "Info: module " << mod_name << " will be marked as a root module." << endl;
	  break;
	case 'h':
	  Usage_Aa2VC();
	  return(1);
	default:
	  cerr << "Error: unknown option " << opt << endl;
	  Usage_Aa2VC();
	  return(1);
	}
    }
      
  if(AaProgram::_keep_extmem_inside)
    {
      if(AaProgram::_extmem_object_name == "")
	{
	  AaProgram::_extmem_object_name = "extmem_pool__";
	  cerr << "Warning: external memory object name in program not specified, will be named " 
	       << AaProgram::_extmem_object_name << endl;
	}
      AaProgram::Make_Extmem_Object();
    }

  for(int i = optind; i < argc; i++)
    {
      string filename = argv[i];      
      AaParse(filename);
    }


  if(AaRoot::Get_Error_Flag())
    {
      cerr << "Error: there were errors during parsing, check the log" << endl;
      return(1);
    }

  
  AaProgram::Elaborate();

  if(AaRoot::Get_Error_Flag())
    cerr << "Error: there were errors during elaboration, check the log" << endl;
  else
    {
      cout << "// Virtual circuit produced from Aa description by Aa2VC " << endl;
      if(opt_flag)
	AaProgram::Write_VC_Model_Optimized(32,8,cout);
      else
	AaProgram::Write_VC_Model(32,8,cout);

      if(write_vhdl_c_stubs)
	AaProgram::Write_VHDL_C_Stubs();
    }


  return(0);
}
