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
#include <hierSystem.h>
#include <hierSysParser.hpp>
#include <hierSysLexer.hpp>


using namespace std;

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

  
// globals
map<string, hierPipe* > __pmap;
map<string, int > __parameter_map;

void Handle_Segfault(int signal)
{
  cerr << "Error: in hierSys2Vhdl: segmentation fault! giving up!!" << endl;
  exit(-1);
}

void Usage_hierSysVhdlGenVhdlComponentsPackage()
{
  cerr << "brief description: reads hierarchical system description and produces VHDL, " << endl;
  cerr << "Usage: " << endl;
  cerr << "hierSysVhdlGenVhdlComponentsPackage -l <vhdl-lib> [-o <vhdl-output-directory>]  <file-name> (<file-name>)* " << endl;
  cerr << "Options: " << endl;
  cerr << "   -l vhdl-lib:  dumps all components corresponding to modules in library vhdl-lib." << endl;
  cerr << "             The VHDL file is streamed to stdout." << endl;
}


int  Parse(string filename, vector<hierSystem*>& sys_vec)
{
  int ret_val = 0;
  hierSystem* sys = NULL;
  ifstream infile;
  
  infile.open(filename.c_str());
  if(!infile.is_open())
    {
      cerr << "Error: Could not read file " << filename << endl;
      exit(1);
    }

  hierSysLexer* lexer = new hierSysLexer(infile);
  hierSysParser* parser = new hierSysParser(*lexer);
  
  lexer->setFilename(filename);
  parser->setFilename(filename);
  
  try
    {
      parser->sys_Description(sys_vec, __pmap, __parameter_map);
    }
  catch(ANTLR_USE_NAMESPACE(antlr)RecognitionException& re)
    {
      cerr << "Error: Parsing Exception: " << re.toString() << endl;
    }
  
  infile.close();
  delete parser;

  return(0);

}

int main(int argc, char* argv[])
{

	int ret_val = 0;
	int print_whole_hierarchy = 0;
	int map_all_libraries_to_work = 0;

	string opt_string;

	string sim_link_library = "GhdlLink";
	string sim_link_prefix = "Vhpi_";

	string odir = "./";

	signal(SIGSEGV, Handle_Segfault);

	if(argc < 2)
	{
		Usage_hierSysVhdlGenVhdlComponentsPackage();
		exit(1);
	}

	string vhdl_lib;
	while ((opt = getopt_long(argc, argv, "l:o:", long_options, &option_index)) != -1) {
		switch(opt) {
			case 'l': 
				vhdl_lib = optarg;
				cerr << "Info: vhdl-library is " << vhdl_lib << "." << endl;
				break;
			default: cerr << "Error: unknown option " << opt << endl; ret_val = 1; break;
		}
	}

	if(ret_val) return(ret_val);

	vector<hierSystem*> sys_vec;
	for(int I = optind;  I < argc; I++) {
		string filename = argv[I];
		int pstat = Parse(filename, sys_vec);
		if(pstat) {
			cerr << "Error: in parsing file " << filename << endl;
			ret_val = 1;
		}
	}
	if(ret_val) return(ret_val);



	if(ret_val == 0) 
	{

		string package_name = vhdl_lib + "BaseComponents";
		string package_vhdl_file_name =  package_name + ".unformatted_vhdl";


		cout << "library ieee;" << endl;
		cout << "use ieee.std_logic_1164.all;" << endl;
		cout << "package " << package_name << " is -- " << endl;

		for(int I = 0, fI = sys_vec.size(); I < fI; I++)
		{
			hierSystem* sys = sys_vec[I];
			string sys_vhdl_lib = sys->Get_Library();

			if(sys_vhdl_lib != vhdl_lib)
				continue;

			sys->Print_Vhdl_Component_Declaration(cout);
		}

		cout << " -- " << endl;
		cout << "end package;" << endl;

		if(hierRoot::_error_count > 0) 
		{
			cerr << "Error: there were " << hierRoot::_error_count << " errors." << endl;
			ret_val = 1;
		}
		return(ret_val);
	}
}
