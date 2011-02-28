#include <signal.h>
#include <vcSystem.hpp>
#include <vcParser.hpp>
#include <vcLexer.hpp>

using namespace std;

void Handle_Segfault(int signal)
{
  vcSystem::Error("segmentation fault! giving up!!");
  exit(-1);
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
      
      test_system.Parse(filename);
      
      if(vcSystem::Get_Error_Flag())
	{
	  cerr << "Error: there were errors during parsing, check the log" << endl;
	  return(1);
	}
    }

  test_system.Elaborate();
  test_system.Print_Control_Structure(cout);
  return(0);
}


