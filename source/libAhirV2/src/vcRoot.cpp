#include <vcRoot.hpp>

string IntToStr(unsigned int x)
{
  ostringstream string_stream(ostringstream::out);
  string_stream << x;
  return(string_stream.str());
}

bool vcRoot_Compare::operator() (vcRoot* s, vcRoot* t) const
{
  const char *s1 = s->Get_Id().c_str ();
  const char *s2 = t->Get_Id().c_str ();

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
}

vcRoot::vcRoot()
{
  this->_id = "";
}
vcRoot::vcRoot(string id)
{
  this->_id = id;
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
