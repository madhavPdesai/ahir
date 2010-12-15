#include <signal.h>
#include <AaParserClasses.h>
#include <AaParser.hpp>
#include <AaLexer.hpp>

using namespace std;
using namespace antlr;



void Handle_Segfault(int signal)
{
  vcRoot::Error("segmentation fault! giving up!!", NULL);
  exit(-1);
}


void vcParse(string filename)
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
      parser->vc_System();
    }
  catch(ANTLR_USE_NAMESPACE(antlr)RecognitionException& re)
    {
      cerr << "Error: Parsing Exception: " << re.toString() << endl;
      vcRoot::Error("",NULL);
    }
  
  infile.close();
  delete parser;
  delete lexer;
}


int main(int argc, char* argv[])
{

  signal(SIGSEGV, Handle_Segfault);

  if(argc < 2)
    {
      cerr << "Usage: TestVcParser <filename>" << endl;

      exit(1);
    }


  ifstream infile;
  string filename = argv[1];

  vcParse(filename);

  if(vcRoot::Get_Error_Flag())
    {
      cerr << "Error: there were errors during parsing, check the log" << endl;
      return(1);
    }

  return(0);
}
