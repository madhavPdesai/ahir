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
  AaRoot::Error("in AaOpt: segmentation fault! giving up!!", NULL);
  exit(-1);
}

int main(int argc, char* argv[])
{
  AaProgram::_verbose_flag = false;

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      cerr << "Usage: AaOpt [-I <extmem-obj-name>] [-r <module-name>]* <filename> (<filename>) ... " << endl;
      cerr << "    -I <extmem-obj-name> : specify the name of the memory object target for external references." << endl
	   << "    -r <module-name>     : specify roots of the module hierarchy." << endl
	   << "    -B                   : select option to balance do-while loop pipelines." << endl
	   << "    -v                   : verbose... lots of junk printed." << endl
           << "     <filename> (<filename>) ... " << endl;
      exit(1);
    }

  string fname;
  string mod_name;
  string opt_string;
  bool opt_flag = false;


  // inline in outfile
  AaProgram::_print_inlined_functions_in_caller = true;
  AaProgram::_do_not_print_orphans = true;

  AaProgram::_tool_name = "AaOpt";
  AaProgram::_buffering_bits_added_during_path_balancing = 0;

  while ((opt = 
	  getopt_long(argc, 
		      argv, 
		      "I:r:Bv",
		      long_options, &option_index)) != -1)
    {
      switch (opt)
	{
	case 'I':
	  AaProgram::_keep_extmem_inside  = true;
	  AaProgram::_extmem_object_name = optarg;
	  break;
	case 'r':
	  mod_name = string(optarg);
	  AaProgram::Mark_As_Root_Module(mod_name); 
	  cerr << "Info:AaOpt: module " << mod_name << " set as a root module." << endl;
	  break;
        case 'B':
	  AaProgram::_balance_loop_pipeline_bodies = true;
	  break;
	case 'v':
	  AaProgram::_verbose_flag = true;
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
  {
    cerr << "Error: there were errors during elaboration, check the log" << endl;
    return(1);
  }

  if(!AaRoot::Get_Error_Flag() && AaProgram::_balance_loop_pipeline_bodies)
  {
	AaProgram::Equalize_Paths_Of_Pipelined_Modules();
   }

  if(AaRoot::Get_Error_Flag())
    cerr << "Error: there were errors during balancing of pipeline-bodies, check the log" << endl;
  else
    AaProgram::Print(cout);

   cerr << "Info: added " << AaProgram::_buffering_bits_added_during_path_balancing
			<< " bits of buffering during path balancing." << endl;
  if(AaRoot::Get_Error_Flag())
    {
      cerr << "Error: there were errors during elaboration, check the log" << endl;
      return(1);
    }
  return(0);
}
