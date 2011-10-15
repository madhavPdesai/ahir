#include <signal.h>
#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>
#include <getopt.h>
#include <fstream>
using namespace std;
using namespace antlr;

// command-line parsing
extern int optind;
extern char *optarg;
int opt;
int option_index = 0;

void Handle_Segfault(int signal)
{
  AaRoot::Error("in AaLinkExtMem: segmentation fault! giving up!!", NULL);
  exit(-1);
}

void Usage_AaLinkExtMem()
{

  cerr << "brief description: reads source Aa program, adds external-memory linkages,\n and writes out modified Aa program,  " << endl;
  cerr << "Usage: AaLinkExtMem [-v] [-I <ext-mem-size>] <filename> (<filename>) ... " << endl;
  cerr << " options " << endl;
  cerr <<  " -v (or --verbose): verbose, generate lots of messages about whats happening." << endl
       <<  " -h (or --help): print help and quit.. " << endl
       <<  " -I (or --internal_ext_mem)  <mem-size> : all orphan memory references (which cannot be resolved" << endl
       <<  "              as pointing to an internally declared object in ths program) are assumed to" << endl
       <<  "              point to an external memory object whose size is mem-size bytes.  This external" << endl
       <<  "              memory object will be declared in the output program." << endl
       <<  "  Note: if -I is absent, all orphan memory references are directed outside the system " << endl
       <<  "        and need to be served by the outside world.  Further, the program will throw an " <<  endl
       <<  "        error if a pointer in the program can point to an internally declared object as well as to " << endl
       <<  "        an external object." << endl;
  cerr <<  " -E (or --ext_mem_pool_name) <mem-pool-name>: the external memory is viewed as an object " << endl
       <<  "              whose name is <mem-pool-name>.  This object is considered as an array of bytes" << endl
       <<  "              whose length needs to be specified with the -I option." << endl;
  cerr << endl;
  cerr << "example: " << endl
       << "    AaLinkExtMem -I 1024 -E mempool file1.aa  file2.aa" << endl;
  cerr << "file1.aa and file2.aa will be parsed in order, the Aa program will " << endl
       << "be analyzed for its memory structure.  The external memory object will be named  " << endl
       << "mempool and will be considered as an array of 1024 bytes.  Access routines to this memory" << endl
       << "object will be auto-generated in the output Aa file.  The external world can access this" << endl
       << "memory object as a byte-addressable array with base address 0." << endl;

}

int main(int argc, char* argv[])
{
  signal(SIGSEGV, Handle_Segfault);


  if(argc < 2)
    {
      Usage_AaLinkExtMem();
      return(1);
    }


  // command-line parsing
  struct option long_options[] =
    {
      /* These options set a flag. */
      {"verbose", no_argument, 0, 'v'},
      {"help", no_argument, 0, 'h'},
      {"optimize", no_argument,0, 'O'},
      {"internal_ext_mem",  required_argument, 0, 'I'},
      {"ext_mem_pool_name",  required_argument, 0, 'E'},
      {0, 0, 0, 0}
    };


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
	  Usage_AaLinkExtMem();
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

  // print a temporary Aa file for the global storage initializer..
  string gsi_file_name = ".gsi.aa";
  ofstream gsi_file(gsi_file_name.c_str(),ios::out);
  AaProgram::Print_Global_Storage_Initializer(gsi_file);
  gsi_file.close();

  // now parse the temporary file.
  AaParse(gsi_file_name);

  
  // elaborate
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
