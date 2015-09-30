#include <signal.h>
#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>
#include <Aa2C.h>

using namespace std;
using namespace antlr;


// command-line parsing
extern int optind;
extern char *optarg;
int opt;
int option_index = 0;


struct option long_options[] = {
    {"relaxed-component-visibility", 0, 0, 0},
    {"depend", required_argument, 0, 0},
    {0, 0, 0, 0}
};


void Handle_Segfault(int signal)
{
  AaRoot::Error("in Aa2C: segmentation fault! giving up!!", NULL);
  exit(-1);
}

int main(int argc, char* argv[])
{

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      cerr << "Usage: Aa2C [-I ext-storage-object] [-T top-module]* [-P c-fn-prefix] [-o <output-directory>]  <filename> (<filename>) ... " << endl;
      exit(1);
    }


   AaProgram::_tool_name = "Aa2C";
  string fname;
  string mod_name;
  string opt_string;
  bool opt_flag = false;
  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "I:T:P:o:",
		      long_options, &option_index)) != -1)
    {
      switch (opt)
	{
	case 'I':
	  AaProgram::_keep_extmem_inside  = true;
	  AaProgram::_extmem_object_name = optarg;
	  break;
	case 'T':
	  opt_string = optarg; 
	  AaProgram::_top_level_daemons.insert(opt_string);
	  cerr << "Info: marked " << opt_string << " as a top-level daemon. " << endl;
	  break;
	case 'P':
	  opt_string = optarg; 
	  AaProgram::_c_vhdl_module_prefix  = opt_string;
	  cerr << "Info: C function name prefix set to " << opt_string << ". " << endl;
	  break;
	case 'o':
	  opt_string = optarg; 
	  AaProgram::_aa2c_output_directory  = opt_string;
	  cerr << "Info: C output directory set to " << opt_string << ". " << endl;
	  break;
	default:
	  cerr << "Error: unknown option " << opt << endl;
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
    AaProgram::Write_C_Model();

  return(0);
}
