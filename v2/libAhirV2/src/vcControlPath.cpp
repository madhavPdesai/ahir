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
#include <limits.h>
#include <BGLWrap.hpp>
#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcSystem.hpp>

int64_t vcControlPath::_free_index = 0;

vcCompatibilityLabel::vcCompatibilityLabel(vcControlPath* cp, string id): vcCPElement(cp,id)
{
	this->_labeled_in_arc.first = NULL;
}

void vcCompatibilityLabel::Add_In_Arc(vcCompatibilityLabel* u, pair<vcTransition*, int>& arc)
{
	assert(this->_labeled_in_arc.first == NULL);

	this->_labeled_in_arc.first = u;
	this->_labeled_in_arc.second = arc;
}

void vcCompatibilityLabel::Add_In_Arc(vcCompatibilityLabel* u)
{
	this->_unlabeled_in_arcs.insert(u);
}

vcCompatibilityLabel* vcCompatibilityLabel::Reduce(vcControlPath* cp)
{
	vcCompatibilityLabel* ret_label = this;
	bool change_flag = true;;

	while(change_flag)
	{

		change_flag = false;
		if(this->_unlabeled_in_arcs.size() > 0)
			assert(this->_labeled_in_arc.first == NULL);
		if(this->_labeled_in_arc.first != NULL)
			assert(this->_unlabeled_in_arcs.size() ==  0);

		if(this->_unlabeled_in_arcs.size() == 0)
			return(ret_label);

		if(this->_unlabeled_in_arcs.size() == 1)
		{
			{// just one labeled in arc.
				ret_label = (*(this->_unlabeled_in_arcs.begin()));
			}
			return(ret_label);
		}

		// more than one incoming unlabeled edge

		vector<vcCompatibilityLabel* > erase_vec;
		vector<vcCompatibilityLabel* > insert_vec;


		// First, eliminate unlabeled paths of length 2.
		for(set<vcCompatibilityLabel*>::iterator iter = this->_unlabeled_in_arcs.begin();
				iter != this->_unlabeled_in_arcs.end();
				iter++)
		{
			vcCompatibilityLabel* u = *(iter);
			if(u->_unlabeled_in_arcs.size() > 0)
			{
				erase_vec.push_back(u);
				for(set<vcCompatibilityLabel*>::iterator miter = u->_unlabeled_in_arcs.begin();
						miter != u->_unlabeled_in_arcs.end();
						miter++)
				{
					insert_vec.push_back((*miter));
				}
			}
		}
		// remove all elements in erase set from unlabeled_in_arcs
		for(int idx = 0; idx < erase_vec.size(); idx++)
			this->_unlabeled_in_arcs.erase(erase_vec[idx]);

		// add all elements in insert set to unlabeled_in_arcs
		for(int idx = 0; idx < insert_vec.size(); idx++)
			this->_unlabeled_in_arcs.insert(insert_vec[idx]);


		set<vcCompatibilityLabel*> insert_set;

		// OK, now you have multiple incoming unlabeled arcs..
		// try to reduce.
		map<vcCompatibilityLabel*, map<vcTransition*,int> > reduce_map;
		for(set<vcCompatibilityLabel*>::iterator iter = this->_unlabeled_in_arcs.begin();
				iter != this->_unlabeled_in_arcs.end();
				iter++)
		{
			vcCompatibilityLabel* u = (*iter);
			assert(u->_unlabeled_in_arcs.size() == 0);

			vcCompatibilityLabel* v = u->_labeled_in_arc.first;
			if(v != NULL)
			{

				vcTransition* t = u->_labeled_in_arc.second.first;

				if(reduce_map[v].find(t) == reduce_map[v].end())
					(reduce_map[v])[t] = 1;
				else
					((reduce_map[v])[t])++;

				if((reduce_map[v])[t] == t->Get_Number_Of_Successors())
				{
					insert_set.insert(v);
				}
			}
		}

		// based on the insert set, compute the reduce set.
		set<vcCompatibilityLabel*> erase_set;
		for(set<vcCompatibilityLabel*>::iterator iter = this->_unlabeled_in_arcs.begin();
				iter != this->_unlabeled_in_arcs.end();
				iter++)
		{
			vcCompatibilityLabel* u = (*iter);
			assert(u->_unlabeled_in_arcs.size() == 0);

			vcCompatibilityLabel* v = u->_labeled_in_arc.first;
			if(v != NULL)
			{
				if(insert_set.find(v) != insert_set.end())
				{
					erase_set.insert(u);
				}
			}
		}

		// now remove elements from the erase set and
		// add elements from the insert set
		for(set<vcCompatibilityLabel*>::iterator iter = erase_set.begin();
				iter != erase_set.end();
				iter++)
		{
			this->_unlabeled_in_arcs.erase((*iter));
			change_flag = true;
		}

		for(set<vcCompatibilityLabel*>::iterator iter = insert_set.begin();
				iter != insert_set.end();
				iter++)
		{
			this->_unlabeled_in_arcs.insert((*iter));
			change_flag = true;
		}

		// thats it.  you have done one pass of the  reduction.. one last step remains..
		// after the previous reduction, you may be left with a unique
		// unlabeled in arc... In this case, break out of the
		// loop..
		if(this->_unlabeled_in_arcs.size() == 1)
		{
			ret_label = *(this->_unlabeled_in_arcs.begin());
			break;
		}
	}

	// one final reduction needs to be done..
	// it is possible that the return label already
	// exists in the set of computed labels..
	//  if(ret_label->Is_Join())
	//    ret_label = cp->Find_Or_Map_Join_Label(ret_label->Get_Join_String(),ret_label);

	return(ret_label);
}

bool vcCompatibilityLabel::Is_Compatible(vcCompatibilityLabel* other)
{
	if(this == other)
		return true;
	else if(((vcControlPath*)(this->_parent))->Are_Compatible(this,other))
		return true;
	else
		return false;
}


bool operator==(vector<vcCompatibilityLabel*>& u, vector<vcCompatibilityLabel*>& v)
{
	bool ret_flag = true;
	for(int idx = 0; idx < u.size(); idx++)
	{
		for(int jdx = 0; idx < v.size(); jdx++)
		{
			if(!(u[idx]->Is_Compatible(v[idx])))
			{
				ret_flag = false;
				break;
			}
		}
	}
	return(ret_flag);
}

bool operator==(set<vcCompatibilityLabel*>& u, set<vcCompatibilityLabel*>& v)
{
	bool ret_flag = true;
	for(set<vcCompatibilityLabel*>::iterator uiter = u.begin();
			uiter != u.end();
			uiter++)
	{
		for(set<vcCompatibilityLabel*>::iterator viter = v.begin();
				viter != v.end();
				viter++)
		{
			if(!(*uiter)->Is_Compatible((*viter)))
			{
				ret_flag = false;
				break;
			}
		}
	}
	return(ret_flag);
}

void vcCompatibilityLabel::Print(ostream& ofile)
{
	ofile << "label " << this->Get_Id() << " : " << endl;
	if(this->_labeled_in_arc.first != NULL)
	{
		ofile << "\t labeled predecessor (" << this->_labeled_in_arc.first->Get_Id() << ", " 
			<< this->_labeled_in_arc.second.first->Get_Hierarchical_Id() << ", " 
			<< this->_labeled_in_arc.second.second << ")" << endl;
	}
	else if(this->_unlabeled_in_arcs.size() > 0)
	{
		ofile << "\t unlabeled predecessor(s) " << endl;
		for(set<vcCompatibilityLabel*>::iterator iter = this->_unlabeled_in_arcs.begin();
				iter != this->_unlabeled_in_arcs.end();
				iter++)
		{
			ofile << "\t\t" << (*iter)->Get_Id() << endl;
		}
		ofile << endl;
	}
	else
		ofile << endl;
}

vcCPElement::vcCPElement(vcCPElement* parent, string id):vcRoot(id)
{
	this->_index = vcControlPath::_free_index;
	vcControlPath::_free_index++;

	this->_compatibility_label = NULL;
	this->_parent = parent;

	_associated_cp_function = NULL;
	_associated_cp_region   = NULL;

	_is_bound_as_input_to_cp_function = false;
	_is_bound_as_output_from_cp_function = false;
	_is_bound_as_input_to_region = false;
	_is_bound_as_output_from_region = false;

	_has_null_successor = false;
	_has_null_predecessor = false;

	_is_left_open = false;
	_pipeline_parent = NULL;
}

vcModule* vcCPElement::Get_Root_Parent_Module()
{
	vcCPElement* root = this->Get_Parent();
	vcModule* ret_module = NULL;
	while ((root != NULL) && !root->Is_Control_Path())
	{
		root = root->Get_Parent();
	}
	if(root != NULL)
	{
		vcControlPath* cp = (vcControlPath*) root;
		ret_module = cp->Get_Parent_Module();
	}
	return(ret_module);
}

/*
   void  vcCPElement::Set_Pipeline_Parent()
   {
   if(this->_pipeline_parent != NULL)
   return;

   vcCPElement* p = this->Get_Parent();
   while(p != NULL)
   {
   if(p->Is("vcCPPipelinedLoopBody") || p->Is("vcCPPipelinedForkBlock") || p->Is("vcCPSimpleLoopBlock")
   || (p->Is("vcControlPath") && ((vcControlPath*)p)->Get_Is_Pipelined()) )
   {
   this->_pipeline_parent = (vcCPBlock*) p;
   break;
   }
   p = p->Get_Parent();
   }
   this->_pipeline_parent = p;
   }
 */

void vcCPElement::Set_Associated_CP_Function(vcCPElement* c)
{
	if(_associated_cp_function == NULL) 
		_associated_cp_function = c; 
	else if (_associated_cp_function != c)
	{
		vcSystem::Error("CP Element " + this->Get_Id() + " is associated with two CP functions..");
	}
}

void vcCPElement::Get_Explicit_Predecessors(vector<vcCPElement*>& epreds)
{
	epreds.clear();
	vcCPElement* my_assoc = this->Get_Associated_CP_Function();
	for(int idx = 0, fidx = _predecessors.size(); idx < fidx; idx++)
	{
		vcCPElement* other_assoc = _predecessors[idx]->Get_Associated_CP_Function();

		// implicit if both associated are not null and associated functions match.
		bool implicit_flag = false;
		if((my_assoc != NULL) && (other_assoc != NULL) && (my_assoc == other_assoc))
			implicit_flag =	true;

		if(!implicit_flag)
			epreds.push_back(_predecessors[idx]);
	}
	return;
}

void vcCPElement::Get_Explicit_Successors(vector<vcCPElement*>& esuccs)
{
	esuccs.clear();
	vcCPElement* my_assoc = this->Get_Associated_CP_Function();
	for(int idx = 0, fidx = _successors.size(); idx < fidx; idx++)
	{
		vcCPElement* other_assoc = _successors[idx]->Get_Associated_CP_Function();

		// implicit if both associated are not null and associated functions match.
		bool implicit_flag = false;
		if((my_assoc != NULL) && (other_assoc != NULL) && (my_assoc == other_assoc))
			implicit_flag = true;

		if(!implicit_flag)
			esuccs.push_back(_successors[idx]);

	}
	return;
}

string vcCPElement::Get_Exit_Symbol(vcControlPath* cp)
{
	string ret_string;
	if(cp == NULL)
		ret_string = (this->Get_Exit_Symbol());
	else
	{
		vcCPElement* eu = NULL;

		if(this->Is_Place() || this->Is_Transition())
			eu = this;
		else if(this->Is_Block())
			eu = this->Get_Exit_Element();

		vcCPElementGroup* grp = cp->Get_Group(eu);
		if(grp == NULL)
		{
			vcSystem::Error("group of CP element " + this->Get_Id() + " not found.");
			ret_string = (eu->Get_Exit_Symbol());
		}
		else
			ret_string = (grp->Get_VHDL_Id());
	}

	return(ret_string);
}
void vcCPElement::Add_Successor(vcCPElement* cpe) 
{
	// scan the list and add only if the
	// successor is not already present.
	bool add_flag = true;
	for(int idx = 0, fidx = _successors.size(); idx < fidx; idx++)
	{
		if(cpe == this->_successors[idx])
		{
			add_flag = false;
			break;
		}
	}

	if(add_flag)
		this->_successors.push_back(cpe);
}

void vcCPElement::Remove_Successor(vcCPElement* cpe) 
{
	bool rem_flag = false;
	for(vector<vcCPElement*>::iterator iter = _successors.begin(), fiter = _successors.end();
			iter != fiter; iter++)
	{
		if(cpe == *iter)
		{
			rem_flag = true;
			this->_successors.erase(iter);
			break;
		}
	}

}

void vcCPElement::Add_Predecessor(vcCPElement* cpe) 
{ 
	bool add_flag = true;
	for(int idx = 0, fidx = _predecessors.size(); idx < fidx; idx++)
	{
		if(cpe == this->_predecessors[idx])
		{
			add_flag = false;
			break;
		}
	}
	if(add_flag);
	this->_predecessors.push_back(cpe);
}

void vcCPElement::Remove_Predecessor(vcCPElement* cpe) 
{
	bool rem_flag = false;
	for(vector<vcCPElement*>::iterator iter = _predecessors.begin(), fiter = _predecessors.end();
			iter != fiter; iter++)
	{
		if(cpe == *iter)
		{
			rem_flag = true;
			this->_predecessors.erase(iter);
			break;
		}
	}
}

void vcCPElement::Add_Marked_Successor(vcCPElement* cpe) 
{
	// scan the list and add only if the
	// successor is not already present.
	bool add_flag = true;
	for(int idx = 0, fidx = _marked_successors.size(); idx < fidx; idx++)
	{
		if(cpe == this->_marked_successors[idx])
		{
			add_flag = false;
			break;
		}
	}

	if(add_flag)
		this->_marked_successors.push_back(cpe);
}

void vcCPElement::Remove_Marked_Successor(vcCPElement* cpe) 
{
	bool rem_flag = false;
	for(vector<vcCPElement*>::iterator iter = _marked_successors.begin(), fiter = _marked_successors.end();
			iter != fiter; iter++)
	{
		if(cpe == *iter)
		{
			rem_flag = true;
			this->_marked_successors.erase(iter);
			this->_marked_successor_delays.erase(cpe);
			break;
		}
	}

}

void vcCPElement::Add_Marked_Predecessor(vcCPElement* cpe) 
{ 
	bool add_flag = true;
	for(int idx = 0, fidx = _marked_predecessors.size(); idx < fidx; idx++)
	{
		if(cpe == this->_marked_predecessors[idx])
		{
			add_flag = false;
			break;
		}
	}
	if(add_flag);
	this->_marked_predecessors.push_back(cpe);
}

void vcCPElement::Remove_Marked_Predecessor(vcCPElement* cpe) 
{
	bool rem_flag = false;
	for(vector<vcCPElement*>::iterator iter = _marked_predecessors.begin(), fiter = _marked_predecessors.end();
			iter != fiter; iter++)
	{
		if(cpe == *iter)
		{
			rem_flag = true;
			this->_marked_predecessors.erase(iter);
			this->_marked_predecessor_delays.erase(cpe);
			break;
		}
	}
}

void vcCPElement::Set_Marked_Successor_Delay(vcCPElement* cpe, int m)
{
	_marked_successor_delays[cpe] = m;
}
int  vcCPElement::Get_Marked_Successor_Delay(vcCPElement* cpe)
{
	if(_marked_successor_delays.find(cpe) != _marked_successor_delays.end())
		return(_marked_successor_delays[cpe]);
	else
		return(1);
}

void vcCPElement::Set_Marked_Predecessor_Delay(vcCPElement* cpe, int m)
{
	_marked_predecessor_delays[cpe] = m;
}
int  vcCPElement::Get_Marked_Predecessor_Delay(vcCPElement* cpe)
{
	if(_marked_predecessor_delays.find(cpe) != _marked_predecessor_delays.end())
		return(_marked_predecessor_delays[cpe]);
	else
		// default value is 1
		return(1);
}

void vcCPElement::Get_Hierarchical_Ref(vector<string>& ref_vec)
{
	if(this->_parent != NULL)
		this->_parent->Get_Hierarchical_Ref(ref_vec);
	ref_vec.push_back(this->Get_Id());
}
string vcCPElement::Get_Hierarchical_Id()
{
	string ret_string;
	vector<string> ref_vec;
	this->Get_Hierarchical_Ref(ref_vec);
	for(int idx = 0; idx < ref_vec.size(); idx++)
	{
		ret_string += ref_vec[idx];
		if((idx+1) < ref_vec.size())
			ret_string += vcLexerKeywords[__SLASH];
	}
	return(ret_string);
}

void vcCPElement::Print_Successors(ostream& ofile)
{
	ofile << this->Get_Hierarchical_Id() << endl
		<< "\t (label =  " << this->Get_Compatibility_Label()->Get_Id() 
		<< ")" << endl << "\t -> { " << endl;

	for(int idx =0; idx < this->_successors.size(); idx++)
	{
		ofile << "\t\t" << this->_successors[idx]->Get_Hierarchical_Id() << endl;
	}
	ofile << "}" << endl;
}

void vcCPElement::Print_Marked_Successors(ostream& ofile)
{
	ofile << this->Get_Hierarchical_Id() << endl
		<< "\t (label =  " << this->Get_Compatibility_Label()->Get_Id() 
		<< ")" << endl << "\t -> { " << endl;

	for(int idx =0; idx < this->_marked_successors.size(); idx++)
	{
		ofile << "\t\t" << this->_marked_successors[idx]->Get_Hierarchical_Id() << endl;
	}
	ofile << "}" << endl;
}

