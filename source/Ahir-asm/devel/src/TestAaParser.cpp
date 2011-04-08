#include <signal.h>
#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>

using namespace std;
using namespace antlr;



void Handle_Segfault(int signal)
{
  AaRoot::Error("segmentation fault! giving up!!", NULL);
  exit(-1);
}

int main(int argc, char* argv[])
{

  AaProgram::_verbose_flag = true;

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      cerr << "Usage: TestAaParser <filename>" << endl;

      exit(1);
    }


  ifstream infile;
  string filename = argv[1];

  AaParse(filename);

  if(AaRoot::Get_Error_Flag())
    {
      cerr << "Error: there were errors during parsing, check the log" << endl;
      return(1);
    }

  AaProgram::Elaborate();

  if(AaRoot::Get_Error_Flag())
    cerr << "Error: there were errors during elaboration, check the log" << endl;
  else
    AaProgram::Print(cout);
  return(0);
}
