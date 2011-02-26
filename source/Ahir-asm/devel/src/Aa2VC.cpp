#include <signal.h>
#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>
#include <Aa2C.h>

using namespace std;
using namespace antlr;



void Handle_Segfault(int signal)
{
  AaRoot::Error("segmentation fault! giving up!!", NULL);
  exit(-1);
}

int main(int argc, char* argv[])
{

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      cerr << "Usage: Aa2VC <filename> (<filename>) ... " << endl;
      exit(1);
    }


  for(int i = 1; i < argc; i++)
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
    cerr << "Error: there were errors during elaboration, check the log" << endl;
  else
    AaProgram::Write_VC_Model(32,8,cout);

  return(0);
}