vcTransition::vcTransition(vcCPElement* parent, string id):vcCPElement(parent, id)
{
	_is_input = false;
	_is_output = false;
	_is_dead = false;
	_is_tied_high = false;
	_is_left_open = false;
	_is_entry_transition = false;
	_is_linked_to_non_local_dpe = false;
	_is_delay_element = false;
}

void vcTransition::Add_DP_Link(vcDatapathElement* dpe,vcTransitionType ltype)
{
	if(dpe == NULL)
		return;

	if(ltype == _IN_TRANSITION)
		_is_input = true;
	else if(ltype == _OUT_TRANSITION)
		_is_output = true;
	else
		assert(0);

	if(!dpe->Is_Local_To_Datapath())
	{
		_is_linked_to_non_local_dpe = true;
	}

	this->_dp_link.push_back(pair<vcDatapathElement*,vcTransitionType>(dpe,ltype));
}




void vcTransition::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__TRANSITION] << " " << this->Get_Label() << " "  <<
			(this->Get_Is_Delay_Element() ? "" : vcLexerKeywords[__DELAY])  << endl;
}

#define MAX(x,y) (x > y ? x : y)

//
// slightly complicated but not too bad.
// you will need to instantiate places if the transition is a join..
//
//  TBD:  increase the capacity of places and introduce trivial joins?
//
void vcTransition::Print_VHDL(ostream& ofile)
{
	bool block_was_used = false;
	string marked_join_marking;

	if(this->Get_Is_Dead())
	{
		// it will never ever fire... tie it to false.
		ofile << "-- Dead. tied low." << endl;
		ofile << this->Get_Exit_Symbol() << " <= false;" << endl;
		return;
	}
	if(this->Get_Is_Tied_High())
	{
		// it will never ever fire... tied to true.
		ofile << "-- Tied high." << endl;
		ofile << this->Get_Exit_Symbol() << " <= true;" << endl;

		// TODO.. if it is an output transition, it needs to be 
		// marked.

		return;
	}
	if(this->Get_Is_Left_Open())
	{
		// it is only driven, not used.
		ofile << "-- left open:  " << this->Get_Exit_Symbol()  << endl;
		return;
	}
	if(this->Get_Is_Delay_Element())
	{
		assert(this->Get_Number_Of_Predecessors() == 1);
		assert(this->Get_Number_Of_Marked_Predecessors() == 0);

		ofile << "-- Delay element." << endl;
		vcCPElement* pred = this->Get_Predecessor(0);
		ofile << this->Get_Exit_Symbol() << "_delay: control_delay_element "
			<< " generic map(name => \" " << this->Get_Exit_Symbol() << "_delay\", delay_value => 1) " 
			<< " port map(req => " << pred->Get_Exit_Symbol() 
			<< ", ack => " << this->Get_Exit_Symbol()
			<< ", clk => clk, reset =>reset);" << endl;
		return;
	}


	// explicit predecessors.. (other than "implicit" ones).
	vector<vcCPElement*> explicit_preds;
	this->Get_Explicit_Predecessors(explicit_preds);

	// if the transition is mapped as an output of a CP function,
	// then there should be no explicit preds.
	if(this->Get_Is_Bound_As_Output_From_CP_Function())
	{
		assert(explicit_preds.size() == 0);
		return;
	}

	// if the transition is bound as an input to its region,
	// then dont print anything.
	if(this->Get_Is_Bound_As_Input_To_Region())
	{
		ofile << "-- transition " << this->Get_Exit_Symbol() << " is mapped as an input to its region." << endl;
		return;
	}

	// every transition has at least one predecessor (entry of control-path has no
	// explicit predecessor, but does have an implicit one.
	//  
	//  TBD: even if there is only one predecessor, if the parent
	//  is a pipelined loop body, then we treat the transition as a
	//  join... Why?  No need unless there is a marked predecessor.
	//
	vcCPBlock* pp = this->Get_Pipeline_Parent();
	int max_iterations_in_flight = 1;
	if(pp != NULL)
	{
		max_iterations_in_flight = pp->Get_Max_Iterations_In_Flight();
	}


	// 
	bool has_null_predecessor = this->Get_Has_Null_Predecessor();

	// It is a true join if
	//   it has more than one explicit predecessor.
	//   OR
	//   the parent is pipelined and it either has more
	//   than one explicit predecessor or it has at least
	//   one explicit predecessor and at least one marked
	//   predecessor.
	bool is_true_join = ((pp != NULL)  ? 
			((explicit_preds.size() > 1) || 
			 ((has_null_predecessor || (explicit_preds.size() > 0)) && (_marked_predecessors.size() > 0))) :
			(explicit_preds.size() > 1));

	if(this->Get_Is_Input())
	{
		// input transition? it is supposed to be enabled.. just fire it.
		ofile << "-- input transition " << endl;
		this->Print_DP_To_CP_VHDL_Link(ofile);
	}
	else if(is_true_join)
	{
		if(explicit_preds.size() > 0)
		{
			bool marked_join_flag = false;
			block_was_used = true;

			ofile << this->Get_VHDL_Id() << "_block : Block -- non-trivial join transition " << this->Get_Hierarchical_Id() << " {" <<  endl;

			ofile << "signal " <<  this->Get_VHDL_Id() << "_predecessors: BooleanArray(" 
				<< explicit_preds.size()-1 << " downto 0);" << endl;
			if(this->Get_Number_Of_Marked_Predecessors() > 0)
			{
				marked_join_flag = true;
				ofile << "signal " <<  this->Get_VHDL_Id() << "_marked_predecessors: BooleanArray(" 
					<< this->Get_Number_Of_Marked_Predecessors()-1 << " downto 0);" << endl;

				string marking_string = this->Generate_Marked_Join_Bypass_String();
				ofile << marking_string << endl;
			}
			ofile << "-- }" << endl << "begin -- {" << endl;

			for(int idx = 0; idx < explicit_preds.size(); idx++)
			{
				vcCPElement* pred = explicit_preds[idx];
				ofile << this->Get_VHDL_Id() << "_predecessors(" << idx << ") <= "
					<< pred->Get_Exit_Symbol() << ";" << endl;
			}

			if(marked_join_flag)
			{
				for(int idx = 0; idx < this->Get_Number_Of_Marked_Predecessors(); idx++)
				{
					vcCPElement* pred = this->Get_Marked_Predecessors()[idx];
					ofile << this->Get_VHDL_Id() << "_marked_predecessors(" << idx << ") <= "
						<< pred->Get_Exit_Symbol() << ";" << endl;
				}
			}

			string comp_id = "join";
			if(marked_join_flag)
				comp_id = "marked_join";
			ofile << this->Get_VHDL_Id() << "_join:" << comp_id << " -- {" << endl
				<< "generic map(place_capacity => " << max_iterations_in_flight << "," << endl;
			if(marked_join_flag)	
				ofile << "marked_predecessor_bypass => markedPredBypass," << endl;
			ofile	<< "name => \" " << this->Get_VHDL_Id() << "_join\")" << endl
				<< "port map( -- {"
				<< "preds => " << this->Get_VHDL_Id() <<  "_predecessors," << endl;
			if(marked_join_flag)
				ofile << "marked_preds => " << this->Get_VHDL_Id() <<  "_marked_predecessors," << endl;
			ofile << "symbol_out => " << this->Get_Exit_Symbol() << "," << endl
				<< "clk => clk," << endl
				<< "reset => reset); -- }}" << endl;
		}
		else
		{
			assert(this->Get_Number_Of_Marked_Predecessors() > 0);

			string join_name = this->Get_VHDL_Id() + "_join";
			vector<string> preds; 
			vector<int> pred_markings;
			vector<int> pred_capacities;
			vector<int> pred_delays;
			string joined_symbol = this->Get_Exit_Symbol();

			for(int idx = 0; idx < this->Get_Number_Of_Marked_Predecessors(); idx++)
			{
				vcCPElement* pred = this->Get_Marked_Predecessors()[idx];
				preds.push_back(pred->Get_Exit_Symbol());
				pred_markings.push_back(1);
				pred_capacities.push_back(1);
				pred_delays.push_back(this->Get_Marked_Predecessor_Delay(pred));
			}

			Print_VHDL_Join(join_name,
					preds,
					pred_markings,
					pred_capacities,
					pred_delays,
					joined_symbol,
					ofile);
		}
	}
	else if(explicit_preds.size() == 1)
		// at least one real predecessor..
	{
		vcCPElement* pred = this->Get_Predecessors()[0];
		ofile <<  this->Get_Exit_Symbol() << " <= " << pred->Get_Exit_Symbol() << "; -- transition " << this->Get_Hierarchical_Id() << endl;
	}
	else
		// no explicit preds.. but may have implicit preds..
	{
		if(this->Get_Is_Entry_Transition())
		{
			ofile <<  this->Get_Exit_Symbol() << "  <= " << this->Get_Parent()->Get_Start_Symbol() << "; -- transition " << this->Get_Hierarchical_Id() << endl;
		}
		else 
		{
			int pred_count = this->Get_Number_Of_Predecessors();
			if(pred_count == 0)
			{
				vcSystem::Warning("transition " + this->Get_Hierarchical_Id() + " has no predecessor: tied to false");
				ofile << "-- transition " << this->Get_Hierarchical_Id() << " has no predecessor: tied to false." << endl;
				ofile << this->Get_Exit_Symbol() << " <= false;" << endl;	  
			}
		}
	}

	if(this->Get_Is_Output())
	{
		ofile << "-- output transition " << endl;
		this->Print_CP_To_DP_VHDL_Link(ofile);
	}

	if(block_was_used) // block was used...
		ofile << "-- }" << endl << "end Block; -- non-trivial join transition " << this->Get_Hierarchical_Id() << endl;

}

string vcTransition::Generate_Marked_Join_Bypass_String()
{
	string ret_string ;
	int N = this->Get_Number_Of_Marked_Predecessors();
	if(N > 0)
	{
		ret_string = "constant markedPredBypass: BooleanArray(" + IntToStr(N-1) + " downto 0) := (";
		for(int i = 0; i < N; i++)
		{
			if(i > 0)
				ret_string += ", ";
			vcCPElement* cpe = this->Get_Marked_Predecessor(i);
			ret_string += IntToStr(i) + " => " + ((this->Get_Marked_Predecessor_Delay(cpe) > 0) ? "false" : "true");
		}
		ret_string += ");";
	}
	return(ret_string);
}

string vcTransition::Get_CP_To_DP_Symbol()
{
	string ret_string;
	for(int idx = 0; idx < _dp_link.size(); idx++)
	{
		int req_idx = _dp_link[idx].first->Get_Req_Index(this);
		if(req_idx >= 0)
		{
			if(ret_string != "")
				ret_string += "_";

			ret_string += _dp_link[idx].first->Get_Id() + "_" + "req_" + IntToStr(req_idx);
		}
	}
	return(To_VHDL(ret_string));
}
string vcTransition::Get_DP_To_CP_Symbol()
{
	string ret_string;
	for(int idx = 0; idx < _dp_link.size(); idx++)
	{
		int ack_idx = _dp_link[idx].first->Get_Ack_Index(this);
		if(ack_idx >= 0)
		{
			if(ret_string != "")
				ret_string += "_";

			ret_string += _dp_link[idx].first->Get_Id() + "_" + "ack_" + IntToStr(ack_idx);
		}
	}
	return(To_VHDL(ret_string));
}

void vcTransition::Print_DP_To_CP_VHDL_Link(ostream& ofile)
{

	string delay_str = "0";
	ofile << this->Get_Exit_Symbol() << "_link_from_dp: control_delay_element -- { "  << endl
		<< "generic map (name => \" " << this->Get_Exit_Symbol() << "_delay\", delay_value => " << delay_str << ")" << endl
		<< "port map(clk => clk, reset => reset, req => " << this->Get_DP_To_CP_Symbol()
		<< ", ack => " << this->Get_Exit_Symbol() << "); -- } " << endl;
}

void vcTransition::Print_CP_To_DP_VHDL_Link(ostream& ofile)
{

	//string delay_str = (vcSystem::_min_clock_period_flag ? "1" : "0");
	// if this is a transition which connects to a "remote" operator
	// (for example, a call/load/store/io-port, then, if the min_clock_period_flag is
	// set, insert a cycle delay in the request.
	string delay_str;
	// if(vcSystem::_min_clock_period_flag)
	//delay_str = "1";
	//else
	//delay_str = "0";

	delay_str = "0";

	ofile << this->Get_Exit_Symbol() << "_link_to_dp: control_delay_element -- { "  << endl
		<< "generic map (name => \" " << this->Get_Exit_Symbol() << "_delay\", delay_value => " << delay_str << ")" << endl
		<< "port map(clk => clk, reset => reset, ack => " << this->Get_CP_To_DP_Symbol()
		<< ", req => " << this->Get_Exit_Symbol() << "); -- } " << endl;
}

vcPlace::vcPlace(vcCPElement* parent, string id, unsigned int init_marking):vcCPElement(parent, id)
{
	this->_initial_marking = init_marking;
	this->_is_bound_as_input_to_region = false;
	this->_is_bound_as_output_from_region = false;
}

void vcPlace::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__PLACE] << " " << this->Get_Label() << endl;
}

void vcPlace::Print_VHDL(ostream& ofile)
{

	if(this->_is_bound_as_output_from_region)
	{
		ofile << "-- place " << this->Get_Exit_Symbol() <<  " is bound as output from region, link printed in region to which it is bound. " << endl;
		return;
	}

	if(this->_is_bound_as_output_from_cp_function)
	{
		ofile << "-- place " << this->Get_Exit_Symbol() <<  " is bound as output from cp function, link printed as part of function instance. " << endl;
		return;
	}

	// 
	// the place is simply optimized away to a direct connection..
	//
	if(this->Get_Number_Of_Predecessors() > 0)
	{
		ofile << " -- place " << this->Get_Hierarchical_Id() << " " << endl;
		ofile << this->Get_Exit_Symbol() <<  "  <=  ";
		for(int idx = 0; idx < this->Get_Number_Of_Predecessors(); idx++)
		{
			if(idx > 0)
				ofile << " or ";

			ofile <<  this->Get_Predecessors()[idx]->Get_Exit_Symbol();
		}
		ofile << ";" << endl;
		return;
	}
	else
	{
		if(!this->Get_Is_Left_Open())
		{
			vcSystem::Warning("place " + this->Get_Hierarchical_Id() + " has no predecessors... tied to false");
			ofile << " -- place " << this->Get_Hierarchical_Id() << " has no predecessors, will tie it false. " << endl;
			ofile << this->Get_Exit_Symbol() <<  "  <=  ";
			ofile << " false; " << endl;
		}
		else
			ofile << " -- place " << this->Get_Hierarchical_Id() << " is left open? " << endl;

		return;
	}
}

vcCPBlock::vcCPBlock(vcCPBlock* parent, string id): vcCPElement((vcCPElement*)parent, id)
{
	_entry = new vcTransition(this,vcLexerKeywords[__ENTRY]);
	this->_entry->Set_Is_Entry_Transition(true);
	_exit = new vcTransition(this,vcLexerKeywords[__EXIT]);
}

void vcCPBlock::Add_CPElement(vcCPElement* cpe)
{
	if(cpe != NULL)
	{
		assert(this->_element_map.find(cpe->Get_Id()) == this->_element_map.end());

		this->_element_map[cpe->Get_Id()] = cpe;
		this->_elements.push_back(cpe);
	}
}

vcCPElement* vcCPBlock::Find_CPElement(string cname)
{
	vcCPElement* ret_cpe = NULL;
	string aname = this->Get_Alias_Reference_String(cname); 

	if(aname == vcLexerKeywords[__ENTRY])
		ret_cpe = (vcCPElement*) this->_entry;
	else if(aname == vcLexerKeywords[__EXIT])
		ret_cpe = (vcCPElement*) this->_exit;
	else if(this->_element_map.find(aname) != this->_element_map.end())
		ret_cpe = ((*(this->_element_map.find(aname))).second);
	return(ret_cpe);
}


string vcCPBlock::Get_Predecessor_Exit_Symbol()
{
	vcCPElement* pred = this->Get_Predecessors()[0];
	if(this->Get_Parent() && (pred == this->Get_Parent()->Get_Entry_Element()))
	{
		return(this->Get_Parent()->Get_Entry_Element()->Get_Exit_Symbol());
	}
	else
		return(pred->Get_Exit_Symbol());
}

string vcCPBlock::Get_Successor_Start_Symbol()
{
	vcCPElement* succ = this->Get_Successors()[0];
	if(this->Get_Parent() && (succ == this->Get_Parent()->Get_Exit_Element()))
	{
		return(this->Get_Parent()->Get_Exit_Element()->Get_Exit_Symbol());
	}
	else
		return(succ->Get_Start_Symbol());
}

void vcCPBlock::Print_VHDL_Start_Interlock(ostream& ofile)
{
	assert(0);
}

void vcCPBlock::Print_VHDL_Start_Symbol_Assignment(ostream& ofile)
{
	assert(this->Get_Predecessors().size() == 1);
	ofile << this->Get_Start_Symbol() << " <= "  << this->Get_Predecessors()[0]->Get_Exit_Symbol() 
		<< "; -- control passed to block" << endl;
}

void vcCPBlock::Print_VHDL_Exit_Symbol_Assignment(ostream& ofile)
{
	ofile << this->Get_Exit_Symbol() << " <= " << this->_exit->Get_Exit_Symbol() << "; -- control passed from block " << endl;
}

