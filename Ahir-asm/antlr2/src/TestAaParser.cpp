#include <signal.h>
#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>

using namespace std;
using namespace antlr;



void Handle_Segfault(int signal)
{
    cerr << "Error: segmentation fault, Exiting the program." << endl;
    exit(-1);
}

int main(int argc, char* argv[])
{

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      cerr << "Usage: TestAaParser <filename>" << endl;
      exit(1);
    }


  ifstream infile;
  string filename = argv[1];
  infile.open(argv[1]);
  if(!infile.is_open())
    {
      cerr << "Error: Could not read file " << filename << endl;
      exit(1);
    }

  AaLexer* lexer = new AaLexer(infile);
  AaParser* parser = new AaParser(*lexer);

  lexer->setFilename(filename);
  parser->setFilename(filename);

  try
  {
    parser->aA_Program();
  }
  catch(ANTLR_USE_NAMESPACE(antlr)RecognitionException& re)
  {
    cerr << "Error: Parsing Exception: " << re.toString() << endl;
    AaRoot::Error();
  }

  infile.close();
  delete parser;
  delete lexer;


  if(AaRoot::Get_Error_Flag())
    {
      cerr << "Error: there were errors during parsing, check the log" << endl;
      return(1);
    }


  AaProgram::Init_Call_Graph();
  AaProgram::Map_Source_References();
  AaProgram::Check_For_Cycles_In_Call_Graph();

  //  AaProgram::Print_Type_Dependency_Graph(std::cerr);
  AaProgram::Propagate_Types();

  if(AaRoot::Get_Error_Flag())
    cerr << "Error: there were errors during elaboration, check the log" << endl;
  else
    AaProgram::Print(cout);
  return(0);
}
