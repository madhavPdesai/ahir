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
      parser->sys_Description(sys_vec);
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


  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
	Usage_hierSys2C();
      	exit(1);
    }

  while ((opt = getopt_long(argc, argv, "n:o:", long_options, &option_index)) != -1) {
	switch(opt) {
		case 'n': 
			c_prefix = optarg;
			cerr << "Info: C-prefix set to " << c_prefix  << "." << endl;
			break;
		case 'o':
			o_dir = optarg;
			cerr << "Info: output-directory set to " << o_dir  << "." << endl;
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
	else sys->Print(cerr);
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

	source_file << "#include <" << base_header_file_name << ">" << endl;
	source_file << "void " << c_prefix << "_start_daemons() {" << endl;
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{
		hierSystem* sys = sys_vec[I];

		if(sys->Is_Leaf())
		{
			string lib = sys->Get_Library();
			string id  = sys->Get_Id();

			string init_fn_name = lib + "_start_daemons";
			header_file << "void " << init_fn_name << "();" << endl;
			source_file << init_fn_name << "();" << endl;
		}	
	}
	source_file << "}" << endl;
	source_file << "void " << c_prefix << "_stop_daemons() {" << endl;
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{
		hierSystem* sys = sys_vec[I];

		if(sys->Is_Leaf())
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

  return(ret_val);
}
