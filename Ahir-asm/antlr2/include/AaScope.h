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

  // hierarchical identifier of a child.
  virtual AaScope* Get_Descendant_Scope(vector<string>& desc_labels)
  {
    AaScope* ret_scope = this;
    for(unsigned int i= 0; i < desc_labels.size(); i++)
      {
	AaRoot* child = ret_scope->Find_Child(desc_labels[i]);
	if(child->Is_Scope())
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

};

#endif