void vcCPBlock::Print_VHDL_Signal_Declarations(ostream& ofile)
{
	ofile << "signal " << this->_entry->Get_Exit_Symbol() << ": Boolean;" << endl;
	ofile << "signal " << this->_exit->Get_Exit_Symbol() << ": Boolean;" << endl;
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		if(_elements[idx]->Is_Block())
			ofile << "signal " << _elements[idx]->Get_Start_Symbol() << " : Boolean;" << endl;
		ofile << "signal " << _elements[idx]->Get_Exit_Symbol() << " : Boolean;" << endl;
	}
}

void vcCPBlock::Print_VHDL(ostream& ofile)
{

	// Hack alert!
	string id = (this->Get_Hierarchical_Id() == "" ? "control-path" : this->Get_Hierarchical_Id());

	// declare all exit flags.
	ofile << this->Get_VHDL_Id() << ": Block -- " << id << " {" << endl;
	this->Print_VHDL_Signal_Declarations(ofile);

	ofile << "-- }" << endl << "begin -- {" << endl;
	this->Print_VHDL_Start_Symbol_Assignment(ofile);

	this->_entry->Print_VHDL(ofile);
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		this->_elements[idx]->Print_VHDL(ofile);
	}
	this->_exit->Print_VHDL(ofile);
	this->Print_VHDL_Exit_Symbol_Assignment(ofile);

	vcCPElement* prnt = this->Get_Parent();

	this->Print_VHDL_Export_Cleanup(ofile);
	ofile << "-- }" << endl << "end Block; -- " << id << endl;
}

void vcCPBlock::Print_VHDL_Export_Cleanup(ostream& ofile)
{
	// TODO.. this will be non-empty only for
	// control-paths.. place holder for ugly fixups.
}

void vcCPBlock::Print_Elements(ostream& ofile)
{
	for(int idx = 0; idx < this->_elements.size(); idx++)
		this->_elements[idx]->Print(ofile);
}

bool vcCPBlock::Check_Structure() 
{ 
	bool ret_flag = true;
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		ret_flag = (ret_flag && this->_elements[idx]->Check_Structure());
		if(!ret_flag)
			break;
	}
	return(ret_flag);
}


void vcCPBlock::Print_Structure(ostream& ofile)
{
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		this->_elements[idx]->Print_Structure(ofile);
	}

}


void vcCPBlock::BFS_Order(bool reverse_flag, vcCPElement* start_element, int& num_visited, 
		vector<vcCPElement*>& bfs_ordered_elements,
		set<vcCPElement*>& visited_set)
{
	deque<vcCPElement*> bfs_queue;
	set<vcCPElement*> on_queue_set;
	bfs_queue.push_back(start_element);
	on_queue_set.insert(start_element);
	num_visited = 0;

	while(!bfs_queue.empty())
	{
		vcCPElement* top = (bfs_queue.front());

		bfs_queue.pop_front();
		on_queue_set.erase(top);

		visited_set.insert(top);
		bfs_ordered_elements.push_back(top);

		num_visited++;

		vector<vcCPElement*>& adj = (reverse_flag ? top->Get_Predecessors() : top->Get_Successors());
		for(int idx = 0; idx < adj.size(); idx++)
		{
			vcCPElement* w = adj[idx];

			// skip if the adjacency is outside the block.	
			if(w->Get_Parent() != top->Get_Parent())
				continue;

			if((on_queue_set.find(w) == on_queue_set.end()) && (visited_set.find(w) == visited_set.end()))
			{// push into queue if not already present in the queue and if not already popped from front..
				bfs_queue.push_back(w);
				on_queue_set.insert(w);
			}
		}
	}
}


void vcCPBlock::DFS_Order(bool reverse_flag, vcCPElement* start_element, bool& cycle_flag, int& num_visited, 
		vector<vcCPElement*>& dfs_ordered_elements,
		set<vcCPElement*>& visited_set)
{
	set<vcCPElement*> on_queue_set;
	deque<vcCPElement*> dfs_queue;

	dfs_queue.push_front(start_element);
	on_queue_set.insert(start_element);

	num_visited = 1;
	visited_set.insert(start_element);
	dfs_ordered_elements.push_back(start_element);

	while(!dfs_queue.empty())
	{
		vcCPElement* top = dfs_queue.front();
		vector<vcCPElement*>& adj = (reverse_flag ? top->Get_Predecessors() : top->Get_Successors());
		bool all_neighbours_visited = true;
		for(int idx = 0; idx < adj.size(); idx++)
		{
			vcCPElement* w = adj[idx];

			// skip if the adjacency is outside the block.	
			if(w->Get_Parent() != top->Get_Parent())
				continue;

			if(on_queue_set.find(w) != on_queue_set.end())
			{
				cycle_flag = true;
				vcSystem::Info("cycle present in fork-block.\n");
				cerr << "Cycle found in block.\n"; 
				for(deque<vcCPElement*>::iterator iter = dfs_queue.begin(), fiter = dfs_queue.end();
						iter != fiter; iter++)
				{
					cerr << "\t" << (*iter)->Get_Id() << endl;
				}
				cerr << "end-Cycle.\n"; 
				this->DFS_Backward_Edge_Action(reverse_flag, dfs_queue, on_queue_set, top, w);
			}
			else if(visited_set.find(w) == visited_set.end())
			{
				num_visited++;
				this->DFS_Forward_Edge_Action(reverse_flag, dfs_queue, on_queue_set, top, w);

				dfs_ordered_elements.push_back(w);
				visited_set.insert(w);
				dfs_queue.push_front(w);
				on_queue_set.insert(w);
				all_neighbours_visited = false;

				break;
			}
		}

		if(all_neighbours_visited)
		{
			dfs_queue.pop_front();
			on_queue_set.erase(top);
		}
	}
}

void vcCPBlock::Print_Missing_Elements(set<vcCPElement*>& visited_set)
{
	cerr <<"\t un-visited elements" << endl;
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		if(visited_set.find(_elements[idx]) == visited_set.end())
			cerr << "\t" << _elements[idx]->Get_Id() << endl;
	}
	if(visited_set.find(_entry) == visited_set.end())
		cerr << "\t" << _entry->Get_Id() << endl;
	if(visited_set.find(_exit) == visited_set.end())
		cerr << "\t" << _exit->Get_Id() << endl;

}

void vcCPBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* cp) {assert(0);}
void vcCPBlock::Update_Predecessor_Successor_Links() 
{
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		this->_elements[idx]->Update_Predecessor_Successor_Links();
	}
}

void vcCPBlock::Update_Binding_Predecessor_Successor_Links()
{
	// for the bindings.
	for(map<vcPlace*,vcTransition*>::iterator biter = _output_bindings.begin();
			biter != _output_bindings.end();
			biter++)
	{
		vcPlace* pl = (*biter).first;
		vcTransition* tr = (*biter).second;

		tr->Add_Successor(pl);
		pl->Add_Predecessor(tr);
	}

	for(map<vcPlace*,vcTransition*>::iterator biter = _input_bindings.begin();
			biter != _input_bindings.end();
			biter++)
	{
		vcPlace* pl = (*biter).first;
		vcTransition* tr = (*biter).second;

		tr->Add_Predecessor(pl);
		pl->Add_Successor(tr);
	}
}

void vcCPBlock::Bind(string place_name, string region_name, string transition_name, bool input_binding)
{
	vcCPElement* pl = this->Find_CPElement(place_name);
	if(!((pl != NULL) && (pl->Is_Place())))
	{
		vcSystem::Error("did not find place " + place_name + " in simple loop " + this->Get_Id());
		return;
	}

	vcCPElement* body = this->Find_CPElement(region_name);
	if(!((body != NULL) && (body->Is("vcCPPipelinedLoopBody") || body->Is("vcCPPipelinedForkBlock"))))
	{
		vcSystem::Error("did not find loop body " + region_name + " in " + this->Get_Id());
		return;
	}


	vcCPElement* tr = body->Find_CPElement(transition_name);
	if(!((tr != NULL) && (tr->Is_Transition())))
	{
		vcSystem::Error("did not find transition " + transition_name + " in loop body " + region_name);
		return;
	}

	if(input_binding)
	{
		_input_bindings[((vcPlace*)pl)] = ((vcTransition*)tr);
		((vcTransition*)tr)->Set_Is_Bound_As_Input_To_Region(true);
		((vcPlace*)pl)->Set_Is_Bound_As_Input_To_Region(true);
	}
	else
	{
		_output_bindings[((vcPlace*)pl)] = ((vcTransition*)tr);
		((vcTransition*)tr)->Set_Is_Bound_As_Output_From_Region(true);
		((vcPlace*)pl)->Set_Is_Bound_As_Output_From_Region(true);
	}
}

void vcCPBlock::Print_VHDL_Bindings(vcControlPath* cp, ostream& ofile)
{
	// input bindings.
	ofile << "-- Input Bindings " << endl;
	for(map<vcPlace*,vcTransition*>::iterator biter = _input_bindings.begin(), fbiter = _input_bindings.end();
			biter != fbiter;
			biter++)
	{
		vcPlace* pl = (*biter).first;
		vcTransition* tr = (*biter).second;

		string pl_id = pl->Get_Exit_Symbol(cp);
		string tr_id = tr->Get_Exit_Symbol(cp);

		ofile << tr_id << " <= " << pl_id  << ";" << endl;
	}

	ofile << "-- Output Bindings " << endl;
	for(map<vcPlace*,vcTransition*>::iterator biter = _output_bindings.begin(), fbiter = _output_bindings.end();
			biter != fbiter;
			biter++)
	{
		vcPlace* pl = (*biter).first;
		vcTransition* tr = (*biter).second;

		string pl_id = pl->Get_Exit_Symbol(cp);
		string tr_id = tr->Get_Exit_Symbol(cp);

		ofile << pl_id << " <= " << tr_id  << ";" << endl;
	}

}

void vcCPBlock::Add_Scc_Arc (string tail_lbl, string head_lbl)
{
	vcCPElement* tail_cpe = this->Find_CPElement(tail_lbl);
	if((tail_cpe != NULL) && (tail_cpe->Is_Transition()))
	{
		vcCPElement* head_cpe = this->Find_CPElement(head_lbl);
		if((head_cpe != NULL) && (head_cpe->Is_Transition()))
		{
			vcSystem::_scc_arcs.
				push_back(pair<vcTransition*, vcTransition*> 
					((vcTransition*)tail_cpe,
						(vcTransition*) head_cpe));
		}
		else
		{
			vcSystem::Error("did not find tail transition " + tail_lbl + " in Add_Scc_Arc in block " +
						this->Get_Label());
		}
	}
	else
	{
		vcSystem::Error("did not find head transition " + head_lbl + " in Add_Scc_Arc in block " +
						this->Get_Label());
	}
	
}
vcCPSeriesBlock::vcCPSeriesBlock(vcCPBlock* p, string id):vcCPBlock(p, id)
{
}


void vcCPSeriesBlock::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__SERIESBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
	this->Print_Elements(ofile);
	ofile << "\n// end series-block " << this->Get_Id() << endl << "}" << endl;
}


void vcCPSeriesBlock::Print_Structure(ostream& ofile)
{
	string id = this->Get_Hierarchical_Id();
	if(id == "")
		id = this->Get_Id();
	ofile << this->Kind() << " " << id
		<< " (label = " << this->Get_Compatibility_Label()->Get_Id() 
		<< ") {" << endl;
	this->_entry->Print_Successors(ofile);
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		this->_elements[idx]->Print_Successors(ofile);
	}
	this->_exit->Print_Successors(ofile); 
	ofile << "}" << endl;

	this->vcCPBlock::Print_Structure(ofile);
}


void vcCPSeriesBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* cp)
{
	this->Set_Compatibility_Label(in_label);

	this->_entry->Set_Compatibility_Label(in_label);
	for(int idx = 0; idx < this->_elements.size(); idx++)
		this->_elements[idx]->Compute_Compatibility_Labels(in_label,cp);
	this->_exit->Set_Compatibility_Label(in_label);
}

void vcCPSeriesBlock::Update_Predecessor_Successor_Links()
{

	if(this->_elements.size() > 0)
	{
		this->_entry->Add_Successor(this->_elements.front());
		this->_elements.front()->Add_Predecessor(this->_entry);
		for(int idx = 0; idx < this->_elements.size(); idx++)
		{
			if(idx > 0)
			{
				this->_elements[idx]->Add_Predecessor(this->_elements[idx-1]);
			}
			if(idx+1 < this->_elements.size())
			{
				this->_elements[idx]->Add_Successor(this->_elements[idx+1]);
			}
		}
		this->_elements.back()->Add_Successor(this->_exit);
		this->_exit->Add_Predecessor(this->_elements.back());
	}
	else
	{
		this->_entry->Add_Successor(this->_exit);
		this->_exit->Add_Predecessor(this->_entry);
	}

	this->vcCPBlock::Update_Predecessor_Successor_Links();
}

vcCPParallelBlock::vcCPParallelBlock(vcCPBlock* p, string id):vcCPBlock(p, id)
{

}


void vcCPParallelBlock::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__PARALLELBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
	this->Print_Elements(ofile);
	ofile << "\n// end  parallel-block " << this->Get_Id() << endl << "}" << endl;
}


void vcCPParallelBlock::Print_Structure(ostream& ofile)
{
	string id = (this->Get_Hierarchical_Id());
	if(id == "")
		id = this->Get_Id();

	ofile << this->Kind() << " "  << id << " (label = " << this->Get_Compatibility_Label()->Get_Id() 
		<< ") {" << endl;
	this->_entry->Print_Successors(ofile);
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		this->_elements[idx]->Print_Successors(ofile);
	}
	this->_exit->Print_Successors(ofile);
	ofile << "}" << endl;

	this->vcCPBlock::Print_Structure(ofile);
}


void vcCPParallelBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* cp)
{
	this->Set_Compatibility_Label(in_label);
	this->_entry->Set_Compatibility_Label(in_label);

	if(this->_elements.size() > 1)
	{
		for(int idx = 0; idx < this->_elements.size(); idx++)
		{
			string hid = this->Get_Hierarchical_Id();
			if(hid == "")
				hid = this->Get_Id();

			string id = cp->Get_Id() + "/" +  hid + "[" + IntToStr(idx) + "]";
			vcCompatibilityLabel* nl = cp->Make_Compatibility_Label(id);

			pair<vcTransition*,int> p(this->_entry,idx);
			nl->Add_In_Arc(in_label,p);
			this->_elements[idx]->Compute_Compatibility_Labels(nl,cp);
		}
	}
	else if(this->_elements.size() == 1)
		this->_elements[0]->Compute_Compatibility_Labels(in_label,cp);

	this->_exit->Set_Compatibility_Label(in_label);
}

void vcCPParallelBlock::Update_Predecessor_Successor_Links()
{
	if(!this->_elements.empty())
	{
		for(int idx = 0; idx < this->_elements.size(); idx++)
		{
			this->_entry->Add_Successor(this->_elements[idx]);
			this->_elements[idx]->Add_Predecessor(this->_entry);

			this->_exit->Add_Predecessor(this->_elements[idx]);
			this->_elements[idx]->Add_Successor(this->_exit);
		}
	}
	else
	{
		this->_entry->Add_Successor(this->_exit);
		this->_exit->Add_Predecessor(this->_entry);
	}
	this->vcCPBlock::Update_Predecessor_Successor_Links();
}


vcCPBranchBlock::vcCPBranchBlock(vcCPBlock* p, string id):vcCPSeriesBlock(p, id)
{
}

void vcCPBranchBlock::Add_Branch_Point(string bp_name, vector<string>& choice_cpe_vec)
{
	vcCPElement* bp = this->Find_CPElement(bp_name);

	if(!(bp != NULL && bp->Is("vcPlace")))
	{
		if(bp == NULL)
			vcSystem::Error("branch point " + bp_name + " does not exist"); 
		else
			vcSystem::Error("branch point " + bp_name + " is not a place"); 
		return;
	}

	for(int idx = 0; idx < choice_cpe_vec.size(); idx++)
	{
		vcCPElement* bre = this->Find_CPElement(choice_cpe_vec[idx]);
		if(bre == NULL)
		{
			vcSystem::Error("did not find branch choice region " + choice_cpe_vec[idx]); 	  
			return;
		}
		this->_branch_map[((vcPlace*)bp)].push_back(bre);
	}
}

void vcCPBranchBlock::Add_Merge_Point(string merge_place, string merge_region)
{
	vcCPElement* mp = this->Find_CPElement(merge_place);
	vcCPElement* mr = this->Find_CPElement(merge_region);

	if(mp == NULL)
	{
		vcSystem::Error("did not find place " + merge_place);
		return;
	}

	if(!mp->Is("vcPlace"))
	{
		vcSystem::Error("merge point " + merge_place + " is not a place");
		return;
	}

	if(mr == NULL)
	{
		vcSystem::Error("merged region " + merge_region + " not found");
		return;
	}

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
		ofile << (*iter).first->Get_Id() << " " << 
			vcLexerKeywords[__BRANCH] << " (";
		for(int idx = 0; idx < (*iter).second.size(); idx++)
		{
			ofile << " " << (*iter).second[idx]->Get_Id() << " ";
		}
		ofile << ")" << endl;
	}

	for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _merge_map.begin();
			iter != _merge_map.end();
			iter++)
	{
		ofile << (*iter).first->Get_Id() << " " << vcLexerKeywords[__MERGE] << " (";
		for(int idx = 0; idx < (*iter).second.size(); idx++)
		{
			ofile << " " << (*iter).second[idx]->Get_Id() << " ";
		}
		ofile << ")" << endl;
	}
	ofile << "\n// end branch-block " << this->Get_Id() << endl << "}" << endl;
}


