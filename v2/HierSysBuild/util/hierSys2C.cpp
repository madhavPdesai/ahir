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
map<string, pair<int,int> > __pmap;
set<string> __signals;
set<string> __noblock_pipes;

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
      parser->sys_Description(sys_vec, __pmap, __signals,__noblock_pipes);
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
  string c_prefix = "";
  string o_dir   = "./";

  string opt_string;

  bool use_gnu_pth = false;

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
	Usage_hierSys2C();
      	exit(1);
    }

  while ((opt = getopt_long(argc, argv, "n:o:G", long_options, &option_index)) != -1) {
	switch(opt) {
		case 'n': 
			c_prefix = optarg;
			cerr << "Info: C-prefix set to " << c_prefix  << "." << endl;
			break;
		case 'o':
			o_dir = optarg;
			cerr << "Info: output-directory set to " << o_dir  << "." << endl;
			break;
		case 'G':
			use_gnu_pth  = true;
			cerr << "Info: will link to Gnu Pth." << endl;
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
  	string base_source_file_name = c_prefix + "_" + top_sys->Get_Id() + ".c";
  	string source_file_name = o_dir + "/" + c_prefix + "_" + top_sys->Get_Id() + ".c";
  	ofstream source_file;
	source_file.open(source_file_name.c_str());

  	string base_header_file_name = c_prefix + "_" + top_sys->Get_Id() + ".h";
  	string header_file_name = o_dir + "/" + base_header_file_name;
  	ofstream header_file;
  	header_file.open(header_file_name.c_str());

	header_file << "#include <stdio.h>"  << endl;
	header_file << "void " << c_prefix << "_start_daemons(FILE* fp);" << endl;
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

	source_file << "void " << c_prefix << "_start_daemons(FILE* fp) {" << endl;
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

			string init_fn_name = lib + "_start_daemons";
			header_file << "void " << init_fn_name << "(FILE* fp );" << endl;
			source_file << init_fn_name << "(fp);" << endl;
		}	



	}
	source_file << "}" << endl;
	source_file << "void " << c_prefix << "_stop_daemons() {" << endl;
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
			string stop_fn_name = lib + "_stop_daemons";
			header_file << "void " << stop_fn_name << "();" << endl;
			source_file << stop_fn_name << "();" << endl;
		}	
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
