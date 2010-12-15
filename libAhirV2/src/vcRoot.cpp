#include <vcRoot.hpp>

bool vcRoot::_err_flag = false;

vcRoot::vcRoot()
{
  this->_id = "";
}
vcRoot::vcRoot(string id)
{
  this->_id = id;
}

void vcRoot::Error(string err_msg)
{
  cerr << "Error: " << err_msg << endl;
  vcRoot::_err_flag = true;
}

void vcRoot::Warning(string err_msg)
{
  cerr << "Warning: " << err_msg << endl;
}


bool vcRoot::Get_Error_Flag()
{
  return(vcRoot::_err_flag);
}

void vcRoot::Add_Attribute(string tag, string value)
{
  this->_attribute_map[tag] = value;
}
string vcRoot::Get_Id() 
{
  return(this->_id);
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
      ofile << vcLexerKeywords[__ATTRIBUTE] << " " << vcLexerKeywords[__LPAREN] << " "
	    << (*iter).first << " " << vcLexerKeywords[__IMPLIES] << (*iter).second << vcLexerKeywords[__RPAREN] << endl;
    }
}
