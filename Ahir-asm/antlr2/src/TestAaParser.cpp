#include <AaParserClasses.h>
#include <AaParser.h>
#include <AaLexer.h>

using namespace std;
using namespace antlr;


int main(int argc, char* argv[])
{

  if(argc < 2)
    {
      cerr << "Usage: TestAaParser <filename>" << endl;
      exit(1);
    }

  // make the program
  AaProgram* pgm = new AaProgram();

  ifstream infile;
  string filename = argv[1];
  infile.open(argv[1]);
  if(!infile.is_open())
    {
      cerr << "Error: Could not read file " << filename << endl;
      exit(1);
    }

  AaLexer* lexer = new AaLexer(fin);
  AaParser* parser = new AaParser(*lexer);

  lexer->setFilename(filename);
  parser->setFilename(filename);

  try
  {
    parser->aA_Program(pgm);
  }
  catch(ANTLR_USE_NAMESPACE(antlr)RecognitionException& re)
  {
    cerr << "ERROR: Parsing Exception [#1]: " << re.toString() << endl;
    exit(1); 
  }

  delete parser;
  delete lexer;


  pgm->Print(cout);

  return(0);
}
