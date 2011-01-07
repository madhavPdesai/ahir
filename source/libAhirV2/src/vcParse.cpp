#include <signal.h>
#include <vcSystem.hpp>
#include <vcParser.hpp>
#include <vcLexer.hpp>

using namespace std;
using namespace antlr;

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



