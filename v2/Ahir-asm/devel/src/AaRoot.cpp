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
  this->_delay = 0;
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
  cerr << AaProgram::_tool_name << " Error: " << msg;
  if(r != NULL)
    {
      cerr << ": file " << r->Get_File_Name() << ", line " << r->Get_Line_Number();
    }

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

void AaRoot::Info(string msg) 
{
  cerr << "Info: " << msg << endl;
}

void AaRoot::DebugInfo(string msg) 
{
  if(AaProgram::_verbose_flag)
  	cerr << "Info: " << msg << endl;
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

  for(int idx = 0; idx < x.size(); idx++)
    {
      if(isalnum(x[idx]) || (x[idx] == '_'))
	ret_string += x[idx];
      else
	ret_string += "xx";
    }

  return(ret_string);
}


bool AaRootCompare::operator() (AaRoot* s1, AaRoot* s2) const
{
  if(s1->Get_Index() < s2->Get_Index())
    return(true);
  else
    return(false);
}

bool AaRootPairCompare::operator() (AaRootPair* s1, AaRootPair* s2) const
{
  if(s1->_distance_from_root > s2->_distance_from_root)
    return(true);
  else if((s1->_element != NULL) && (s2->_element == NULL))
    return(true); 
  else if((s2->_element == NULL) && (s2->_element != NULL))
    return(false);
  else if((s1->_element == NULL) && (s2->_element == NULL))
    return(false);
  else if(s1->_element->Get_Root_Counter() < s2->_element->Get_Root_Counter())
    return(true);
  else
    return(false);
}

void __InsMap(map<AaRoot*,vector< pair<AaRoot*, int> > >& amap, AaRoot* src, AaRoot* dest, int Dist)
{
	amap[src].push_back(pair<AaRoot*,int>(dest,Dist));
	cerr << "Info:aa: added adjacency " << ((src != NULL) ? src->Get_Name() : "NULL") << " -> " << dest->Get_Name() << "(" << Dist << ")" << endl;
	cerr << "Info:aa:vc: added adjacency " << ((src != NULL) ? src->Get_VC_Name() : "NULL") << " -> " << dest->Get_VC_Name() << "(" << Dist << ")" << endl;

}