bool vcCPBranchBlock::Check_Structure()
{

	bool ret_flag = this->vcCPBlock::Check_Structure();
	if(ret_flag)
	{

		vector<vcCPElement*> reachable_elements;
		bool cycle_flag = false;
		int num_visited = 0;

		set<vcCPElement*> visited_set;
		this->BFS_Order(false,this->_entry, num_visited, reachable_elements,visited_set);
		if(num_visited != this->Number_Of_Elements_Reachable_From_Entry())
		{
			vcSystem::Warning("some elements are not reachable from the entry point of branch region " + this->Get_Hierarchical_Id());
			if(vcSystem::_verbose_flag)
				this->Print_Missing_Elements(visited_set);
		}

		reachable_elements.clear();
		num_visited = 0;
		cycle_flag = false;
		visited_set.clear();
		this->BFS_Order(true, this->_exit, num_visited, reachable_elements,visited_set);
		if(num_visited != this->Number_Of_Elements_That_Can_Reach_Exit())
		{
			vcSystem::Warning("region exit not reachable from some elements in branch region " + this->Get_Hierarchical_Id());
			if(vcSystem::_verbose_flag)
				this->Print_Missing_Elements(visited_set);
		}
	}

	return(ret_flag);
}

void vcCPBranchBlock::Update_Predecessor_Successor_Links()
{
	// branches
	for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = this->_branch_map.begin();
			iter != this->_branch_map.end();
			iter++)
	{
		vcPlace* p = (*iter).first;
		for(int idx = 0; idx < (*iter).second.size(); idx++)
		{
			vcCPElement* e = (*iter).second[idx];
			e->Add_Predecessor(p);
			p->Add_Successor(e);
		}
	}

	// merges
	for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = this->_merge_map.begin();
			iter != this->_merge_map.end();
			iter++)
	{
		vcPlace* p = (*iter).first;
		for(int idx = 0; idx < (*iter).second.size(); idx++)
		{
			vcCPElement* e = (*iter).second[idx];
			e->Add_Successor(p);
			p->Add_Predecessor(e);
		}
	}

	this->vcCPBlock::Update_Predecessor_Successor_Links();
}


vcPhiSequencer::vcPhiSequencer(vcCPElement* prnt, string id): vcCPElement(prnt,id)
{
	_place_capacity = 1;
	_phi_mux_ack   = NULL;
	_phi_sample_req    = NULL;
	_phi_sample_ack    = NULL;
	_phi_update_req    = NULL;
	_phi_update_ack    = NULL;
}

void vcPhiSequencer::Print(ostream& ofile)
{
	assert(!this->Check_Consistency());

	ofile << vcLexerKeywords[__PHISEQUENCER] << " " << this->Get_Label() 
		<<   " " << vcLexerKeywords[__COLON] << " ";
	// selects.
	for(int idx = 0, fidx = _triggers.size(); idx < fidx; idx++)
	{
		ofile << _triggers[idx]->Get_Id() << " ";
		ofile << _src_sample_reqs[idx]->Get_Id() << " ";
		ofile << _src_sample_acks[idx]->Get_Id() << " ";
		ofile << _src_update_reqs[idx]->Get_Id() << " ";
		ofile << _src_update_acks[idx]->Get_Id() << " ";
	}

	ofile << vcLexerKeywords[__COLON]  << " ";
	ofile << _phi_sample_req->Get_Id() << " ";
	ofile << _phi_sample_ack->Get_Id() << " ";
	ofile << _phi_update_req->Get_Id() << " ";
	ofile << _phi_update_ack->Get_Id() << " ";
	ofile << vcLexerKeywords[__COLON]  << " ";
	for(int idx = 0, fidx = _triggers.size(); idx < fidx; idx++)
	{
		ofile << _phi_mux_reqs[idx]->Get_Id() << " ";
	}
	ofile << vcLexerKeywords[__COLON] << " ";
	ofile << _phi_mux_ack->Get_Id() << " ";
}

void vcPhiSequencer::Print_VHDL(vcControlPath* cp, ostream& ofile)
{

	assert(!this->Check_Consistency());

	bool parent_is_pipelined_loop_body = (this->Get_Parent()->Is("vcCPPipelinedLoopBody"));
	int max_iterations_in_flight = 1;
	if(parent_is_pipelined_loop_body) 
	{
		max_iterations_in_flight = ((vcCPPipelinedLoopBody*) (this->Get_Parent()))->Get_Max_Iterations_In_Flight();
	}

	ofile << this->Get_VHDL_Id() << "_block : block -- { " << endl;
	ofile << "signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to " << _triggers.size()-1 << ");" << endl;
	ofile << "signal phi_mux_reqs : BooleanArray(0 to " << _triggers.size()-1 << "); -- }" << endl;
	ofile << "begin -- { " << endl;
	for(int idx = 0, fidx = _triggers.size(); idx < fidx; idx++)
	{
		string sig_id = _triggers[idx]->Get_Exit_Symbol(cp);
		ofile << "triggers(" << idx << ")  <= " << sig_id << ";" << endl;
		ofile <<  _src_sample_reqs[idx]->Get_Exit_Symbol(cp) 
			<< "<= src_sample_reqs(" << idx << ");" << endl;
		ofile << "src_sample_acks(" << idx << ")  <= " << 
			_src_sample_acks[idx]->Get_Exit_Symbol(cp) << ";" << endl;
		ofile <<  _src_update_reqs[idx]->Get_Exit_Symbol(cp) 
			<< "<= src_update_reqs(" << idx << ");" << endl;
		ofile << "src_update_acks(" << idx << ")  <= " << 
			_src_update_acks[idx]->Get_Exit_Symbol(cp) << ";" << endl;

		ofile << _phi_mux_reqs[idx]->Get_Exit_Symbol(cp) << " <= phi_mux_reqs(" << idx << ");" << endl;
	}

	string gen_name = '"' +  this->Get_VHDL_Id() + '"';
	ofile << this->Get_VHDL_Id() << " : phi_sequencer_v2-- { " << endl;;
	ofile << "generic map (place_capacity => " << max_iterations_in_flight 
		<< ", ntriggers => "  << _triggers.size() 
		<< ", name => "  << gen_name << ") " << endl;
	ofile << "port map ( -- {" << endl
		<< " triggers => triggers, src_sample_starts => src_sample_reqs, "   << endl
		<< " src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, " << endl
		<< " src_update_completes => src_update_acks," << endl
		<< " phi_mux_select_reqs => phi_mux_reqs, "  << endl
		<< " phi_sample_req => " << _phi_sample_req->Get_Exit_Symbol(cp) << ", " << endl
		<< " phi_sample_ack => " << _phi_sample_ack->Get_Exit_Symbol(cp) << ", " << endl
		<< " phi_update_req => " << _phi_update_req->Get_Exit_Symbol(cp) << ", " << endl
		<< " phi_update_ack => " << _phi_update_ack->Get_Exit_Symbol(cp) << ", " << endl
		<< " phi_mux_ack => "    << _phi_mux_ack->Get_Exit_Symbol(cp)    << ", " << endl
		<< " clk => clk, reset => reset -- }" << endl << ");" << endl;
	ofile << " -- } } " << endl;
	ofile << "end block;" << endl;

}

void vcPhiSequencer::Print_Dot_Entry(vcControlPath* cp, ostream& ofile)
{
	string tnode_id = this->Get_VHDL_Id();
	ofile << "  " << tnode_id << " [shape=rectangle];" << endl;

	for(int idx = 0, fidx = _triggers.size(); idx < fidx; idx++)
	{
		string src = cp->Get_Group(_triggers[idx])->Get_Dot_Id();
		ofile << src << " -> " << tnode_id << ";" << endl;

		string dest = cp->Get_Group(_src_sample_reqs[idx])->Get_Dot_Id();
		ofile << tnode_id << " -> " << dest << ";" << endl;

		dest = cp->Get_Group(_src_update_reqs[idx])->Get_Dot_Id();
		ofile << tnode_id << " -> " << dest << ";" << endl;

		dest = cp->Get_Group(_phi_mux_reqs[idx])->Get_Dot_Id();
		ofile << tnode_id << " -> " << dest << ";" << endl;

		src = cp->Get_Group(_src_sample_acks[idx])->Get_Dot_Id();
		ofile << src << " -> " << tnode_id << ";" << endl;

		src = cp->Get_Group(_src_update_acks[idx])->Get_Dot_Id();
		ofile << src << " -> " << tnode_id << ";" << endl;
	}

	string src = cp->Get_Group(_phi_sample_ack)->Get_Dot_Id();
	ofile << src << " -> " << tnode_id << ";" << endl;

	src = cp->Get_Group(_phi_update_ack)->Get_Dot_Id();
	ofile << src << " -> " << tnode_id << ";" << endl;

	string dest = cp->Get_Group(_phi_sample_req)->Get_Dot_Id();
	ofile << tnode_id << " -> " << dest << ";" << endl;

	dest = cp->Get_Group(_phi_update_req)->Get_Dot_Id();
	ofile << tnode_id << " -> " << dest << ";" << endl;

	src = cp->Get_Group(_phi_mux_ack)->Get_Dot_Id();
	ofile << src << " -> " << tnode_id << ";" << endl;

}

// connectivity is expressed.
void vcPhiSequencer::Update_Predecessor_Successor_Links()
{
	assert (!this->Check_Consistency());

	// predecessor successor relations.
	for(int idx = 0, fidx = _triggers.size(); idx < fidx; idx++)
	{
		vcTransition* s = _triggers[idx];
		s->Connect(_src_sample_reqs[idx]);
		s->Connect(_src_update_reqs[idx]);

		_src_sample_reqs[idx]->Connect(_src_sample_acks[idx]);
		_src_update_reqs[idx]->Connect(_src_update_acks[idx]);
		_phi_mux_reqs[idx]->Connect(_phi_mux_ack);

		_phi_sample_req->Connect(_src_sample_reqs[idx]);
		_src_sample_acks[idx]->Connect(_phi_sample_ack);

		_phi_update_req->Connect(_src_update_reqs[idx]);
		_src_update_acks[idx]->Connect(_phi_mux_reqs[idx]);

		// suppress this.. not a true join.
		//_phi_mux_reqs[idx]->Connect(_phi_mux_ack); 
	}

	_phi_mux_ack->Connect(_phi_update_ack);
}


vcTransitionMerge::vcTransitionMerge(vcCPElement* prnt, string id): vcCPElement(prnt,id)
{

}

  
void vcTransitionMerge::Append_Zero_Delay_Successors(vcTransition* t, set<vcCPElement*>& zero_delay_successors)
{
	for(int I = 0, fI = _in_transitions.size(); I  < fI; I++)
	{
		if(t == _in_transitions[I])
			zero_delay_successors.insert(_out_transition);
	}
}

void vcTransitionMerge::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__TRANSITIONMERGE] << " " << this->Get_Label() <<  " ";
	ofile << "(";
	for(int idx = 0, fidx = _in_transitions.size(); idx < fidx; idx++)
	{
		ofile << _in_transitions[idx]->Get_Id() << " ";
	}
	ofile << ") (";

	ofile << _out_transition->Get_Id() << " )" << endl;
}

void vcTransitionMerge::Print_VHDL(vcControlPath* cp, ostream& ofile)
{
	ofile << this->Get_VHDL_Id() << "_block : block -- { " << endl;
	ofile << "signal preds : BooleanArray(0 to " << _in_transitions.size()-1 << ");" << endl;
	ofile << "begin -- { " << endl;
	for(int idx = 0, fidx = _in_transitions.size(); idx < fidx; idx++)
	{
		string sig_id = _in_transitions[idx]->Get_Exit_Symbol(cp);
		ofile << "preds(" << idx << ")  <= " << sig_id << ";" << endl;
	}

	ofile << this->Get_VHDL_Id() << " : transition_merge -- { " << endl;;
	ofile << "generic map(name => \" " << this->Get_VHDL_Id() << "\")" << endl;
	ofile << "port map (preds => preds, symbol_out => " << _out_transition->Get_Exit_Symbol(cp) << ");" << endl;
	ofile << " -- } } } " << endl;
	ofile << "end block;" << endl;
}

void vcTransitionMerge::Print_Dot_Entry(vcControlPath* cp, ostream& ofile)
{
	string tnode_id = this->Get_VHDL_Id();
	ofile << tnode_id << " [shape = rectangle]; " << endl;
	for(int idx = 0, fidx = _in_transitions.size(); idx < fidx; idx++)
	{
		string sig_id = cp->Get_Group(_in_transitions[idx])->Get_Dot_Id();
		ofile << sig_id << " -> " << tnode_id << ";" << endl;
	}

	string oid = cp->Get_Group(_out_transition)->Get_Dot_Id();
	ofile << tnode_id << " -> " << oid << ";" << endl;
}

void vcTransitionMerge::Update_Predecessor_Successor_Links()
{
	// This is dangerous, because the paths are used in
	// eliminating redundancies.  These should not
	// be considered true predecessor->successor relations.
	/*
	   for(int idx = 0, fidx = _in_transitions.size(); idx < fidx; idx++)
	   {
	   vcTransition* i = _in_transitions[idx];

	   i->Add_Successor(_out_transition);
	   _out_transition->Add_Predecessor(i);
	   }
	 */
}


vcCPSimpleLoopBlock::vcCPSimpleLoopBlock(vcCPBlock* parent, string id): vcCPBranchBlock(parent,id)
{
	this->_pipeline_depth = 2;  // default value.
}

vcCPPipelinedLoopBody* vcCPSimpleLoopBlock::Get_Loop_Body()
{
	for(int idx = 0, fidx = _elements.size(); idx < fidx; idx++)
	{
		vcCPElement* cpe = _elements[idx];
		if(cpe->Is("vcCPPipelinedLoopBody"))
			return((vcCPPipelinedLoopBody*) cpe);
	}
	return(NULL);
}

void vcCPSimpleLoopBlock::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__LOOPBLOCK]  << " [" << this->Get_Id() << "] ";
	ofile  << vcLexerKeywords[__DEPTH]  << this->Get_Pipeline_Depth() <<  " ";
	ofile  << vcLexerKeywords[__BUFFERING]  << this->Get_Pipeline_Buffering() <<  " { " << endl;

	// print all the normal elements.. This includes the loop-body.
	this->Print_Elements(ofile);
	// now print the merge and branch points.
	for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _merge_map.begin();
			iter != _merge_map.end();
			iter++)
	{
		ofile << (*iter).first->Get_Id() << " " << vcLexerKeywords[__MERGE] << " (";
		for(int idx = 0; idx < (*iter).second.size(); idx++)
		{
			ofile << " " << (*iter).second[idx]->Get_Id() << " ";
		}
		ofile << ")" << endl;
	}

	for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _branch_map.begin();
			iter != _branch_map.end();
			iter++)
	{
		ofile << (*iter).first->Get_Id() << " " << 
			vcLexerKeywords[__BRANCH] << " (";
		for(int idx = 0; idx < (*iter).second.size(); idx++)
		{
			ofile << " " << (*iter).second[idx]->Get_Id() << " ";
		}
		ofile << ")" << endl;
	}

	// Now the special elements.

	// input bindings.
	for(map<vcPlace*,vcTransition*>::iterator biter = _input_bindings.begin();
			biter != _input_bindings.end();
			biter++)
	{
		vcPlace* pl = (*biter).first;
		vcTransition* tr = (*biter).second;

		ofile << vcLexerKeywords[__BIND] << " " << pl->Get_Id() << " " 
			<< vcLexerKeywords[__IMPLIES] << " " 
			<< tr->Get_Parent()->Get_Id() << vcLexerKeywords[__COLON] 
			<< tr->Get_Id() << endl;	
	}


	// output bindings.
	for(map<vcPlace*,vcTransition*>::iterator biter = _output_bindings.begin();
			biter != _output_bindings.end();
			biter++)
	{
		vcPlace* pl = (*biter).first;
		vcTransition* tr = (*biter).second;

		ofile << vcLexerKeywords[__BIND] << " " << pl->Get_Id() << " " 
			<< vcLexerKeywords[__ULE_OP] << " " 
			<< tr->Get_Parent()->Get_Id() << vcLexerKeywords[__COLON] 
			<< tr->Get_Id() << endl;	
	}

	// terminator.
	ofile << vcLexerKeywords[__TERMINATE] << " " << vcLexerKeywords[__LPAREN] << " (";
	ofile << _terminator->_loop_exit->Get_Id() << " " << _terminator->_loop_taken->Get_Id() << " " << _terminator->_loop_body->Get_Id() << ") (";
	ofile << _terminator->_exit_from_loop->Get_Id() << ")" << endl;

	ofile << "\n// end loop-block " << this->Get_Id() << endl << "}" << endl;
}

// This is the same routine as that for the vcCPBlock, 
// modified to take care of the simple loop structure.
void vcCPSimpleLoopBlock::Print_VHDL(ostream& ofile)
{
	string id = this->Get_Hierarchical_Id();

	// declare all exit flags.
	ofile << this->Get_VHDL_Id() << ": Block -- " << id << " {" << endl;
	this->Print_VHDL_Signal_Declarations(ofile);

	ofile << "-- }" << endl << "begin -- {" << endl;
	this->Print_VHDL_Start_Symbol_Assignment(ofile);

	this->_entry->Print_VHDL(ofile);
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		this->_elements[idx]->Print_VHDL(ofile);
	}
	this->_exit->Print_VHDL(ofile);
	this->Print_VHDL_Exit_Symbol_Assignment(ofile);

	this->Print_VHDL_Terminator(NULL,ofile);
	ofile << "-- }" << endl << "end Block; -- " << id << endl;
}

