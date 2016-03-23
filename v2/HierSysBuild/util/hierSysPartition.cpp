#include <signal.h>
#include <Value.hpp>
#include <hierSystem.h>
#include <hierSysParser.hpp>
#include <hierSysLexer.hpp>
#include <rtlThread.h>
using namespace std;
  
// global variables
map<string, hierPipe* > __pmap;

void Handle_Segfault(int signal)
{
  cerr << "Error: in hierSys2C: segmentation fault! giving up!!" << endl;
  exit(-1);
}

void Usage_hierSysPartition()
{
  cerr << "brief description: reads hierarchical system, checks it for errors, flattens and partitions into HW/SW as specified. " << endl;
  cerr << "Usage: " << endl;
  cerr << "hierSysPartition <file-name> (<file-name>)* " << endl;
  cerr << "IN PROGRESS :-) " << endl;
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
      parser->sys_Description(sys_vec, __pmap);
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
	Usage_hierSysPartition();
      	exit(1);
    }

  vector<hierSystem*> sys_vec;
  for(int I = 1;  I < argc; I++) {
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
  }

  hierSystem* top_sys = sys_vec[sys_vec.size() - 1];
  hierInstanceGraph* g = NULL;
  top_sys->Build_Instance_Hierarchy(&g);

  assert (g != NULL);
  g->Build_Connectivity();
  g->Print(cout);

  map<hierPipeInstance*, hierPipeInstance*> root_pipe_map;
  g->Set_Root_Pipes(root_pipe_map);

  FlatLeafGraph* fg = NULL;
  g->Build_Flat_Leaf_Graph(&fg);
  assert(fg != NULL);
  fg->Print(cout);

  return(ret_val);
}
