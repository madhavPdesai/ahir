#include <iostream>
#include <fstream>

using namespace std;
string Tab(int tab_count)
{
  string ret_string;
  while(tab_count > 0)
    {
      ret_string += "  ";
      tab_count--;
    }
  return(ret_string);
}

// uses @ and # as indent-region boundaries.
int main(int argc, char* argv[])
{
  bool last_char_is_return = true;
  if(argc > 1)
    {
      cerr << "Usage: vcFormat < file " << endl;
      return(1);
    }

  /*  ifstream infile;
  string filename = argv[1];
  infile.open(filename.c_str());
  */

  char inchar;
  int tab_count = 0;
  while(!cin.eof())
    {

      inchar = cin.get();
      if(cin.eof())
	break;

      if(!last_char_is_return || !isspace(inchar))
	{

	  if(inchar  == '{')
	    {
	      if(!last_char_is_return) // push { to new line with appropriate tab.
		cout << "\n";
	      tab_count++;
	      last_char_is_return = true;
	    }
	  else if(inchar == '}')
	    {
	      if(!last_char_is_return) // push } to new line with appropriate tab
		cout << "\n";
	      tab_count--;
	      last_char_is_return = true;
	      
	    }
	  else if(inchar == '\n')
	    {
	      cout << inchar;
	      last_char_is_return = true;
	    }
	  else
	    {
	      if(last_char_is_return)
		cout << Tab(tab_count);

	      last_char_is_return = false;
	      cout << inchar;
	    }
	}
    }
  return(0);
}

