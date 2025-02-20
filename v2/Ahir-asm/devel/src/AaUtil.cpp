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
using namespace std;
#include <AaIncludes.h>
#include <AaEnums.h>
#include <AaUtil.h>

string Tab_(unsigned int n)
{
  string ret_string = "";
  for(unsigned int i=0; i < n; i++)
    ret_string += '\t';
  return(ret_string);
}

string IntToStr(int x)
{
  ostringstream string_stream(ostringstream::out);
  string_stream << x;
  return(string_stream.str());
}

string Int64ToStr(int64_t x)
{
  ostringstream string_stream(ostringstream::out);
  string_stream << x;
  return(string_stream.str());
}

string UintToStr(uint32_t x)
{
  ostringstream string_stream(ostringstream::out);
  string_stream << x;
  return(string_stream.str());
}

string Uint64ToStr(uint64_t x)
{
  ostringstream string_stream(ostringstream::out);
  string_stream << x;
  return(string_stream.str());
}

int CeilLog2(int n)
{
  int ret_val = 1;

  while( n > 1)
    {
      n = n/2;
      ret_val++;
    }


  return(ret_val);
}

int nAddressBits(int n)
{
  int ret_val = 0;
  if (n > 0)
  {
  	int T = 1;
  	while(T < n)
    	{
		T = 2*T;
		ret_val++;
    	}
  }

  //
  // at least 1 bit...
  //
  if(ret_val == 0)
	ret_val = 1;

  return(ret_val);
}

uint32_t uLog2(uint32_t n)
{
  uint32_t ret_val = 0;

  while( n > 1)
    {
      n = n/2;
      ret_val++;
    }


  return(ret_val);
}


bool StringCompare::operator() (string s11, string s21) const
{
  const char *s1 = s11.c_str ();
  const char *s2 = s21.c_str ();
  for (int i = 0; s2[i]; i++)
    {
      if (!s1[i])
	return ((!s2[i]) ? false : true);
      else if (s1[i] < s2[i])
	return true;
      else if (s1[i] > s2[i])
	return false;
    }
  return false;
};

bool Is_Shift_Operation(AaOperation op)
{
  return(op == __SHL || op == __SHR);
}
bool Is_Compare_Operation(AaOperation op)
{
  return(op == __LESS || op == __GREATER || op == __LESSEQUAL || op == __GREATEREQUAL 
	 || op == __EQUAL || op == __NOTEQUAL || op == __UNORDERED);
}
bool Is_Bitsel_Operation(AaOperation op)
{
  return(op == __BITSEL);
}
bool Is_Concat_Operation(AaOperation op)
{
  return(op == __CONCAT);
}

string C_Name(AaOperation op)
{
  string ret_string = "__undefined";
  switch(op)
    {
    case __OR:
      ret_string = "__OR";
      break;
    case __AND:
      ret_string = "__AND";
      break;
    case __NOR:
      ret_string = "__NOR";
      break;
    case __NAND:
      ret_string = "__NAND";
      break;
    case __XOR:
      ret_string = "__XOR";
      break;
    case __XNOR:
      ret_string = "__XNOR";
      break;
    case __SHL:
      ret_string = "__SHL";
      break;
    case __SHR:
      ret_string = "__SHR";
      break;
    case __ROL:
      ret_string = "__ROL";
      break;
    case __ROR:
      ret_string = "__ROR";
      break;
    case __PLUS:
      ret_string = "__PLUS";
      break;
    case __MINUS:
      ret_string = "__MINUS";
      break;
    case __DIV:
      ret_string = "__DIV";
      break;
    case __MUL:
      ret_string = "__MUL";
      break;
    case __EQUAL:
      ret_string = "__EQUAL";
      break;
    case __NOTEQUAL:
      ret_string = "__NOTEQUAL";
      break;
    case __LESS:
      ret_string = "__LESS";
      break;
    case __LESSEQUAL:
      ret_string = "__LESSEQUAL";
      break;
    case __GREATER:
      ret_string = "__GREATER";
      break;
    case __GREATEREQUAL:
      ret_string = "__GREATEREQUAL";
      break;
    case __NOT:
      ret_string = "__NOT";
      break;
    case __BITSEL:
      ret_string = "__BITSELECT";
      break;
    case __CONCAT:
      ret_string = "__CONCATENATE";
      break;
    case __UNORDERED:
      ret_string = "__UNORDERED";
      break;
    default:
      cerr << "Error: unrecognized operation" << endl;
    }
  return(ret_string);
}

