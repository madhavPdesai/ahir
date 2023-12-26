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
#include <limits.h>
#include <vcRoot.hpp>

string StripBracketingQuotes(string x)
{
   string ret_string;
   for(int idx = 0; idx < x.size(); idx++)
   {
	if(x[idx] == '"')
		continue;
	else
	   ret_string  += x[idx];
   }
   return(ret_string);
}

string To_VHDL(string x)
{
  string ret_string;
  bool replace_underscore = false;;
  for (int i = 0; i < x.size(); i++)
    {
      if(x[i] == '/' || x[i] == '$' || x[i] == '.')
	{
	  ret_string += 'X';
	}
      else
	{
	  if(x[i] == '_')
	  {
		if(replace_underscore)
		{
			ret_string += "x_x";
			replace_underscore = false;
		}
		else
		{ 
			if(i == (x.size()-1))
			{
				ret_string += "_x";
				replace_underscore = false;
			}
			else
			{
				ret_string += "_";
				replace_underscore = true;
			}
		}
          }
	  else
	  {
		replace_underscore = false;
	    	ret_string += x[i];
	  }
	}
    }
  return(ret_string);
}

string IntToStr(unsigned int x)
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

// n must be a power of base.
int Log(int n, int base)
{
  assert( n > 0);

  int ret_val = 0;
  int pow_val = 1;
  int tn = n;
  while(tn > 1)
    {
      tn = tn/base; ret_val++; pow_val = pow_val*base;
    }

  return(ret_val);
}

int IPow(int n, int e)
{
  if(n != 0 && e == 0)
    return(1);

  if(n == 0 && e < 0)
    assert(0);

  int exp = 1; int nexp;
  int ret_val = n;
  while(1)
    {

      nexp = 2*exp;

      if(nexp > e)
	break;

      ret_val = (ret_val*ret_val);

      exp = nexp;
    }

  if(exp < e)
    {
      ret_val = ret_val*IPow(n,e-exp);
    }

  return(ret_val);
}


bool vcRoot_Compare::operator() (vcRoot* s, vcRoot* t) const
{
  return(s->Get_Root_Index() < t->Get_Root_Index());
}


int64_t vcRoot::_root_index_counter = 0;

vcRoot::vcRoot()
{
  this->_id = "";
  this->_root_index = vcRoot::_root_index_counter;
  vcRoot::_root_index_counter++;
}
vcRoot::vcRoot(string id)
{
  this->_id = id;
  this->_root_index = vcRoot::_root_index_counter;
  vcRoot::_root_index_counter++;
}


void vcRoot::Add_Attribute(string tag, string value)
{
	this->_attribute_map[tag] = value;
}
  
bool vcRoot::Has_Attribute(string tag)
{
  return(this->_attribute_map.find(tag) != this->_attribute_map.end());
}

string vcRoot::Find_Attribute_Value(string tag)
{
	if(this->Has_Attribute(tag))
	{
		return(this->_attribute_map[tag]);
	}
}

string vcRoot::Get_Id() 
{
  return(this->_id);
}
string vcRoot::Get_Label()
{
  string ret_string = (vcLexerKeywords[__LBRACKET] + this->Get_Id()) + vcLexerKeywords[__RBRACKET];
  return(ret_string);
}
void vcRoot::Print(ostream& ofile)
{
  assert(0);
}
void vcRoot::Print(ofstream& ofile)
{
  ostream *outstr = &ofile;
  this->Print(*outstr);
}
void vcRoot::Print(string& ostring)
{
  ostringstream string_stream(ostringstream::out);
  this->Print(string_stream);
  ostring += string_stream.str();
}

void vcRoot::Print_Attributes(ostream& ofile)
{
  for(map<string,string>::iterator iter = _attribute_map.begin();
      iter != _attribute_map.end();
      iter++)
    {
      ofile << vcLexerKeywords[__ATTRIBUTE] << " " 
	    << (*iter).first << " " << vcLexerKeywords[__IMPLIES] << (*iter).second << endl;
    }
}