void vcLoopTerminator::Append_Zero_Delay_Successors(vcTransition* t, set<vcCPElement*>& zero_delay_successors)
{
	if((t == _loop_taken) || (t == _loop_exit) || (t == _loop_body))
	{
		zero_delay_successors.insert(_loop_back);
		zero_delay_successors.insert(_exit_from_loop);
	}
}


void vcCPSimpleLoopBlock::Set_Loop_Termination_Information(string loop_exit, string loop_taken, string loop_body, string loop_back, string exit_from_loop)
{
	string tid = this->Get_Id() + "_terminator";
	_terminator = new vcLoopTerminator(this,tid);

	_terminator->_loop_exit = this->Find_CPElement(loop_exit);
	assert(_terminator->_loop_exit != NULL);	
	assert(_terminator->_loop_exit->Is("vcCPSeriesBlock"));
	_terminator->_loop_exit->Set_Is_Bound_As_Input_To_CP_Function(true);
	_terminator->_loop_exit->Set_Associated_CP_Function(_terminator);

	_terminator->_loop_taken = this->Find_CPElement(loop_taken);
	assert(_terminator->_loop_taken != NULL);	
	assert(_terminator->_loop_taken->Is("vcCPSeriesBlock"));
	_terminator->_loop_taken->Set_Is_Bound_As_Input_To_CP_Function(true);
	_terminator->_loop_taken->Set_Associated_CP_Function(_terminator);

	_terminator->_loop_body = this->Find_CPElement(loop_body);
	assert(_terminator->_loop_body != NULL);	
	assert(_terminator->_loop_body->Is("vcPlace"));
	_terminator->_loop_body->Set_Is_Bound_As_Input_To_CP_Function(true);
	_terminator->_loop_body->Set_Associated_CP_Function(_terminator);

	_terminator->_loop_back = this->Find_CPElement(loop_back);
	assert(_terminator->_loop_back != NULL);	
	assert(_terminator->_loop_back->Is("vcPlace"));
	_terminator->_loop_back->Set_Is_Bound_As_Output_From_CP_Function(true);
	_terminator->_loop_back->Set_Associated_CP_Function(_terminator);

	_terminator->_exit_from_loop = this->Find_CPElement(exit_from_loop);
	assert(_terminator->_exit_from_loop != NULL);	
	assert(_terminator->_exit_from_loop->Is("vcPlace"));
	_terminator->_exit_from_loop->Set_Is_Bound_As_Output_From_CP_Function(true);
	_terminator->_exit_from_loop->Set_Associated_CP_Function(_terminator);

}


bool vcCPSimpleLoopBlock::Check_Structure()
{
	// normal branch block related stuff.
	this->vcCPBranchBlock::Check_Structure();
    return true;
}

void vcCPSimpleLoopBlock::Update_Predecessor_Successor_Links()
{
	// normal branch block related stuff.
	this->vcCPBranchBlock::Update_Predecessor_Successor_Links();

	// for the terminator.
	_terminator->_loop_exit->Add_Successor(_terminator->_loop_back);
	_terminator->_loop_back->Add_Predecessor(_terminator->_loop_exit);

	_terminator->_loop_exit->Add_Successor(_terminator->_exit_from_loop);
	_terminator->_exit_from_loop->Add_Predecessor(_terminator->_loop_exit);

	_terminator->_loop_taken->Add_Successor(_terminator->_loop_back);
	_terminator->_loop_back->Add_Predecessor(_terminator->_loop_taken);

	_terminator->_loop_taken->Add_Successor(_terminator->_exit_from_loop);
	_terminator->_exit_from_loop->Add_Predecessor(_terminator->_loop_taken);

	_terminator->_loop_body->Add_Successor(_terminator->_loop_back);
	_terminator->_loop_back->Add_Predecessor(_terminator->_loop_body);

	_terminator->_loop_body->Add_Successor(_terminator->_exit_from_loop);
	_terminator->_exit_from_loop->Add_Predecessor(_terminator->_loop_body);


	this->Update_Binding_Predecessor_Successor_Links();

}


vcCPForkBlock::vcCPForkBlock(vcCPBlock* p, string id):vcCPParallelBlock(p, id)
{
}



void vcCPForkBlock::Add_Fork_Point(vcTransition* fp, vcCPElement* fre)
{
	if((this->_fork_map.find(fp) == this->_fork_map.end())
			||
			(this->_fork_map[fp].find(fre) == this->_fork_map[fp].end()))
	{
		this->_fork_map[((vcTransition*)fp)].insert(fre);
		this->_forked_elements.insert(fre);

		fp->Add_Successor(fre);

		if(fre->Is_Transition())
		{
			this->Add_Join_Point((vcTransition*)fre, fp);
		}
		else
			fre->Add_Predecessor(fp);
	}
}


void vcCPForkBlock::Remove_Fork_Point(vcTransition* fp, vcCPElement* fre)
{
	if(_fork_map.find(fp) != _fork_map.end())
	{
		if(_fork_map[fp].find(fre) != _fork_map[fp].end())
		{
			fp->Remove_Successor(fre);	
			fre->Remove_Predecessor(fp);
			_fork_map[fp].erase(fre);
		}
	}
}

void vcCPForkBlock::Add_Fork_Point(string& fork_name, vector<string>& fork_cpe_vec)
{
	vcCPElement* fp = NULL;
	if(fork_name != "$null")
	{
		fp = this->Find_CPElement(fork_name);
		if(fp == NULL)
		{
			vcSystem::Error("did not find fork point " + fork_name);
			return;
		}
		else if(!fp->Is("vcTransition"))
		{
			vcSystem::Error("fork point " + fork_name + " is not a transition");
			return;
		}

	}
	for(int idx = 0; idx < fork_cpe_vec.size(); idx++)
	{
		if(fork_cpe_vec[idx] == "$null")
		{
			if(fp != NULL)
				fp->Set_Has_Null_Successor(true);
		}
		else
		{
			vcCPElement* fre = this->Find_CPElement(fork_cpe_vec[idx]);
			if(fre == NULL)
			{
				vcSystem::Error("did not find forked region " + fork_cpe_vec[idx]);
				return;
			}
			else 
			{
				if(fp != NULL)
					this->Add_Fork_Point((vcTransition*)fp, fre);
				else
					fre->Set_Has_Null_Predecessor(true);
			}
		}
	}
}

void vcCPForkBlock::Add_Join_Point(vcTransition* jp, vcCPElement* jre)
{
	if((this->_join_map.find(jp) == this->_join_map.end())
			||
			(this->_join_map[jp].find(jre) == this->_join_map[jp].end()))
	{
		this->_join_map[((vcTransition*)jp)].insert(jre);
		this->_joined_elements.insert(jre);

		jp->Add_Predecessor(jre);

		if(jre->Is_Transition())
		{
			this->Add_Fork_Point((vcTransition*)jre, jp);
		}
		else
			jre->Add_Successor(jp);
	}
}

void vcCPForkBlock::Remove_Join_Point(vcTransition* jp, vcCPElement* jre)
{
	if(_join_map.find(jp) != _join_map.end())
	{
		if(_join_map[jp].find(jre) != _join_map[jp].end())
		{
			jp->Remove_Predecessor(jre);	
			jre->Remove_Successor(jp);
			_join_map[jp].erase(jre);
		}
	}
}

void vcCPForkBlock::Add_Join_Point(string& join_name, vector<string>& join_cpe_vec)
{
	bool null_join = false;
	if(join_name == "$null")
		null_join = true;

	vcCPElement* jp = this->Find_CPElement(join_name);

	if(!null_join && (jp == NULL))
	{
		vcSystem::Error("did not find join point " + join_name);
		return;
	}
	else if((jp != NULL) && !jp->Is("vcTransition"))
	{
		vcSystem::Error("join point " + join_name + " is not a transition");
		return;
	}
	else
	{
		for(int idx = 0; idx < join_cpe_vec.size(); idx++)
		{
			if(join_cpe_vec[idx] == "$null")
			{
				jp->Set_Has_Null_Predecessor(true);
				continue; // no need to make the null transitions..
			}

			vcCPElement* jre = this->Find_CPElement(join_cpe_vec[idx]);

			if(jre == NULL)
			{
				vcSystem::Error("did not find joined region " + join_cpe_vec[idx]);
				return;
			}
			else
			{
				if(null_join)
					jre->Set_Has_Null_Successor(true);
				else
					this->Add_Join_Point((vcTransition*)jp,jre);
			}
		}
	}
}

void vcCPForkBlock::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__FORKBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
	this->Print_Elements(ofile);


	for(map<vcTransition*,set<vcCPElement*>,vcRoot_Compare>::iterator iter = _fork_map.begin();
			iter != _fork_map.end();
			iter++)
	{
		ofile << (*iter).first->Get_Id() << " " << 
			vcLexerKeywords[__FORK] << " (" ;
		for(set<vcCPElement*>::iterator siter = (*iter).second.begin(), sfiter = (*iter).second.end();
				siter != sfiter;
				siter++)
		{
			ofile << " " << (*siter)->Get_Id() << " ";
		}
		ofile << ")" << endl;
	}


	for(map<vcTransition*,set<vcCPElement*>,vcRoot_Compare>::iterator iter = _join_map.begin();
			iter != _join_map.end();
			iter++)
	{
		ofile <<  (*iter).first->Get_Id() << " " << 
			vcLexerKeywords[__JOIN] << " (" ;
		for(set<vcCPElement*>::iterator siter = (*iter).second.begin(), sfiter = (*iter).second.end();
				siter != sfiter;
				siter++)
		{
			ofile << " " << (*siter)->Get_Id() << " ";
		}
		ofile << ")" << endl;
	}
	ofile << "\n// end fork-block " << this->Get_Id() << endl << "}" << endl;
}

void vcCPForkBlock::DFS_Forward_Edge_Action(bool reverse_flag,
		deque<vcCPElement*>& dfs_queue,
		set<vcCPElement*>& on_queue_set,
		vcCPElement* u, vcCPElement* v)
{
	if(reverse_flag == false)
	{
		// for each predecessor w of v, if w is on the queue
		// then mark (w,v) as an arc to be removed. 
		vector<vcCPElement*>& adj =  v->Get_Predecessors();
		for(int idx = 0; idx < adj.size(); idx++)
		{
			vcCPElement* w = adj[idx];
			if((w != u) && (on_queue_set.find(w) != on_queue_set.end()))
			{
				this->_redundant_pairs.push_back(pair<vcCPElement*,vcCPElement*>(w,v));	
			}
		}
	}
}


void vcCPForkBlock::All_Pairs_Longest_Paths(map<vcCPElement*,map<vcCPElement*,int> >& distance_map)
{

	// Since we are looking at a Fork-block, the control
	// graph is guaranteed to be acyclic --> efficient algorithm!

	// 
	// Algorithm runs in O(|E||V|) time.  First perform
	// a topological sort, and update distances starting
	// from the sources to the sinks.
	//

	GraphBase g;
	vector<vcCPElement*> vertex_vector; // to keep all the vertices.

	// first build a Boost graph.
	string nname = "null";
	g.Add_Vertex(NULL);
	g.Add_Vertex((void*) _entry);
	g.Add_Vertex((void*) _exit);
	vertex_vector.push_back(_entry);
	vertex_vector.push_back(_exit);

	for(int idx = 0; idx < _elements.size(); idx++)
	{
		vcCPElement* u = _elements[idx];
		g.Add_Vertex((void*) u);
		vertex_vector.push_back(u);
	}


	for(int idx = 0, fidx = vertex_vector.size(); idx < fidx; idx++)
	{
		vcCPElement* u = vertex_vector[idx];

		for(int jdx = 0, fjdx = vertex_vector.size(); jdx < fjdx; jdx++)
		{
			vcCPElement* v = vertex_vector[jdx];
			distance_map[u][v] = 0;
		}

		// NULL to all source vertices.
		if(u->Get_Number_Of_Predecessors() == 0)
			g.Add_Edge(NULL,(void*) u);
		else
		{
			for(int vidx = 0, fvidx = u->Get_Number_Of_Predecessors(); 
					vidx < fvidx; 
					vidx++)
			{
				vcCPElement* v = u->Get_Predecessor(vidx);
				g.Add_Edge(v,u);
			}
		}
	}

	// Boost topological sort.
	vector<void*> precedence_order;
	g.Topological_Sort(precedence_order);


	// start from sources and iterate towards the sinks.
	// When the algorithm reaches a node, the longest
	// paths to all higher precedence nodes have already
	// been calculated.
	for(int i = precedence_order.size()-1 ; i >= 0; i--) 
	{
		vcCPElement* v = ((vcCPElement*) precedence_order[i]);
		if(v == NULL)
			continue;
		for(int vidx = 0, fvidx = v->Get_Number_Of_Predecessors(); 
				vidx < fvidx; 
				vidx++)
		{
			vcCPElement* u = v->Get_Predecessor(vidx);

			// Update all path lengths to v.
			for(int q = 0, fq = vertex_vector.size(); q  < fq; q++)
			{
				vcCPElement* w = vertex_vector[q];
				int dwu = distance_map[w][u];
				if((dwu > 0) || (w == u))
				{
					int nd = dwu + 1;
					if(nd > distance_map[w][v])
						distance_map[w][v] = nd;
				}
			}
		}
	}
}


void vcCPForkBlock::Remove_Redundant_Arcs(map<vcCPElement*,map<vcCPElement*,int> >& distance_map)
{
	// for each arc (u,v), check if distance[u][v] > 1.
	// If so, then arc (u,v) is to be deleted.
	for(map<vcCPElement*,map<vcCPElement*,int> >::iterator iter = distance_map.begin(),
			fiter = distance_map.end(); iter != fiter; iter++)
	{
		vcCPElement* u = (*iter).first;
		for(int idx = 0, fidx = u->Get_Number_Of_Successors();
				idx < fidx; idx++)
		{
			vcCPElement* v = u->Get_Successor(idx);
			if(distance_map[u][v] > 1) 
			{
				if(v->Is_Transition())
				{
					//if(!((vcTransition*)v)->Get_Is_Delay_Element())
					//{
					this->Remove_Join_Point((vcTransition*)v,u);
					if(vcSystem::_verbose_flag)
						vcSystem::Info("removed redundant join point " + v->Get_Label() + " <-& "
								+ u->Get_Label());
					//}
				}
				if(u->Is_Transition())
				{
					//if(!((vcTransition*)u)->Get_Is_Delay_Element())
					//{
					this->Remove_Fork_Point((vcTransition*)u,v);
					if(vcSystem::_verbose_flag)
						vcSystem::Info("removed redundant fork point " + u->Get_Label() + " &-> "
								+ v->Get_Label());
					//}
				}
			}
		}
	}
}


void vcCPForkBlock::Eliminate_Redundant_Dependencies()
{
	// First get rid of the redundant pairs that the DFS
	// had discovered.
	for(int idx = 0; idx < _redundant_pairs.size(); idx++)
	{
		vcCPElement* u = _redundant_pairs[idx].first;
		vcCPElement* v = _redundant_pairs[idx].second;

		if(u->Is_Transition())
		{
			//if(!((vcTransition*)u)->Get_Is_Delay_Element())
			//{
			this->Remove_Fork_Point((vcTransition*)u,v);
			if(vcSystem::_verbose_flag)
				vcSystem::Info("removed redundant fork point " + u->Get_Label() + " &-> "
						+ v->Get_Label());
			//}
		}

		if(v->Is_Transition())
		{
			//if(!((vcTransition*)v)->Get_Is_Delay_Element())
			//{
			this->Remove_Join_Point((vcTransition*)v,u);
			if(vcSystem::_verbose_flag)
				vcSystem::Info("removed redundant join point " + v->Get_Label() + " <-& "
						+ u->Get_Label());
			//}
		}
	}

	// calculate all pairs longest paths.
	map<vcCPElement*,map<vcCPElement*,int> > distance_map;
	this->All_Pairs_Longest_Paths(distance_map);

	// Now for each arc, 
	this->Remove_Redundant_Arcs(distance_map);
}

void vcCPForkBlock::Remove_Isolated_Transitions()
{
	vector<vcCPElement*> kept_elements;
	for(int idx = 0, fidx = _elements.size(); idx < fidx; idx++)
	{
		vcCPElement* cpe = _elements[idx];
		if(cpe->Is_Transition())
		{
			vcTransition* t = (vcTransition*) cpe;
			if(!t->Get_Is_Input() && !t->Get_Is_Output() && 
					!t->Get_Is_Linked_To_Non_Local_Dpe() && 
					!cpe->Get_Is_Bound_As_Input_To_CP_Function() && 
					!cpe->Get_Is_Bound_As_Output_From_CP_Function() && 
					!cpe->Get_Is_Bound_As_Output_From_Region() && 
					(t->Get_Number_Of_Predecessors() == 0) && 
					(t->Get_Number_Of_Successors() == 0) && 
					(t->Get_Number_Of_Marked_Predecessors() == 0) && 
					(t->Get_Number_Of_Marked_Successors() == 0))
			{
				vcSystem::Info("Info: transition " + t->Get_Label() + " is isolated, removed.");
			}
			else
				kept_elements.push_back(t);
		}
		else
			kept_elements.push_back(cpe);
	}

	_elements.clear();
	for(int idx = 0, fidx = kept_elements.size(); idx < fidx; idx++)
	{
		_elements.push_back(kept_elements[idx]);
	}
}

