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
  AaRoot::Error("segmentation fault! giving up!!", NULL);
  exit(-1);
}

struct option long_options[] = {
    {"relaxed-component-visibility", 0, 0, 0},
    {"depend", required_argument, 0, 0},
    {0, 0, 0, 0}
};


int main(int argc, char* argv[])
{

  cout << "// Virtual circuit produced from Aa description by Aa2VC " << endl;
  signal(SIGSEGV, Handle_Segfault);

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      cerr << "Usage: Aa2VC [-O] <filename> (<filename>) ... " << endl;
      exit(1);
    }


  string fname;
  string mod_name;
  string opt_string;
  bool opt_flag = false;

  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "O",
		      long_options, &option_index)) != -1)
    {
      switch (opt)
	{
	case 'O':
	  opt_flag = true;
	  break;
	default:
	  cerr << "Error: unknown option " << opt << endl;
	}
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
      if(opt_flag)
	AaProgram::Write_VC_Model_Optimized(32,8,cout);
      else
	AaProgram::Write_VC_Model(32,8,cout);
    }


  return(0);
}
