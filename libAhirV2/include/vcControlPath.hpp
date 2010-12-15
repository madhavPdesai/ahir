
#ifndef _vC_CP_H_
#define _vC_CP_H_
#include <vcIncludes.hpp>
class vcRoot;

enum vcTransitionType
  {
    _IN_TRANSITION,
    _OUT_TRANSITION,
    _HIDDEN_TRANSITION
  };

class vcCPElement: public vcRoot
{
  vector<vcCPElement*> _predecessors;
  vector<vcCPElement*> _successors;

public:
  vcCPElement(string id);

  void Add_Successor(vcCPElement* cpe) { this->_successors.push_back(cpe);}
  void Add_Predecessor(vcCPElement* cpe) {this->_predecessors.push_back(cpe);}

  virtual string Kind() {return("vcCPElement");}
  virtual void Print(ostream& ofile) {assert(0);}

};


class vcTransition: public vcCPElement
{
  vcTransitionType _transition_type;
  pair<string, string> _dp_link;

public:
  vcTransition(string id, vcTransitionType t);
  void Add_DP_Link(string dpe_name, string req_ack_name)
  {
    this->_dp_link.first = dpe_name;
    this->_dp_link.second = req_ack_name;
  }

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcTransition");}

  pair<string,string>& Get_DP_Link() {return(this->_dp_link);}

  friend class ControlPath;
};

class vcPlace: public vcCPElement
{
  unsigned int _initial_marking;
public:
  vcPlace(string id, unsigned int init_marking);
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcPlace");}

  friend class ControlPath;
};

class vcCPBlock: public vcCPElement
{

  map<string, vcCPElement*> _element_map;
  vector<vcCPElement*> _elements;

public:
  vcCPBlock(string id);
  void Add_CPElement(vcCPElement* cpe);
  vcCPElement* Find_CPElement(string cname);
  virtual void Print(ostream& ofile) {assert(0);}
  void Print_Elements(ostream& ofile);

  virtual string Kind() {return("vcCPBlock");}
};

class vcCPSeriesBlock: public vcCPBlock
{
protected:
  vcPlace* _entry;
  vcPlace* _exit;
  
public:
  vcCPSeriesBlock(string id);
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcCPSeriesBlock");}
};

class vcCPParallelBlock: public vcCPBlock
{
protected:
  vcTransition* _entry;
  vcTransition* _exit;

public:
  vcCPParallelBlock(string id);
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcCPSeriesBlock");}
};

class vcCPBranchBlock: public vcCPSeriesBlock
{
  map<vcPlace*, vector<vcCPElement*>, vcRoot_Compare >   _branch_map;
  map<vcPlace*, vector<vcCPElement*>, vcRoot_Compare > _merge_map;

public:
  vcCPBranchBlock(string id);
  virtual string Kind() {return("vcCPBranchBlock");}

  void Add_Branch_Point(string bp_name, vector<string>& choice_cpe_vec);
  void Add_Merge_Point(string merge_place, string merge_region);
  virtual void Print(ostream& ofile);
};

class vcCPForkBlock: public vcCPParallelBlock
{
  map<vcTransition*, vector<vcCPElement*>, vcRoot_Compare > _fork_map;
  map<vcTransition*, vector<vcCPElement*>, vcRoot_Compare > _join_map;

public:
  virtual string Kind() {return("vcCPForkBlock");}
  vcCPForkBlock(string id);
  virtual void Print(ostream& ofile);
  void Add_Fork_Point(string& fork_name, vector<string>& fork_cpe_vec);
  void Add_Join_Point(string& join_name, vector<string>& join_cpe_vec);
};


class vcControlPath: public vcCPParallelBlock
{
public:
  virtual string Kind() {return("vcControlPath");}

  vcControlPath(string id);
  vcTransition* Find_Transition(string tname);
  vcPlace* Find_Place(string pname);
  virtual void Print(ostream& ofile);

};

#endif
