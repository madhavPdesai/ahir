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
#ifndef _Aa_Scope__
#define _Aa_Scope__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>

//**************************************** SCOPE **************************************


// each scope manages a collection of scopes
class AaScope : public AaRoot
{
  // the containing scope of this scope!
  AaScope* _scope;
  unsigned int _depth;

 private: 

  string _label;
    
  //
  // map of label to children of this scope
  // children can be scopes or objects or ...
  // 
  map<string,AaRoot*,StringCompare> _child_map;


 public:

  virtual unsigned int Get_Depth() {return this->_depth;}

  virtual void Set_Label(string s) {if(s != "") this->_label = s; else assert(0);}
  virtual string Get_Label() {return (this->_label);}

  AaScope* Get_Scope() { return(this->_scope);}
  AaScope* Get_Root_Scope() 
  { 
    if(this->Get_Scope() != NULL) 
      return(this->Get_Scope()->Get_Root_Scope());
    else
      return(this);
  }
  virtual bool Get_Is_Volatile() {return(false);}

  AaScope(AaScope* parent_scope);
  ~AaScope(); 

  //  map for easy searching
  virtual void Map_Child(string tag, AaRoot* tn);

  // find child with specified label here
  virtual AaRoot* Find_Child_Here(string tag);

  // find child with specified label here or
  // higher up
  virtual AaRoot* Find_Child(string tag);


  // level_count = 0 means this scope.
  virtual AaScope* Get_Ancestor_Scope(unsigned int level_count)
  {
    AaScope* ret_scope = this;
    while(level_count > 0)
      {
	ret_scope = ret_scope->Get_Scope();
	level_count--;
	if(ret_scope == NULL)
	  break;
      }
    return(ret_scope);
  }

  
  // get nearest ancestor (including self) of the
  // specified class name
  virtual AaScope* Get_Nearest_Ancestor_Scope(string class_type);

  // hierarchical identifier of a child.
  virtual AaScope* Get_Descendant_Scope(const vector<string>& desc_labels)
  {
    AaScope* ret_scope = this;
    for(unsigned int i= 0; i < desc_labels.size(); i++)
      {
	AaRoot* child = ret_scope->Find_Child(desc_labels[i]);
	if(child != NULL && child->Is_Scope())
	  ret_scope = (AaScope*) child;
	else
	  ret_scope = NULL;
	if(ret_scope == NULL)
	  break;
      }
    return(ret_scope);
  }

  virtual bool Is_Scope() {return(true); }


  virtual string Get_Hierarchical_Name()
  {
    string ret_string;
    if(this->Get_Scope())
      ret_string = this->Get_Scope()->Get_Hierarchical_Name();
    ret_string += "%" + this->Get_Label();
    return(ret_string);
  }

  virtual string Kind() {return("AaScope");}

  virtual string Get_Struct_Dereference();
};

#endif