bool vcCPForkBlock::Check_Structure()
{
	bool ret_flag = this->vcCPBlock::Check_Structure();

	if(ret_flag)
	{

		vector<vcCPElement*> reachable_elements;
		bool cycle_flag = false;
		int num_visited = 0;

		set<vcCPElement*> visited_set;
		this->DFS_Order(false, this->_entry, cycle_flag, num_visited, reachable_elements,visited_set);
		if(num_visited != (this->Number_Of_Elements_Reachable_From_Entry()))
		{
			ret_flag = false;

			//
			// TODO: this needs to be cleaned up a bit.  We should really write
			//       a Check_Structure method for the Pipelined-Loop-Body instead
			//       of this hack.
			//       
			//       For pipelined-loop bodies, all elements should be reachable
			//       from the multiple entry points to the body.  So multiple DFS
			//       searches need to be performed.
			//
			vcSystem::Warning("all elements not reachable from entry in region " + this->Get_Hierarchical_Id());

			if(vcSystem::_verbose_flag)
				this->Print_Missing_Elements(visited_set);
		}

		if(cycle_flag)
		{
			vcSystem::Error("Cycles present in fork region " + this->Get_Hierarchical_Id());
			ret_flag = false;
		}

		reachable_elements.clear();
		num_visited = 0;

		cycle_flag = false;
		visited_set.clear();
		this->BFS_Order(true, this->_exit, num_visited, reachable_elements,visited_set);
		if(num_visited != (this->_elements.size() + 2))
		{
			ret_flag = false;

			//
			// TODO: this needs to be cleaned up a bit.  We should really write
			//       a Check_Structure method for the Pipelined-Loop-Body instead
			//       of this hack.
			//
			//       For pipelined-loop bodies, all elements should be able to reach
			//       the multiple exit points from the body.  So multiple (reverse) DFS
			//       searches need to be performed.
			//       
			vcSystem::Warning("exit not reachable from every element in region " + this->Get_Hierarchical_Id());
			if(vcSystem::_verbose_flag)
				this->Print_Missing_Elements(visited_set);
		}


		for(int idx = 0; idx < _elements.size(); idx++)
		{
			vcCPElement* cpe = this->_elements[idx];
			if(!cpe->Is_Transition())
			{
				if(cpe->Get_Number_Of_Successors() > 1)
				{
					vcSystem::Error("non-transition cannot be a fork: " + cpe->Get_Hierarchical_Id());
				}
				if(cpe->Get_Number_Of_Predecessors() > 1)
				{
					vcSystem::Error("non-transition cannot be a join: " + cpe->Get_Hierarchical_Id());
				}

			}
		}
	}


	this->Eliminate_Redundant_Dependencies();
	return(ret_flag);
}

// assumption..  that the graph is acyclic, with a single source and a single sink.
void vcCPForkBlock::Precedence_Order(bool reverse_flag, vcCPElement* start_element, vector<vcCPElement*>& precedence_order)
{
	int idx = 0;

	if(!reverse_flag)
		assert(start_element->Get_Predecessors().size() == 0);
	else
		assert(start_element->Get_Successors().size() == 0);

	set<vcCPElement*> scanned_set;
	scanned_set.insert(start_element);

	set<vcCPElement*> ordered_set;
	// the first candidate.
	while(scanned_set.size() > 0)
	{
		vcCPElement* top =  *(scanned_set.begin());
		scanned_set.erase(top);

		precedence_order.push_back(top);
		ordered_set.insert(top);

		// scan all neighbours of top_element.
		vector<vcCPElement*>& adj = (reverse_flag ? top->Get_Predecessors() : top->Get_Successors());
		for(int idx = 0; idx < adj.size(); idx++)
		{
			bool add_flag = true;
			vcCPElement* w = adj[idx];

			// all predecessors of w marked?
			vector<vcCPElement*>& adjw = (reverse_flag ? w->Get_Successors() : w->Get_Predecessors());
			for(int idx2 = 0; idx2 < adjw.size(); idx2++)
			{
				vcCPElement* u = adjw[idx2];
				if(ordered_set.find(u) == ordered_set.end())
				{
					add_flag = false;
					break;
				}
			}

			if(add_flag) 
			{
				scanned_set.insert(w);
			}
		}
	}
}

void vcCPForkBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath*  cp)
{
	// inherited label is passed down from _entry.
	// create additional labels whenever there is 
	// a fork.  Whenever there is a join, do 
	// a reduce.
	this->Set_Compatibility_Label(in_label);

	vector<vcCPElement*> reachable_elements;
	int num_visited = 0;

	this->Precedence_Order(false, this->_entry,reachable_elements);

	map<vcCPElement*,vcCompatibilityLabel*> nl_map;
	nl_map[this->_entry] = in_label;


	for(int tidx = 0; tidx < reachable_elements.size(); tidx++)
	{
		vcCPElement* cpe = reachable_elements[tidx];

		vcCompatibilityLabel* nl = NULL;
		if(nl_map.find(cpe) != nl_map.end())
		{
			nl = nl_map[cpe];
		}

		assert(nl != NULL);
		vcCompatibilityLabel* reduced_label = nl->Reduce(cp);	  

		if(reduced_label != nl)
		{
			cp->Delete_Compatibility_Label(nl);
			nl = NULL;
		}

		if(!cpe->Is_Transition())
		{
			cpe->Compute_Compatibility_Labels(reduced_label,cp);
			nl_map[cpe] = reduced_label;

			// there should be exactly one successor!
			assert(cpe->Get_Successors().size() == 1);
			for(int idx = 0, fidx = cpe->Get_Successors().size(); idx < fidx; idx++)
			{
				vcCPElement* ncpe = cpe->Get_Successor(idx);
				string cpelabel_id = ncpe->Get_Hierarchical_Id();
				vcCompatibilityLabel* nnl = NULL;
				if(nl_map.find(ncpe) == nl_map.end())
				{
					nnl = cp->Make_Compatibility_Label(cpelabel_id);
					nl_map[ncpe] = nnl;
				}
				else
					nnl = nl_map[ncpe];
				nnl->Add_In_Arc(reduced_label);
			}
		}
		else
		{
			vcTransition* t = (vcTransition*) cpe;

			t->Set_Compatibility_Label(reduced_label);
			nl_map[t] = reduced_label;

			bool no_fork = (t->Get_Successors().size() == 1);
			for(int idx = 0, fidx = t->Get_Successors().size(); idx < fidx; idx++)
			{
				vcCPElement* ncpe = t->Get_Successor(idx);


				// for each, create a new label
				string fid = reduced_label->Get_Id() + "/" 
					+ t->Get_Hierarchical_Id() + "[" +IntToStr(idx) + "]";

				string cpelabel_id = ncpe->Get_Hierarchical_Id();
				vcCompatibilityLabel* nnl = NULL;
				if(nl_map.find(ncpe) == nl_map.end())
				{
					nnl = cp->Make_Compatibility_Label(cpelabel_id);
					nl_map[ncpe] = nnl;
				}
				else
					nnl = nl_map[ncpe];

				if(no_fork)
				{
					nnl->Add_In_Arc(t->Get_Compatibility_Label());
				}
				else
				{
					vcCompatibilityLabel* flabel =  cp->Make_Compatibility_Label(fid);
					pair<vcTransition*, int> npair(t,idx);
					flabel->Add_In_Arc(t->Get_Compatibility_Label(), npair);
					nnl->Add_In_Arc(flabel);
				}
			}
		}
	}
}

void vcCPForkBlock::Update_Predecessor_Successor_Links()
{
	this->vcCPBlock::Update_Predecessor_Successor_Links();

	this->Remove_Isolated_Transitions();
	// those that were not covered by explicit fork/join declarations
	vector<vcCPElement*> unforked_elements;
	vector<vcCPElement*> unjoined_elements;
	for(int idx = 0; idx < _elements.size(); idx++)
	{
		vcCPElement* ele = _elements[idx];

		bool has_implicit_predecessor = false;
		if(ele->Is_Transition() && (((vcTransition*)ele)->Get_Is_Bound_As_Input_To_Region() || 
					((vcTransition*)ele)->Get_Is_Input() || 
					((vcTransition*)ele)->Get_Is_Bound_As_Output_From_CP_Function()) )
			has_implicit_predecessor = true;

		if(ele->Get_Has_Null_Predecessor())
			has_implicit_predecessor = true;

		if(!has_implicit_predecessor)
		{
			if(ele->Get_Predecessors().size() == 0)
				unforked_elements.push_back(ele);
		}


		// all elements if not joined to something inside the block, are joined to exit.
		bool has_implicit_successor = false;
		if(ele->Is_Transition() && ( ((vcTransition*)ele)->Get_Is_Bound_As_Input_To_CP_Function() ||
					((vcTransition*)ele)->Get_Is_Bound_As_Output_From_Region() ) )
			has_implicit_successor = true;

		if(ele->Get_Has_Null_Successor())
			has_implicit_successor = true;

		if(!has_implicit_successor)
		{
			if(ele->Get_Successors().size() == 0)
				unjoined_elements.push_back(ele);	
		}
	}


	// finally, those CPElements in the block which
	// are not forked from an explicitly specified fork
	// are assumed to be forked from $entry.
	if(unforked_elements.size() > 0)
	{
		for(int idx = 0; idx < unforked_elements.size(); idx++)
		{
			this->Add_Fork_Point(this->_entry,unforked_elements[idx]);

			/*
			 *  dangerous to put this in...   Can create a 
			 *marked->marked path which can overflow place capacity.
 			if(this->Is_Pipelined())
			{
				this->Add_Marked_Join_Point(this->_entry,1, unforked_elements[idx]); 
			}
			*/
		}
	}

	// finally, those CPElements in the block which
	// are not joined at an explicitly specified join
	// are assumed to join at $exit.
	if(unjoined_elements.size() > 0)
	{
		for(int idx = 0; idx < unjoined_elements.size(); idx++)
		{
			this->Add_Join_Point(this->_exit, unjoined_elements[idx]);
		}
	}

	if(this->_exit->Get_Predecessors().size() == 0 || this->_entry->Get_Successors().size() == 0)
	{
		// will take care of both sides..
		this->Add_Fork_Point(this->_entry, this->_exit);
	}

}


vcCPPipelinedForkBlock::vcCPPipelinedForkBlock(vcCPBlock* parent, string id): vcCPForkBlock(parent, id)
{
	_max_iterations_in_flight = 1;
}


void vcCPPipelinedForkBlock::Add_Marked_Join_Point(string& join_name, vector<string>& join_cpe_vec, vector<int>& join_markings)
{

	// length of the two should be the same..
	assert(join_cpe_vec.size() == join_markings.size());

	bool null_join = false;

	// null marked joins are ignored.
	if(join_name == "$null")
		return;

	vcCPElement* jp = this->Find_CPElement(join_name);
	if(jp == NULL)
		vcSystem::Error("did not find fork point " + join_name);
	else if(!jp->Is("vcTransition"))
		vcSystem::Error("fork point " + join_name + " is not a transition");
	else
	{
		for(int idx = 0; idx < join_cpe_vec.size(); idx++)
		{
			vcCPElement* jre = this->Find_CPElement(join_cpe_vec[idx]);
			if(jre == NULL)
			{
				vcSystem::Error("did not find joined region " + join_cpe_vec[idx]);
				return;
			}
			else
				this->Add_Marked_Join_Point((vcTransition*)jp,join_markings[idx], jre);
		}
	}
}

void vcCPPipelinedForkBlock::Add_Marked_Join_Point(vcTransition* jp, int join_marking,  vcCPElement* jre)
{

	if((this->_marked_join_map.find(jp) == this->_marked_join_map.end())
			||
			(this->_marked_join_map[jp].find(jre) == this->_marked_join_map[jp].end()))
	{
		this->_marked_join_map[((vcTransition*)jp)].insert(jre);

		jp->Add_Marked_Predecessor(jre); jp->Set_Marked_Predecessor_Delay(jre, join_marking);
		jre->Add_Marked_Successor(jp); jre->Set_Marked_Successor_Delay(jp, join_marking);
	}
}

void vcCPPipelinedForkBlock::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__PIPELINEDFORKBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
	this->Print_Elements(ofile);
	this->Print_Forks_And_Joins(ofile);
	ofile << "}" << endl;
	this->Print_Exports(ofile);
}

void vcCPPipelinedForkBlock::Print_VHDL_Export_Cleanup(ostream& ofile)
{
	vcCPElement* prnt = this->Get_Parent();
	if(prnt != NULL)
		prnt->Print_VHDL_Bindings(NULL,ofile);
}

void vcCPPipelinedForkBlock::Print_VHDL(ostream& ofile)
{
	this->vcCPBlock::Print_VHDL(ofile);
}


// same algorithm as in the parallel block case..  All elements
// are potentially active in parallel (this is a bit conservative)
void vcCPPipelinedForkBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* cp)
{
	this->Set_Compatibility_Label(in_label);
	this->_entry->Set_Compatibility_Label(in_label);

	if(this->_elements.size() > 1)
	{
		for(int idx = 0; idx < this->_elements.size(); idx++)
		{
			string hid = this->Get_Hierarchical_Id();
			if(hid == "")
				hid = this->Get_Id();

			string id = cp->Get_Id() + "/" +  hid + "[" + IntToStr(idx) + "]";
			vcCompatibilityLabel* nl = cp->Make_Compatibility_Label(id);

			pair<vcTransition*,int> p(this->_entry,idx);
			nl->Add_In_Arc(in_label,p);
			this->_elements[idx]->Compute_Compatibility_Labels(nl,cp);
		}
	}
	else if(this->_elements.size() == 1)
		this->_elements[0]->Compute_Compatibility_Labels(in_label,cp);

	this->_exit->Set_Compatibility_Label(in_label);
}


void vcCPPipelinedForkBlock::Remove_Redundant_Reenable_Arcs(map<vcCPElement*,map<vcCPElement*,int> >& distance_map)
{
	// If (v,u) and (w,u) are two reenable arcs
	// and distance[v][w] > 0 and delay(v,u) <= delay(w,u)
	// then (v,u) is redundant.
	for(map<vcCPElement*,map<vcCPElement*,int> >::iterator iter = distance_map.begin(),
			fiter = distance_map.end(); iter != fiter; iter++)
	{
		vcCPElement* u = (*iter).first;
		set<vcCPElement*> survivors;
		set<vcCPElement*> evict_set;

		for(int idx = 0, fidx = u->Get_Number_Of_Marked_Predecessors();
				idx  < fidx;
				idx++)
		{
			vcCPElement* v = u->Get_Marked_Predecessor(idx);
			int mv = u->Get_Marked_Predecessor_Delay(v);

			bool insert_v = true;
			vector<vcCPElement*> del_vec;
			for(set<vcCPElement*>::iterator niter = survivors.begin(),
					fniter = survivors.end();
					niter != fniter;
					niter++)
			{
				bool evict_w = false;
				vcCPElement* w = *niter;
				int mw = u->Get_Marked_Predecessor_Delay(w);

				if((distance_map[v][w] > 0) && (mv <= mw))
				{
					insert_v = false;
					break;
				}
				if((distance_map[w][v] > 0) && (mw <= mv))
					evict_w = true;

				if(evict_w)
				{
					del_vec.push_back(w);
					evict_set.insert(w);
				}
			}

			if(del_vec.size() > 0)
			{
				for(int J = 0, fJ = del_vec.size(); J < fJ; J++)
				{
					survivors.erase(del_vec[J]);
				}
				del_vec.clear();
			}

			if(insert_v)
				survivors.insert(v);
			else
				evict_set.insert(v);
		}

		for(set<vcCPElement*>::iterator eiter = evict_set.begin(), feiter = evict_set.end();				eiter != feiter;
				eiter++)
		{
			vcCPElement* v = *eiter;
			u->Remove_Marked_Predecessor(v);
			v->Remove_Marked_Successor(u);

			vcSystem::_number_of_marked_arcs_saved += 1;

			if(vcSystem::_verbose_flag)
				vcSystem::Info("removed redundant marked link: " + u->Get_Label() + " o<-& "
						+ v->Get_Label());
		}
	}

	this->Remove_Redundant_Reenable_Arcs_Pass2(distance_map);
}


//
// Look to get rid of redundant self-reenable arcs.
//
void vcCPPipelinedForkBlock::Remove_Redundant_Reenable_Arcs_Pass2(map<vcCPElement*,map<vcCPElement*,int> >& distance_map)
{
	// If (u,v) and (u,w) are two marked arcs such that
	// distance[w][v] > 0, then (u,v) can be dropped.
	for(map<vcCPElement*,map<vcCPElement*,int> >::iterator iter = distance_map.begin(),
			fiter = distance_map.end(); iter != fiter; iter++)
	{
		vcCPElement* u = (*iter).first;
		vector<vcCPElement*> marked_successors;

		int N = u->Get_Number_Of_Marked_Successors();

		for(int idx = 0, fidx = N; idx  < fidx; idx++)
		{
			vcCPElement* v = u->Get_Marked_Successor(idx);
			marked_successors.push_back(v);
		}

		// Look to drop one arc.
		int I,J;
		int drop_one = 0;
		vcCPElement* evicted_element = NULL;
		for(I = 0; I < N; I++)
		{
			vcCPElement* x = marked_successors[I];
			for(J = 0; J < N; J++)
			{
				if(I != J) 
				{
					vcCPElement* y = marked_successors[J];
					if (distance_map[y][x] > 0)
					{ 
						// (u,x) can be dropped!
						drop_one = 1;
						evicted_element = x;
						break;
					}
				}
			}

			if(drop_one)
				break;
		}

		if(drop_one)
			// erase that one
		{
			u->Remove_Marked_Successor(evicted_element);
			evicted_element->Remove_Marked_Predecessor(u);
			vcSystem::_number_of_marked_arcs_saved += 1;

			if(vcSystem::_verbose_flag)
				vcSystem::Info("removed redundant marked link: " + 
						evicted_element->Get_Label() + " o<-& "
						+ u->Get_Label());
		}
	}
}

