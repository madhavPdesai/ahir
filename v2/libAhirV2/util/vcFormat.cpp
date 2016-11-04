//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.


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
	      cout << Tab(tab_count);
	      cout << inchar << "\n";
	      tab_count++;
	      last_char_is_return = true;
	    }
	  else if(inchar == '}')
	    {
	      if(!last_char_is_return) // push } to new line with appropriate tab
		cout << "\n";
	      tab_count--;
	      cout << Tab(tab_count);
	      cout << inchar << "\n";
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