void vcRoot::Print_VHDL(ofstream& ofile)
{
  ostream *outstr = &ofile;
  this->Print_VHDL(*outstr);
}

int max(vector<int>& vec)
{
 	int ret_val = INT_MIN;
	for(int I = 0, fI = vec.size(); I < fI; I++)
	{
		int U = vec[I];
		ret_val = ((U > ret_val) ? U : ret_val);
	}
	return(ret_val);
}
int min(vector<int>& vec)
{
 	int ret_val = INT_MAX;
	for(int I = 0, fI = vec.size(); I < fI; I++)
	{
		int U = vec[I];
		ret_val = ((U < ret_val) ? U : ret_val);
	}
	return(ret_val);
}

string GenConcatenation(vector<string>& preds)
{
  string ret_string;
  for(int u = 0; u < preds.size(); u++)
    {
      if(u > 0)
	ret_string += " & ";
      ret_string += preds[u];
    }
  return(ret_string);
}


string GenConstString(vector<int>& V)
{
  string ret_string = "(";
  for(int u = 0; u < V.size(); u++)
    {
      if(u > 0)
	ret_string += ",";
      ret_string += IntToStr(u) + " => " + IntToStr(V[u]);
    }
  ret_string += ")";
  return(ret_string);

}

void Print_VHDL_Join(string join_name,
		     vector<string>& preds,
		     vector<int>& pred_markings,
		     vector<int>& pred_capacities,
		     vector<int>& pred_delays,
		     string joined_symbol,
		     ostream& ofile)
{
  ofile << join_name << ": block -- { " << endl
	<< "constant place_capacities: IntegerArray(0 to " << preds.size()-1 << ") := " << GenConstString(pred_capacities) << ";" << endl
	<< "constant place_markings: IntegerArray(0 to " << preds.size()-1 << ")  := " << GenConstString(pred_markings) << ";" << endl
	<< "constant place_delays: IntegerArray(0 to " << preds.size()-1 << ") := " << GenConstString(pred_delays) << ";" << endl
	<< "constant joinName: string(1 to " << join_name.size() << ") := \"" << join_name << "\"; " << endl;
  ofile << "signal preds: BooleanArray(1 to " << preds.size() << "); -- }" << endl;
  ofile << "begin -- { " << endl;
  if(preds.size() > 1)
    ofile << "preds <= " << GenConcatenation(preds) << ";" << endl;
  else
    ofile << "preds(1) <= " << preds[0] << ";" << endl;
  ofile << " gj_" << join_name << " : generic_join generic map(name => joinName, number_of_predecessors => " << preds.size() 
	<< ", place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- {"
	<< endl
	<< " port map(preds => preds, symbol_out => " << joined_symbol << ", clk => clk, reset => reset); --}}" << endl;
  ofile << "end block;" << endl;
}

void Print_VHDL_Simple_Join(string join_name, 
			    vector<string>& preds, 
			    string joined_symbol,
			    int delay,
			    ostream& ofile)
{

  ofile << join_name << ": block -- { " << endl;
  ofile << "signal preds: BooleanArray(0 to " << preds.size()-1 << ");" << endl;
  ofile << "constant joinName: string(1 to " << join_name.size() << ") := \"" << join_name << "\"; -- }" << endl;

  string bypass_str = ((delay > 0) ? "false" : "true");
  ofile << "begin -- { " << endl;
  if(preds.size() > 1)
    ofile << "preds <= " << GenConcatenation(preds) << ";" << endl;
  else
    ofile << "preds(0) <= " << preds[0] << ";" << endl;
  ofile << " jn_" << join_name << " : join generic map(name => joinName, number_of_predecessors => " << preds.size()
	<< ", place_capacity => 1, bypass => " << bypass_str << ") -- {"
	<< endl
	<< " port map(preds => preds, symbol_out => " << joined_symbol << ", clk => clk, reset => reset); --}}" << endl;
  ofile << "end block;" << endl;

}
