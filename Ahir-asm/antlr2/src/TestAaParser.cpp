#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>

using namespace std;
using namespace antlr;


int main(int argc, char* argv[])
{

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
    cerr << "ERROR: Parsing Exception [#1]: " << re.toString() << endl;
    exit(1); 
  }

  infile.close();
  delete parser;
  delete lexer;


  AaProgram::Map_Source_References();


  if(AaRoot::Get_Error_Flag())
    cerr << "Error: there were errors during parsing/elaboration, check the log" << endl;
  else
    AaProgram::Print(cout);
  return(0);
}
