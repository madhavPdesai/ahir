using namespace std;
#include <AaIncludes.h>
#include <AaEnums.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>
#include <AaModule.h>
#include <AaProgram.h>


//---------------------------------------------------------------------
// AaRoot
//---------------------------------------------------------------------
int64_t AaRoot::_root_counter = 0;
bool AaRoot::_error_flag = false;
bool AaRoot::_warning_flag = false;

AaRoot::AaRoot() 
{
  this->_index = AaRoot::Get_Root_Counter();
  this->Increment_Root_Counter();
  this->_file_name = AaProgram::_current_file_name;
}
AaRoot::~AaRoot() {};
string AaRoot::Kind()
{
  return("AaRoot");
}
bool AaRoot::Is(const string kinfo)
{ 
  return(this->Kind() == kinfo);
}
void AaRoot::Increment_Root_Counter() { AaRoot::_root_counter += 1; }
int64_t AaRoot::Get_Root_Counter() { return AaRoot::_root_counter; }
void AaRoot::Error(string msg,AaRoot* r) 
{ 
  cerr << "Error: " << msg;
  if(r != NULL)
    cerr << " :line " << r->Get_Line_Number();
  cerr << endl;
  AaRoot::_error_flag = true;
}
void AaRoot::Warning(string msg,AaRoot* r) 
{ 
  cerr << "Warning: " << msg;
  if(r != NULL)
    cerr << " :line " << r->Get_Line_Number();
  cerr << endl;
  AaRoot::_warning_flag = true;
}

bool AaRoot::Get_Error_Flag() { return AaRoot::_error_flag; }
bool AaRoot::Get_Warning_Flag() { return AaRoot::_warning_flag; }

void AaRoot::Print(ostream& ofile)
{
  assert(0);
}
void AaRoot::Print(ofstream& ofile)
{
  ostream *outstr = &ofile;
  this->Print(*outstr);
}
void AaRoot::Print(string& ostring) 
{
  ostringstream string_stream(ostringstream::out);
  this->Print(string_stream);
  ostring += string_stream.str();
}

void AaRoot::Add_Target_Reference(AaRoot* referrer)
{
  this->_target_references.insert(referrer);
}
void AaRoot::Add_Source_Reference(AaRoot* referrer)
{
  this->_source_references.insert(referrer);
}

string Make_VC_Legal(string x)
{
  string ret_string;
  for(int i = 0; i < x.size(); i++)
    {
      if(x[i] == '%' || x[i] == '$')
	ret_string += "xx";
      else
	ret_string += x[i];
    }
  return(ret_string);
}
