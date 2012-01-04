#include <signal.h>
#include <vcSystem.hpp>
#include <vcParser.hpp>
#include <vcLexer.hpp>

using namespace std;

void Handle_Segfault(int signal)
{
  vcSystem::Error("in vcAnalyze: segmentation fault! giving up!!");
  exit(-1);
}

void Usage_VcAnalyze()
{

  cerr << "brief description: analyzes specified VC files,  " << endl;
  cerr << "Usage: " << endl;
  cerr << "vcAnalyze ... options ... " << endl;
  cerr << " options " << endl;
  cerr <<  " -t mod-name: will make mod-name a top-level module which must" << endl
       <<  "              be started from outside the AHIR system.  Such a module can " << endl
       <<  "              have input/output arguments from/to the outside world" << endl
       <<  " Notes: " << endl
       <<  "   1. alternate form: --top mod-name" << endl
       <<  "   2. option can be repeated to specify multiple top-level modules" << endl;
  cerr << endl;  
  cerr <<  " -f vcfile-name: specifies a VC file to be parsed.  Repetitions of this option can be" << endl
       <<  "                 used to specify more than one file.  Files are parsed in the order specified." << endl
       <<  " alternate form:  --file vcfile-name" << endl;
  cerr << endl;
  cerr << "example: " << endl
       << "    vcAnalyze  -t foo -f file1.vc -f file2.vc -t bar" << endl;
  cerr << "file1.vc and file2.vc will be parsed in order, and the instantiated " << endl
       << "system will have modules foo and bar as top-modules, which are controllable  " << endl
       << "from outside the system. vcAnalyze will make certain checks on these files.." << endl;
}


int main(int argc, char* argv[])
{
  

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
	Usage_VcAnalyze();
      	exit(1);
    }

  // command-line parsing
  struct option long_options[] =
    {
      /* These options set a flag. */
      {"help", no_argument, 0, 'h'},
      {"set_as_top",  required_argument, 0, 't'},
      {"vcfile",    required_argument, 0, 'f'},
      {0, 0, 0, 0}
    };


  vcSystem::_tool_name = "vcAnalyze";

  vector<string> file_list;
  set<string> file_set;

  set<string> top_modules;
  set<string> always_running_top_modules;

  extern int optind;
  extern char *optarg;
  int opt;
  int option_index = 0;

  string fname;
  string mod_name;
  string opt_string;

  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "t:f:h",
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
        case 'h':
	  Usage_VcAnalyze();
	  break;
	case '?':		  // incorrect option
	  opt_string = opt;
	  cerr << (string("Error: ") + " illegal option " + opt_string);
	  Usage_VcAnalyze();
	  break;
	default:
	  break;
	}
    }

  string sys_name = "test_system";
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

  for(set<string>::iterator iter = top_modules.begin();
	  	iter != top_modules.end();
	  	iter++)
  {
  	test_system.Set_As_Top_Module(*iter);
  }

  test_system.Elaborate();
  test_system.Print_Control_Structure(cout);

  return(0);
}