string Aa_Name(AaOperation op)
{
  string ret_string = "__undefined";
  switch(op)
    {
    case __OR:
      ret_string = "|";
      break;
    case __AND:
      ret_string = "&";
      break;
    case __NOR:
      ret_string = "~|";
      break;
    case __NAND:
      ret_string = "~&";
      break;
    case __XOR:
      ret_string = "^";
      break;
    case __XNOR:
      ret_string = "~^";
      break;
    case __SHL:
      ret_string = "<<";
      break;
    case __SHR:
      ret_string = ">>";
      break;
    case __ROL:
      ret_string = "<o<";
      break;
    case __ROR:
      ret_string = ">o>";
      break;
    case __PLUS:
      ret_string = "+";
      break;
    case __MINUS:
      ret_string = "-";
      break;
    case __DIV:
      ret_string = "/";
      break;
    case __MUL:
      ret_string = "*";
      break;
    case __EQUAL:
      ret_string = "==";
      break;
    case __NOTEQUAL:
      ret_string = "!=";
      break;
    case __LESS:
      ret_string = "<";
      break;
    case __LESSEQUAL:
      ret_string = "<=";
      break;
    case __GREATER:
      ret_string = ">";
      break;
    case __GREATEREQUAL:
      ret_string = ">=";
      break;
    case __NOT:
      ret_string = "~";
      break;
    case __BITSEL:
      ret_string = "[]";
      break;
    case __CONCAT:
      ret_string = "&&";
      break;
    case __UNORDERED:
      ret_string = "><";
      break;
    case __DECODE:
      ret_string = " $decode ";
      break;
    case __ENCODE:
      ret_string = " $encode ";
      break;
    case __PRIORITYENCODE:
      ret_string = " $p_encode ";
      break;
    case __BITREDUCEOR:
      ret_string = " $bitreduce | ";
      break;
    case __BITREDUCEAND:
      ret_string = " $bitreduce & ";
      break;
    case __BITREDUCEXOR:
      ret_string = " $bitreduce ^ ";
      break;
    default:
      cerr << "Error: unrecognized operation" << endl;
    }
  return(ret_string);
}


string To_Alphanumeric(string x)
{
  string ret_string;
  for(int i =0; i< x.size(); i++)
    {
      if(!isalnum(x[i]))
	ret_string += "_";
      else
	ret_string += x[i];
    }
  return(ret_string);
}

int GCD(set<int>::iterator iL, set<int>::iterator iR)
{
  int ret_val = 0;
  if(iL != iR)
    {
      int l_val = *iL;

      set<int>::iterator nextiL = iL;
      nextiL++;

      int r_val = GCD(nextiL,iR);

      if(r_val > 0)
	{
	  ret_val = r_val % l_val;
	  if(ret_val == 0)
	    ret_val = l_val;
	}
      else
	ret_val = l_val;
    }
  return(ret_val);
}

int GCD(set<int>& s)
{
  return(GCD(s.begin(), s.end()));
}

string Augment_Hier_Id(string hid, string suffix)
{
  return((hid == "") ? suffix : (hid + "/" + suffix));
}


uint32_t IntPower(uint32_t A, uint32_t B)
{
	uint32_t ret_val = 1;
	uint32_t curr_power = A;
	int I;
	for(I = 0; I < 32; I++)
	{
		if(B & 0x1)
		{
			ret_val = ret_val * curr_power;
		}
		curr_power = (curr_power * curr_power);
		B = (B >> 1);
	}
	return(ret_val);
}


string Replace_Dollar(string x)
{
  string ret_string;
  for(int i =0; i< x.size(); i++)
  {
	if(x[i] == '$') 
		ret_string += "_";
	else
		ret_string += x[i];
  }
  return(ret_string);
}

