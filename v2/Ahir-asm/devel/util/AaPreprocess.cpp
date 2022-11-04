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
#include <stdlib.h>
#include <signal.h>
#include <getopt.h>
#include <vector>
#include <map>
#include <stack>
#include <fstream>
#include <iostream>

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


void Handle_Segfault(int signal)
{
  cerr << "Error: in AaInclude: segmentation fault! giving up!!";
  exit(-1);
}

void __print_string__(ofstream& ofile, string val)
{
	ofile << val;
}

void __print_char__(ofstream& ofile, char val)
{
	ofile << val;
}

      
int IncludeAndPrint(ifstream& infile,vector<string>& include_directories,map<string,string>& defines_map, stack<int>& ifdef_stack, ofstream& ofile)
{
  int err = 0;
  char last_inchar = 0;
  char terminating_char;


  //
  // look for #<file-name> and include those files also..
  //
  while(!infile.eof()) 
  {
     
     char inchar = infile.get();
    
     if(infile.eof()) 
	break;

     if(inchar == '#')
//
// #define   X Y
// #include filename
// ##X
// #undefine
// #ifdef #endif
     {
	string keyword;
	while(1) {
		inchar = infile.get();
		if(infile.eof() || isspace(inchar) || (inchar == '\\'))
		{
			terminating_char = inchar;
			break;
		}
		keyword.push_back(inchar);
        }
	
	if(keyword == "define")
	{
		string s1, s2;

		infile >> s1;
		infile >> s2;

		cout << "Info: #define " << s1 << " " << s2 << endl;
		defines_map[s1] = s2;
	}
	else if(keyword == "undefine")
	{
		string key;
		infile >> key;
		cerr << "Info: #undefine " << key << endl;
		defines_map.erase(key);
	}
        else if (keyword == "if") 
	{
		string key;
		infile >> key;

		int pval = 0;
		if(defines_map.find(key)  != defines_map.end())
		{
			int print_on = (ifdef_stack.size() == 0) || (ifdef_stack.top() != 0);
			if((defines_map[key] != "0") && print_on)
			{
				pval = 1;
			}
		}
		ifdef_stack.push(pval);
	}
	else if (keyword == "endif")
	{
		if(ifdef_stack.size() > 0)
		{
			ifdef_stack.pop();
		}
		else
		{
			cerr << "Error: unmatched #endif" << endl;
			err = 1;
		}
	}
	else if(keyword == "include")
	{
		string incl_filename;
		infile >> incl_filename;


		int ok_flag = 0;

		int print_on = (ifdef_stack.size() == 0) || (ifdef_stack.top() != 0);

		if(print_on)
		{
			cerr << "Info: #include " << incl_filename << endl;
			for(int I = 0, fI = include_directories.size(); I < fI; I++)
			{
				string full_file_name = include_directories[I] + "/" + incl_filename;
				ifstream incl_file;
				incl_file.open(full_file_name.c_str());
				if(incl_file.is_open())
				{
					cerr << "Info: included file " << full_file_name << endl;
					err = IncludeAndPrint(incl_file, include_directories, defines_map, ifdef_stack, ofile) || err;
					incl_file.close();
					ok_flag = true;
					break;
				}
			}
			if(!ok_flag)
			{
				cerr << "Error:AaInclude could not include file " << incl_filename << endl;
				err = 1;
			}
		}
	}
	else if(keyword[0] == '#')
	{
	     	int print_on = (ifdef_stack.size() == 0) || (ifdef_stack.top() != 0);
		if(print_on) {
			string key = keyword.substr(1);
			if(defines_map.find(key) != defines_map.end())
			{
				// ofile << defines_map[key];
				__print_string__(ofile, defines_map[key]);

				if(isspace(terminating_char)) 
					__print_char__(ofile, terminating_char);
				// ofile  << terminating_char;
				cerr << "Info: ##" << key << endl;
			}	
			else
			{
				cerr << "Error: could not find define to paste " << keyword << endl;
				err = 1;
			}
		}
	}
     }
     else
     {
	     int print_on = (ifdef_stack.size() == 0) || (ifdef_stack.top() != 0);
	     if(print_on)
		     __print_char__(ofile, inchar);
	     //ofile << inchar;

	     last_inchar = inchar;
     } 
  }
  return(err);
}

int main(int argc, char* argv[])
{
	int err = 0;
	signal(SIGSEGV, Handle_Segfault);

	if(argc < 2)
	{
		cerr << "Usage: AaPreprocess [-I <include-directory>]*  <filename> (<filename>) ... " << endl;
		cerr << "    -I <include-directory> : add include directory to search path." << endl;
		cerr << "    -o <output-file-name>  : output file\n" << endl;
		cerr << "     <filename> (<filename>) ... " << endl;
		return(1);
	}

	string idir;
	vector<string> include_directories;

	string ofile_name;
	while ((opt = 
				getopt_long(argc, 
					argv, 
					"I:o:",
					long_options, &option_index)) != -1)
	{
		switch (opt)
		{
			case 'I':
				idir = optarg;
				include_directories.push_back(idir);
				break;
			case 'o':
				ofile_name = optarg;
				break;
			default:
				cerr << "Error: unknown option " << opt << endl;
				err = 1;
				break;
		}
	}

	if(ofile_name == "") 
	{
		cerr << "Error: output file not specified" << endl;
		err = 1;
	}
	ofstream ofile;
	ofile.open(ofile_name.c_str());
	map<string, string> defines_map;

	stack<int> ifdef_stack;

	for(int i = optind; i < argc; i++)
	{
		ifstream infile;
		string filename = argv[i];      
		infile.open(filename.c_str());
		if(infile.is_open())
		{
			err = IncludeAndPrint(infile,include_directories,defines_map, ifdef_stack, ofile) | err;
		}
		else
		{
			cerr << "Error: could not open file " << filename << endl;
			err = 1;
		}
		infile.close();
	}
	ofile.close();

	return(err);
}