void vcCPPipelinedForkBlock::Remove_Redundant_Arcs(map<vcCPElement*,map<vcCPElement*,int> >& distance_map)
{
	this->Remove_Redundant_Reenable_Arcs(distance_map);
	this->vcCPForkBlock::Remove_Redundant_Arcs(distance_map);
}

void vcCPPipelinedForkBlock::Add_Exported_Input(string internal_id)
{
	this->Add_Export(internal_id, true);
}


void vcCPPipelinedForkBlock::Add_Exported_Output(string internal_id)
{
	this->Add_Export(internal_id, false);
}


void vcCPPipelinedForkBlock::Add_Export(string internal_id, bool input_flag)
{
	vcCPElement* jp = this->Find_CPElement(internal_id);
	if(jp == NULL)
	{
		vcSystem::Error("did not find export transition " + jp->Get_Id());
		return;
	}

	if(!jp->Is_Transition())
	{
		vcSystem::Error("export control-element must be a transition: " + jp->Get_Id());
		return;
	}

	if(input_flag)
		_exported_inputs.insert((vcTransition*)jp);
	else
		_exported_outputs.insert((vcTransition*)jp);

}

void vcCPPipelinedForkBlock::Eliminate_Redundant_Dependencies()
{

	this->vcCPForkBlock::Eliminate_Redundant_Dependencies();
}

void vcCPPipelinedForkBlock::Print_Forks_And_Joins(ostream& ofile)
{
	for(map<vcTransition*,set<vcCPElement*>,vcRoot_Compare>::iterator iter = _fork_map.begin();
			iter != _fork_map.end();
			iter++)
	{
		ofile << (*iter).first->Get_Id() << " " << 
			vcLexerKeywords[__FORK] << " (" ;
		for(set<vcCPElement*>::iterator siter = (*iter).second.begin(), sfiter = (*iter).second.end();
				siter != sfiter;
				siter++)
		{
			ofile << " " << (*siter)->Get_Id() << " ";
		}
		ofile << ")" << endl;
	}


	for(map<vcTransition*,set<vcCPElement*>,vcRoot_Compare>::iterator iter = _join_map.begin();
			iter != _join_map.end();
			iter++)
	{
		ofile <<  (*iter).first->Get_Id() << " " << 
			vcLexerKeywords[__JOIN] << " (" ;
		for(set<vcCPElement*>::iterator siter = (*iter).second.begin(), sfiter = (*iter).second.end();
				siter != sfiter;
				siter++)
		{
			ofile << " " << (*siter)->Get_Id() << " ";
		}
		ofile << ")" << endl;
	}

	for(map<vcTransition*,set<vcCPElement*>,vcRoot_Compare>::iterator iter = _marked_join_map.begin();
			iter != _marked_join_map.end();
			iter++)
	{
		vcTransition* u = (*iter).first;
		ofile <<  (*iter).first->Get_Id() << " " << 
			vcLexerKeywords[__MARKEDJOIN] << " (" ;
		for(set<vcCPElement*>::iterator siter = (*iter).second.begin(), sfiter = (*iter).second.end();
				siter != sfiter;
				siter++)
		{
			ofile << " " << (*siter)->Get_Id() << " ";
			// print the join delays.
			ofile << (*iter).first->Get_Marked_Predecessor_Delay(*siter) << " ";
		}
		ofile << ")" << endl;
	}

}

void vcCPPipelinedForkBlock::Print_Exports(ostream& ofile)
{
	// print mandatory exports.
	ofile << vcLexerKeywords[__LPAREN] << " ";
	for(set<vcTransition*>::iterator eiter = _exported_inputs.begin();
			eiter != _exported_inputs.end();
			eiter++)
	{
		ofile << (*eiter)->Get_Id() << " ";
	}
	ofile << vcLexerKeywords[__RPAREN] << endl;


	ofile << vcLexerKeywords[__LPAREN] << " ";
	for(set<vcTransition*>::iterator eiter = _exported_outputs.begin();
			eiter != _exported_outputs.end();
			eiter++)
	{
		ofile << (*eiter)->Get_Id() << " ";
	}
	ofile << vcLexerKeywords[__RPAREN] << endl;
}

////////////////////  pipelined loop-body.
vcCPPipelinedLoopBody::vcCPPipelinedLoopBody(vcCPBlock* parent, string id):vcCPPipelinedForkBlock(parent,id)
{
	assert(_parent->Is("vcCPSimpleLoopBlock"));

	// for now, keep it user-defined.
	// Aa2VC should figure it out (ideally)..
	_max_iterations_in_flight = ((vcCPSimpleLoopBlock*)parent)->Get_Pipeline_Depth();;

}

void vcCPPipelinedLoopBody::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__PIPELINE]  << " [" << this->Get_Id() << "] {" << endl;
	this->Print_Elements(ofile);
	this->Print_Forks_And_Joins(ofile);

	for(int idx = 0, fidx = _phi_sequencers.size(); idx < fidx; idx++)
		_phi_sequencers[idx]->Print(ofile);

	for(int idx = 0, fidx = _transition_merges.size(); idx < fidx; idx++)
		_transition_merges[idx]->Print(ofile);

	ofile << "}" << endl;

	assert(_exported_inputs.size() > 0);
	assert(_exported_outputs.size() > 0);

	this->Print_Exports(ofile);
	ofile << "\n// end pipelined-loop-body " << this->Get_Id() << endl << "}";
}


void vcCPPipelinedLoopBody::Print_VHDL(ostream& ofile)
{

	// the same stuff as in vcCPBlock::Print_VHDL with a bit of
	// specialization..
	string id = this->Get_Hierarchical_Id();

	// declare all exit flags.
	ofile << this->Get_VHDL_Id() << ": Block -- " << id << " {" << endl;
	this->Print_VHDL_Signal_Declarations(ofile);

	ofile << "-- }" << endl << "begin -- {" << endl;

	// print control transfers from and to places in parent.
	vcCPElement* prnt = this->Get_Parent();
	assert(prnt->Is("vcCPSimpleLoopBlock"));
	prnt->Print_VHDL_Bindings(NULL,ofile);

	this->_entry->Print_VHDL(ofile);
	for(int idx = 0; idx < this->_elements.size(); idx++)
	{
		this->_elements[idx]->Print_VHDL(ofile);
	}

	// print phi-sequencers 
	for(int idx = 0, fidx = _phi_sequencers.size(); idx < fidx; idx++)
		_phi_sequencers[idx]->Print_VHDL(NULL,ofile);

	// print sequencers and transition merges.
	for(int idx = 0, fidx = _transition_merges.size(); idx < fidx; idx++)
		_transition_merges[idx]->Print_VHDL(NULL,ofile);

	this->_exit->Print_VHDL(ofile);
	this->Print_VHDL_Exit_Symbol_Assignment(ofile);



	ofile << "-- }" << endl << "end Block; -- " << id << endl;
}

// A bit of a heavy function.. But the phi-sequencer hides a lot 
// of ugliness.
void vcCPPipelinedLoopBody::Add_Phi_Sequencer(string& phi_id, 
		vector<string>& triggers, 
		vector<string>& src_sample_reqs, 
		vector<string>& src_sample_acks, 
		vector<string>& src_update_reqs, 
		vector<string>& src_update_acks, 
		string& phi_sample_req,
		string& phi_sample_ack,
		string& phi_update_req,
		string& phi_update_ack,
		vector<string>& phi_mux_reqs,
		string& phi_mux_ack)
{

	vcPhiSequencer* new_phi_seq = new vcPhiSequencer(this, phi_id);
	new_phi_seq->Set_Place_Capacity(this->Get_Max_Iterations_In_Flight());

	assert(triggers.size() == src_sample_reqs.size());
	assert(triggers.size() == src_sample_acks.size());
	assert(triggers.size() == src_update_reqs.size());
	assert(triggers.size() == src_update_acks.size());
	assert(triggers.size() == phi_mux_reqs.size());

	// add per-trigger stuff.
	for(int idx = 0, fidx = triggers.size(); idx < fidx; idx++)
	{
		vcCPElement* ste = this->Find_CPElement(triggers[idx]);
		if((ste == NULL) || (!ste->Is_Transition()))
		{
			vcSystem::Error("Trigger " + triggers[idx] + " transition not found in " + this->Get_Id());
			delete new_phi_seq;
			return;
		}
		new_phi_seq->Add_Trigger((vcTransition*) ste);
		((vcTransition*) ste)->Set_Is_Bound_As_Input_To_CP_Function(true);
		ste->Set_Associated_CP_Function(new_phi_seq);

		vcCPElement* rte = this->Find_CPElement(src_sample_reqs[idx]);
		if((rte == NULL) || (!rte->Is_Transition()))
		{
			vcSystem::Error("Sample-Req " + src_sample_reqs[idx] + " transition not found in " + this->Get_Id());
			delete new_phi_seq;
			return;
		}
		new_phi_seq->Add_Src_Sample_Req((vcTransition*) rte);
		((vcTransition*) rte)->Set_Is_Bound_As_Output_From_CP_Function(true);
		rte->Set_Associated_CP_Function(new_phi_seq);

		rte = this->Find_CPElement(src_update_reqs[idx]);
		if((rte == NULL) || (!rte->Is_Transition()))
		{
			vcSystem::Error("Update-Req " + src_update_reqs[idx] + " transition not found in " + this->Get_Id());
			delete new_phi_seq;
			return;
		}
		new_phi_seq->Add_Src_Update_Req((vcTransition*) rte);
		((vcTransition*) rte)->Set_Is_Bound_As_Output_From_CP_Function(true);
		rte->Set_Associated_CP_Function(new_phi_seq);

		rte = this->Find_CPElement(phi_mux_reqs[idx]);
		if((rte == NULL) || (!rte->Is_Transition()))
		{
			vcSystem::Error("Phi-Mux-Req " + phi_mux_reqs[idx] + " transition not found in " + this->Get_Id());
			delete new_phi_seq;
			return;
		}
		new_phi_seq->Add_Phi_Mux_Req((vcTransition*) rte);
		((vcTransition*) rte)->Set_Is_Bound_As_Output_From_CP_Function(true);
		rte->Set_Associated_CP_Function(new_phi_seq);

		rte = this->Find_CPElement(src_sample_acks[idx]);
		if((rte == NULL) || (!rte->Is_Transition()))
		{
			vcSystem::Error("Sample-Ack " + src_sample_acks[idx] + " transition not found in " + this->Get_Id());
			delete new_phi_seq;
			return;
		}
		new_phi_seq->Add_Src_Sample_Ack((vcTransition*) rte);
		((vcTransition*) rte)->Set_Is_Bound_As_Input_To_CP_Function(true);
		rte->Set_Associated_CP_Function(new_phi_seq);


		rte = this->Find_CPElement(src_update_acks[idx]);
		if((rte == NULL) || (!rte->Is_Transition()))
		{
			vcSystem::Error("Update-Ack " + src_update_acks[idx] + " transition not found in " + this->Get_Id());
			delete new_phi_seq;
			return;
		}
		new_phi_seq->Add_Src_Update_Ack((vcTransition*) rte);
		((vcTransition*) rte)->Set_Is_Bound_As_Input_To_CP_Function(true);
		rte->Set_Associated_CP_Function(new_phi_seq);
	}

	vcCPElement* psr = this->Find_CPElement(phi_sample_req);
	if((psr == NULL) || (!psr->Is_Transition()))
	{
		vcSystem::Error("Phi-Sample-Req " + phi_sample_req + " transition not found in " + this->Get_Id());
		delete new_phi_seq;
		return;
	}
	new_phi_seq->Set_Phi_Sample_Req((vcTransition*) psr);
	((vcTransition*) psr)->Set_Is_Bound_As_Input_To_CP_Function(true);
	psr->Set_Associated_CP_Function(new_phi_seq);

	vcCPElement* pur = this->Find_CPElement(phi_update_req);
	if((pur == NULL) || (!pur->Is_Transition()))
	{
		vcSystem::Error("Phi-Update-Req " + phi_update_req + " transition not found in " + this->Get_Id());
		delete new_phi_seq;
		return;
	}
	new_phi_seq->Set_Phi_Update_Req((vcTransition*) pur);
	((vcTransition*) pur)->Set_Is_Bound_As_Input_To_CP_Function(true);
	pur->Set_Associated_CP_Function(new_phi_seq);

	vcCPElement* psc = this->Find_CPElement(phi_sample_ack);
	if((psc == NULL) || (!psc->Is_Transition()))
	{
		vcSystem::Error("Phi-Sample-Ack " + phi_sample_ack + " transition not found in " + this->Get_Id());
		delete new_phi_seq;
		return;
	}
	new_phi_seq->Set_Phi_Sample_Ack((vcTransition*) psc);
	((vcTransition*) psc)->Set_Is_Bound_As_Output_From_CP_Function(true);
	psc->Set_Associated_CP_Function(new_phi_seq);

	vcCPElement* puc = this->Find_CPElement(phi_update_ack);
	if((puc == NULL) || (!puc->Is_Transition()))
	{
		vcSystem::Error("Phi-Update-Ack " + phi_update_ack + " transition not found in " + this->Get_Id());
		delete new_phi_seq;
		return;
	}
	new_phi_seq->Set_Phi_Update_Ack((vcTransition*) puc);
	((vcTransition*) puc)->Set_Is_Bound_As_Output_From_CP_Function(true);
	puc->Set_Associated_CP_Function(new_phi_seq);

	// set done.
	vcCPElement* dte = this->Find_CPElement(phi_mux_ack);
	if((dte == NULL) || (!dte->Is_Transition()))
	{
		vcSystem::Error("Phi-mux-ack " + phi_mux_ack + " transition not found in " + this->Get_Id());
		delete new_phi_seq;
		return;
	}
	new_phi_seq->Set_Phi_Mux_Ack((vcTransition*) dte);
	((vcTransition*) dte)->Set_Is_Bound_As_Input_To_CP_Function(true);
	dte->Set_Associated_CP_Function(new_phi_seq);

	_phi_sequencers.push_back(new_phi_seq);
}


  
void vcPhiSequencer::Append_Zero_Delay_Successors(vcTransition* t, set<vcCPElement*>& zero_delay_successors)
{
	for(int I = 0, fI = _triggers.size(); I  < fI; I++)
	{
		if(t == _triggers[I])
		{
			zero_delay_successors.insert(_src_sample_reqs[I]);
			zero_delay_successors.insert(_src_update_reqs[I]);
		}

		if(t == _src_sample_acks[I])
		{
			zero_delay_successors.insert(_phi_sample_ack);
		}

		if(t == _src_update_acks[I])
		{
			zero_delay_successors.insert(_phi_mux_reqs[I]);
		}
	
		if(t == _phi_mux_ack)
		{
			zero_delay_successors.insert(_phi_update_ack);
		}

	}

	if(t == _phi_sample_req)
	{
		for(int I = 0, fI = _triggers.size(); I  < fI; I++)
		{
			zero_delay_successors.insert(_src_sample_reqs[I]);
		}
	}

	if(t == _phi_update_req)
	{
		for(int I = 0, fI = _triggers.size(); I  < fI; I++)
		{
			zero_delay_successors.insert(_src_update_reqs[I]);
		}
	}
}



void vcCPPipelinedLoopBody::Add_Transition_Merge(string& tm_id, vector<string>& in_transitions, string& out_transition)
{

	vcTransitionMerge* new_tm = new vcTransitionMerge(this, tm_id);
	for(int idx = 0, fidx = in_transitions.size(); idx < fidx; idx++)
	{
		vcCPElement* rte = this->Find_CPElement(in_transitions[idx]);
		if((rte == NULL) || (!rte->Is_Transition()))
		{
			vcSystem::Error("TMerge In-transition " + in_transitions[idx] + " transition not found in " + this->Get_Id());
			delete new_tm;
			return;
		}
		new_tm->Add_In_Transition((vcTransition*) rte);
		((vcTransition*) rte)->Set_Is_Bound_As_Input_To_CP_Function(true);
		rte->Set_Associated_CP_Function(new_tm);
	}

	vcCPElement* ote = this->Find_CPElement(out_transition);
	if((ote == NULL) || (!ote->Is_Transition()))
	{
		vcSystem::Error("TMerge Out-transition " + out_transition + " transition not found in " + this->Get_Id());
		delete new_tm;
		return;
	}
	new_tm->Set_Out_Transition((vcTransition*) ote);
	((vcTransition*) ote)->Set_Is_Bound_As_Output_From_CP_Function(true);
	ote->Set_Associated_CP_Function(new_tm);

	_transition_merges.push_back(new_tm);
}

void vcCPPipelinedLoopBody::Update_Predecessor_Successor_Links()
{
	// the predecessor-successor relations are similar to
	// those in the fork-block case, except for the addition of
	// the phi-sequencers and transition-merges, which alter
	// it somewhat.
	this->vcCPPipelinedForkBlock::Update_Predecessor_Successor_Links();

	// the phi-sequencers..
	for(int idx = 0, fidx = _phi_sequencers.size(); idx < fidx; idx++)
		_phi_sequencers[idx]->Update_Predecessor_Successor_Links();


	// the transition-merges.
	for(int idx = 0, fidx = _transition_merges.size(); idx < fidx; idx++)
		_transition_merges[idx]->Update_Predecessor_Successor_Links();

}




//////////////////////////////   control path.

vcControlPath::vcControlPath(string id):vcCPSeriesBlock(NULL, id)
{
	_is_pipelined = false;
	_pipeline_depth = 1;
	_pipeline_buffering = 1;
	_pipeline_full_rate_flag = false;
	_parent_module = NULL;
}


