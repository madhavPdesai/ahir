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
// AaScope
//---------------------------------------------------------------------
AaScope::AaScope(AaScope* p):AaRoot() 
{
  this->_scope = p; 
  if(p != NULL)
    this->_depth = p->Get_Depth() + 1;
  else
    this->_depth = 0;
}

AaScope::~AaScope() {}


void AaScope::Map_Child(string lbl, AaRoot* tn)
{
  if(tn != NULL)
    {
      if(this->_child_map.find(lbl) == this->_child_map.end())
	{
	  this->_child_map[lbl] = tn;
	}
      else if(!tn->Is("AaPlaceStatement"))
	{
	  AaRoot::Error("scope has multiple children with same label " + lbl, this);
	}
      else
	{
	  AaRoot::Warning("Place with multiple sources: " + lbl, this);
	}
    }
}

AaRoot* AaScope::Find_Child_Here(string cname)
{
  AaRoot* ret_child = NULL;
  map<string,AaRoot*,StringCompare>::iterator miter =
    this->_child_map.find(cname);
  if(miter != this->_child_map.end())
    ret_child = (*miter).second;
  return(ret_child);
}

AaRoot* AaScope::Find_Child(string cname)
{
  AaRoot* ret_child = this->Find_Child_Here(cname);
  if(!ret_child && this->Get_Scope())
    {
      ret_child = this->Get_Scope()->Find_Child(cname);
    }
  return(ret_child);
}


string AaScope::Get_Struct_Dereference()
{
  string ret_string;

  if(this->Get_Scope() == NULL)
    ret_string = AaProgram::Get_Top_Struct_Variable_Name() + "->";
  else if (this->Get_Label() != "")
    ret_string = this->Get_Scope()->Get_Struct_Dereference() + this->Get_Label() + ".";
  else 
    ret_string = this->Get_Scope()->Get_Struct_Dereference();

  return(ret_string);
}


AaScope* AaScope::Get_Nearest_Ancestor_Scope(string class_type)
{
  AaScope* p = this;
  while (p != NULL)
    {
      if(p->Is(class_type))
	break;
      p = p->Get_Scope();
    }
  return(p);
}
