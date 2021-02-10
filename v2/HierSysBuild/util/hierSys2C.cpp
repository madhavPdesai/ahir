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
#include <Value.hpp>
#include <hierSystem.h>
#include <hierSysParser.hpp>
#include <hierSysLexer.hpp>
#include <rtlThread.h>

using namespace std;

// command-line parsing
extern int optind;
extern char *optarg;
int opt;
int option_index = 0;


// global variables
map<string, hierPipe* > __pmap;
map<string, int > __parameter_map;

struct option long_options[] = {
	{"relaxed-component-visibility", 0, 0, 0},
	{"depend", required_argument, 0, 0},
	{0, 0, 0, 0}
};

void Handle_Segfault(int signal)
{
	cerr << "Error: in hierSys2C: segmentation fault! giving up!!" << endl;
	exit(-1);
}

void Usage_hierSys2C()
{
	cerr << "brief description: reads hierarchical system description and produces C code for the system, " << endl;
	cerr << "Usage: " << endl;
	cerr << "hierSys2C [-n <function-prefix>] [-o <out-directory>] <file-name> (<file-name>)* " << endl;
	cerr << "Options: " << endl;
	cerr << "   -n system-name:  a prefix of system-name will be added to all generated functions. " << endl;
	cerr << "   -u  (optional: will flatten and use unique ids for each instance " << endl;
	cerr << "   -o out-directory:  generated source and header files will be printed into out-directory. " << endl;
	cerr << "   -G  (to use Gnu Pth.. slower, but more reliable than pthreads)" << endl;
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

void printUniquifiedStartDaemons(vector<hierSystem*>& sys_vec, 
		FlatLeafGraph* fg,
		ostream& header_file,
		ostream& source_file)
{
	hierSystem* top_sys = sys_vec[sys_vec.size() - 1];

	// register all pipes
	for(set<hierPipeInstance*>::iterator pter = fg->_flat_pipes.begin(), fpter = fg->_flat_pipes.end();
			pter != fpter; pter++)
	{
		hierPipeInstance* pi = *pter;
		bool top_level_pipe  = (pi->_instance_graph_node->_system == top_sys);

		hierPipe* p = pi->_pipe;
		int W = p->Get_Width();
		int D = p->Get_Depth();

		if (D <= 0) D = 1;
		int eW = (((W == 8) || (W == 16) || (W == 32) || (W ==64)) ? W : 8);
		int eD = D*((((W/eW)*eW) == W) ? W/eW  : (W/eW)+1);

		string pname;
		if(!top_level_pipe)
			pname= Make_C_Legal(pi->Hierarchical_Name());
		else
			pname= pi->_pipe->Get_Id();

		if(p->Get_Is_Signal())
		{
			source_file << " register_signal(\"" << pname <<  "\", " << eW << ");" << endl;
		}
		else
		{
			int pipe_type = (p->Get_Is_Noblock() ? 2 : 0);
			source_file << " register_pipe(\"" << pname << "\", "  << eD << ", " << eW << ", "
				<< pipe_type << ");" << endl;
		}

		if(fg->_driven_instance_map.find(pi) != fg->_driven_instance_map.end())
		{
			source_file  << "set_pipe_is_written_into(\"" << pname << "\");" << endl;
		}
		if(fg->_driving_instance_map.find(pi) != fg->_driving_instance_map.end())
		{
			source_file  << "set_pipe_is_read_from(\"" << pname << "\");" << endl;
		}
	}


	// start all leaf daemons.
	for(set<hierInstanceGraph*>::iterator iiter = fg->_instances.begin(),
			fiiter = fg->_instances.end();
			iiter != fiiter; iiter++)
	{
		hierInstanceGraph* g = *iiter;
		string g_c_name = Make_C_Legal(g->Hierarchical_Name());
		hierSystem* gs = g->_system;
		string gs_prefix = gs->Get_Library() + "_" + g_c_name + "_";

		header_file << "void " << gs_prefix << "start_daemons(FILE*fp, int trace_on);" << endl;
		source_file << gs_prefix << "start_daemons(fp,trace_on);" << endl;

	}
}

int printNonuniquifiedStartDaemons(vector<hierSystem*>& sys_vec,
		map<hierSystem*, vector<string> >&  match_daemon_map,
		ostream& header_file,
		ostream& source_file)
{
	int ret_val = 0;
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{

		hierSystem* sys = sys_vec[I];

		// register all input/output pipes and set written-into/read-from
		// status.
		vector<string> in_pipes;
		vector<string> out_pipes;
		vector<string> internal_pipes;
		sys->List_In_Pipe_Names(in_pipes);
		sys->List_Out_Pipe_Names(out_pipes);
		sys->List_Internal_Pipe_Names(internal_pipes);

		int J, fJ;
		for(J = 0, fJ = in_pipes.size(); J < fJ; J++)
		{
			string pname = in_pipes[J];
			string q_pname = "\"" + pname + "\"";
			int W = sys->Get_Input_Pipe_Width(pname);
			int D = sys->Get_Input_Pipe_Depth(pname);
			if (D <= 0) D = 1;
			int eW = (((W == 8) || (W == 16) || (W == 32) || (W ==64)) ? W : 8);
			int eD = D*((((W/eW)*eW) == W) ? W/eW  : (W/eW)+1);
			if(sys->Is_Signal(pname))
				source_file << " register_signal(" << q_pname <<  ", " << eW << ");" << endl;
			else
			{
				int pipe_type = (sys->Is_Noblock_Pipe(pname) ? 2 : 0);
				source_file << " register_pipe(" << q_pname << ", "  << eD << ", " << eW << ", "
					<< pipe_type << ");" << endl;
			}

			source_file << " set_pipe_is_read_from(" << q_pname << ");" << endl;
		}
		for(J = 0, fJ = out_pipes.size(); J < fJ; J++)
		{
			string pname = out_pipes[J];
			string q_pname = "\"" + pname + "\"";
			int W = sys->Get_Output_Pipe_Width(pname);
			int D = sys->Get_Output_Pipe_Depth(pname);
			if (D <= 0) D = 1;
			int eW = (((W == 8) || (W == 16) || (W == 32) || (W ==64)) ? W : 8);
			int eD = D*((((W/eW)*eW) == W) ? W/eW  : (W/eW)+1);
			if(sys->Is_Signal(pname))
				source_file << " register_signal(" << q_pname <<  ", " << eW << ");" << endl;
			else
			{
				int pipe_type = (sys->Is_Noblock_Pipe(pname) ? 2 : 0);
				source_file << " register_pipe(" << q_pname << ", "  << eD << ", " << eW << ", "
					<< pipe_type << ");" << endl;
			}
			source_file << " set_pipe_is_written_into(" << q_pname << ");" << endl;
		}
		for(J = 0, fJ = internal_pipes.size(); J < fJ; J++)
		{
			string pname = internal_pipes[J];
			string q_pname = "\"" + pname + "\"";
			int W = sys->Get_Internal_Pipe_Width(pname);
			int D = sys->Get_Internal_Pipe_Depth(pname);
			if (D <= 0) D = 1;
			int eW = (((W == 8) || (W == 16) || (W == 32) || (W ==64)) ? W : 8);
			int eD = D*((((W/eW)*eW) == W) ? W/eW  : (W/eW)+1);
			if(sys->Is_Signal(pname))
				source_file << " register_signal(" << q_pname <<  ", " << eW << ");" << endl;
			else
			{
				int pipe_type = (sys->Is_Noblock_Pipe(pname) ? 2 : 0);
				source_file << " register_pipe(" << q_pname << ", "  << eD << ", " << eW << ", "
					<< pipe_type << ");" << endl;
			}
			source_file << " set_pipe_is_read_from(" << q_pname << ");" << endl;
			source_file << " set_pipe_is_written_into(" << q_pname << ");" << endl;
		}
	}

	// print daemons etc.
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{

		hierSystem* sys = sys_vec[I];

		if(sys->Number_Of_Strings() > 0)
		{
			source_file << "// allocate match structs for system " << sys->Get_Id() << endl;
			for(int J = 0, fJ = sys->Number_Of_Strings(); J < fJ; J++)
			{
				rtlString* s = sys->Get_Rtl_String(J);
				source_file << stringMatcherAllocatorFunctionName(s) << "();" << endl;
			}

			source_file << "// match daemons for system " << sys->Get_Id() << endl;
			for (int J = 0, fJ = match_daemon_map[sys].size(); J < fJ; J++)
			{
				string match_daemon = match_daemon_map[sys][J];
				source_file << "PTHREAD_DECL(" << match_daemon << ");" << endl;
				source_file << "PTHREAD_CREATE(" << match_daemon << ");" << endl;
			}

			string ticker_name = sys->Get_Id() + "_String_Ticker";
			source_file  << "PTHREAD_DECL(" << ticker_name << ");" << endl;
			source_file  << "PTHREAD_CREATE("  << ticker_name << ");" << endl;
		}

		if(sys->Is_Leaf() && (I < (fI-1)))
		{
			string lib = sys->Get_Library();
			string id  = sys->Get_Id();

			string init_fn_name = lib + "_" + id + "_start_daemons";
			header_file << "void " << init_fn_name << "(FILE* fp, int trace_on);" << endl;
			source_file << init_fn_name << "(fp, trace_on);" << endl;
		}	
	}
	return(ret_val);
}

void printUniquifiedStopDaemons(vector<hierSystem*>& sys_vec,
		FlatLeafGraph* fg,
		ostream& header_file,
		ostream& source_file)
{
	// stop all leaf daemons.
	for(set<hierInstanceGraph*>::iterator iiter = fg->_instances.begin(),
			fiiter = fg->_instances.end();
			iiter != fiiter; iiter++)
	{
		hierInstanceGraph* g = *iiter;
		string g_c_name = Make_C_Legal(g->Hierarchical_Name());
		hierSystem* gs = g->_system;
		string gs_prefix = gs->Get_Library() + "_" + g_c_name + "_";

		header_file << "void " << gs_prefix << "stop_daemons();" << endl;
		source_file << gs_prefix << "stop_daemons();" << endl;

	}
}


int printNonuniquifiedStopDaemons(vector<hierSystem*>& sys_vec,
		ostream& header_file,
		ostream& source_file)
{
	int ret_val = 0;
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{
		hierSystem* sys = sys_vec[I];

		if(sys->Is_Leaf() && (I < (fI-1)))
		{
			if(sys->Get_Instance_Count() > 1)
			{
				cerr << "Error: for legal conversion to C, each system can have only one instance.." << endl
					<< "  system " << sys->Get_Id() << " has " << sys->Get_Instance_Count() << " instances." << endl;
				ret_val = 1;
			}
			string lib = sys->Get_Library();
			string id  = sys->Get_Id();
			string stop_fn_name = lib + "_" + id + "_stop_daemons";
			header_file << "void " << stop_fn_name << "();" << endl;
			source_file << stop_fn_name << "();" << endl;
		}	
	}
	return(ret_val);
}

int main(int argc, char* argv[])
{

	int ret_val = 0;
	string c_prefix = "";
	string o_dir   = "./";

	string opt_string;

	bool use_gnu_pth = false;
	bool uniquify_flag = false;

	signal(SIGSEGV, Handle_Segfault);

	if(argc < 2)
	{
		Usage_hierSys2C();
		exit(1);
	}

	while ((opt = getopt_long(argc, argv, "n:o:Gu", long_options, &option_index)) != -1) {
		switch(opt) {
			case 'n': 
				c_prefix = optarg;
				cerr << "Info: C-prefix set to " << c_prefix  << "." << endl;
				break;
			case 'u': 
				uniquify_flag = true;
				cerr << "Info: uniquify-flag = true."  << endl;
				break;
			case 'o':
				o_dir = optarg;
				cerr << "Info: output-directory set to " << o_dir  << "." << endl;
				break;
			case 'G':
				use_gnu_pth  = true;
				cerr << "Info: will link to Gnu Pth." << endl;
				break;
			default: cerr << "Error: unknown option " << opt << " ignored " <<  endl;  break;
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

	for(int I = 0, fI = sys_vec.size(); I < fI; I++) {
		hierSystem* sys = sys_vec[I];
		if(sys->Get_Error() || sys->Check_For_Errors()) {
			cerr << "Error: in building system " << sys->Get_Id() << endl;
			ret_val = 1;	
		}
		else 
			sys->Print(cerr);
	}


	if(ret_val == 0) {		


		hierSystem* top_sys = sys_vec.back();
		hierInstanceGraph* g = NULL;
		map<hierPipeInstance*, hierPipeInstance*> root_pipe_map;
		FlatLeafGraph* fg = NULL;

		if(uniquify_flag)
		{

			hierSystem* top_sys = sys_vec[sys_vec.size()-1];

			top_sys->Build_Instance_Hierarchy(&g);

			assert (g != NULL);

			g->Build_Connectivity();
			g->Set_Root_Pipes(root_pipe_map);
			g->Build_Flat_Leaf_Graph(&fg);

			assert(fg != NULL);

		}

		string base_source_file_name = c_prefix + "_" + top_sys->Get_Id() + ".c";
		string source_file_name = o_dir + "/" + c_prefix + "_" + top_sys->Get_Id() + ".c";
		ofstream source_file;
		source_file.open(source_file_name.c_str());

		string base_header_file_name = c_prefix + "_" + top_sys->Get_Id() + ".h";
		string header_file_name = o_dir + "/" + base_header_file_name;
		ofstream header_file;
		header_file.open(header_file_name.c_str());

		header_file << "#include <stdio.h>"  << endl;
		header_file << "void " << c_prefix << "_start_daemons(FILE* fp, int trace_on);" << endl;
		header_file << "void " << c_prefix << "_stop_daemons();" << endl;

		source_file << "#include <string.h>"  << endl;
		source_file << "#include <pipeHandler.h>"  << endl;

		if(use_gnu_pth)
			source_file << "#include <GnuPthUtils.h>"  << endl;
		else
			source_file << "#include <pthreadUtils.h>"  << endl;

		source_file << "#include <rtl2AaMatcher.h>"  << endl;
		source_file << "#include <" << base_header_file_name << ">" << endl;

		map<hierSystem*, vector<string> >  match_daemon_map;
		for(int I = 0, fI = sys_vec.size(); I < fI; I++)
		{
			hierSystem* sys = sys_vec[I];
			vector<string> match_daemons;
			if(sys->Number_Of_Strings() > 0)
			{
				sys->Print_C_String_Ticker(header_file, source_file, match_daemons);
			}
			match_daemon_map[sys] = match_daemons;
		}

		source_file << "void " << c_prefix << "_start_daemons(FILE* fp, int trace_on) {" << endl;
		if(uniquify_flag)
		{
			printUniquifiedStartDaemons(sys_vec,fg,header_file,source_file);
		}
		else
		{
			ret_val = printNonuniquifiedStartDaemons(sys_vec, match_daemon_map, 
								header_file, source_file);
		}
		source_file << "}" << endl;
		source_file << "void " << c_prefix << "_stop_daemons() {" << endl;
		if(uniquify_flag)
		{
			printUniquifiedStopDaemons(sys_vec, fg, header_file, source_file);
		}
		else
		{
			ret_val = printNonuniquifiedStopDaemons(sys_vec, header_file, source_file);
		}

		source_file << "}" << endl;
		header_file.close();
		source_file.close();
	}

	if(hierRoot::_error_count > 0)
	{
		cerr << "Error: there were " << hierRoot::_error_count << " errors. " << endl;
		ret_val = 1;
	}
	return(ret_val);
}
