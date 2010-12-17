#include <signal.h>
#include <vcSystem.hpp>
#include <vcParser.hpp>
#include <vcLexer.hpp>

using namespace std;
using namespace antlr;


void Handle_Segfault(int signal)
{
  vcSystem::Error("segmentation fault! giving up!!");
  exit(-1);
}


void vcParse(string filename, vcSystem* sys)
{
  ifstream infile;
  
  infile.open(filename.c_str());
  if(!infile.is_open())
    {
      cerr << "Error: Could not read file " << filename << endl;
      exit(1);
    }
  
  vcLexer* lexer = new vcLexer(infile);
  vcParser* parser = new vcParser(*lexer);
  
  lexer->setFilename(filename);
  parser->setFilename(filename);
  
  try
    {
      parser->vc_System(sys);
    }
  catch(ANTLR_USE_NAMESPACE(antlr)RecognitionException& re)
    {
      cerr << "Error: Parsing Exception: " << re.toString() << endl;
      vcSystem::Error("");
    }
  
  infile.close();
  delete parser;
  delete lexer;
}


int main(int argc, char* argv[])
{
  
  string sys_name = "test_system";
  vcSystem test_system(sys_name);

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      cerr << "Usage: TestVcParser <filename> <filename> ... " << endl;

      exit(1);
    }


  for(int idx = 1; idx < argc; idx++)
    {

      string filename = argv[idx];
      
      vcParse(filename, &test_system);
      
      if(vcSystem::Get_Error_Flag())
	{
	  cerr << "Error: there were errors during parsing, check the log" << endl;
	  return(1);
	}
    }

  test_system.Print(cout);
  return(0);
}