void  vcControlPath::Set_Parent_Module(vcModule* m) 
{
	_parent_module = m;
}


// some thought here.. named transitions must be unique.
vcTransition* vcControlPath::Find_Transition(vector<string>& hier_id)
{
	vcCPElement* cpe = this;
	for(int idx = 0; idx < hier_id.size(); idx++)
	{
		cpe = cpe->Find_CPElement(hier_id[idx]);
		if(cpe == NULL)
			break;
	}

	if(cpe != NULL && cpe->Is("vcTransition"))
		return((vcTransition*)cpe);
	else
		return(NULL);
}

vcPlace* vcControlPath::Find_Place(vector<string>& hier_id)
{

	vcCPElement* cpe = this;
	for(int idx = 0; idx < hier_id.size(); idx++)
	{
		cpe = cpe->Find_CPElement(hier_id[idx]);
		if(cpe == NULL)
			break;
	}

	if(cpe != NULL && cpe->Is("vcPlace"))
		return((vcPlace*)cpe);
	else
		return(NULL);
}

void vcControlPath::Update_Predecessor_Successor_Links()
{
	if(this->_is_pipelined)
	{
		// ignore places, and attach pipelined-fork region
		// between this->_entry and this->_exit.
		for(int idx = 0; idx < this->_elements.size(); idx++)
		{
			vcCPElement* cpe = this->_elements[idx];
			if(cpe->Is("vcCPPipelinedForkBlock"))
			{
				this->_entry->Add_Successor(cpe);
				cpe->Add_Predecessor(this->_entry);
				cpe->Add_Successor(this->_exit);
				this->_exit->Add_Predecessor(cpe);
			}
			else if(cpe->Is("vcPlace"))
			{
				cpe->Set_Is_Left_Open(true);
			}
		}

		this->vcCPBlock::Update_Predecessor_Successor_Links();
		this->vcCPBlock::Update_Binding_Predecessor_Successor_Links();	
	}
	else
	{
		this->vcCPSeriesBlock::Update_Predecessor_Successor_Links();
	}
}

void vcControlPath::Print(ostream& ofile)
{
	ofile << vcLexerKeywords[__CONTROLPATH] << " {" << endl;
	this->Print_Elements(ofile);
	this->Print_Attributes(ofile);
	ofile << "\n// end controlpath" << endl << "}" << endl;
}


void vcControlPath::Mark_As_Compatible(set<vcCompatibilityLabel*>& uset, set<vcCompatibilityLabel*>& vset)
{
	for(set<vcCompatibilityLabel*>::iterator iter = uset.begin(), fiter = uset.end();
			iter != fiter;
			iter++)
	{
		for(set<vcCompatibilityLabel*>::iterator iter2 = vset.begin(), fiter2 = vset.end();
				iter2 != fiter2;
				iter2++)
		{
			_compatible_label_map[(*iter)].insert(*iter2);
		}
	}
}



void vcControlPath::Update_Compatibility_Map()
{
	vector<vcCompatibilityLabel*> labels;
	// for each label u
	//    look at the successor set succ(u).
	//        If w,x are two successors of u with unlabeled inarcs
	//        then  w,x are compatible.
	// 
	for(set<vcCompatibilityLabel*>::iterator iter = this->_compatibility_label_set.begin();
			iter != this->_compatibility_label_set.end();
			iter++)
	{
		labels.push_back(*iter);

		map<vcTransition*, set<vcCompatibilityLabel*> > fork_map;
		// for each label u
		vcCompatibilityLabel* u = (*iter);
		for(int idx = 0, fidx = u->Get_Number_Of_Successors(); idx < fidx; idx++)
		{
			// look at all successors
			vcCompatibilityLabel* w = (vcCompatibilityLabel*)(u->Get_Successor(idx));

			if(w->_labeled_in_arc.second.first != NULL)
			{
				// w and all its descendents are kept in fork_map
				// entry for the fork.
				fork_map[w->_labeled_in_arc.second.first].insert(w);
				fork_map[w->_labeled_in_arc.second.first].insert(_label_descendent_map[w].begin(),
						_label_descendent_map[w].end());
			}
		}

		for(map<vcTransition*,set<vcCompatibilityLabel*> >::iterator citer = fork_map.begin(),
				cfiter = fork_map.end();
				citer != cfiter;
				citer++)
		{
			map<vcTransition*,set<vcCompatibilityLabel*> >::iterator niter = citer;
			niter++;

			for(; niter != cfiter; niter++)
			{
				this->Mark_As_Compatible((*citer).second, (*niter).second);
			}
		}
	}

	// unlabeled arc condition.  For each pair u,v, see if u has an ancestor w
	// through an unlabeled arc such that path from w->u starts with an
	// unlabeled edge and w is a nearest common ancestor of u and v.
	int uindex, vindex;
	for(uindex = 0; uindex < labels.size(); uindex++)
	{
		vcCompatibilityLabel* u = labels[uindex];
		for(vindex = uindex+1; vindex < labels.size(); vindex++)
		{
			vcCompatibilityLabel* v = labels[vindex];
			if(!this->Are_Compatible(u,v))
			{
				set<vcCompatibilityLabel*> visited_set;
				if(Look_Back_For_Compatibility(u,v,visited_set))
				{
					_compatible_label_map[u].insert(v);
					if(vcSystem::_verbose_flag)
					{
						string info_str = u->Get_Id() + ",  " + v->Get_Id() + 
							" found to be compatible through lookback search";
						vcSystem::Info(info_str);
					}
				}
				visited_set.clear();
			}
		}
	}
}


bool vcControlPath::Look_Back_For_Compatibility(vcCompatibilityLabel* from_here, 
		vcCompatibilityLabel* check_against,
		set<vcCompatibilityLabel*>& visited_set)
{
	bool ret_flag = false;
	for(set<vcCompatibilityLabel*>::iterator iter = from_here->_unlabeled_in_arcs.begin(), fiter = from_here->_unlabeled_in_arcs.end();
			iter != fiter;
			iter++)
	{

		vcCompatibilityLabel* upred = (*iter);
		if(visited_set.find(upred) == visited_set.end())
		{
			if(this->_label_descendent_map[upred].find(check_against) == this->_label_descendent_map[upred].end())
			{
				visited_set.insert(upred);
				if(Look_Back_For_Compatibility(upred,check_against,visited_set))
					return(true);
			}
			else
				return(true);
		}
	}

	vcCompatibilityLabel* lpred = from_here->_labeled_in_arc.first;
	if(lpred != NULL)
	{
		if(this->_label_descendent_map[lpred].find(check_against) == this->_label_descendent_map[lpred].end())
		{
			if(Look_Back_For_Compatibility(lpred,check_against,visited_set))
				return(true);
		}
	}

	return(false);
}

void vcControlPath::Print_Compatibility_Map(ostream& ofile)
{
	ofile << "Label Compatibility Map: { " << endl;
	for(map<vcCompatibilityLabel*,set<vcCompatibilityLabel*> >::iterator iter = _compatible_label_map.begin(),
			fiter = _compatible_label_map.end();
			iter != fiter;
			iter++)
	{
		for(set<vcCompatibilityLabel*>::iterator siter = (*iter).second.begin(),
				sfiter = (*iter).second.end();
				siter != sfiter;
				siter++)
		{
			ofile << (*iter).first->Get_Id() << " === " << (*siter)->Get_Id() << endl;
		}
	}

	for(map<vcCompatibilityLabel*,set<vcCompatibilityLabel*> >::iterator iter = _label_descendent_map.begin(),
			fiter = _label_descendent_map.end();
			iter != fiter;
			iter++)
	{
		for(set<vcCompatibilityLabel*>::iterator siter = (*iter).second.begin(),
				sfiter = (*iter).second.end();
				siter != sfiter;
				siter++)
		{
			ofile << (*iter).first->Get_Id() << " >== " << (*siter)->Get_Id() << endl;
		}
	}
	ofile << "}" << endl;

}

void vcControlPath::Compute_Compatibility_Labels()
{
	vcCompatibilityLabel* nl = this->Make_Compatibility_Label(this->Get_Id());
	this->vcCPSeriesBlock::Compute_Compatibility_Labels(nl,this);

	this->Connect_Compatibility_Labels();
	this->Update_Compatibility_Map();
}

void vcControlPath::Connect_Compatibility_Labels()
{

	// set up connectivity
	for(set<vcCompatibilityLabel*>::iterator iter = this->_compatibility_label_set.begin();
			iter != this->_compatibility_label_set.end();
			iter++)
	{
		if((*iter)->_labeled_in_arc.first != NULL)
		{
			(*iter)->_labeled_in_arc.first->Add_Successor((*iter));
			(*iter)->Add_Predecessor((*iter)->_labeled_in_arc.first);
		}
		else 
		{
			for(set<vcCompatibilityLabel*>::iterator siter = (*iter)->_unlabeled_in_arcs.begin();
					siter != (*iter)->_unlabeled_in_arcs.end();
					siter++)
			{
				(*iter)->Add_Predecessor((*siter));
				(*siter)->Add_Successor((*iter));
			}
		}
	}

	// check that there is exactly one vertex of out-degree 1.
	vcCompatibilityLabel* source = NULL;
	for(set<vcCompatibilityLabel*>::iterator iter = this->_compatibility_label_set.begin();
			iter != this->_compatibility_label_set.end();
			iter++)
	{
		if((*iter)->Get_Number_Of_Predecessors() == 0)
		{
			if(source != NULL)
				vcSystem::Error("Multiple source labels in compatibility graph \n");
			assert(source == NULL && "more than one source in compatibility label graph?");
			source = (*iter);
		}
	}

	// now check that all labels are reachable from the source
	// and that there is no cycle.
	bool cycle_flag = false;
	int num_visited = 0;
	vector<vcCPElement*> dfs_ordered_elements;
	set<vcCPElement*> v_set;
	this->vcCPBlock::DFS_Order(false, (vcCPElement*) source, cycle_flag, num_visited,dfs_ordered_elements,v_set);
	if(cycle_flag)
	{
		vcSystem::Error("Cycle in compatibility label graph\n");
	}
	if(num_visited != this->_compatibility_label_set.size())
	{
		vcSystem::Error("Some compatibility labels are not reachable from the source label\n");
	}

	// now build the descendant maps.
	// transitive closure..
	v_set.clear();
	this->vcCPBlock::BFS_Order(false, (vcCPElement*) source,num_visited, this->_bfs_ordered_labels,v_set);
	for(int hidx = this->_bfs_ordered_labels.size(); hidx > 0; hidx--)
	{
		int idx = hidx-1;

		vcCompatibilityLabel* u = (vcCompatibilityLabel*) (this->_bfs_ordered_labels[idx]);
		set<vcCompatibilityLabel*>& adj_set = this->_label_descendent_map[u];
		adj_set.insert(u);

		for(int adjidx = 0; adjidx < u->Get_Number_Of_Successors(); adjidx++)
		{
			adj_set.insert(this->_label_descendent_map[((vcCompatibilityLabel*)(u->Get_Successor(adjidx)))].begin(),
					this->_label_descendent_map[((vcCompatibilityLabel*) (u->Get_Successor(adjidx)))].end());
		}
	}

}

bool vcControlPath::Are_Compatible(vcCompatibilityLabel* u, vcCompatibilityLabel* v)
{
	if(u == v)
		return(true);
	else if(this->_label_descendent_map[u].find(v) != this->_label_descendent_map[u].end())
		return(true);
	else if(this->_label_descendent_map[v].find(u) != this->_label_descendent_map[v].end())
		return(true);
	else if(this->_compatible_label_map[u].find(v) != this->_compatible_label_map[u].end())
		return(true);
	else if(this->_compatible_label_map[v].find(u) != this->_compatible_label_map[v].end())
		return(true);
	else
		return(false);
}

bool vcControlPath::Are_Compatible(vector<vcCompatibilityLabel*>& l1, vector<vcCompatibilityLabel*>& l2)
{
	bool ret_val = true;
	for(int i = 0, i_f = l1.size() ; i < i_f; i++)
	{
		vcCompatibilityLabel* u = l1[i];
		for(int j = 0, j_f = l1.size() ; j < j_f; j++)
		{
			vcCompatibilityLabel* v = l2[i];
			if(!this->Are_Compatible(u,v))
			{
				ret_val = false;
				break;
			}
		}
	}
	return(ret_val);
}

bool vcControlPath::Lesser(vcCompatibilityLabel* u, vcCompatibilityLabel* v)
{
	return(this->_label_descendent_map[u].find(v) != this->_label_descendent_map[u].end());
}

bool vcControlPath::Greater(vcCompatibilityLabel* v, vcCompatibilityLabel* u)
{
	return(this->_label_descendent_map[u].find(v) != this->_label_descendent_map[u].end());
}


vcCompatibilityLabel* vcControlPath::Make_Compatibility_Label(string id)
{

#ifndef DEBUG
	id = "cL" + Int64ToStr(vcControlPath::_free_index);
#endif 

	vcCompatibilityLabel* nl = new vcCompatibilityLabel(this,id);
	this->_compatibility_label_set.insert(nl);
	return(nl);
}

void vcControlPath::Delete_Compatibility_Label(vcCompatibilityLabel* nl)
{
	if(_compatibility_label_set.find(nl) != _compatibility_label_set.end())
	{
		_compatibility_label_set.erase(nl);
		delete nl;
	}
}

bool vcControlPath::Check_Structure()
{
	this->Update_Predecessor_Successor_Links();

	if(!this->_is_pipelined)
		this->vcCPSeriesBlock::Check_Structure();

	this->Construct_Reduced_Group_Graph();
    return true;
}

void vcControlPath::Print_Compatibility_Labels(ostream& ofile)
{
	ofile << "Label Summary " << endl;
	for(set<vcCompatibilityLabel*>::iterator iter = _compatibility_label_set.begin();
			iter != _compatibility_label_set.end();
			iter++)
	{
		ofile << "\t";
		(*iter)->Print(ofile);
		ofile << endl;
	}

	ofile << "Label Transitive Closure " << endl;
	for(map<vcCompatibilityLabel*, set<vcCompatibilityLabel*> >::iterator iter = this->_label_descendent_map.begin();
			iter != this->_label_descendent_map.end();
			iter++)
	{
		ofile <<  (*iter).first->Get_Id() << " ==> {" << endl;
		for(set<vcCompatibilityLabel*>::iterator siter = (*iter).second.begin();
				siter != (*iter).second.end();
				siter++)
		{
			ofile << "\t";
			ofile << (*siter)->Get_Id() << endl;
		}
		ofile << "}" << endl;
	}
}

bool vcCompatibilityLabel_Compare::operator() (vcCompatibilityLabel* u, vcCompatibilityLabel* v) const
{
	return(u->Get_Id() < v->Get_Id());
}

void vcControlPath::Print_VHDL_Start_Symbol_Assignment(ostream& ofile)
{
	// nothing to do..
}

void vcControlPath::Print_VHDL_Exit_Symbol_Assignment(ostream& ofile)
{
	ofile << this->Get_Exit_Symbol() <<  " <= " << this->_exit->Get_Exit_Symbol()   << ";" << endl;
}

void vcControlPath::Print_VHDL_Export_Cleanup(ostream& ofile)
{
	// input bindings.
	ofile << "--  hookup: inputs to control-path " << endl;
	for(map<vcPlace*,vcTransition*>::iterator biter = _input_bindings.begin(), fbiter = _input_bindings.end();
			biter != fbiter;
			biter++)
	{
		vcPlace* pl = (*biter).first;

		string pl_id = pl->Get_Exit_Symbol(NULL);
		string raw_id = To_VHDL(pl->Get_Id());

		ofile << pl_id << " <= " << raw_id  << ";" << endl;
	}

	ofile << "-- hookup: output from control-path " << endl;
	for(map<vcPlace*,vcTransition*>::iterator biter = _output_bindings.begin(), fbiter = _output_bindings.end();
			biter != fbiter;
			biter++)
	{
		vcPlace* pl = (*biter).first;

		string pl_id = pl->Get_Exit_Symbol(NULL);
		string raw_id = To_VHDL(pl->Get_Id());

		ofile << raw_id << " <= " << pl_id  << ";" << endl;
	}
}

void vcControlPathPipelined::Compute_Compatibility_Labels()
{
	vcCompatibilityLabel* in_label = this->Make_Compatibility_Label(this->Get_Id());

	this->Set_Compatibility_Label(in_label);
	this->_entry->Set_Compatibility_Label(in_label);

	if(this->_elements.size() > 1)
	{
		for(int idx = 0; idx < this->_elements.size(); idx++)
		{
			string hid = this->Get_Hierarchical_Id();
			if(hid == "")
				hid = this->Get_Id();

			string id = this->Get_Id() + "/" +  hid + "[" + IntToStr(idx) + "]";
			vcCompatibilityLabel* nl = this->Make_Compatibility_Label(id);

			pair<vcTransition*,int> p(this->_entry,idx);
			nl->Add_In_Arc(in_label,p);
			this->_elements[idx]->Compute_Compatibility_Labels(nl,this);
		}
	}
	else if(this->_elements.size() == 1)
		this->_elements[0]->Compute_Compatibility_Labels(in_label,this);

	this->_exit->Set_Compatibility_Label(in_label);

	this->Connect_Compatibility_Labels();
	this->Update_Compatibility_Map();
}


bool vcControlPathPipelined::Check_Structure()
{
	this->vcCPSeriesBlock::Update_Predecessor_Successor_Links();
	this->vcCPSeriesBlock::Check_Structure();
    return true;
}
