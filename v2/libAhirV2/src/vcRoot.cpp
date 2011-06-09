#include <vcRoot.hpp>

string To_VHDL(string x)
{
  string ret_string;
  for (int i = 0; i < x.size(); i++)
    {
      if(x[i] == '/' || x[i] == '$')
	{
	  ret_string += 'X';
	}
      else
	{
	  if((i > 0) && x[i-1] == '_' && x[i] == '_')
	    ret_string += "x_x";
	  else if(i == x.size()-1 && x[i] == '_')
	    ret_string += "_x";
	  else
	    ret_string += x[i];
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
  else
    return(0);

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
