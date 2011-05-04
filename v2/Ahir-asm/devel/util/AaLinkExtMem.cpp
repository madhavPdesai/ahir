#include <signal.h>
#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>
#include <getopt.h>
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
  AaRoot::Error("in AaLinkExtMem: segmentation fault! giving up!!", NULL);
  exit(-1);
}

int main(int argc, char* argv[])
{
  signal(SIGSEGV, Handle_Segfault);


  if(argc < 2)
    {
      cerr << "Usage: AaLinkExtMem [-v] [-I <ext-mem-size>] [-E <ext-mem-obj-name>]  <filename> (<filename>) ... " << endl;
      return(1);
    }


  string fname;
  string mod_name;
  string opt_string;
  bool opt_flag = false;

  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "vI:E:",
		      long_options, &option_index)) != -1)
    {
      switch (opt)
	{
	case 'v':
	  AaProgram::_verbose_flag = true;
	  break;
	case 'E' :
	  AaProgram::_extmem_object_name = optarg;
	  cerr << "Info: external memory object in program will be named " << optarg << endl;
	  break;
	case 'I':
	  AaProgram::_keep_extmem_inside = true;
	  AaProgram::_extmem_size = atoi(optarg);

	  if(AaProgram::_extmem_size <= 0)
	    {
	      cerr << "Error: external memory size should be > 0" << endl;
	      return(1);
	    }
	  cerr << "Info: will keep external memory inside Aa program" << endl;
	  cerr << "Info: allocating " << AaProgram::_extmem_size << " words to external memory" << endl;
	  break;
	default:
	  cerr << "Error: unknown option " << opt << endl;
	  cerr << "Usage: AaLinkExtMem [-v] [-I <ext-mem-size>] <filename> (<filename>) ... " << endl;
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
      
      if(AaRoot::Get_Error_Flag())
	{
	  cerr << "Error: there were errors while parsing file " << filename << ", check the log" << endl;
	  return(1);
	}
    }

  AaProgram::Elaborate();
  if(AaRoot::Get_Error_Flag())
    cerr << "Error: there were errors during elaboration, check the log" << endl;
  else
    {
      AaProgram::Print_ExtMem_Access_Modules(cout);
      AaProgram::Print(cout);
    }

  if(AaRoot::Get_Error_Flag())
    {
      cerr << "Error: there were errors during elaboration, check the log" << endl;
      return(1);
    }
  return(0);
}
