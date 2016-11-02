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

void printUsage()
{
      cerr << "Usage: Aa2C [-I ext-storage-object] [-T top-module]* [-P c-fn-prefix] [-o <output-directory>] [-G] <filename> (<filename>) ... " << endl;
      cerr << "   -I <ext-storage-object> (as used in Aa2C etc.) " << endl;
      cerr << "   -T <top-module-name>    (as in Aa2C etc.)" << endl;
      cerr << "   -P <c-fn-prefix>    (prefix appended to all generated functions)" << endl;
      cerr << "   -o <output-director> (results to be placed here) " << endl;
      cerr << "   -G    (to use Gnu Pth..  slower than pthreads, but more well behaved)" << endl;
}

int main(int argc, char* argv[])
{

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      printUsage();
      exit(1);
    }


  bool use_gnu_pthreads = false;
   AaProgram::_tool_name = "Aa2C";
  string fname;
  string mod_name;
  string opt_string;
  bool opt_flag = false;
  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "I:T:P:o:G",
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
	case 'G':
	  AaProgram::_use_gnu_pth = true;
	  cerr << "Info: compatible with GNU-PTH. " << opt_string << ". " << endl;
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
