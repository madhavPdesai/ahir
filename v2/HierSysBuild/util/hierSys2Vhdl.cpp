#include <signal.h>
#include <hierSystem.h>
#include <hierSysParser.hpp>
#include <boost/filesystem.hpp>
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
map<string, pair<int,int> > __pmap;
set<string> __signals;

void Handle_Segfault(int signal)
{
  cerr << "Error: in hierSys2Vhdl: segmentation fault! giving up!!" << endl;
  exit(-1);
}

void Usage_hierSys2Vhdl()
{
  cerr << "brief description: reads hierarchical system description and produces VHDL, " << endl;
  cerr << "Usage: " << endl;
  cerr << "hierSys2Vhdl [-s <ghdl/modelsim>] [-o <vhdl-output-directory>]  <file-name> (<file-name>)* " << endl;
  cerr << "Options: " << endl;
  cerr << "   -s ghdl or -s modelsim:  specifies the simulator for which the test-bench should be generated." << endl;
  cerr << "   -o <vhdl-dir>:  specifies the directory into which the VHDL is to be printed." << endl;
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
      parser->sys_Description(sys_vec, __pmap, __signals);
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

  string opt_string;

  string sim_link_library = "GhdlLink";
  string sim_link_prefix = "Vhpi_";
  
  string odir = "./";

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
	Usage_hierSys2Vhdl();
      	exit(1);
    }

  while ((opt = getopt_long(argc, argv, "s:o:a", long_options, &option_index)) != -1) {
	switch(opt) {
		case 's': 
			opt_string = optarg;
			if(opt_string == "modelsim")  {
				sim_link_prefix = "Modelsim_FLI_";
				sim_link_library = "ModelsimLink";
			}
			break;
		case 'o':
			odir = optarg;
			break;
		case 'a':
			print_whole_hierarchy = 1;
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
	if(odir != "./")
		boost::filesystem::create_directory(odir);

  	hierSystem* top_sys = sys_vec.back();
	string top_vhdl_lib = top_sys->Get_Library();
	if(top_vhdl_lib == "")
		top_vhdl_lib = "work";

	
	//
	// print lower level entity/architectures..
	// (for all non-leaf entities)
	// 
	if(print_whole_hierarchy)
	{
		for(int I = 0, fI = sys_vec.size(); I < fI; I++)
		{
			hierSystem* sys = sys_vec[I];
			if(sys == top_sys)
				continue;
			if(sys->Is_Leaf())
				continue;

			string sys_vhdl_lib = sys->Get_Library();
			if(sys_vhdl_lib == "")
				sys_vhdl_lib = "work";


			string sys_dir =  odir + "/" + sys_vhdl_lib;
			boost::filesystem::create_directory(sys_dir);

			string sys_vhdl_file_name =  sys_dir + "/" + sys->Get_Id() + ".unformatted_vhdl";
			ofstream sys_vhdl_file;

			sys_vhdl_file.open(sys_vhdl_file_name.c_str());
			sys_vhdl_file << "library ieee;" << endl;
			sys_vhdl_file << "use ieee.std_logic_1164.all;" << endl;

			sys->Print_Vhdl_Entity_Architecture(sys_vhdl_file);
			sys_vhdl_file.close();
		}
	}

	string top_dir = odir + "/" + top_vhdl_lib;
	boost::filesystem::create_directory(top_dir);

	string top_vhdl_file_name = top_dir + "/" +  top_sys->Get_Id() + ".unformatted_vhdl";
	ofstream top_vhdl_file;

	top_vhdl_file.open(top_vhdl_file_name.c_str());
	top_vhdl_file << "library ieee;" << endl;
	top_vhdl_file << "use ieee.std_logic_1164.all;" << endl;
	top_sys->Print_Vhdl_Entity_Architecture(top_vhdl_file);
	top_vhdl_file.close();


	string tb_dir = odir + "/work";
	boost::filesystem::create_directory(tb_dir);

	string vhdl_tb_file_name = tb_dir + "/" + top_sys->Get_Id() + "_test_bench.unformatted_vhdl";
	ofstream vhdl_tb_file; 
	vhdl_tb_file.open(vhdl_tb_file_name.c_str());

	vhdl_tb_file << "library ieee;" << endl;
	vhdl_tb_file << "use ieee.std_logic_1164.all;" << endl;

	top_sys->Print_Vhdl_Test_Bench(sim_link_library, sim_link_prefix, vhdl_tb_file);
	vhdl_tb_file.close();
  }
  return(ret_val);
}
