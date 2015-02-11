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
  cerr << "Error: in vcAnalyze: segmentation fault! giving up!!" << endl;
  exit(-1);
}

void Usage_hierSys2Vhdl()
{
  cerr << "brief description: reads hierarchical system description and produces VHDL, " << endl;
  cerr << "Usage: " << endl;
  cerr << "hierSys2Vhdl [-s <ghdl/modelsim>]  <file-name> (<file-name>)* " << endl;
  cerr << "Options: " << endl;
  cerr << "   -s ghdl or -s modelsim:  specifies the simulator for which the test-bench should be generated." << endl;
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
  string opt_string;

  string sim_link_library = "GhdlLink";
  string sim_link_prefix = "Vhpi_";
  

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
	Usage_hierSys2Vhdl();
      	exit(1);
    }

  while ((opt = getopt_long(argc, argv, "s:", long_options, &option_index)) != -1) {
	switch(opt) {
		case 's': 
			opt_string = optarg;
			if(opt_string == "modelsim")  {
				sim_link_prefix = "Modelsim_FLI_";
				sim_link_library = "ModelsimLink";
			}
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
  	string vhdl_file_name = top_sys->Get_Id() + ".vhdl";
  	ofstream vhdl_file;
  	vhdl_file.open(vhdl_file_name.c_str());

	vhdl_file << "library ieee;" << endl;
	vhdl_file << "use ieee.std_logic_1164.all;" << endl;
	vhdl_file << "package HierSysComponentPackage is --{ " << endl;
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{
		hierSystem* sys = sys_vec[I];
		sys->Print_Vhdl_Component_Declaration(vhdl_file);
	}
	vhdl_file << "--}" << endl <<"end package;" << endl;
	vhdl_file << endl << endl;
	
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{
		hierSystem* sys = sys_vec[I];
		sys->Print_Vhdl_Entity_Architecture(vhdl_file);
	}
	vhdl_file.close();

  	string vhdl_testbench_file_name = top_sys->Get_Id() + "_test_bench.vhdl";
	ofstream vhdl_tb_file; 
	vhdl_tb_file.open(vhdl_testbench_file_name.c_str());
	vhdl_tb_file << "library ieee;" << endl;
	vhdl_tb_file << "use ieee.std_logic_1164.all;" << endl;
	vhdl_tb_file << "library work;" <<endl;
	vhdl_tb_file << "use work.HierSysComponentPackage.all;" << endl;
	top_sys->Print_Vhdl_Test_Bench(sim_link_library, sim_link_prefix, vhdl_tb_file);
	vhdl_tb_file.close();
  }


  return(ret_val);
}
