#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcControlPath.hpp>

vcCPElement::vcCPElement(string id):vcRoot(id)
{
}

vcTransition::vcTransition(string id, vcTransitionType t):vcCPElement(id)
{
  this->_transition_type = t;
}

void vcTransition::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__TRANSITION] << " " << this->Get_Id() << " ";
  switch(_transition_type)
    {
    case  _IN_TRANSITION: ofile << vcLexerKeywords[__IN] << endl; break;
    case  _OUT_TRANSITION: ofile << vcLexerKeywords[__OUT] << endl; break;
    case  _HIDDEN_TRANSITION: ofile << vcLexerKeywords[__HIDDEN] << endl; break;
    default: break;
    }
}


vcPlace::vcPlace(string id, unsigned int init_marking):vcCPElement(id)
{
  this->_initial_marking = init_marking;
}

void vcPlace::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__PLACE] << " " << this->Get_Id() << endl;
}

vcCPBlock::vcCPBlock(string id): vcCPElement(id)
{
}

void vcCPBlock::Add_CPElement(vcCPElement* cpe)
{
  assert(this->_element_map.find(cpe->Get_Id()) == this->_element_map.end());

  this->_element_map[cpe->Get_Id()] = cpe;
  this->_elements.push_back(cpe);
}

vcCPElement* vcCPBlock::Find_CPElement(string cname)
{
  if(this->_element_map.find(cname) == this->_element_map.end())
    return(NULL);
  else
    return ((*(this->_element_map.find(cname))).second);
}

void vcCPBlock::Print_Elements(ostream& ofile)
{
  for(int idx = 0; idx < this->_elements.size(); idx++)
    this->_elements[idx]->Print(ofile);
}


vcCPSeriesBlock::vcCPSeriesBlock(string id):vcCPBlock(id)
{
  _entry = new vcPlace(vcLexerKeywords[__ENTRY],0);
  _exit = new vcPlace(vcLexerKeywords[__EXIT],0);
}

void vcCPSeriesBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__SERIESBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);
  ofile << "}" << endl;
}

vcCPParallelBlock::vcCPParallelBlock(string id):vcCPBlock(id)
{
  _entry = new vcTransition(vcLexerKeywords[__ENTRY],_HIDDEN_TRANSITION);
  _exit = new vcTransition(vcLexerKeywords[__EXIT], _HIDDEN_TRANSITION);
}
void vcCPParallelBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__PARALLELBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);
  ofile << "}" << endl;
}

vcCPBranchBlock::vcCPBranchBlock(string id):vcCPSeriesBlock(id)
{
}

void vcCPBranchBlock::Add_Branch_Point(string bp_name, vector<string>& choice_cpe_vec)
{
  vcCPElement* bp = this->Find_CPElement(bp_name);
  assert(bp != NULL && bp->Is("vcPlace"));

  for(int idx = 0; idx < choice_cpe_vec.size(); idx++)
    {
      vcCPElement* bre = this->Find_CPElement(choice_cpe_vec[idx]);
      assert(bre != NULL);
      this->_branch_map[((vcPlace*)bp)].push_back(bre);
    }
}

void vcCPBranchBlock::Add_Merge_Point(string merge_place, string merge_region)
{
  vcCPElement* mp = this->Find_CPElement(merge_place);
  vcCPElement* mr = this->Find_CPElement(merge_region);

  assert(mp != NULL && mp->Is("vcPlace"));
  assert(mr != NULL);
  this->_merge_map[(vcPlace*)mp].push_back(mr);
}

void vcCPBranchBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__BRANCHBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);

  // now print the branch and merge points.
  for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _branch_map.begin();
      iter != _branch_map.end();
      iter++)
    {
      ofile << vcLexerKeywords[__FROM] << " " << (*iter).first->Get_Label() << " " << 
	vcLexerKeywords[__BRANCH] << " " << vcLexerKeywords[__LPAREN];
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << vcLexerKeywords[__RPAREN] << endl;
    }

  for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _merge_map.begin();
      iter != _merge_map.end();
      iter++)
    {
      ofile << vcLexerKeywords[__AT] << " " << (*iter).first->Get_Label() << " " << vcLexerKeywords[__MERGE] << " "
	    << vcLexerKeywords[__LPAREN] ;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << vcLexerKeywords[__RPAREN] << endl;
    }
}



vcCPForkBlock::vcCPForkBlock(string id):vcCPParallelBlock(id)
{
}


void vcCPForkBlock::Add_Fork_Point(string& fork_name, vector<string>& fork_cpe_vec)
{
  vcCPElement* fp = this->Find_CPElement(fork_name);
  assert(fp != NULL && fp->Is("vcTransition"));

  for(int idx = 0; idx < fork_cpe_vec.size(); idx++)
    {
      vcCPElement* fre = this->Find_CPElement(fork_cpe_vec[idx]);
      assert(fre != NULL);
      this->_fork_map[((vcTransition*)fp)].push_back(fre);
    }
}

void vcCPForkBlock::Add_Join_Point(string& join_name, vector<string>& join_cpe_vec)
{
  vcCPElement* jp = this->Find_CPElement(join_name);
  assert(jp != NULL && jp->Is("vcTransition"));

  for(int idx = 0; idx < join_cpe_vec.size(); idx++)
    {
      vcCPElement* jre = this->Find_CPElement(join_cpe_vec[idx]);
      assert(jre != NULL);
      this->_join_map[((vcTransition*)jp)].push_back(jre);
    }
}
void vcCPForkBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__FORKBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);


  for(map<vcTransition*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _fork_map.begin();
      iter != _fork_map.end();
      iter++)
    {
      ofile << vcLexerKeywords[__FROM] << " " << (*iter).first->Get_Label() << " " << 
	vcLexerKeywords[__FORK] << " " << vcLexerKeywords[__LPAREN];
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << vcLexerKeywords[__RPAREN] << endl;
    }


  for(map<vcTransition*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _join_map.begin();
      iter != _join_map.end();
      iter++)
    {
      ofile << vcLexerKeywords[__AT] << " " << (*iter).first->Get_Label() << " " << 
	vcLexerKeywords[__JOIN] << " " << vcLexerKeywords[__LPAREN];
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << vcLexerKeywords[__RPAREN] << endl;
    }
}


vcControlPath::vcControlPath(string id):vcCPParallelBlock(id)
{
}

// some thought here.. named transitions must be unique.
vcTransition* vcControlPath::Find_Transition(string tname)
{
  assert(0);
  vcCPElement* cpe = this->Find_CPElement(tname);
  if(cpe->Is("vcTransition"))
    return((vcTransition*)cpe);

  return(NULL);

  //\todo: recursive descent into child regions
  //       to locate transition
}

vcPlace* vcControlPath::Find_Place(string tname)
{
  assert(0);
  vcCPElement* cpe = this->Find_CPElement(tname);
  if(cpe->Is("vcPlace"))
    return((vcPlace*)cpe);

  return(NULL);

  //\todo: recursive descent into child regions
  //       to locate transition
}

void vcControlPath::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__CONTROLPATH] << " {" << endl;
  this->Print_Elements(ofile);
  this->Print_Attributes(ofile);
  ofile << "}" << endl;
}

