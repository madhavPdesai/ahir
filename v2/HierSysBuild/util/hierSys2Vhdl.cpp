#include <signal.h>
#include <hierSystem.h>
#include <hierSysParser.hpp>
#include <hierSysLexer.hpp>

using namespace std;

void Handle_Segfault(int signal)
{
  cerr << "Error: in vcAnalyze: segmentation fault! giving up!!" << endl;
  exit(-1);
}

void Usage_hierSys2Vhdl()
{
  cerr << "brief description: reads hierarchical system description and produces VHDL, " << endl;
  cerr << "Usage: " << endl;
  cerr << "hierSys2Vhdl <file-name> " << endl;
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
  

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
	Usage_hierSys2Vhdl();
      	exit(1);
    }


  string filename = argv[1];
  vector<hierSystem*> sys_vec;
  ret_val = Parse(filename, sys_vec);
  if(ret_val)
  {
	cerr << "Error: in parsing " << endl;
	return(ret_val);
  }
      

  for(int I = 0, fI = sys_vec.size(); I < fI; I++)
  {
	hierSystem* sys = sys_vec[I];
	if(sys->Get_Error() || sys->Check_For_Errors())
	{
		cerr << "Error: in building system " << sys->Get_Id() << endl;
		ret_val = 1;	
	}
	else
		sys->Print(cerr);
  }


  if(ret_val == 0)
  {
	cout << "package HierSysComponentPackage is --{ " << endl;
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{
		hierSystem* sys = sys_vec[I];
		sys->Print_Vhdl_Component_Declaration(cout);
	}
	cout << "--}" << endl <<"end package;" << endl;
	cout << endl << endl;
	for(int I = 0, fI = sys_vec.size(); I < fI; I++)
	{
		hierSystem* sys = sys_vec[I];
		sys->Print_Vhdl_Entity_Architecture(cout);
	}
  }


  return(ret_val);
}
