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
#include <AaProgram.h>
#include <Aa2VC.h>
#include <Aa2C.h>
#include <AaDelays.h>


//---------------------------------------------------------------------
// AaStatement
//---------------------------------------------------------------------
AaStatement::AaStatement(AaScope* p): AaScope(p) 
{
  this->_tab_depth = ((p != NULL) ? p->Get_Depth()+1 : 1);
  _index_in_sequence = -1;
  _guard_expression = NULL;
  _guard_complement = false;
  _pipeline_parent = NULL;
  _longest_path    = 2; // default value.
  _keep_flag = false;
}

AaStatement::~AaStatement() {};

void AaStatement::Mark_Statement(string mid, AaStatement* stmt)
{
	// TODO: check if stmt exists in block.
	if(!stmt->Get_Is_Volatile())
		_marked_statement_map[mid] = stmt;
	else
		AaRoot::Error("cannot put a mark on a volatile statement", stmt);

}


AaModule* AaStatement::Get_Module()
{
	AaScope* root_scope = this->Get_Root_Scope();
	if((root_scope != NULL) && (root_scope->Is("AaModule")))
		return((AaModule*) root_scope);
	else
		return(NULL);
}

bool AaStatement::Is_Part_Of_Pipelined_Module()
{
	AaScope* s = (this->Is_Module() ? this : this->Get_Scope());
	if(s && s->Is("AaModule") && ((AaModule*) s)->Is_Pipelined())
		return(true);
	else
		return(false);
}

bool AaStatement::Is_Part_Of_Fullrate_Pipeline()
{
	AaStatement* dws = this->Get_Pipeline_Parent();
	bool ret_val = ((dws != NULL)  && dws->Get_Pipeline_Full_Rate_Flag());
	return(ret_val);
}

string AaStatement::Tab()
{
  return(Tab_(this->Get_Tab_Depth()));
}

// Algorithm:
//  Find search-scope:
//  Find child in search-scope
//  if ref is array ref and child is null, throw error
//  if ref is array ref and child is not null, link target
//  if ref is not array ref
//       if child is null, go ahead and declare implicit variable
//       if child is not null
//            if child is declared object/iface, link to it and
//               check link count.
//            if child is not declared object/iface
//                if child is not from this->Get_Scope()
//                   declare implicit variable
//               else
//                   redeclaration error!
//
// Added: multiple writes to the same port are permitted
//        if the module to which the port belongs is 
//        a MACRO..
void AaStatement::Map_Target(AaObjectReference* obj_ref) 
{

  bool is_pointer_deref = obj_ref->Is("AaPointerDereferenceExpression");
  if(is_pointer_deref)
    return;

  string obj_ref_root_name =obj_ref->Get_Object_Root_Name();
  bool err_flag = false;
  AaScope* search_scope = this->Get_Scope()->Get_Ancestor_Scope(obj_ref->Get_Search_Ancestor_Level());
  AaRoot* child = NULL;

  if(search_scope != NULL)
    child = search_scope->Find_Child(obj_ref_root_name);
  else
    child = AaProgram::Find_Object(obj_ref_root_name);

  bool unsuitable_target = (child != NULL) && !(child->Is_Object() || child->Is_Expression());
  if(unsuitable_target)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " is not an object/expression",this);
      err_flag = true;
    }
  
  if(child != NULL && child->Is("AaPipeObject"))
    {
      AaScope* root = this->Get_Root_Scope();
      assert(root->Is_Module());
      ((AaPipeObject*)child)->Add_Writer((AaModule*)root);
      ((AaModule*)root)->Add_Write_Pipe((AaPipeObject*)child);
    }

  bool is_array_ref = obj_ref->Is("AaArrayObjectReference");

  bool is_simple_ref = obj_ref->Is("AaSimpleObjectReference");

  bool from_above = ((child != NULL) && (child->Is_Expression()) && 
		     (((AaExpression*)child)->Get_Scope() != this->Get_Scope()));

  bool map_flag = (((child == NULL) || from_above) && 
		   (search_scope == this->Get_Scope()) && 
		   !(is_array_ref) && !(is_pointer_deref));

  bool err_no_target_in_scope = ((child == NULL) && 
				 (is_array_ref || is_pointer_deref 
				  || (search_scope != this->Get_Scope())));

  bool err_redeclaration = ((child !=NULL) && 
			    (child->Is_Expression()) &&
			    is_simple_ref &&
			    (((AaExpression*)child)->Get_Scope() == this->Get_Scope()));

  bool err_write_to_constant = ((child !=NULL) && child->Is("AaConstantObject"));
  bool err_write_to_input_port = ((child != NULL) &&
				  (child->Is("AaInterfaceObject") && 
				   (((AaInterfaceObject*)child)->Get_Mode() == "in")));

  bool err_multiple_refs_to_ports =((child != NULL) &&  
				    child->Is("AaInterfaceObject") && 
				    !((AaModule*)((AaInterfaceObject*)child)->Get_Scope())->Get_Macro_Flag() &&
				    (child->Get_Number_Of_Target_References() > 0));
  
  
  if(err_no_target_in_scope)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " not found ",this);
      err_flag = true;
    }
  if(err_redeclaration)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " redeclared ",this);
      err_flag = true;
    }
  if(err_write_to_constant)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " is a constant, cannot be written to ",this);
      err_flag = true;
    }
  if(err_write_to_input_port)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " is a module input, cannot be written to ",this);
      err_flag = true;
    }
  if(err_multiple_refs_to_ports)
    {
      AaRoot::Error( string("multiple writes to module port ") + obj_ref_root_name + " are not permitted",this);
      err_flag = true;
    }

  if(child != NULL && child->Is_Interface_Object())
    {
      ((AaInterfaceObject*)child)->Set_Unique_Driver_Statement(this);
    }

  if(map_flag)
    {
      this->Get_Scope()->Map_Child(obj_ref_root_name,obj_ref);
      obj_ref->Set_Object(this);
    }
  else if((child != NULL) && !err_flag)
    {
      obj_ref->Set_Object(child);

      if(child->Is_Expression())
	obj_ref->Add_Target((AaExpression*) child);


      if(child->Is_Storage_Object())
	{
		((AaStorageObject*)child)->Set_Is_Written_Into(true);
		AaScope* r_scope = this->Get_Root_Scope();
		assert((r_scope != NULL) && r_scope->Is_Module());

		// remember which modules wrote to the child...
		((AaStorageObject*)child)->Add_Writer_Module((AaModule*)r_scope);
	}


      // obj_ref -> child
      child->Add_Target_Reference(obj_ref); // obj_ref uses child as a target
      obj_ref->Add_Source_Reference(child); // child uses obj_ref as a source
      

      if(child->Is_Object())
	{
	  this->_target_objects.insert(child);
	}
    }

}

bool AaStatement::Is_Dependent_On_Phi()
{
	bool ret_val = false;
	if(this->Get_Is_Volatile())
	{
		set<AaRoot*> write_roots;
		this->Collect_Root_Sources(write_roots);
		for(set<AaRoot*>::iterator witer = write_roots.begin(), fwiter = write_roots.end();
				witer != fwiter; witer++)
		{
			if((*witer)->Is("AaPhiStatement"))
			{
				ret_val = true;
				break;
			}
		}
	}
	else
		ret_val = this->Is("AaPhiStatement");

	return(ret_val);
}

// return true if one of the sources or targets is a pipe.
bool AaStatement::Can_Block(bool pipeline_flag)
{
 
	for(set<AaRoot*>::iterator siter = this->_target_objects.begin();
			siter != this->_target_objects.end();
			siter++)
	{
		if((*siter)->Is("AaPipeObject"))
		{
			if(!pipeline_flag || ((AaPipeObject*)(*siter))->Get_Synch())
				return(true);
		}
	}

	for(set<AaRoot*>::iterator siter = this->_source_objects.begin();
			siter != this->_source_objects.end();
			siter++)
	{
		if((*siter)->Is("AaPipeObject"))
		{
			if(!pipeline_flag || ((AaPipeObject*)(*siter))->Get_Synch())
				return(true);
		}
	}

	return(false);
}

void AaStatement::Propagate_Addressed_Object_Representative(AaStorageObject* obj)
{
	for(set<AaRoot*>::iterator iter = _source_references.begin();
			iter != _source_references.end();
			iter++)
	{
		if((*iter)->Is_Expression())
			((AaExpression*)(*iter))->Propagate_Addressed_Object_Representative(obj,this);
	}
}



string AaStatement::Get_VC_Guard_String()
{
	string ret_string;
	AaExpression* ge = this->Get_Guard_Expression();
	bool not_flag = this->Get_Guard_Complement();
	if(ge)
	{
		if(not_flag)
			ret_string = "$guard ( ~ " + ge->Get_VC_Driver_Name() + " ) " ;
		else
			ret_string = "$guard ( " + ge->Get_VC_Driver_Name() + " ) " ;
	}
	return(ret_string);
}
void AaStatement::Print_Adjacency_Map( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map)
{
	for(map<AaRoot*,vector<pair<AaRoot*,int> > >::iterator miter = adjacency_map.begin(),
			fmiter = adjacency_map.end(); miter != fmiter; miter++)
	{
		AaRoot* tmp  = (*miter).first;
		if(tmp != NULL)
			cerr << (*miter).first->To_String() << " (" << (*miter).first->Get_VC_Name() << "): " << endl;
		else
			cerr <<  "NULL : " << endl;

		for(int idx = 0, fidx = (*miter).second.size(); idx < fidx; idx++)
		{
			cerr << "\t(" << (*miter).second[idx].first->Get_VC_Name() << "," << (*miter).second[idx].second << ")" 
				<< endl;
		}
	}
}


// Build a weighted statement precedence graph as follows:
//   1.  A vertex for each expression/statement.
//   2.  If result of u is used in v  then introduce an edge u -> v.  
//       The weight of the edge is the estimated delay incurred in executing
//       statement v in hardware.
//   3.  For each u, build a longest path tree to
//       its neighbours.  
//   4.  For each statement u, find the maximum slack Su on
//       any path u->v relative to the longest path tree.
//   5.  For each u, introduce Su delayed versions of u.
//   6.  For each u: in every v such that u->v, if the slack on u->v
//       is Suv, then replace the uses of u in v by 
//       u-delayed-by-Suv.
//
void AaStatement::Equalize_Paths_For_Pipelining()
{
	set<AaRoot*> visited_elements;

	// initialization.. for pipelined modules, the 
	// seeds are set from the input arguments.
	this->Initialize_Visited_Elements(visited_elements);

	// implicit variable references.. which are targets
	// of statements and the expression that depend on them,
	// with the estimated delay from the point of generation
	// to the point of use.
	map<AaRoot*, vector< pair<AaRoot*, int> > > adjacency_map;

	//
	// NULL source to initial visited elements (input args of pipelined modules)
	//
	for(set<AaRoot*>::iterator iter = visited_elements.begin(), fiter = visited_elements.end();	
		iter != fiter; iter++)
	{
		AaRoot* r = *iter;
		__InsMap(adjacency_map,NULL,r,0);
	}

	// steps 1,2.
	//
	this->Update_Adjacency_Map(adjacency_map, visited_elements);

	// OK. At this point, you have all the adjacencies.  Now, 
	// AaRoot::Info("Adjacency map in do-while loop body " + this->Get_VC_Name());
	if(AaProgram::_verbose_flag)
		this->Print_Adjacency_Map(adjacency_map);

	// find the longest paths from the NULL node to all other
	// vertices.
	map<AaRoot*, int> longest_paths_from_root_map;


	// find longest paths to each element from NULL.	
	int longest_path = this->Find_Longest_Paths(adjacency_map,visited_elements, longest_paths_from_root_map);
	this->Set_Longest_Path(longest_path);

	AaRoot::Info("Longest path in " + this->Get_Name() + " is " + IntToStr(longest_path));

	if(AaProgram::_verbose_flag)
		this->Print_Slacks(visited_elements, adjacency_map, longest_paths_from_root_map);

	// Now, for each expression in visited-elements..  introduce delayed
	// versions of them as needed.
	//
	// Note: do not do this if the module is marked as a deterministic pipeline
	//	(this balancing will be taken care of in vc2vhdl0
	//
	if(!this->Get_Module()->Get_Pipeline_Deterministic_Flag())
		this->Add_Delayed_Versions(adjacency_map, visited_elements, longest_paths_from_root_map);
}

void AaStatement::Calculate_And_Update_Longest_Path()
{
	// implicit variable references.. which are targets
	// of statements and the expression that depend on them,
	// with the estimated delay from the point of generation
	// to the point of use.
	map<AaRoot*, vector< pair<AaRoot*, int> > > adjacency_map;

	// set of statements already visited.
	set<AaRoot*> visited_elements;

	// steps 1,2.
	//
	this->Update_Adjacency_Map(adjacency_map, visited_elements);

	// find the longest paths from the NULL node to all other
	// vertices.
	map<AaRoot*, int> longest_paths_from_root_map;


	// find longest paths to each element from NULL.	
	int longest_path = this->Find_Longest_Paths(adjacency_map,visited_elements, longest_paths_from_root_map);
	this->Set_Longest_Path(longest_path);

	AaRoot::Info("Longest path in " + this->Get_Name() + " is " + IntToStr(longest_path));
}

void AaStatement::Print_Slacks(set<AaRoot*>& visited_elements,
	map<AaRoot*, vector< pair<AaRoot*, int> > > adjacency_map,
	map<AaRoot*, int> longest_paths_from_root_map)
{
	cerr << "Info: Slacks" << endl;
	for(set<AaRoot*>::iterator iter = visited_elements.begin(), fiter = visited_elements.end();
			iter != fiter;
			iter++)
	{
		AaRoot* curr = (*iter);
		for(int idx = 0, fidx = adjacency_map[curr].size(); idx < fidx; idx++)
		{
			AaRoot* nbr = adjacency_map[curr][idx].first;
			int D = adjacency_map[curr][idx].second;
			int L = longest_paths_from_root_map[nbr];
			cerr << curr->Get_VC_Name() << " => " << nbr->Get_VC_Name() << " L=" << L << ", D=" << D << ", Slack=" << (L-D) << endl;
		}
	}
	cerr << "end: Slacks" << endl;
}

// find the longest paths.  First do a topological sort
// and then a straight update.
int AaStatement::Find_Longest_Paths(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		set<AaRoot*>& visited_elements,
		map<AaRoot*, int>& longest_paths_from_root_map)
{	

	int ret_val = 0;

	// initialize
	for(set<AaRoot*>::iterator iter = visited_elements.begin(), fiter = visited_elements.end();
			iter != fiter; iter++)
	{
		longest_paths_from_root_map[*iter] = 0;	
	}

	// reverse lookup map.
	map<AaRoot*, vector<pair<AaRoot*,int> > > predecessor_map;
	AaGraphBase g;


	// first build a Boost graph.
	string nname = "null";
	g.Add_Vertex(NULL);

	for(map<AaRoot*,int>::iterator miter = longest_paths_from_root_map.begin(),
			fmiter = longest_paths_from_root_map.end();
			miter != fmiter;
			miter++)
	{
		AaRoot* it = (*miter).first;
		g.Add_Vertex(it);
	}

	for(map<AaRoot*,vector< pair<AaRoot*,int> > >::iterator iter = adjacency_map.begin(), fiter = adjacency_map.end();
			iter != fiter;
			iter++)
	{
		AaRoot* u = (*iter).first;
		for(int idx = 0, fidx = (*iter).second.size(); idx < fidx; idx++)
		{
			AaRoot* v = (*iter).second[idx].first;
			int length = (*iter).second[idx].second;
			g.Add_Edge(u,v);

			predecessor_map[v].push_back(pair<AaRoot*,int>(u,length));
		}
	}

	// topological sort.
	vector<AaRoot*> precedence_order;
	g.Topological_Sort(precedence_order);

	for(int idx = precedence_order.size()-1, fidx = 0; idx >= fidx; idx--)
	{


		AaRoot* v = precedence_order[idx];
		int lp = 0;

		if(v != NULL)
		{
			int curr_dist = longest_paths_from_root_map[v];
			int new_dist =0;
			for(int jdx = 0, fjdx = predecessor_map[v].size(); jdx < fjdx; jdx++)
			{
				AaRoot* u = predecessor_map[v][jdx].first;

				int dist_to_u = 0;
				if(u != NULL)
				{
					dist_to_u = longest_paths_from_root_map[u];
				}
				int length = predecessor_map[v][jdx].second;
				int nn = length + dist_to_u;
				if(nn > new_dist)
				{	
					new_dist = nn;
				}
			}

			if(new_dist > curr_dist)
			{
				lp = new_dist;
				longest_paths_from_root_map[v] = new_dist;
			}
			else
				lp  = curr_dist;
				
			ret_val = ((ret_val < lp) ? lp : ret_val);
			AaRoot::DebugInfo("longest path to " + 
					    ((v == AaProgram::_dummy_root)? "EXIT" : v->Get_VC_Name()) + 
						" is " + IntToStr(lp));
		}
		else
			 AaRoot::DebugInfo("longest path to NULL is 0");
	}

	return(ret_val);
}

// Add delayed versions of curr (if curr is an implicit object reference or an intermediate expression)
void AaStatement::Add_Delayed_Versions(AaRoot* curr, 
		map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		set<AaRoot*>& visited_elements,
		map<AaRoot*, int>& longest_paths_from_root_map,
		AaStatementSequence* stmt_sequence)
{

	int new_stmt_counter = 0;
	AaExpression* curr_expr = NULL;

	// only expressions from here on.
	if(curr->Is_Expression())
	{
		curr_expr = (AaExpression*) curr;
	}
	else 
	{
		return;
	}

	// continue from here only if it is an implicit variable
	// reference or an intermediate expression.
	if((curr_expr != NULL) &&
		(curr_expr->Is_Constant() ||
			(!curr_expr->Is_Implicit_Variable_Reference() && !curr_expr->Get_Is_Intermediate())))
		return;

	AaRoot* curr_expr_root =  curr_expr->Get_Root_Object();
	// curr-expr-root not in visited elements...  leave it
	// since it is out of scope...
	if((curr_expr_root != NULL) &&
		(visited_elements.find(curr_expr_root) == visited_elements.end()))
	{
		if(!curr_expr_root->Is_Interface_Object() ||
					!curr_expr->Get_Scope()->Is_Module())
		 	return;
	}

	// signals are asynchronous.. no point in delaying them.
	if(curr_expr->Is_Indirect_Signal_Read())
	{
		return;
	}


	//
	// Is curr-expression acting as a guard to some statement?
	// In this case, only the guarded statement is affected.
	//
	if(curr_expr->Get_Guarded_Statement() != NULL)
	{

		assert (curr_expr->Is_Implicit_Variable_Reference());

		AaStatement* gstmt = curr_expr->Get_Guarded_Statement();
		int curr_slack = longest_paths_from_root_map[gstmt] - longest_paths_from_root_map[curr];
		
		if (curr_slack > 0)
		{
			AaScope* prnt_scope = this->Get_Scope();
			if(prnt_scope == NULL) // if null scope, then assignment will be in "this"
				prnt_scope = this; 

			AaRoot* root_obj = curr_expr->Get_Root_Object();
			string root_name = curr_expr->Get_Name();
			string delayed_name =  root_name + "_" + Int64ToStr(curr_expr->Get_Index()) + "_delayed_" + IntToStr(curr_slack) + "_" + IntToStr(new_stmt_counter);
			new_stmt_counter++;

			AaSimpleObjectReference* new_target = new AaSimpleObjectReference(prnt_scope, delayed_name);
			new_target->Set_Type(curr_expr->Get_Type());

			AaSimpleObjectReference* new_src    = new AaSimpleObjectReference(prnt_scope, root_name);
			new_src->Set_Type(curr_expr->Get_Type());


		      

			AaAssignmentStatement* new_stmt = new AaAssignmentStatement(prnt_scope,
					new_target,
					new_src,
					0);

			int buf_val = curr_slack;
			//if(this->Is_Part_Of_Fullrate_Pipeline()) buf_val = ((buf_val < 2) ? 2 : buf_val);
			new_stmt->Set_Buffering(buf_val);
			new_stmt->Set_Cut_Through(true);

			AaProgram::Increment_Buffering_Bit_Count(buf_val * new_target->Get_Type()->Size());

			new_stmt->Map_Targets();
			new_stmt->Map_Source_References();

			AaSimpleObjectReference* new_guard_expr = new AaSimpleObjectReference(prnt_scope, new_stmt);
			gstmt->Replace_Guard_Expression(new_guard_expr);			

			// lost track of curr_expr, but it doesnt matter..
			vector<AaStatement*> dv;
			dv.push_back((AaStatement*)new_stmt);
			stmt_sequence->Insert_Statements_Before(gstmt, dv);
		}
	}
	else
	{

		map<AaRoot*,int> slack_map;
		set<int> slack_set;
		map<int, AaAssignmentStatement*> slack_to_stmt_map;

		// Look at all the outarcs of curr.  If there is slack present on the outarc,
		// calculate the slack for that arc.  Keep track of the maximum, and
		// add those many delayed versions of curr (you will need to add
		// assignment statements for them).  Then for each outarc, reconnect
		// from curr to the appropriate delayed version!
		//
		// Note: one delayed version is produced for each desired slack.
		//
		int max_slack = 0;
		for(int idx = 0, fidx = adjacency_map[curr].size(); idx < fidx; idx++)
		{
			AaRoot* nbr = adjacency_map[curr][idx].first;

			// check for slack only on neighbours which are
			// expressions.
			if(nbr->Is_Statement())
			{
				// Note: if it is a call statement, then
				// curr_expr must be one of its arguments.
				if(!nbr->Is_Assignment_Statement() && !nbr->Is_Call_Statement())
					continue;
			}

			int dist =  adjacency_map[curr][idx].second;
			int slack = longest_paths_from_root_map[nbr] - (dist + longest_paths_from_root_map[curr]);

			if(nbr == AaProgram::_dummy_root)
			//
			// This is for writes to output arguments.
			//
			{
				AaStatement* stmt = curr_expr->Get_Associated_Statement();
				if(stmt != NULL)
				{
					int sbuff = stmt->Get_Buffering();
					stmt->Set_Buffering(slack + sbuff);
				}
			}
			else
			{
				if(slack_map.find(nbr) == slack_map.end())
					slack_map[nbr] = slack;
				else if(slack_map[nbr] < slack)
					slack_map[nbr] = slack;

				if(slack > max_slack)
					max_slack = slack;

				if(slack > 0)
					slack_set.insert(slack);
			}
		}


		// if the maximum slack is 0, then do nothing..
		if(max_slack == 0)
			return;

		AaStatement* stmt = curr_expr->Get_Associated_Statement();

		//
		// TODO
		// should this case also be considered?  Why should
		// the interface references not get delayed?
		//
		/*
		if(curr_expr->Is_Implicit_Variable_Reference() &&
			((stmt == NULL) && 
				((curr_expr_root == NULL) || (!curr_expr_root->Is("AaInterfaceObject")))))
		{
			// This can happen if there is a reference to
			// an interface object.
			return;
		}
		*/

		vector<AaStatement*> delayed_versions;


		// if expression is target, then introduce delayed 
		// statements after the stmt in which it occurs.
		string root_name = curr_expr->Get_Name();

		string delayed_name;
		for(set<int>::iterator siiter = slack_set.begin(), sfiter = slack_set.end();
				siiter != sfiter; siiter++)
		{
			AaScope* prnt_scope = this->Get_Scope();
			if(prnt_scope == NULL) // if null scope, then assignment will be in "this"
				prnt_scope = this; 

			int curr_slack = *siiter;
			if(curr_slack > 0)
			{
				delayed_name =  root_name + "_" + Int64ToStr(curr_expr->Get_Index()) + "_delayed_" + IntToStr(curr_slack) + "_" + IntToStr(new_stmt_counter);
				new_stmt_counter++;

				AaSimpleObjectReference* new_target = new AaSimpleObjectReference(prnt_scope, delayed_name);
				new_target->Set_Type(curr_expr->Get_Type());

				AaExpression* new_src    = NULL;

				bool linked_to_stmt = curr_expr->Is_Implicit_Variable_Reference() && !curr_expr->Get_Is_Intermediate();
				if(linked_to_stmt)
				{
					new_src =  new AaSimpleObjectReference(prnt_scope, root_name);
					new_src->Set_Type(curr_expr->Get_Type());
				}
				else
				{
					new_src = curr_expr;
				}

				AaAssignmentStatement* new_stmt = new AaAssignmentStatement(prnt_scope,
						new_target,
						new_src,
						0);
				new_stmt->Map_Targets();

				int buf_val = curr_slack;
				//if(this->Is_Part_Of_Fullrate_Pipeline()) buf_val = ((buf_val < 2) ? 2 : buf_val);
				new_stmt->Set_Buffering(buf_val);
				new_stmt->Set_Cut_Through(true);

				AaProgram::Increment_Buffering_Bit_Count(buf_val * new_target->Get_Type()->Size());

				if(linked_to_stmt)
				{
					new_stmt->Map_Source_References();
				}

				delayed_versions.push_back(new_stmt);
				slack_to_stmt_map[curr_slack] = new_stmt;
			}
		}

		if(curr_expr->Get_Is_Target())
		{
			stmt_sequence->Insert_Statements_After(stmt,delayed_versions);
		}
		else
		{
			stmt_sequence->Insert_Statements_Before(stmt,delayed_versions);
		}

		for(map<AaRoot*,int>::iterator iter = slack_map.begin(), fiter = slack_map.end(); iter != fiter; iter++)
		{
			AaRoot* nbr = (*iter).first;
			int slack   = (*iter).second;

			assert(slack <= max_slack);

			AaRoot* curr_expr_root = curr_expr->Get_Root_Object();

			// Replace uses of curr_expr in nbr_expr by 
			// a simple object reference to the appropriately
			// delayed version.
			//
			if((slack > 0) & (slack_to_stmt_map.find(slack) != slack_to_stmt_map.end()))
			{
				AaAssignmentStatement* rs = (AaAssignmentStatement*) slack_to_stmt_map[slack];
				if(nbr->Is_Expression())
				{
					AaExpression* nbr_expr = (AaExpression*) nbr;
					AaStatement* nbr_stmt = nbr_expr->Get_Associated_Statement();
					if((nbr_stmt == NULL) || (nbr_stmt != curr_expr_root))
					{
						nbr_expr->Replace_Uses_By(curr_expr, rs);
						if(nbr_stmt != NULL)
							nbr_stmt->Map_Source_References();
					}

				}
				else if(nbr->Is_Call_Statement())
				{
					AaCallStatement* cnbr = (AaCallStatement*) nbr;
					if(cnbr != curr_expr_root)
					{
						AaScope* prnt_scope = this->Get_Scope();
						if(prnt_scope == NULL) // if null scope, then assignment will be in "this"
							prnt_scope = this; 
						AaSimpleObjectReference* new_arg = new AaSimpleObjectReference(prnt_scope, 
													rs->Get_Target()->Get_Name());
						new_arg->Set_Type(curr_expr->Get_Type());

						cnbr->Replace_Input_Argument(curr_expr, new_arg);
					}
				}
				else if(nbr->Is_Assignment_Statement())
				{
					AaAssignmentStatement* astmt = ((AaAssignmentStatement*) nbr);
					if(astmt != curr_expr_root)
					{
						AaScope* prnt_scope = this->Get_Scope();
						if(prnt_scope == NULL) // if null scope, then assignment will be in "this"
							prnt_scope = this; 

						AaSimpleObjectReference* new_arg = new AaSimpleObjectReference(prnt_scope, 
								rs->Get_Target()->Get_Name());
						new_arg->Set_Type(curr_expr->Get_Type());
						astmt->Replace_Source_Expression(curr_expr, new_arg);

					}
				}
			}
		}
	}
}

void AaStatement::Replace_Guard_Expression(AaSimpleObjectReference* new_arg)
{
	if(this->_guard_expression != NULL)
	{
		AaSimpleObjectReference* old_arg = this->_guard_expression;

		old_arg->Set_Associated_Statement(NULL);
		old_arg->Remove_Target_Reference(this);

		this->Remove_Source_Reference(old_arg);
		this->_source_objects.erase(old_arg->Get_Object());
	}

	this->_guard_expression = new_arg;
	this->_guard_expression->Map_Source_References(this->_source_objects);
}


//---------------------------------------------------------------------
// AaStatementSequence
//---------------------------------------------------------------------
AaStatementSequence::AaStatementSequence(AaScope* scope, vector<AaStatement*>& statement_sequence):AaScope(scope)
{
	for(unsigned int i=0; i < statement_sequence.size();i++)
	{
		AaStatement* stmt = statement_sequence[i];
		stmt->Set_Index_In_Sequence(i);

		this->_statement_sequence.push_back(stmt);
	}

	_pipeline_parent = NULL;
}
AaStatementSequence::~AaStatementSequence() {}


bool AaStatementSequence::Can_Block(bool pipeline_flag)
{
	for(int i = 0, imax = _statement_sequence.size(); i < imax; i++)
	{
		if(_statement_sequence[i]->Can_Block(pipeline_flag))
			return(true);
	}
	return(false);
}


void AaStatementSequence::Print(ostream& ofile)
{
	for(unsigned int i=0; i < this->_statement_sequence.size();i++)
	{
		if(!this->_statement_sequence[i]->Is_Orphaned() || !AaProgram::_do_not_print_orphans || this->_statement_sequence[i]->Get_Keep_Flag())
			this->_statement_sequence[i]->Print(ofile);
		else
		{
			AaRoot::Info("ignored orphan statement: " + this->_statement_sequence[i]->To_String());
		}
	}
}


void AaStatementSequence::Write_VC_Control_Path(ostream& ofile)
{
	for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
		this->_statement_sequence[i]->Write_VC_Control_Path(ofile);
}
void AaStatementSequence::Write_VC_Pipe_Declarations(ostream& ofile)
{
	for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
		this->_statement_sequence[i]->Write_VC_Pipe_Declarations(ofile);
}
void AaStatementSequence::Write_VC_Memory_Space_Declarations(ostream& ofile)
{
	for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
		this->_statement_sequence[i]->Write_VC_Memory_Space_Declarations(ofile);
}
void AaStatementSequence::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
	for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
		this->_statement_sequence[i]->Write_VC_Constant_Wire_Declarations(ofile);
}
void AaStatementSequence::Write_VC_Wire_Declarations(ostream& ofile)
{
	for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
		this->_statement_sequence[i]->Write_VC_Wire_Declarations(ofile);
}
void AaStatementSequence::Write_VC_Datapath_Instances(ostream& ofile)
{
	for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
		this->_statement_sequence[i]->Write_VC_Datapath_Instances(ofile);
}
void AaStatementSequence::Write_VC_Links(string hier_id, ostream& ofile)
{
	for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
		this->_statement_sequence[i]->Write_VC_Links(hier_id, ofile);
}

// TODO: get rid of this..
void AaStatementSequence::Write_VC_Control_Path_As_Fork_Block(bool pipe_flag, string region_id, ostream& ofile)
{
	assert(0);
}

AaStatement* AaStatementSequence::Get_Next_Statement(AaStatement* stmt)
{
	AaStatement* ret_stmt = NULL;
	int idx = stmt->Get_Index_In_Sequence();

	assert(idx >= 0);

	if(idx < (this->Get_Statement_Count() -1))
	{
		ret_stmt = this->Get_Statement(idx+1);
	}

	return(ret_stmt);
}

AaStatement* AaStatementSequence::Get_Previous_Statement(AaStatement* stmt)
{
	AaStatement* ret_stmt = NULL;
	int idx = stmt->Get_Index_In_Sequence();

	assert(idx >= 0);

	if(idx > 0)
	{
		ret_stmt = this->Get_Statement(idx-1);
	}

	return(ret_stmt);
}

void AaStatementSequence::Get_Target_Places(set<AaPlaceStatement*>& target_places)
{
	for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
	{
		AaStatement* stmt = this->_statement_sequence[i];
		stmt->Get_Target_Places(target_places);
		if(this->_statement_sequence[i]->Is("AaPlaceStatement"))
			break;
	}
}


void AaStatementSequence::Insert_Statements_After(AaStatement* pred, vector<AaStatement*>& nstmts)
{

	for(vector<AaStatement*>::iterator iter = _statement_sequence.begin(), fiter = _statement_sequence.end();
			iter != fiter; iter++)
	{
		if(*iter == pred)
		{
			iter++;
			_statement_sequence.insert(iter, nstmts.begin(), nstmts.end());	
			break;
		}
	}	
	this->Renumber_Statements();
}

void AaStatementSequence::Insert_Statements_Before(AaStatement* succ, vector<AaStatement*>& nstmts)
{
	for(vector<AaStatement*>::iterator iter = _statement_sequence.begin(), fiter = _statement_sequence.end();
			iter != fiter; iter++)
	{
		if(*iter == succ)
		{
			_statement_sequence.insert(iter, nstmts.begin(), nstmts.end());	
			break;
		}
	}	
	this->Renumber_Statements();
}

void AaStatementSequence::Delete_Statement(AaStatement* stmt)
{
	for(vector<AaStatement*>::iterator iter = _statement_sequence.begin(), fiter = _statement_sequence.end();
			iter < fiter; iter++)
	{
		if(*iter == stmt)
		{
			_statement_sequence.erase(iter);
			break;
		}
	}
	this->Renumber_Statements();
}


void AaStatement::Set_Guard_Expression(AaSimpleObjectReference* oref)
{
	_guard_expression = oref;
	oref->Set_Associated_Statement(this);
	oref->Set_Guarded_Statement(this);
}

string AaStatement::Get_VC_Synch_Transition_Name(bool& has_delay)
{
	has_delay = false;
 	string ret_val = __SCT(this);
	return(ret_val);
}

//---------------------------------------------------------------------
// AaNullStatement: public AaStatement
//---------------------------------------------------------------------
AaNullStatement::AaNullStatement(AaScope* parent_tpr):AaStatement(parent_tpr) {};
AaNullStatement::~AaNullStatement() {};
void AaNullStatement::Write_VC_Control_Path(ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	ofile << ";;[" << this->Get_VC_Name() << "] {" << endl; 
	__T ("dummy");
	ofile << "}" << endl;
}

//---------------------------------------------------------------------
// AaBarrierStatement: public AaNullStatement
//---------------------------------------------------------------------
AaBarrierStatement::AaBarrierStatement(AaScope* parent_tpr):AaNullStatement(parent_tpr) {};
AaBarrierStatement::~AaBarrierStatement() {};
void AaBarrierStatement::Write_VC_Control_Path(ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	ofile << ";;[" << this->Get_VC_Name() << "] {" << endl; 
	__T ("dummy");
	ofile << "}" << endl;
}
//---------------------------------------------------------------------
// AaLockStatement: public AaNullStatement
//---------------------------------------------------------------------
AaLockStatement::AaLockStatement(AaScope* prnt, string mutex_id):AaNullStatement(prnt)
{
	_mutex_id = mutex_id;
	if(!AaProgram::Is_Mutex(mutex_id))
	{
		AaRoot::Error("lock statement uses undeclared mutex.", this);
	}
}


void AaLockStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "MUTEX_LOCK(" << _mutex_id << ");" << endl;
}

//---------------------------------------------------------------------
// AaUnlockStatement: public AaNullStatement
//---------------------------------------------------------------------
AaUnlockStatement::AaUnlockStatement(AaScope* prnt, string mutex_id):AaNullStatement(prnt)
{
	_mutex_id = mutex_id;
	if(!AaProgram::Is_Mutex(mutex_id))
	{
		AaRoot::Error("unlock statement uses undeclared mutex.", this);
	}
}

void AaUnlockStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "MUTEX_UNLOCK(" << _mutex_id << ");" << endl;
}

//---------------------------------------------------------------------
// AaTraceStatement: public AaNullStatement
//---------------------------------------------------------------------
void AaTraceStatement::Print(ostream& ofile)
{
	if(this->Get_Guard_Expression())
	{
		ofile << "$guard (";
		if(this->Get_Guard_Complement())
		{
			ofile << "~";
		}
		this->Get_Guard_Expression()->Print(ofile);
		ofile << ") ";
	}
	ofile << "$trace " << this->_trace_identifier <<  " (" << this->_trace_index << ")" <<  endl;
}


void AaTraceStatement::Map_Source_References()
{
	if(this->Get_Guard_Expression())
	{
		this->Get_Guard_Expression()->Map_Source_References(this->_source_objects);
		if(!this->_guard_expression->Is_Implicit_Variable_Reference())
		{
			AaRoot::Error("guard variable must be implicit (SSA)", this);
		}
	}
}


void AaTraceStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "// " << this->To_String();
	headerfile << "\n#define " << this->Get_C_Macro_Name() << " " ;
	srcfile << this->Get_C_Macro_Name() << "; " << endl ;
	if(this->Get_Guard_Expression())
	{
		this->Get_Guard_Expression()->PrintC_Declaration(headerfile);
		this->Get_Guard_Expression()->PrintC(headerfile);
	}
	if(this->Get_Guard_Expression())
	{
		headerfile << "if (" ;
		if(this->Get_Guard_Complement())
			headerfile << "!";
		Print_C_Value_Expression(this->Get_Guard_Expression()->C_Reference_String(), this->Get_Guard_Expression()->Get_Type(), headerfile);
		headerfile << ") {\\" << endl;
	}
	headerfile << "if (" << AaProgram::Trace_On_Flag_Name() << ") {\\" << endl;
	headerfile << "__trace(1, \"" << this->_trace_identifier << "\"," << this->_trace_index << ");\\" <<  endl;
	headerfile << "}\\" << endl;
	headerfile << "else {\\" << endl;
	headerfile << "__trace(0, \"" << this->_trace_identifier << "\"," << this->_trace_index << ");\\" <<  endl;
	headerfile << "}\\" << endl;
	if(this->Get_Guard_Expression())
		headerfile << "}\\" << endl;
}

//---------------------------------------------------------------------
// AaSleepStatement: public AaNullStatement
//---------------------------------------------------------------------
void AaSleepStatement::Print(ostream& ofile)
{
	if(this->Get_Guard_Expression())
	{
		ofile << "$guard (";
		if(this->Get_Guard_Complement())
		{
			ofile << "~";
		}
		this->Get_Guard_Expression()->Print(ofile);
		ofile << ") ";
	}
	ofile << "$sleep " << this->_sleep_count <<  endl;
}


void AaSleepStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "// " << this->To_String();
	headerfile << "\n#define " << this->Get_C_Macro_Name() << " " ;
	srcfile << this->Get_C_Macro_Name() << "; " << endl ;
	if(this->Get_Guard_Expression())
	{
		this->Get_Guard_Expression()->PrintC_Declaration(headerfile);
		this->Get_Guard_Expression()->PrintC(headerfile);
	}
	if(this->Get_Guard_Expression())
	{
		headerfile << "if (" ;
		if(this->Get_Guard_Complement())
			headerfile << "!";
		Print_C_Value_Expression(this->Get_Guard_Expression()->C_Reference_String(), this->Get_Guard_Expression()->Get_Type(), headerfile);
		headerfile << ") {\\" << endl;
	}
	headerfile << "usleep (" << this->_sleep_count << ");\\" <<  endl;
	if(this->Get_Guard_Expression())
		headerfile << "}\\" << endl;
}


//
//---------------------------------------------------------------------
// AaReportStatement: public AaNullStatement
//---------------------------------------------------------------------
AaReportStatement::AaReportStatement(AaScope* parent, 
		AaExpression* assert_expr,
		string tag,
		string synopsys, 
		vector< pair<string,AaExpression* > >& descr_pairs): 
	AaNullStatement(parent)
{
	_assert_expression = assert_expr;
	if(assert_expr != NULL)
		_assert_expression->Set_Associated_Statement(this);

	_tag = tag;
	_synopsys = synopsys;
	for(int I = 0, fI = descr_pairs.size(); I < fI; I++)
	{
		descr_pairs[I].second->Set_Associated_Statement(this);
		_descr_pairs.push_back(pair<string,AaExpression*>(descr_pairs[I].first, descr_pairs[I].second));
	}
}

void AaReportStatement::Print(ostream& ofile)
{
	if(this->Get_Guard_Expression())
	{
		ofile << "$guard (";
		if(this->Get_Guard_Complement())
		{
			ofile << "~";
		}
		this->Get_Guard_Expression()->Print(ofile);
		ofile << ") ";
	}

	if(_assert_expression)
	{
		ofile << "$assert ";
		_assert_expression->Print(ofile);
		ofile << " ";
	}
	ofile << "$report (" << _tag << " " << _synopsys << " ";
	for(int I = 0, fI = _descr_pairs.size(); I < fI; I++)
	{
		ofile << this->Tab() << " " << _descr_pairs[I].first << " ";
		_descr_pairs[I].second->Print(ofile);
		ofile << " ";
	}
	ofile << ")" << endl;
}

void AaReportStatement::Map_Source_References()
{
	if(_assert_expression)
	{
		_assert_expression->Map_Source_References(this->_source_objects);
	}

	if(this->Get_Guard_Expression())
	{
		this->Get_Guard_Expression()->Map_Source_References(this->_source_objects);
		if(!this->_guard_expression->Is_Implicit_Variable_Reference())
		{
			AaRoot::Error("guard variable must be implicit (SSA)", this);
		}
	}
	for(int I = 0, fI = _descr_pairs.size(); I < fI; I++)
	{
		_descr_pairs[I].second->Map_Source_References(this->_source_objects);
	}
}

void AaReportStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "// " << this->To_String();
	headerfile << "\n#define " << this->Get_C_Macro_Name() << " " ;
	srcfile << this->Get_C_Macro_Name() << "; " << endl ;
	if(this->_assert_expression)
	{
		this->_assert_expression->PrintC_Declaration(headerfile);
		this->_assert_expression->PrintC(headerfile);
	}
	if(this->Get_Guard_Expression())
	{
		this->Get_Guard_Expression()->PrintC_Declaration(headerfile);
		this->Get_Guard_Expression()->PrintC(headerfile);
	}
	if(this->_assert_expression)
	{
		headerfile << "if (!" ;
		Print_C_Value_Expression(this->_assert_expression->C_Reference_String(), 
				this->_assert_expression->Get_Type(), headerfile);
		headerfile << ") {\\" << endl;
	}
	if(this->Get_Guard_Expression())
	{
		headerfile << "if (" ;
		if(this->Get_Guard_Complement())
			headerfile << "!";
		Print_C_Value_Expression(this->Get_Guard_Expression()->C_Reference_String(), this->Get_Guard_Expression()->Get_Type(), headerfile);
		headerfile << ") {\\" << endl;
	}
	string plock_counter = this->Get_C_Macro_Name() + "__print_counter";
	headerfile << "uint32_t " << plock_counter << "= get_file_print_lock(" << AaProgram::Report_Log_File_Name() <<");";

	string tag_expression;
	if(_assert_expression != NULL)
		tag_expression  = "ASSERTION! " + this->_tag;
	else
		tag_expression = this->_tag;

	Print_C_Report_String(plock_counter, tag_expression, this->_synopsys, headerfile);

	for(int I = 0, fI = _descr_pairs.size(); I < fI; I++)
	{
		_descr_pairs[I].second->PrintC_Declaration(headerfile);
		_descr_pairs[I].second->PrintC(headerfile);
		Print_C_Report_String_Expr_Pair(plock_counter, this->_tag, _descr_pairs[I].first,
				_descr_pairs[I].second->C_Reference_String(),
				_descr_pairs[I].second->Get_Type(), headerfile);
	}
	headerfile << "release_file_print_lock(" << AaProgram::Report_Log_File_Name() <<");";
	if(this->Get_Guard_Expression())
		headerfile << "}";
	if(this->_assert_expression)
	{
		headerfile << "assert(0);" ;
		headerfile << "}";
	}
	headerfile << ";" << endl;
}

//---------------------------------------------------------------------
// AaAssignmentStatement
//---------------------------------------------------------------------
AaAssignmentStatement::AaAssignmentStatement(AaScope* parent_tpr, AaExpression* tgt, AaExpression* src, int lineno):
	AaStatement(parent_tpr) 
{
	assert(tgt); assert(src);

	_is_volatile = false;
	_cut_through = false;

	tgt->Set_Associated_Statement(this);
	tgt->Set_Is_Intermediate(false);
	src->Set_Associated_Statement(this);
	src->Set_Is_Intermediate(false);


	this->Set_Line_Number(lineno);

	this->_target = tgt;
	this->_target->Set_Is_Target(true);

	tgt->Add_RHS_Source(src);
	this->_source = src;
	this->_source->Add_Target(this->_target);

	this->_buffering = 1;
}

AaAssignmentStatement::~AaAssignmentStatement() {};


bool AaAssignmentStatement::Get_Is_Volatile()
{
	return(_is_volatile);
}

void AaAssignmentStatement::Set_Is_Volatile(bool v)
{

	_is_volatile = v;
	if(this->_source)
	{
		this->_source->Set_Is_Intermediate(v);
	}
}

void AaAssignmentStatement::Set_Pipeline_Parent(AaStatement* dws)
{
	_pipeline_parent = dws;
	this->_source->Set_Pipeline_Parent(dws);
	this->_target->Set_Pipeline_Parent(dws);
}

string AaAssignmentStatement::Debug_Info()
{
	string ret_string;
	AaType* tt;
	AaType* st;

	tt = this->Get_Target()->Get_Type();
	AaStorageObject* tms =  this->_target->Get_Addressed_Object_Representative();

	st = this->Get_Source()->Get_Type();
	AaStorageObject* sms =  this->_source->Get_Addressed_Object_Representative();

	ret_string =  "// target-type =   ";
	ret_string += (tt ? tt->To_String() : "unknown") + "\n";
	ret_string += "// target-memory-space = ";
	if(tms != NULL && tms->Is_Foreign_Storage_Object())
		ret_string += tms->Get_Name() + "\n";
	else
		ret_string += (tms ?  IntToStr(tms->Get_Mem_Space_Index()) : " none") + "\n";

	ret_string += "// source-type = " ;
	ret_string += (st ? st->To_String() : "unknown") + "\n";
	ret_string += "// source-memory-space = ";
	if(sms != NULL && sms->Is_Foreign_Storage_Object())
		ret_string += sms->Get_Name() + "\n";
	else
		ret_string += (sms ?  IntToStr(sms->Get_Mem_Space_Index()) : " none") + "\n";

	return(ret_string);
}


string AaAssignmentStatement::Get_VC_Buffering_String()
{
	string ret_string = "";
	int buf_val = this->Get_Buffering();

	if(buf_val > 1)
	{
		ret_string = "$buffering " + IntToStr(buf_val);
	}
	return(ret_string);
}
  
string AaAssignmentStatement::Get_VC_Synch_Transition_Name(bool& has_delay)
{
	string ret_val;
	has_delay = false;
	
	if(this->_source->Is_Pipe_Read() &&
		this->_target->Is_Implicit_Variable_Reference())
	{
		ret_val = __UCT(this);
		has_delay = true;
	}
	else
	{
		ret_val = __SCT(this);
	}
	return(ret_val);
}

  
bool AaAssignmentStatement::Is_Orphaned()
{
	bool ret_val = 0;
	if(this->_target->Is_Implicit_Variable_Reference() && !this->_target->Is_Interface_Object_Reference())
	{
		if((this->_target->Get_Number_Of_Things_Driven_By_This() == 0) &&
			!this->Can_Block(false))
			ret_val = 1;
	}
	return(ret_val);
}

bool AaAssignmentStatement::Can_Be_Combinationalized()
{
	AaExpression* tgt = this->_target;
	AaExpression* src = this->_source;

	// target should not be an interface object, and should not be a complex function that needs
	// to be registered.
	bool ret_val = (!tgt->Is_Interface_Object_Reference() && tgt->Can_Be_Combinationalized() && src->Can_Be_Combinationalized());

	//
	// fanout should be 1.
	//
	if(ret_val && (tgt->Get_Source_References().size() == 1))
	{
		AaRoot* robj = *(tgt->Get_Source_References().begin());
		if(robj->Is_Phi_Statement())
			ret_val = true;
		else
		{
			if(robj->Is_Expression())
			{
				// should not create a combinational loop.
				ret_val = (((AaExpression*)robj)->Get_Associated_Statement() != this);
			}
			else
			{
				// should not be a WAR dependency.
				ret_val = (robj->Get_Index() < tgt->Get_Index());
			}
		}
	}
	return(ret_val);
}


void AaAssignmentStatement::Print(ostream& ofile)
{
	assert(this->Get_Target()->Get_Type() && this->Get_Source()->Get_Type());

	if(AaProgram::_combinationalize_statements && this->Can_Be_Combinationalized())
	{
		this->Set_Is_Volatile(true);
	}

	int twidth = this->Get_Target()->Get_Type()->Size();
	int swidth = this->Get_Source()->Get_Type()->Size();
	int awidth = AaProgram::_foreign_address_width;
	bool flag = AaProgram::_keep_extmem_inside;

		
	string guard_string;

	AaScope* ps = this->Get_Scope();
	AaModule* pm = NULL;
	if(ps->Is_Module())
		pm = (AaModule*) ps;

	if((pm != NULL) && pm->Get_Macro_Flag() && AaProgram::_print_inlined_functions_in_caller)
	{
	
		string as_g_var = "as_guard_" + pm->Get_Print_Prefix() + "_"  +  
							Int64ToStr(this->Get_Index());

		if(this->_guard_expression != NULL)
		{
			ofile << "$volatile " << as_g_var  << " := " << (this->_guard_complement ? "(~" : "") << 
					"($bitcast ($uint<1>)  " << this->_guard_expression->To_String() << ")" 
					<< (this->_guard_complement ? ")" : "") << endl;
		}

		if((pm != NULL) && (pm->Get_Print_Guard_String() != ""))
		{
			if(this->_guard_expression != NULL)
			{
				string mg_var = "macro_guard_" + pm->Get_Print_Prefix() + "_" +  Int64ToStr(this->Get_Index());
				ofile << "$volatile " << mg_var  <<  " := ( " << pm->Get_Print_Guard_String() << " & " << as_g_var << ")" << endl;
				guard_string += "$guard ( " + mg_var + ") ";
			}
			else
			{
				guard_string = "$guard (" + pm->Get_Print_Guard_String() + ") ";
			}
		}
		else if(this->_guard_expression != NULL)
		{
			guard_string = "$guard (" + as_g_var + ") ";
		}
	}
	else if(this->_guard_expression != NULL)
	{
		guard_string = string("$guard (") + (this->_guard_complement ? "~" : "") + 
							this->_guard_expression->To_String() + ") ";
	}




	if(!flag && this->Get_Target()->Is_Foreign_Store() && this->Get_Source()->Is_Foreign_Load())
	{
		AaPointerDereferenceExpression *ptgt = (AaPointerDereferenceExpression*)(this->Get_Target());
		AaPointerDereferenceExpression *psrc = (AaPointerDereferenceExpression*)(this->Get_Source());

		// first load and then store.
		ofile << "$seriesblock [as_" << this->Get_Index() << "_ext_mem_access] {";
		ofile << guard_string << "$call extmem_load_for_type_" << this->Get_Target()->Get_Type()->Get_Index()
			<< " ( ($bitcast ( $uint<" << awidth << " > ) "
			<<  psrc->Get_Reference_To_Object()->To_String() << ")) ("
			<< " (as_" << this->Get_Index() << "_ld_result)" << endl;
		ofile << guard_string << "$call extmem_store_for_type_" << this->Get_Source()->Get_Type()->Get_Index()
			<< " ( ($bitcast ($uint<" << awidth << "> )"
			<< ptgt->Get_Reference_To_Object()->To_String() << ") "
			<< "( as_" << this->Get_Index() << "_ld_result)) ()" << endl;
		ofile << "}" << endl;
	}
	else if(!flag && this->Get_Source()->Is_Foreign_Load())
	{
		AaPointerDereferenceExpression *psrc = (AaPointerDereferenceExpression*)(this->Get_Source());

		ofile << guard_string << "$call extmem_load_for_type_" << this->Get_Target()->Get_Type()->Get_Index() 
			<< " ( ($bitcast ($uint<" <<  awidth << "> )"
			<< "  " << psrc->Get_Reference_To_Object()->To_String() << ")) ("
			<< this->Get_Target()->To_String() << ")" << endl;
	}
	else if(!flag && this->Get_Target()->Is_Foreign_Store())
	{
		AaPointerDereferenceExpression *ptgt = (AaPointerDereferenceExpression*)(this->Get_Target());
		ofile << guard_string << "$call extmem_store_for_type_" << this->Get_Source()->Get_Type()->Get_Index()
			<< " ( ($bitcast ($uint<" << awidth << "> )"
			<< ptgt->Get_Reference_To_Object()->To_String() << ") "
			<< " " << this->Get_Source()->To_String() << ")  ()" << endl;
	}
	else
	{
		ofile << this->Tab();
		ofile << guard_string;
		if(this->Get_Is_Volatile())
			ofile << "$volatile ";

		this->Get_Target()->Print(ofile);
		ofile << " := ";
		this->Get_Source()->Print(ofile);

		int bufval = this->Get_Buffering();
		ofile << " $buffering " << bufval;

		if(this->Get_Cut_Through())
			ofile << " $cut_through ";

		if(this->_mark != "")
			ofile << " $mark " << _mark << " ";

		if(this->_synch_statements.size() > 0)
		{
			ofile << " $synch (";
			for(set<AaStatement*>::iterator siter = _synch_statements.begin(), fiter = _synch_statements.end();
					siter != fiter; siter++)
			{
				if(_synch_update_flag_map[(*siter)])
					ofile << " $update "; 
				ofile << (*siter)->Get_Mark();
				ofile << " ";
			}
			ofile << ")  ";
		}
		if(this->_marked_delay_statements.size() > 0)
		{
			ofile << " $delay (";
			for(map<AaStatement*,int>::iterator miter = _marked_delay_statements.begin(), 
					fmiter = _marked_delay_statements.end();
					miter != fmiter; miter++)
			{
				ofile << (*miter).first->Get_Mark();
				ofile << " ";
				ofile << (*miter).second;
				ofile << " ";
			}
			ofile << ")  ";
		}

		if(this->Get_Keep_Flag())
			ofile << " $keep ";

		AaModule* m = this->Get_Module();
		if(!this->Get_Is_Volatile() && (m != NULL) && !m->Get_Is_Volatile() &&
				(this->_target != NULL))
		{
			int bits_of_buffering = bufval * this->_target->Get_Type()->Size();
			ofile << "// bits of buffering = " << bits_of_buffering << ". ";
			if(this->Is_Orphaned())
				ofile << " Orphaned statement with target " << _target->To_String() << " ?? ";
		}
	}

	if(AaProgram::_verbose_flag)
		ofile << endl << Debug_Info();


	ofile << endl;
}

void AaAssignmentStatement::Map_Targets()
{
	// only one target which can serve as a handle
	// to this statement
	if(this->_target->Is_Object_Reference())
	{
		this->Map_Target((AaObjectReference*)this->Get_Target());
	
		AaScope* sc = this->Get_Root_Scope();
		assert(sc && sc->Is("AaModule"));
		AaModule* parent_module = (AaModule*) sc;
		if(this->Get_Is_Volatile() && parent_module->Get_Operator_Flag())
		{
			AaRoot* tobj = _target->Get_Object();
			assert(tobj != NULL);
			if(tobj->Is_Interface_Object())
			{
				AaRoot::Warning("operator module has volatile update of interface object " + tobj->Get_Name(), this); 
				//return;
			}
		}
	}
}


void AaAssignmentStatement::Map_Source_References()
{
	this->_target->Map_Source_References_As_Target(this->_source_objects);
	AaProgram::Add_Type_Dependency(this->_target,this->_source);


	this->_source->Map_Source_References(this->_source_objects);

	if(this->_guard_expression)
	{
		this->_guard_expression->Map_Source_References(this->_source_objects);
		if(!this->_guard_expression->Is_Implicit_Variable_Reference())
		{
			AaRoot::Error("guard variable must be implicit (SSA)", this);
		}
	}
}


void AaAssignmentStatement::Collect_Root_Sources(set<AaRoot*>& root_sources)
{
	if(this->Get_Is_On_Collect_Root_Sources_Stack())
		AaRoot::Error("Cycle in collect-root-sources", this);
	this->Set_Is_On_Collect_Root_Sources_Stack(true);
	if(this->Get_Is_Volatile())
	{
		if(this->_source != NULL)
			this->_source->Collect_Root_Sources(root_sources);
	}
	else
	{
		root_sources.insert(this);
	}
	this->Set_Is_On_Collect_Root_Sources_Stack(false);
}


void AaAssignmentStatement::Get_Non_Trivial_Source_References(set<AaRoot*>& tgt_sources, set<AaRoot*>& visited_elements)
{
	if(this->Get_Is_On_Search_For_Non_Trivial_Refs_Stack())
	{
		AaRoot::Error("Cycle in searching for non-trivial source refs ", this);
		return;
	}
	this->Set_Is_On_Search_For_Non_Trivial_Refs_Stack(true);
	if(visited_elements.find(this) != visited_elements.end())
	{
		if(this->Get_Is_Volatile())
		{
			this->_target->Get_Non_Trivial_Source_References(tgt_sources, visited_elements);
		}
		else
		{
			tgt_sources.insert(this);
		}
	}
	this->Set_Is_On_Search_For_Non_Trivial_Refs_Stack(false);
}

AaSimpleObjectReference* AaAssignmentStatement::Get_Implicit_Target(string tgt_name)
{
	AaSimpleObjectReference* ret = NULL;
	AaExpression* oarg = this->_target;
	if(oarg->Is("AaSimpleObjectReference"))
	{
		string oarg_name = ((AaSimpleObjectReference*)oarg)->Get_Object_Root_Name();
		if(oarg_name == tgt_name)
		{
			ret = (AaSimpleObjectReference*) oarg;
		}
	}	
	return(ret);
}

void AaAssignmentStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "// " << this->To_String(); //includes newline
	headerfile << "\n#define " << this->Get_C_Macro_Name() << " ";
	srcfile << this->Get_C_Macro_Name() << "; " << endl;

	if(this->Get_Is_Volatile())
	{
		//
		// volatile statements should not depend 
		// on anything which is indexed higher than
		// the statement.
		//
		this->Check_Volatility_Ordering_Condition();
	}

	if(this->Get_Guard_Expression())
	{
		this->Get_Guard_Expression()->PrintC_Declaration(headerfile);
		this->Get_Guard_Expression()->PrintC(headerfile);
		if(!this->Get_Guard_Expression()->Is_Constant())
			Print_C_Assert_If_Bitvector_Undefined(this->Get_Guard_Expression()->C_Reference_String(),headerfile);
	}


	this->_source->PrintC_Declaration(headerfile);


	if(this->Get_Guard_Expression())
	{
		headerfile << "if (" ;
		if(this->Get_Guard_Complement())
			headerfile << "!";
		Print_C_Value_Expression(this->Get_Guard_Expression()->C_Reference_String(), this->Get_Guard_Expression()->Get_Type(), headerfile);
		headerfile << ") {\\" << endl;

	}


	this->_source->PrintC(headerfile);


	bool skip_target = false;
	if(this->_target->Is("AaSimpleObjectReference"))
	{
		// if target is a pipe, then we will have to
		// print a pipe-write expression.
		AaSimpleObjectReference* sexpr = (AaSimpleObjectReference*) this->_target;
		assert(sexpr->Get_Object());
		if(sexpr->Get_Object()->Is_Pipe_Object())
		{
			Print_C_Pipe_Write(this->_source->C_Reference_String(),
					this->_source->Get_Type(),
					(AaPipeObject*) sexpr->Get_Object(), headerfile);

			skip_target = true;
		}
	}

	if(!skip_target)
	{
		if(this->_target->Get_Root_Object() != ((AaRoot*) this))
		{
			this->_target->PrintC_Declaration(headerfile);
		}

		// target side stuff.
		if(this->_target->Is("AaArrayObjectReference"))
		{
			AaArrayObjectReference* aor = (AaArrayObjectReference*) (this->_target);
			aor->PrintC(headerfile);			
		}

	

		Print_C_Assignment(this->_target->C_Reference_String(),
				this->_source->C_Reference_String(),
				this->_target->Get_Type(),
				headerfile);
	}


	if(this->Get_Guard_Expression())
		headerfile << "}" << endl;

	headerfile << ";" << endl;

}

void AaAssignmentStatement::PrintC_Implicit_Declarations(ofstream& ofile)
{
	if(this->_target->Get_Root_Object() == ((AaRoot*) this))
	{
		this->_target->PrintC_Declaration(ofile);
	}
}



void AaAssignmentStatement::Write_VC_Control_Path(ostream& ofile)
{

	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	if(this->Get_Is_Volatile())
	{
		//
		// volatile statements should not depend 
		// on anything which is indexed higher than
		// the statement.
		//
		this->Check_Volatility_Ordering_Condition();
	}


	ofile << ";;[" << this->Get_VC_Name() << "] // " << this->Get_Source_Info() << endl << " {" << endl;
	if(!this->Is_Constant())
	{

		this->_source->Write_VC_Control_Path(ofile);
		assert(this->_target->Is_Object_Reference()); //\todo later ->(a)!
		this->_target->Write_VC_Control_Path_As_Target(ofile);

		// if _source is an object-reference which refers to
		// an implicit variable, and if _target is an object
		// reference which refers to an implicit variable,
		// then you will need to instantiate a register..
		if((_source->Is_Signal_Read() || _source->Is_Implicit_Variable_Reference() 
			|| _source->Is_Volatile_Function_Call()) && _target->Is_Implicit_Variable_Reference())
		{
			ofile << "|| [Interlock] {" << endl;
			ofile << " ;;[Sample] {" << endl;
			ofile << "$T [req] $T [ack]" << endl;
			ofile << "}" << endl;
			ofile << " ;;[Update] {" << endl;
			ofile << "$T [req] $T [ack]" << endl;
			ofile << "}" << endl;
			ofile << "}" << endl;
		}

		// if target is a pointer then you will need a
		// register??

	}
	else
	{
		ofile << "$T [dummy] // assignment evaluates to a constant " << endl;
	}
	ofile << "} // end assignment statement " << this->Get_VC_Name() << endl;
}

void AaAssignmentStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
	if(this->Is_Constant())
	{
		ofile << "// " << this->To_String() << endl;
		ofile << "// " << this->Get_Source_Info() << endl;
		if(!this->_target->Is_Interface_Object_Reference())
		{
			// declare the target as a constant...
			Write_VC_Constant_Declaration(this->_target->Get_VC_Constant_Name(),
					this->_target->Get_Type()->Get_VC_Name(),
					this->_target->Get_Expression_Value()->To_VC_String() + " // " +
					this->_target->Get_Expression_Value()->To_C_String(),
					ofile);
		}
	}
	else
	{
		this->_source->Write_VC_Constant_Wire_Declarations(ofile);
		this->_target->Write_VC_Constant_Wire_Declarations(ofile);
	}
}
void AaAssignmentStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
	if(!this->Is_Constant())
	{
		ofile << "// " << this->To_String() << endl;
		ofile << "// " << this->Get_Source_Info() << endl;


		if(this->_target->Is_Implicit_Variable_Reference())
			// source wire not necessary if the target is
			// an implicit variable
			this->_source->Write_VC_Wire_Declarations(true,ofile);
		else
			// if target is not implicit variable,
			// then source wire must be declared..
			this->_source->Write_VC_Wire_Declarations(false,ofile);

		// target wire is explicitly declared only if
		// target is a statement..
		this->_target->Write_VC_Wire_Declarations_As_Target(ofile);
	}
}

void AaAssignmentStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
	if(!this->Is_Constant())
	{
		bool full_rate = this->Is_Part_Of_Fullrate_Pipeline();

		ofile << "// " << this->To_String() << endl;
		ofile << "// " << this->Get_Source_Info() << endl;

		if(this->_target->Is_Implicit_Variable_Reference())
		{
			bool src_is_implicit = 
				(this->_source->Is_Implicit_Variable_Reference() || 
					this->_source->Is_Volatile_Function_Call() ||
							this->_source->Is_Signal_Read());
			if(src_is_implicit)
			{
				string dpe_name = this->_target->Get_VC_Datapath_Instance_Name();
				string src_name = this->_source->Get_VC_Driver_Name();
				string tgt_name = this->_target->Get_VC_Receiver_Name();

				bool cut_through = this->Get_Cut_Through();

				// target and source are both implicit.
				// instantiate a register..
				Write_VC_Interlock_Buffer(dpe_name,
						src_name,
						tgt_name,
						this->Get_VC_Guard_String(),
						this->Get_Is_Volatile(), // flow-through-flag
						full_rate,
						cut_through,
						ofile);


				if(!this->Get_Is_Volatile())
				{

					int bufval = this->Get_Buffering();
					if(bufval > 1)
					{
						ofile << "$buffering  $out " << dpe_name << " " << tgt_name << " " << bufval << endl;
					}
				}
			}

			if(!src_is_implicit || this->_source->Is_Volatile_Function_Call() 
					|| this->_source->Is_Signal_Read())
			{
				if(this->_source->Is_Volatile_Function_Call() ||
						this->_source->Is_Signal_Read())
				{
					// we will create an inport which writes to 
					// the source wire.
					this->_source->Write_VC_Datapath_Instances(NULL,ofile);
				}
				else
				{
					// target is implicit, source is not..
					this->_source->Write_VC_Datapath_Instances(this->_target,ofile);
				}
			}
		}
		else
		{
			// target is not implicit..
			// source will have an explicit wire..
			this->_source->Write_VC_Datapath_Instances(NULL,ofile);
			this->_target->Write_VC_Datapath_Instances_As_Target(ofile, this->_source);
		}
	}
}

void AaAssignmentStatement::Write_VC_Links(string hier_id,ostream& ofile)
{
	if(!this->Is_Constant())
	{

		ofile << "// " << this->To_String() << endl;
		ofile << "// " << this->Get_Source_Info() << endl;


		if(hier_id != "")
			hier_id = hier_id + "/" + this->Get_VC_Name();
		else
			hier_id = this->Get_VC_Name();

		vector<string> reqs;
		vector<string> acks;

		if(this->_target->Is_Implicit_Variable_Reference())
		{
			if(this->_source->Is_Implicit_Variable_Reference() || 
				this->_source->Is_Volatile_Function_Call() ||	
					this->_source->Is_Signal_Read())
			{
				if(!this->Get_Is_Volatile())
				{
					reqs.push_back(hier_id + "/Interlock/Sample/req");
					reqs.push_back(hier_id + "/Interlock/Update/req");
					acks.push_back(hier_id + "/Interlock/Sample/ack");
					acks.push_back(hier_id + "/Interlock/Update/ack");
					Write_VC_Link(this->_target->Get_VC_Datapath_Instance_Name(),
							reqs, acks, ofile);
					reqs.clear();
					acks.clear();
				}
			}
			else
			{
				this->_source->Write_VC_Links(hier_id,ofile);
			}
		}
		else if(!this->_target->Is_Implicit_Variable_Reference())
		{
			this->_target->Write_VC_Links_As_Target(hier_id, ofile);
			this->_source->Write_VC_Links(hier_id, ofile);
		}
	}
}

bool AaAssignmentStatement::Is_Constant()
{
	return(this->_target->Is_Constant());
}

void AaAssignmentStatement::Propagate_Constants()
{
	this->_source->Evaluate();
	this->_target->Evaluate();
	if(this->_guard_expression)
		this->_guard_expression->Evaluate();
	if(this->_source->Is_Constant() && this->_target->Is_Implicit_Variable_Reference())
	{
		this->_target->Assign_Expression_Value(this->_source->Get_Expression_Value());
	}
}

string AaAssignmentStatement::Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
{
	bool source_is_implicit = (_source->Is_Signal_Read() || 
					_source->Is_Volatile_Function_Call() ||
						_source->Is_Implicit_Variable_Reference());
	bool target_is_implicit = _target->Is_Implicit_Variable_Reference();
	// if target is not implicit variable reference, then the final register
	// will be in the source, return the reenable update transition for the
	// target.
	if(!target_is_implicit)
	{
		return(_target->Get_VC_Reenable_Update_Transition_Name(visited_elements));
	}
	// if target is implicit, but source is not implicit, then
	// return the reenable update transition for the source.
	else if (!source_is_implicit)
	{
		return(_source->Get_VC_Reenable_Update_Transition_Name(visited_elements));
	}
	else
		// if both are implicit, return the start transition of this
		// statement, since this starts the registering process..
		return(__UST(this));
}

string AaAssignmentStatement::Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
{
	bool source_is_implicit = (_source->Is_Signal_Read() ||
					_source->Is_Volatile_Function_Call() ||
						 _source->Is_Implicit_Variable_Reference());
	bool target_is_implicit = _target->Is_Implicit_Variable_Reference();
	if(!target_is_implicit)
	{
		return(_target->Get_VC_Reenable_Sample_Transition_Name(visited_elements));
	}
	// if target is implicit, but source is not implicit, then
	// return the reenable update transition for the source.
	else if (!source_is_implicit)
	{
		return(_source->Get_VC_Reenable_Sample_Transition_Name(visited_elements));
	}
	else
		// if both are implicit, return the start transition of this
		// statement, since this starts the registering process..
		return(__SST(this));
}

string AaAssignmentStatement::Get_VC_Sample_Start_Transition_Name()
{
	bool source_is_implicit = (_source->Is_Signal_Read() ||
					_source->Is_Volatile_Function_Call() ||
						 _source->Is_Implicit_Variable_Reference());
	bool target_is_implicit = this->_target->Is_Implicit_Variable_Reference();
	// if target is implicit or interface object..
	if(source_is_implicit && target_is_implicit)
	{
		return(this->AaRoot::Get_VC_Sample_Start_Transition_Name());

	}
	else if(!target_is_implicit)
	{
		return(this->_target->Get_VC_Sample_Start_Transition_Name());
	}
	else
	{
		return(this->_source->Get_VC_Sample_Start_Transition_Name());
	}
}

string AaAssignmentStatement::Get_VC_Sample_Completed_Transition_Name()
{
	bool source_is_implicit = (_source->Is_Signal_Read() ||
					_source->Is_Volatile_Function_Call() ||
						 _source->Is_Implicit_Variable_Reference());
	bool target_is_implicit = this->_target->Is_Implicit_Variable_Reference();
	//  if target is implicit or interface object..
	if(source_is_implicit && target_is_implicit)
	{
		return(this->AaRoot::Get_VC_Sample_Completed_Transition_Name());

	}
	else if(!target_is_implicit)
	{
		return(this->_target->Get_VC_Sample_Completed_Transition_Name());
	}
	else
	{
		return(this->_source->Get_VC_Sample_Completed_Transition_Name());
	}
}

string AaAssignmentStatement::Get_VC_Update_Start_Transition_Name()
{
	bool source_is_implicit = (_source->Is_Signal_Read() ||
					_source->Is_Volatile_Function_Call() ||
						 _source->Is_Implicit_Variable_Reference());
	bool target_is_implicit = this->_target->Is_Implicit_Variable_Reference();
	// if target is implicit or interface object..
	if(source_is_implicit && target_is_implicit)
	{
		return(this->AaRoot::Get_VC_Update_Start_Transition_Name());

	}
	else if(!target_is_implicit)
	{
		return(this->_target->Get_VC_Update_Start_Transition_Name());
	}
	else
	{
		return(this->_source->Get_VC_Update_Start_Transition_Name());
	}
}

string AaAssignmentStatement::Get_VC_Update_Completed_Transition_Name()
{
	bool source_is_implicit = (_source->Is_Signal_Read() || 
					_source->Is_Volatile_Function_Call() ||
					_source->Is_Implicit_Variable_Reference());
	bool target_is_implicit = this->_target->Is_Implicit_Variable_Reference();
	// if target is implicit or interface object..
	if(source_is_implicit && target_is_implicit)
	{
		return(this->AaRoot::Get_VC_Update_Completed_Transition_Name());

	}
	else if(!target_is_implicit)
	{
		return(this->_target->Get_VC_Update_Completed_Transition_Name());
	}
	else
	{
		return(this->_source->Get_VC_Update_Completed_Transition_Name());
	}
}



void AaAssignmentStatement::Replace_Source_Expression(AaExpression* old_arg, AaSimpleObjectReference* new_arg)
{
	if(this->_source == old_arg)
	{
		assert(old_arg->Is_Implicit_Variable_Reference());
		old_arg->Set_Associated_Statement(NULL);
		old_arg->Remove_Target_Reference(this);
		this->Remove_Source_Reference(old_arg);
		this->_source_objects.erase(old_arg->Get_Object());

		this->_source = new_arg;
		new_arg->Set_Associated_Statement(this);
		new_arg->Add_Target_Reference(this);
		this->Add_Source_Reference(new_arg);
		new_arg->Map_Source_References(this->_source_objects);
	}
	else
	{
		this->_source->Replace_Uses_By(old_arg,new_arg);
		new_arg->Map_Source_References(this->_source_objects);
	}

}
//---------------------------------------------------------------------
// AaCallStatement
//---------------------------------------------------------------------
AaCallStatement::AaCallStatement(AaScope* parent_tpr,
		string func_name,
		vector<AaExpression*>& inargs, 
		vector<AaObjectReference*>& outargs,
		int lineno): AaStatement(parent_tpr)
{
	_is_volatile = false;
	_buffering = 1;

	this->_function_name = func_name;
	this->Set_Line_Number(lineno);
	this->_called_module = NULL;

	for(unsigned int i = 0; i < inargs.size(); i++)
	{
		inargs[i]->Set_Associated_Statement(this);
		inargs[i]->Set_Is_Intermediate(true);
		this->_input_args.push_back(inargs[i]);
	}

	for(unsigned int i = 0; i < outargs.size(); i++)
	{
		outargs[i]->Set_Associated_Statement(this);
		outargs[i]->Set_Is_Intermediate(false);
		outargs[i]->Set_Is_Target(true);

		this->_output_args.push_back(outargs[i]);
	}
}

void AaCallStatement::Map_Targets()
{
	for(unsigned int i = 0; i < this->_output_args.size(); i++)
	{
		this->Map_Target(this->_output_args[i]);
	}
}

AaCallStatement::~AaCallStatement() {};

bool AaCallStatement::Get_Is_Volatile()
{
	return(_is_volatile);
}

bool AaCallStatement::Can_Be_Combinationalized()
{
	AaModule* cm = (AaModule*) _called_module;
	return((cm != NULL) && (cm->Get_Volatile_Flag()));
}


void AaCallStatement::Replace_Input_Argument(AaExpression* old_arg, AaSimpleObjectReference* new_arg)
{
	for(unsigned int i = 0; i < _input_args.size(); i++)
	{
		AaExpression* arg = _input_args[i];

		if(arg == old_arg)
		{
			// remove links to old-arg
			arg->Remove_Target_Reference(this);
			this->Remove_Source_Reference(arg);

			if(arg->Is_Implicit_Variable_Reference())
			{
				this->_source_objects.erase(arg->Get_Object());
			}
				
			if(arg->Get_Associated_Statement() == this)
				arg->Set_Associated_Statement(NULL);

			_input_args[i] = new_arg;

			new_arg->Add_Target_Reference(this);
			this->Add_Source_Reference(new_arg);
			new_arg->Map_Source_References(this->_source_objects);

			new_arg->Set_Associated_Statement(this);
			break;
		}
	}
}

void AaCallStatement::Set_Is_Volatile(bool v)
{
	_is_volatile = v;

	for(unsigned int i = 0; i < _input_args.size(); i++)
	{
		_input_args[i]->Set_Is_Intermediate(v);
	}
}
void AaCallStatement::Set_Pipeline_Parent(AaStatement* dws)
{
	_pipeline_parent = dws;

	//
	// set buffering to 2 if dws and called-module are both full-rate.
	if((dws != NULL) && (this->_called_module != NULL) && this->_called_module->Get_Pipeline_Flag() && 
			this->_called_module->Get_Pipeline_Full_Rate_Flag() && dws->Get_Pipeline_Full_Rate_Flag())
	{
		//if(this->_buffering < 2) this->_buffering = 2;
	}

	for(unsigned int i = 0; i < _input_args.size(); i++)
	{
		_input_args[i]->Set_Pipeline_Parent(dws);
	}

	for(unsigned int i = 0; i < _output_args.size(); i++)
	{
		_output_args[i]->Set_Pipeline_Parent(dws);
	}
}

AaExpression* AaCallStatement::Get_Input_Arg(unsigned int index)
{
	assert(index < this->Get_Number_Of_Input_Args());
	return(this->_input_args[index]);
}
AaObjectReference* AaCallStatement::Get_Output_Arg(unsigned int index)
{
	assert(index < this->Get_Number_Of_Output_Args());
	return(this->_output_args[index]);
}

void AaCallStatement::Print(ostream& ofile)
{
	AaModule* cm = (AaModule*) _called_module;
	string guard_string;

	AaScope* pscope = this->Get_Scope();
	AaModule* pm = NULL;
	if(pscope->Is_Module())
		pm = (AaModule*) pscope;

	string pm_guard_string;
	if((pm != NULL) && (pm->Get_Print_Guard_String() != ""))
	{
		pm_guard_string = pm->Get_Print_Guard_String();
	}

	string cg_var;
	string pprefix;

	if((pm_guard_string != "") ||
			(cm->Get_Macro_Flag() && AaProgram::_print_inlined_functions_in_caller))
	{
		pprefix = (((pm != NULL) && (pm->Get_Print_Prefix() != "")) ?
					pm->Get_Print_Prefix()  + "_" : "")  + 
					this->Get_Function_Name() + "_" + 
					Int64ToStr(this->Get_Index()) + "_";

		if(cm->Get_Macro_Flag() && AaProgram::_print_inlined_functions_in_caller)
		{

			cm->Set_Print_Prefix(pprefix);
			ofile << "// begin inlined macro " << this->Get_Function_Name() << endl;
			if(cm->Get_Number_Of_Input_Arguments() > 0) 
			{
				for(int arg_index = 0; arg_index < cm->Get_Number_Of_Input_Arguments(); arg_index++)
				{	
					cm->Set_Print_Remap(cm->Get_Input_Argument(arg_index), this->_input_args[arg_index]);
				}
			}	

			if(cm->Get_Number_Of_Output_Arguments() > 0)
			{
				for(int arg_index = 0; arg_index < cm->Get_Number_Of_Output_Arguments(); arg_index++)
				{	
					cm->Set_Print_Remap(cm->Get_Output_Argument(arg_index), this->_output_args[arg_index]);
				}

			}

			cg_var = "macro_guard_" + pprefix;
			bool guard_flag = false;


			if(this->_guard_expression != NULL)
			{
				string cge =  this->_guard_expression->To_String();
				string bgs = (this->_guard_complement ? "(~" + cge + ")" : cge);
				if(pm_guard_string != "")
				{
					ofile << "$volatile " << cg_var << " := (" << bgs << " & " << pm_guard_string << ")" << endl;
				}
				else
				{
					ofile << "$volatile " << cg_var << " := " << bgs << endl;
				}
				guard_flag = true;
			}
			else if(pm_guard_string != "")
			{
				guard_flag = true;
				ofile << "$volatile " << cg_var << " := " << pm_guard_string << endl;
			}

			if(guard_flag)
			{
				cm->Set_Print_Guard_String(cg_var);
			}

			cm->Print_Body(ofile);

			ofile << "// end inlined macro " << this->Get_Function_Name() << endl;

			cm->Clear_Print_Prefix();
			cm->Clear_Print_Remap();
			cm->Clear_Print_Guard_String();

			return;
		}
	}

	if(this->_guard_expression != NULL)
	{
		string cge =  this->_guard_expression->To_String();
		string bgs = (this->_guard_complement ? "(~" + cge + ")" : cge);
			
		cg_var = "macro_guard_" + pprefix;

		if(pm_guard_string != "")
		{
			ofile << "$volatile " << cg_var << " := (" << bgs << " & " << pm_guard_string << ")" << endl;
			guard_string = "$guard (" + cg_var + ") ";
		}
		else
		{
			guard_string =  string("$guard (") + 
						(this->_guard_complement ? "~" : "") +  
						this->_guard_expression->To_String() + ") ";
		}
	}
	else if(pm_guard_string != "")
	{
		ofile << "$volatile " << cg_var << " := " << pm_guard_string << endl;
		guard_string = "$guard (" + cg_var + ") ";
	}

	if(this->Get_Is_Volatile() || (AaProgram::_combinationalize_statements && cm->Get_Volatile_Flag()))
		ofile << " $volatile ";

	// not inlined or macro
	ofile << this->Tab();
	ofile << guard_string;
	ofile << "$call ";


	ofile << this->Get_Function_Name();

	ofile << " (";
	for(unsigned int i = 0; i < this->Get_Number_Of_Input_Args(); i++)
	{
		this->_input_args[i]->Print(ofile);
		ofile << " ";
	}
	ofile << ")";

	ofile << " (";
	for(unsigned int i = 0; i < this->Get_Number_Of_Output_Args(); i++)
	{
		this->_output_args[i]->Print(ofile);
		ofile << " ";
	}
	ofile << ") ";

	int buf_val = this->Get_Buffering();
	if(buf_val > 1)
		ofile << " $buffering " << buf_val;

	if(this->_mark != "")
		ofile << " $mark " << _mark << " ";

	if(this->_synch_statements.size() > 0)
	{
		ofile << " $synch (";
		for(set<AaStatement*>::iterator siter = _synch_statements.begin(), fiter = _synch_statements.end();
				siter != fiter; siter++)
		{
			if(_synch_update_flag_map[(*siter)])
				 ofile << " $update "; 

			ofile << (*siter)->Get_Mark();
			ofile << " ";
		}
		ofile << ")  ";
	}

	ofile << endl;
}

void AaCallStatement::Set_Called_Module(AaModule* m)
{ 
	this->_called_module = m; 
	if(this->Get_Is_Volatile() != m->Get_Volatile_Flag())
	{
		AaRoot::Error("volatility of call statement not the same as that of called module", this);
	}

	AaStatement* dws = this->Get_Pipeline_Parent();

	if((dws != NULL) && (this->_called_module != NULL) && this->_called_module->Get_Pipeline_Flag() && 
			this->_called_module->Get_Pipeline_Full_Rate_Flag() && dws->Get_Pipeline_Full_Rate_Flag())
	{
		//if(this->_buffering < 2) this->_buffering = 2;
	}
}

void AaCallStatement::Map_Source_References()
{
	AaModule* called_module = AaProgram::Find_Module(this->_function_name);
	if(called_module != NULL)
	{
		called_module->Increment_Number_Of_Times_Called();
		this->Set_Called_Module(called_module);

		AaScope* root_scope = this->Get_Root_Scope();
		assert(root_scope && root_scope->Is("AaModule"));
		AaModule* caller_module = (AaModule*) root_scope;
		AaProgram::Add_Call_Pair(caller_module,called_module);

		if(called_module->Get_Number_Of_Input_Arguments() != this->_input_args.size())
		{
			AaRoot::Error("incorrect number of input arguments in function call", this );
		}


		if(called_module->Get_Number_Of_Output_Arguments() != this->_output_args.size())
		{
			AaRoot::Error("incorrect number of output arguments in function call", this );
		}
	}
	else
	{
		AaRoot::Error("module " +  this->_function_name  + " not found!",this);
	}


	for(unsigned int i=0; i < this->_input_args.size(); i++)
	{
		this->_input_args[i]->Map_Source_References(this->_source_objects);
		if(called_module != NULL)
		{
			// transfer the type of inarg to inargument.
			this->_input_args[i]->Set_Type(called_module->Get_Input_Argument(i)->Get_Type());

			// inarg -> inargument
			this->_input_args[i]->Add_Source_Reference(called_module->Get_Input_Argument(i));
			called_module->Get_Input_Argument(i)->Add_Target_Reference(this->_input_args[i]);
			called_module->Get_Input_Argument(i)->
				Set_Addressed_Object_Representative(this->_input_args[i]->Get_Addressed_Object_Representative());
		}
	}
	for(unsigned int i=0; i < this->_output_args.size(); i++)
	{
		this->_output_args[i]->Map_Source_References_As_Target(this->_source_objects);
		if(called_module != NULL)
		{

			// transfer the type of outarg to ioutargument.
			this->_output_args[i]->Set_Type(called_module->Get_Output_Argument(i)->Get_Type());

			// outarg <- outargument
			this->_output_args[i]->Add_Target_Reference(called_module->Get_Output_Argument(i));
			called_module->Get_Output_Argument(i)->Add_Source_Reference(this->_output_args[i]);
			this->_output_args[i]->
				Set_Addressed_Object_Representative(called_module->Get_Output_Argument(i)->Get_Addressed_Object_Representative());
		}
	}

	if(this->_guard_expression)
	{
		this->_guard_expression->Map_Source_References(this->_source_objects);
		if(!this->_guard_expression->Is_Implicit_Variable_Reference())
		{
			AaRoot::Error("guard variable must be implicit (SSA)", this);
		}
	}
}


// return true if one of the sources or targets is a pipe.
bool AaCallStatement::Can_Block(bool pipeline_flag)
{
	if(this->AaStatement::Can_Block(pipeline_flag))
		return(true);

	if(((AaModule*) this->_called_module)->Can_Block(pipeline_flag))
		return(true);

	return(false);
}

// For foreign module, we have to ensure that all arguments 
// have native C types.
void AaCallStatement::PrintC_Call_To_Foreign_Module(ofstream& ofile)
{
	assert(this->Get_Called_Module() && this->Get_Called_Module()->Is("AaModule"));

	if(this->Get_Is_Volatile())
	{
		//
		// volatile statements should not depend 
		// on anything which is indexed higher than
		// the statement.
		//
		this->Check_Volatility_Ordering_Condition();
	}

	AaModule* m = (AaModule*) this->Get_Called_Module();
	if(!m->Can_Have_Native_C_Interface())
	{
		AaRoot::Error("call to foreign module with unsupported argument types." , this);
		return;
	}

	// input argument expressions.
	for(unsigned int i=0; i < this->_input_args.size(); i++)
	{
		if(this->_input_args[i]->Get_Type()->Is_Integer_Type())
		{
			ofile << this->_input_args[i]->Get_Type()->Native_C_Name() << " __" 
				<< this->_input_args[i]->C_Reference_String() << "__" << this->Get_Index() 
					<< ";\\" << endl;	
		}
	}

	// print the declarations for output variable recipients of
	// the call.
	for(unsigned int i=0; i < this->_output_args.size(); i++)
	{
		if(this->_output_args[i]->Get_Type()->Is_Integer_Type())
		{
			ofile << this->_output_args[i]->Get_Type()->Native_C_Name() << " __" 
				<< this->_output_args[i]->C_Reference_String() << "__"
				<< this->Get_Index() << ";\\" << endl;	
		}
	}


	// now one has to implement the whole shebang.		
	bool first_one = true;
	ofile << ((AaModule*)this->Get_Called_Module())->Get_C_Outer_Wrap_Function_Name()
		<< "(";
	for(unsigned int i=0; i < this->_input_args.size(); i++)
	{
		if(!first_one)
			ofile << ", ";
		Print_C_Value_Expression(this->_input_args[i]->C_Reference_String(),
				this->_input_args[i]->Get_Type(), ofile);
		first_one = false;
	}

	for(unsigned int i=0; i < this->_output_args.size(); i++)
	{
		if(!first_one)
			ofile << ", ";

		ofile << " &";
		if(this->_output_args[i]->Get_Type()->Is_Integer_Type())
		{
			ofile << "__";
		}
		ofile << this->_output_args[i]->C_Reference_String() << "__" << this->Get_Index();
		first_one = false;
	}
	ofile <<  ");\\" << endl;

	// type conversions at the outputs.
	for(unsigned int i=0; i < this->_output_args.size(); i++)
	{
		if(this->_output_args[i]->Get_Type()->Is_Integer_Type())
		{
			Print_C_Uint64_To_BitVector_Assignment("__" + this->_output_args[i]->C_Reference_String() + "__" + Int64ToStr(this->Get_Index()),
					this->_output_args[i]->C_Reference_String(),
					this->_output_args[i]->Get_Type(), ofile);
		}
	}

}

void AaCallStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "// " << this->To_String(); //includes newline
	headerfile << "\n#define " << this->Get_C_Macro_Name() << " ";
	srcfile <<  this->Get_C_Macro_Name() << "; " << endl;

	if(this->Get_Guard_Expression())
	{
		this->Get_Guard_Expression()->PrintC_Declaration(headerfile);
		this->Get_Guard_Expression()->PrintC(headerfile);
		if(!this->Get_Guard_Expression()->Is_Constant())
			Print_C_Assert_If_Bitvector_Undefined(this->Get_Guard_Expression()->C_Reference_String(), headerfile);
	}

	for(unsigned int i=0; i < this->_input_args.size(); i++)
	{
		this->_input_args[i]->PrintC_Declaration(headerfile);
	}

	for(unsigned int i=0; i < this->_output_args.size(); i++)
	{
		if(this->_output_args[i]->Get_Root_Object() != ((AaRoot*) this))
		{
			this->_output_args[i]->PrintC_Declaration(headerfile);
		}
	}



	if(this->Get_Guard_Expression())
	{
		headerfile << "if (" ;
		if(this->Get_Guard_Complement()) 
			headerfile << "!";
		Print_C_Value_Expression(this->Get_Guard_Expression()->C_Reference_String(), this->Get_Guard_Expression()->Get_Type(), headerfile);
		headerfile << ") {\\" << endl;
	}

	for(unsigned int i=0; i < this->_input_args.size(); i++)
	{
		this->_input_args[i]->PrintC(headerfile);
	}

	if(this->Get_Called_Module()->Get_Foreign_Flag())
	{
		this->PrintC_Call_To_Foreign_Module(headerfile);
	}
	else
	{
		bool first_one = true;
		headerfile << ((AaModule*)this->Get_Called_Module())->Get_C_Inner_Wrap_Function_Name()
			<< "(";
		for(unsigned int i=0; i < this->_input_args.size(); i++)
		{
			if(!first_one)
				headerfile << ", ";
			headerfile << " &(" << this->_input_args[i]->C_Reference_String() << ")";
			first_one = false;
		}

		for(unsigned int i=0; i < this->_output_args.size(); i++)
		{
			if(!first_one)
				headerfile << ", ";
			headerfile << "&(";
			headerfile << this->_output_args[i]->C_Reference_String() << ")";
			first_one = false;
		}
		headerfile <<  ");\\" << endl;

	}

	// pass results to output expressions.
	for(unsigned int i=0; i < this->_output_args.size(); i++)
		this->_output_args[i]->PrintC(headerfile);

	if(this->Get_Guard_Expression())
		headerfile << "}\\" << endl;
	headerfile << ";" << endl;
}

void AaCallStatement::PrintC_Implicit_Declarations(ofstream& ofile)
{
	for(unsigned int i=0; i < this->_output_args.size(); i++)
	{
		if(this->_output_args[i]->Get_Root_Object() == ((AaRoot*) this))
		{
			this->_output_args[i]->PrintC_Declaration(ofile);
		}
	}
}

void AaCallStatement::Write_VC_Control_Path(ostream& ofile)
{
	if(this->_called_module->Get_Foreign_Flag())
	{
		AaRoot::Info("ignored foreign module call to " + this->_called_module->Get_Label());
		return;
	}

	if(this->Get_Is_Volatile())
	{
		//
		// volatile statements should not depend 
		// on anything which is indexed higher than
		// the statement.
		//
		this->Check_Volatility_Ordering_Condition();
	}

	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	ofile << ";;[" << this->Get_VC_Name() << "] { // call statement " << this->Get_Source_Info() << endl;

	// nothing should happen.
	if(this->Get_Guard_Expression() != NULL)
		this->Get_Guard_Expression()->Write_VC_Control_Path(ofile);

	ofile << "||[in_args] { // input arguments" << endl;
	for(int idx = 0; idx < _input_args.size(); idx++)
		_input_args[idx]->Write_VC_Control_Path(ofile);
	ofile << "}" << endl;

	ofile << "||[SplitProtocol] { " << endl;
	ofile << ";;[Sample] { " << endl;
	ofile << "$T [crr] $T [cra]" << endl;
	ofile << "}" << endl;
	ofile << ";;[Update] { " << endl;
	ofile << "$T [ccr] $T [cca]" << endl;
	ofile << "}" << endl;
	ofile << "}" << endl;
	ofile << "||[out_args] { // output arguments" << endl;
	for(int idx = 0; idx < _output_args.size(); idx++)
		_output_args[idx]->Write_VC_Control_Path_As_Target(ofile);
	ofile << "}" << endl;

	ofile << "} // end call-statement " << this->Get_VC_Name() << endl;
}


void AaCallStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	if(this->_called_module->Get_Foreign_Flag())
	{
		AaRoot::Info("ignored foreign module call to " + this->_called_module->Get_Label());
		return;
	}

	for(int idx = 0; idx < _input_args.size(); idx++)
	{
		_input_args[idx]->Write_VC_Constant_Wire_Declarations(ofile);
	}
}

void AaCallStatement::Write_VC_Wire_Declarations(ostream& ofile)
{

	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	/*
	if(this->_called_module->Get_Foreign_Flag())
	{
		AaRoot::Info("ignored foreign module call to " + this->_called_module->Get_Label());
		return;
	}
	*/


	for(int idx = 0; idx < _input_args.size(); idx++)
		_input_args[idx]->Write_VC_Wire_Declarations(false, ofile);
	for(int idx = 0; idx < _output_args.size(); idx++)
	{
		if(!_output_args[idx]->Is_Implicit_Variable_Reference())
		{
			// will have to explicitly declare this wire.
			// because a normal store target always
			// has a declared source.  In the case of the
			// call statement, this declared source is absent.
			// hence declare it.
			Write_VC_Wire_Declaration(_output_args[idx]->Get_VC_Driver_Name(),
					_output_args[idx]->Get_Type(),
					ofile);
		}

		// the remaining wires needed ..
		_output_args[idx]->Write_VC_Wire_Declarations_As_Target(ofile);
	}
}
void AaCallStatement::Write_VC_Datapath_Instances(ostream& ofile)
{

	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	if(this->_called_module->Get_Foreign_Flag())
	{
		AaRoot::Info("ignored foreign module call to " + this->_called_module->Get_Label());
		return;
	}

	int delay = (this->Get_Is_Volatile() ? 0 : ((AaModule*)_called_module)->Get_Delay());
	bool full_rate = this->Is_Part_Of_Fullrate_Pipeline();

	vector<pair<string,AaType*> > inargs, outargs;

	for(int idx = 0; idx < _input_args.size(); idx++)
	{
		_input_args[idx]->Write_VC_Datapath_Instances(NULL, ofile);
		inargs.push_back(pair<string,AaType*>(_input_args[idx]->Get_VC_Driver_Name(),
					_input_args[idx]->Get_Type()));
	}

	for(int idx = 0; idx < _output_args.size(); idx++)
	{
		_output_args[idx]->Write_VC_Datapath_Instances_As_Target(ofile,NULL);
		outargs.push_back(pair<string,AaType*>(_output_args[idx]->Get_VC_Receiver_Name(),
					_output_args[idx]->Get_Type()));
	}

	string dpe_name = this->Get_VC_Name() + "_call";
	Write_VC_Call_Operator(dpe_name,
			_function_name,
			inargs,
			outargs,
			this->Get_VC_Guard_String(),
			this->Get_Is_Volatile(),  // flow-through
			full_rate,		      
			ofile);

	// no need for additional buffering if volatile..
	if(this->Get_Is_Volatile())
		return;

	ofile << "$delay " << dpe_name <<  " " << delay << endl;

	// extreme pipelining.
	AaStatement* dws = this->Get_Pipeline_Parent();
	int buffering = this->Get_Buffering();

	//
	// Rationalized earlier...
	//if((dws != NULL)  && (dws->Get_Pipeline_Full_Rate_Flag()))
	//{
	//if(buffering < 2) 
	//buffering = 2;
	//}

	//
	// input buffering is used to decouple the
	// two sides.
	//
	for(int i = 0; i < inargs.size(); i++)
	{
		string src_name = inargs[i].first;
		ofile << "$buffering  $in " << dpe_name << " "
			<< src_name << " " << buffering << endl;
	}

	//
	// output buffering is used to decouple the
	// two sides.
	//
	for(int i = 0; i < outargs.size(); i++)
	{
		string tgt_name = outargs[i].first;
		ofile << "$buffering  $out " << dpe_name << " "
			<< tgt_name << " " << buffering << endl;
	}
}

void AaCallStatement::Write_VC_Links(string hier_id, ostream& ofile)
{

	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	if(this->_called_module->Get_Foreign_Flag())
	{
		AaRoot::Info("ignored foreign module call to " + this->_called_module->Get_Label());
		return;
	}

	hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name());

	vector<string> reqs, acks;

	for(int idx = 0; idx < _input_args.size(); idx++)
	{
		string ih = Augment_Hier_Id(hier_id, "in_args");
		_input_args[idx]->Write_VC_Links(ih, ofile);

	}
	for(int idx = 0; idx < _output_args.size(); idx++)
	{
		string oh = Augment_Hier_Id(hier_id,"out_args");
		_output_args[idx]->Write_VC_Links_As_Target(oh, ofile);
	}

	if(this->Get_Is_Volatile())
		return;

	string sample_region = hier_id + "/SplitProtocol/Sample";
	string update_region = hier_id + "/SplitProtocol/Update";

	reqs.push_back(sample_region + "/crr");
	reqs.push_back(update_region + "/ccr");
	acks.push_back(sample_region + "/cra");
	acks.push_back(update_region + "/cca");

	Write_VC_Link(this->Get_VC_Name() + "_call",reqs,acks,ofile);
}


void AaCallStatement::Propagate_Constants()
{
	for(int idx = 0; idx < _input_args.size(); idx++)
	{
		_input_args[idx]->Evaluate();
	}

	if(this->_guard_expression)
		this->_guard_expression->Evaluate();
}

//---------------------------------------------------------------------
// AaBlockStatement: public AaStatement
//---------------------------------------------------------------------
AaBlockStatement::AaBlockStatement(AaScope* scope,string label):AaStatement(scope) 
{
	this->_label = label;
	this->_statement_sequence = NULL;
	if(label != "" && scope != NULL)
		scope->Map_Child(label,this);
	this->_has_declared_storage_object = false;
}

AaBlockStatement::~AaBlockStatement() {}

void AaBlockStatement::Add_Object(AaObject* obj) 
{ 
	if(AaProgram::Is_Integer_Parameter(obj->Get_Name()))
	{
		AaRoot::Error("Object " + obj->Get_Name() + " shadows parameter name. ", obj);
		return;
	}

	if(this->Find_Child_Here(obj->Get_Name()) == NULL)
	{ 
		this->_objects.push_back(obj);
		this->Map_Child(obj->Get_Name(),obj);
		if(obj->Is("AaStorageObject"))
		{
			AaProgram::Add_Storage_Dependency_Graph_Vertex(obj);
			this->Set_Has_Declared_Storage_Object(true);
		}
	}
	else
	{
		AaRoot::Error("object " + obj->Get_Name() + " already exists in " + this->Get_Label(),obj);
	}
}

void AaBlockStatement::Add_Export(string formal, string actual)
{
	this->_exports[formal] = actual;

}

void AaBlockStatement::Coalesce_Storage()
{
	for(int idx = 0; idx < _objects.size(); idx++)
	{
		if(_objects[idx]->Is("AaStorageObject"))
			_objects[idx]->Coalesce_Storage();
	}

	if(this->_statement_sequence)
		this->_statement_sequence->Coalesce_Storage();
}

void AaBlockStatement::Print(ostream& ofile)
{

	if(this->Get_Label() != "")
		ofile << "[" << this->Get_Label() << "]" << endl;
	else
		ofile << endl;

	ofile << this->Tab() << "{" << endl;
	this->Print_Objects(ofile);
	this->Print_Statement_Sequence(ofile);
	ofile << this->Tab() << "}" << endl;

	// print exports.
	if(this->_exports.size() > 0)
	{
		ofile << "(" ;
		for(map<string,string>::iterator iter = _exports.begin(); iter != _exports.end(); iter++)
		{
			ofile << " " << (*iter).first << " => " << (*iter).second << " ";
		}
		ofile << ")" << endl ;
	}
}

void AaBlockStatement::Write_C_Object_Declarations_And_Initializations(ofstream& ofile)
{
	bool has_objs_for_initialization = false;
	vector<AaObject*> init_objs;
	for(unsigned int i = 0; i < this->_objects.size(); i++)
	{
		AaObject* obj = this->_objects[i];
		if(obj->Is_Storage_Object() || obj->Is_Pipe_Object() || obj->Is_Constant())
		{
			has_objs_for_initialization = true;
			init_objs.push_back(obj);
		}

		obj->PrintC_Declaration(ofile);
	}
	if(has_objs_for_initialization)
	{
		string init_objs_flag = this->Get_C_Name() + "_init_objects_flag";
		ofile << "static char " << init_objs_flag << " = 1;\\" << endl;
		ofile << "if (" << init_objs_flag << ") {\\" << endl;
		ofile << init_objs_flag << "= 0;\\" << endl;
		for(int I = 0, fI = init_objs.size(); I < fI; I++)
		{
			AaObject* iobj = init_objs[I];
			iobj->PrintC_Global_Initialization(ofile);
		}
		ofile << " }\\" << endl;
	}
}

void AaBlockStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	map<string, AaType*> export_type_map;
	map<string, string> renamed_export_map;

	AaModule* m = this->Get_Module();
	bool static_flag = ((m != NULL) && (m->Static_Flag_In_C()));
	// setup export type map.
	for(map<string,string>::iterator iter = _exports.begin(), fiter = _exports.end();
			iter != fiter; iter++)
	{
		string internal_name = (*iter).first;		
		string exported_name = (*iter).second;

		AaRoot* iroot = this->Find_Child(internal_name);
		AaType* iroot_type = NULL;


		if(iroot == NULL)
		{
			AaRoot::Error("unresolved export " + internal_name + " => " + exported_name, this);
		}
		else
			// we need to get the type of iroot.
		{
			if(iroot->Is_Expression())
			{	
				iroot_type = ((AaExpression*) iroot)->Get_Type();
			}
			else if(iroot->Is_Object())
			{
				iroot_type = ((AaObject*) iroot)->Get_Type();
			}
			else
			{
				// exports can only be of objects or expressions.
				assert(0);
			}


			exported_name += "__" + iroot->C_Reference_String();
		}

		if(iroot_type != NULL)
		{
			export_type_map[exported_name] = iroot_type;
			renamed_export_map[exported_name] = iroot->C_Reference_String();
		}
	}
	// declare the objects which need to be exported.
	headerfile << "\n#define " << this->Get_Export_Declare_Macro() << " ";
	for(map<string,AaType*>::iterator iter = export_type_map.begin(), fiter = export_type_map.end();
			iter != fiter; iter++)
	{
		Print_C_Declaration((*iter).first, static_flag, (*iter).second, headerfile);
	}
	this->Write_C_Object_Declarations_And_Initializations(headerfile);
	if(this->_statement_sequence != NULL)
	{
		this->_statement_sequence->PrintC_Implicit_Declarations(headerfile);
	}
	headerfile << endl;

	srcfile  << this->Get_Export_Declare_Macro() << "; " << endl;
	srcfile << "{" << endl;
	if(this->_statement_sequence != NULL)
	{
		this->_statement_sequence->PrintC(srcfile, headerfile);
	}
	headerfile << ";" << endl;

	// ship exports out of the block
	headerfile << "\n#define " << this->Get_Export_Apply_Macro() << " ";
	for(map<string,string>::iterator iter = renamed_export_map.begin(), fiter = renamed_export_map.end();
			iter != fiter; iter++)
	{
		string internal_name = (*iter).second;		
		string exported_name = (*iter).first;
		AaType* exp_type = NULL;
		map<string,AaType*>::iterator titer = export_type_map.find(exported_name);
		if(titer != export_type_map.end())
		{	
			exp_type = (*titer).second;
			Print_C_Assignment(exported_name, internal_name, exp_type, headerfile);
		}
	}
	headerfile << ";" << endl;
	srcfile << this->Get_Export_Apply_Macro() << ";" << endl;
	srcfile << "}" << endl;
}

void AaBlockStatement::Map_Targets()
{
	if(this->_statement_sequence)
		this->_statement_sequence->Map_Targets();	

	// map exports
	for (map<string,string>::iterator miter = this->_exports.begin(), fiter = this->_exports.end();
			miter != fiter; miter++)
	{
		string formal = (*miter).first;
		string actual = (*miter).second;

		AaRoot* formal_ref = this->Find_Child(formal);
		if(formal_ref == NULL)
		{
			AaRoot::Error("in export, did not find object " + formal + " in " + this->Get_Label(),this);
		}
		else
		{
			if(this->Get_Scope() != NULL)
			{
				this->Get_Scope()->Map_Child(actual, formal_ref);
			}
			else
			{
				AaRoot::Warning("export " + formal + " => " + actual + " ignored for block " + this->Get_Label(), this);
			}
		}
	}
}

void AaBlockStatement::Map_Source_References()
{
	if(this->_statement_sequence)
		this->_statement_sequence->Map_Source_References();
}

// Can the execution of the block be blocked?
// Yes, if one of the constituent statements can block
bool AaBlockStatement::Can_Block(bool pipeline_flag)
{
	if(this->AaStatement::Can_Block(pipeline_flag))
		return(true);

	if(this->_statement_sequence == NULL)
		return(false);

	for(int i = 0, imax = this->_statement_sequence->Get_Statement_Count(); i < imax; i++)
	{
		if(this->_statement_sequence->Get_Statement(i)->Can_Block(pipeline_flag))
		{	
			return(true);
		}

	}	
	return(false);
}



void AaBlockStatement::Write_VC_Constant_Declarations(ostream& ofile)
{

	if(this->_statement_sequence != NULL)
		for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			this->_statement_sequence->Get_Statement(idx)->Write_VC_Constant_Declarations(ofile);
		}

	ofile << "// constant-object-declarations for block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	for(int idx = 0; idx < _objects.size(); idx++)
	{
		if(_objects[idx]->Is("AaConstantObject"))
		{
			_objects[idx]->Write_VC_Model(ofile);
		}
		else if(_objects[idx]->Is("AaStorageObject"))
		{
			((AaStorageObject*)(_objects[idx]))->Write_VC_Load_Store_Constants(ofile);
		}
	}
}
void AaBlockStatement::Write_VC_Pipe_Declarations(ostream& ofile)
{
	ofile << "// pipe-declarations for block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	for(int idx = 0; idx < _objects.size(); idx++)
	{
		if(_objects[idx]->Is("AaPipeObject"))
			((AaPipeObject*)(_objects[idx]))->Write_VC_Model(ofile);
	}

	if(this->_statement_sequence != NULL)
		for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			this->_statement_sequence->Get_Statement(idx)->Write_VC_Pipe_Declarations(ofile);
		}
}

void AaBlockStatement::Write_VC_Memory_Space_Declarations(ostream& ofile)
{

	ofile << "// memory-space-declarations for block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	for(int idx = 0; idx < _objects.size(); idx++)
	{
		if(_objects[idx]->Is("AaStorageObject"))
		{
			((AaStorageObject*)(_objects[idx]))->Write_VC_Model(ofile);
		}
	}

	if(this->_statement_sequence != NULL)
		for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			this->_statement_sequence->Get_Statement(idx)->Write_VC_Memory_Space_Declarations(ofile);
		}
}

void AaBlockStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

	ofile << "// constant-declarations for block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	for(int idx = 0; idx < _objects.size(); idx++)
	{
		if(_objects[idx]->Is("AaConstantObject"))
		{
			((AaStorageObject*)(_objects[idx]))->Write_VC_Model(ofile);
		}
	}

	if(this->_statement_sequence != NULL)
		for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			this->_statement_sequence->Get_Statement(idx)->Write_VC_Constant_Wire_Declarations(ofile);
		}
}


void AaBlockStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
	ofile << "// block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	if(this->_statement_sequence != NULL)
		for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			this->_statement_sequence->Get_Statement(idx)->Write_VC_Wire_Declarations(ofile);
		}
}

void AaBlockStatement::Write_VC_Datapath_Instances(ostream& ofile)
{

	ofile << "// datapath-instances for block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	if(this->_statement_sequence != NULL)
		for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			this->_statement_sequence->Get_Statement(idx)->Write_VC_Datapath_Instances(ofile);
		}
}

void AaBlockStatement::Write_VC_Links(string hier_id, ostream& ofile)
{

	ofile << "// CP-DP links for block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	if(hier_id != "")
		hier_id = hier_id + "/" + this->Get_VC_Name();
	else
		hier_id = this->Get_VC_Name();

	if(this->_statement_sequence != NULL)
		for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			this->_statement_sequence->Get_Statement(idx)->Write_VC_Links(hier_id, ofile);
		}
}


void AaBlockStatement::Propagate_Constants()
{
	for(int idx = 0; idx < _objects.size(); idx++)
	{
		if(_objects[idx]->Is("AaConstantObject"))
		{
			((AaConstantObject*)(_objects[idx]))->Evaluate();
		}
	}

	if(this->_statement_sequence)
		this->_statement_sequence->Propagate_Constants();

}

void AaBlockStatement::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	if(this->_statement_sequence != NULL)
		for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			this->_statement_sequence->Get_Statement(idx)->Update_Adjacency_Map(adjacency_map,visited_elements);
		}
}
//---------------------------------------------------------------------
// AaSeriesBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaSeriesBlockStatement::AaSeriesBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaSeriesBlockStatement::~AaSeriesBlockStatement() {}
void AaSeriesBlockStatement::Print(ostream& ofile)
{
	ofile << this->Tab();
	ofile << "$seriesblock";
	this->AaBlockStatement::Print(ofile);
}


// For each expression in visited-elements..  introduce delayed
// versions of them as needed.
void AaSeriesBlockStatement::Add_Delayed_Versions( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		set<AaRoot*>& visited_elements,
		map<AaRoot*, int>& longest_paths_from_root_map)
{
	if(this->_statement_sequence == NULL)
		return;

	for(set<AaRoot*>::iterator iter = visited_elements.begin(), fiter = visited_elements.end();
			iter != fiter; iter++)
	{
		AaRoot* curr = *iter;

		// add delayed versions of curr if required..
		this->AaStatement::Add_Delayed_Versions(curr, adjacency_map, visited_elements,
				longest_paths_from_root_map, this->_statement_sequence);
	}
}


//---------------------------------------------------------------------
// AaParallelBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaParallelBlockStatement::AaParallelBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaParallelBlockStatement::~AaParallelBlockStatement() {}
void AaParallelBlockStatement::Print(ostream& ofile)
{
	ofile << this->Tab();
	ofile << "$parallelblock";
	this->AaBlockStatement::Print(ofile);
}

//---------------------------------------------------------------------
// AaForkBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaForkBlockStatement::AaForkBlockStatement(AaScope* scope,string label):AaParallelBlockStatement(scope,label) {}
AaForkBlockStatement::~AaForkBlockStatement() {}
void AaForkBlockStatement::Print(ostream& ofile)
{
	ofile << this->Tab();
	ofile << "$forkblock ";
	this->AaBlockStatement::Print(ofile);
}

void AaForkBlockStatement::Write_VC_Control_Path(ostream& ofile)
{

	ofile << "// control-path for fork-block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	ofile << "::[" << this->Get_VC_Name() << "] // fork block " << this->Get_Source_Info() << endl << "{";
	// two passes: first print the statements in this
	// block which are NOT fork/joins.
	if(this->_statement_sequence)
	{
		for(int idx = 0; idx  < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
			if(!stmt->Is("AaJoinForkStatement"))
				stmt->Write_VC_Control_Path(ofile);
		}

		// second pass, print the fork/joins.
		for(int idx = 0; idx  < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
			if(stmt->Is("AaJoinForkStatement"))
				stmt->Write_VC_Control_Path(ofile);
		}
	}
	else
	{
		ofile << ";;[DummySB] { $T [dummy] } " << endl;
		ofile << "$entry &-> DummySB" << endl;
		ofile << "$exit <-& DummySB" << endl;
	}
	ofile << "} // end fork block " << this->Get_Source_Info() << endl;
}

//---------------------------------------------------------------------
// AaBranchBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaBranchBlockStatement::AaBranchBlockStatement(AaScope* scope,string label):AaSeriesBlockStatement(scope,label) {}
AaBranchBlockStatement::~AaBranchBlockStatement() {}
void AaBranchBlockStatement::Print(ostream& ofile)
{
	ofile << this->Tab();
	ofile << "$branchblock ";
	this->AaBlockStatement::Print(ofile);
}


void AaBranchBlockStatement::Write_VC_Control_Path(ostream& ofile)
{
	ofile << "// control-path for branch block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	// three passes..
	ofile << "<>[" << this->Get_VC_Name() << "] // Branch Block " << this->Get_Source_Info() << endl << " {" << endl;
	ofile << "$P [" << this->Get_VC_Name() << "__entry__]" << endl;
	ofile << this->Get_VC_Name() << "__entry__ <-| ($entry)" << endl;
	ofile << "$P [" << this->Get_VC_Name() << "__exit__]" << endl;
	ofile << this->Get_VC_Name() << "__exit__ |-> ($exit)" << endl;



	this->Write_VC_Control_Path(this->Get_VC_Name() + "__entry__", 
			this->_statement_sequence, 
			this->Get_VC_Name() + "__exit__",
			ofile);

	ofile << "} " << endl;
}

void AaBranchBlockStatement::Write_VC_Control_Path(string source_link,
		AaStatementSequence* sseq,
		string sink_link,
		ostream& ofile)
{
	if(sseq)
	{
		// first declare the entry/exit places for statements
		// in the sequence..
		for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
		{
			AaStatement* prev = (idx > 0 ? sseq->Get_Statement(idx-1) : NULL);
			AaStatement* stmt = sseq->Get_Statement(idx);
			if(!stmt->Is("AaPlaceStatement"))
			{
				if(!stmt->Is("AaMergeStatement"))
					ofile << "$P [" << stmt->Get_VC_Entry_Place_Name() << "] " << endl;
				else
				{
					if(prev == NULL || !prev->Is("AaPlaceStatement"))
					{

						AaMergeStatement* ms = ((AaMergeStatement*)stmt);
						if(ms->Has_Merge_Label("$entry"))
						{
							if(prev != NULL && prev->Is("AaPlaceStatement"))
							{
								AaRoot::Error("merge statement specifies a merge from entry which is unreachable.",
										stmt);
							}
						}
						ms->Set_Has_Entry_Place(true);
						ofile << "$P [" << stmt->Get_VC_Entry_Place_Name() << "] " << endl;
					}
				}

				ofile << "$P [" << stmt->Get_VC_Exit_Place_Name() << "] " << endl;
			}
			else
				// place statement..
				stmt->Write_VC_Control_Path(ofile);	    
		}


		// next all except the merges.
		for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = sseq->Get_Statement(idx);
			if(!stmt->Is("AaMergeStatement") && !stmt->Is("AaPlaceStatement"))
			{
				stmt->Write_VC_Control_Path(ofile);

				// control regulated by __entry__ and __exit__ places..
				// except for switch and if statements..
				if(!stmt->Is("AaSwitchStatement") && !stmt->Is("AaIfStatement"))
				{
					// for switch and if, the control flow is a bit more complicated..
					// we do not create an explicit CP region for these statements..
					ofile << stmt->Get_VC_Name() << "__entry__ |-> (" << stmt->Get_VC_Name() << ")" << endl;
					ofile << stmt->Get_VC_Name() << "__exit__ <-| (" << stmt->Get_VC_Name() << ")" << endl;
				}
			}
		}

		// almost finally the merges.
		for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = sseq->Get_Statement(idx);
			if(stmt->Is("AaMergeStatement"))
			{
				stmt->Write_VC_Control_Path(ofile);
			}
		}

		// very finally, the control transfer between statements..
		for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = sseq->Get_Statement(idx);


			// stmt gets control from its predecessor..
			AaStatement* prev_stmt = sseq->Get_Previous_Statement(stmt);
			if(prev_stmt == NULL)
			{
				ofile << stmt->Get_VC_Entry_Place_Name() << " <-| (" << source_link << ")" << endl;
			}
			else
			{
				if(!prev_stmt->Is("AaPlaceStatement"))
				{
					ofile << stmt->Get_VC_Entry_Place_Name() 
						<< " <-| (" 
						<< prev_stmt->Get_VC_Exit_Place_Name() 
						<< ")" << endl;

				}
			}

			AaStatement* next_stmt = sseq->Get_Next_Statement(stmt);
			// the last statement needs to be linked up to the sink_link
			// (not if it is a place statement, obviously!)
			if(next_stmt == NULL)
			{
				if(!stmt->Is("AaPlaceStatement"))
				{
					ofile << stmt->Get_VC_Exit_Place_Name() << " |-> (" << sink_link << ")" << endl;
				}
			}
		}
	}
	else 
	{
		ofile << "$P [dummy_place_] " << endl;
		ofile << "dummy___place___ <-| (" << source_link << ")" << endl;
		ofile << "dummy___place___ |-> (" << sink_link  << ")" << endl;
	}
}

void AaBranchBlockStatement::Identify_Inner_Loops(AaStatementSequence* sseq,
		vector<AaStatementSequence*>& linear_segment_vector)
{


	// take the statement sequence and identify inner loops within the sequence.
	// The loops are identified using the following pattern:
	//
	// 1. The inner loop must start with a merge, which must have exactly two incoming places
	//    the $entry place and a loopback place.
	// 2. The last statement in the loop must be either 
	// 	  - an unconditional branch that places a token in the loopback place.
	// 	  - an if statement one of whose branches places a token in the loopback
	// 	    place.
	// 	  - a switch statement, at least one of whose branches places a token in the
	// 	    loopback place.. (NOTE this is currently not implemented).
	// 3. The statements between the first and the last statement must be either 
	//    assignments or calls (can be guarded). (NOTE: this can and should be relaxed..) 
	// 
	int start_idx = 0;
	while(start_idx < sseq->Get_Statement_Count())
	{
		AaStatement* stmt = NULL;
		int end_idx = start_idx;

		vector<AaStatement*> linear_segment;
		while(end_idx < sseq->Get_Statement_Count())
		{
			stmt  = sseq->Get_Statement(end_idx);

			if(!stmt->Is("AaMergeStatement"))
			{
				end_idx++;
				continue;
			}

			// OK, we have found a merge statement. Now, look forward
			// through the sequence to see if you eventually get to a
			// branch which loops back to the merge place.
			linear_segment.push_back(stmt);
			AaMergeStatement* leading_merge_stmt = (AaMergeStatement*) stmt;
			AaStatement* trailing_stmt = NULL;
			AaStatement* next_stmt;
			int trailing_idx = end_idx + 1;
			while(trailing_idx  < sseq->Get_Statement_Count())
			{
				next_stmt = sseq->Get_Statement(trailing_idx);
				if(next_stmt->Is("AaPlaceStatement"))
				{
					if(leading_merge_stmt->Has_Merge_Label(((AaPlaceStatement*)next_stmt)->Get_Label()))
					{
						trailing_stmt = next_stmt;
						linear_segment.push_back(next_stmt);
					}
					break;

				}
				else if(next_stmt->Is("AaIfStatement"))
				{
					AaIfStatement* if_stmt = (AaIfStatement*) stmt;
					int tidx;
					for(tidx = 0; tidx < 2; tidx++)
					{
						AaStatement* xstmt = ((tidx == 0) ? if_stmt->Get_If_Sequence_Statement(0): if_stmt->Get_Else_Sequence_Statement(0));
						if(xstmt != NULL)
						{
							if(xstmt->Is("AaPlaceStatement"))
							{
								if(leading_merge_stmt->Has_Merge_Label(((AaPlaceStatement*)next_stmt)->Get_Label()))
								{
									trailing_stmt = next_stmt;
									linear_segment.push_back(next_stmt);
									break;
								}

							}
						}
					}

					break;
				}
				// for the moment, give up if you hit a switch.
				else if(next_stmt->Is("AaSwitchStatement"))
				{
					break;	
				}
				// in principle, we can continue through blocks, pipe-reads
				// call statements with side-effects etc., but for the moment
				// we abort the loop search if we hit any of these.
				else if(next_stmt->Is_Block_Statement()  || 
						next_stmt->Is_Control_Flow_Statement() || 
						(next_stmt->Is("AaCallStatement") && 
						 !((AaModule*)(((AaCallStatement*)next_stmt)->Get_Called_Module()))->Has_No_Side_Effects())
						|| next_stmt->Can_Block(false))
				{
					break;
				}

				trailing_idx++;
			}

			if(trailing_stmt != NULL)
			{
				AaStatementSequence* new_seq = new AaStatementSequence(this,linear_segment);
				linear_segment_vector.push_back(new_seq);
				linear_segment.clear();
			}

			end_idx = trailing_idx;
		}

		start_idx = end_idx;
	}
}

//---------------------------------------------------------------------
//  AaJoinForkStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaJoinForkStatement::AaJoinForkStatement(AaForkBlockStatement* scope):AaParallelBlockStatement(scope,"") {}
AaJoinForkStatement::~AaJoinForkStatement() {}
void AaJoinForkStatement::Print(ostream& ofile) 
{
	ofile << this->Tab();
	ofile << "$join ";
	for(unsigned int i = 0; i < this->_join_labels.size(); i++)
		ofile << this->_join_labels[i] << " ";
	if(this->Get_Statement_Count() > 0)
	{
		ofile << endl << this->Tab();
		ofile << " $fork " << endl;
		this->_statement_sequence->Print(ofile);
	}
	ofile << this->Tab();
	ofile << "$endjoin " << endl;
}

void AaJoinForkStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "// join-fork statement : " << this->Get_Source_Info() << endl;
	if(this->_statement_sequence != NULL)
	{
		this->_statement_sequence->PrintC(srcfile, headerfile);
	}
}

void AaJoinForkStatement::Map_Source_References()
{

	for(unsigned int i=0; i < this->_join_labels.size(); i++)
	{
		AaRoot* child = 
			((AaScope*)this->Get_Scope())->Find_Child_Here(this->_join_labels[i]);
		if(child != NULL)
		{
			if(child->Is_Statement())
			{
				this->_wait_on_statements.push_back((AaStatement*)child);
			}
			else
				AaRoot::Error("did not find statement with label " + this->_join_labels[i],this);
		}
		else
		{
			AaRoot::Error("did not find statement with label " + this->_join_labels[i],this);
		}
	}

	this->AaBlockStatement::Map_Source_References();
}



void AaJoinForkStatement::Write_VC_Control_Path(ostream& ofile)
{
	ofile << "// control-path for join-fork statement " <<  endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	if(this->_statement_sequence != NULL)
		this->_statement_sequence->Write_VC_Control_Path(ofile);


	ofile << "$T [" << this->Get_VC_Name() <<"] // join " << this->Get_Source_Info() << endl;
	if(_join_labels.size() == 0)
	{
		ofile << this->Get_VC_Name() << " <-& ($entry)" <<  endl;
	}
	else
	{
		ofile << this->Get_VC_Name() << " <-& (";
		for(int idx = 0; idx < _wait_on_statements.size(); idx++)
		{
			if(idx > 0)
				ofile << " ";
			ofile << _wait_on_statements[idx]->Get_VC_Name();
		}
		ofile << ")" << endl;
	}

	if(_statement_sequence == NULL)
	{
		ofile << this->Get_VC_Name() << " &-> ($exit)" <<  endl;
	}
	else
	{
		ofile << this->Get_VC_Name() << " &-> (";
		for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
		{
			if(idx > 0)
				ofile << " ";
			ofile << _statement_sequence->Get_Statement(idx)->Get_VC_Name();
		}
		ofile << ")" << endl;
	}
}

void AaJoinForkStatement::Write_VC_Links(string hier_id, ostream& ofile)
{
	ofile << "// CP-DP links for join-fork  " << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	if(_statement_sequence != NULL)
	{
		for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
		{
			_statement_sequence->Get_Statement(idx)->Write_VC_Links(hier_id,ofile);
		}
	}
}

//---------------------------------------------------------------------
// AaMergeStatement: public AaStatement
//---------------------------------------------------------------------
AaMergeStatement::AaMergeStatement(AaBranchBlockStatement* scope):AaSeriesBlockStatement((AaScope*)scope,"") 
{
	this->_wait_on_entry = 0;
	this->_has_entry_place = 0;
	this->_in_do_while = false;
}

AaMergeStatement::~AaMergeStatement() {}

bool AaMergeStatement::Can_Block(bool pipeline_flag)
{
	for(int I = 0, fI = _wait_on_statements.size(); I < fI; I++)
	{
		if(_wait_on_statements[I]->Can_Block(pipeline_flag))
			return(true);
	}

	if(this->_statement_sequence != NULL)
	{
		if(this->_statement_sequence->Can_Block(pipeline_flag))
			return(true);
	}

	return(false);
}
  
void AaMergeStatement::Get_Phi_Statement_Counts(int& relaxed_count, int& strict_count)
{
	relaxed_count = 0;
	strict_count = 0;

	for(unsigned int idx = 0; idx < this->Get_Statement_Count(); idx++)
	{
		AaPhiStatement* ps = (AaPhiStatement*) (this->Get_Statement(idx));

		if(ps->Get_Relaxed_Flag())
			relaxed_count++;
		else
			strict_count++;

	}
}


void AaMergeStatement::Print(ostream& ofile)
{
	ofile << this->Tab();
	ofile << "$merge " ;
	for(unsigned int i=0; i < this->_merge_label_vector.size(); i++)
	{ 
		ofile  << this->_merge_label_vector[i] << " ";
	}
	ofile << endl;


	if(this->_statement_sequence != NULL)
	{
		ofile << this->Tab() << endl;
		this->_statement_sequence->Print(ofile);
		ofile << this->Tab() << endl;
	}
	ofile << this->Tab();
	ofile << "$endmerge" << endl ;
}

//
// the default entry is from above.
//
// For each merge place, create a label to 
// receive the directed gotos.
//
// finally goto run_block.. and print the
// statements.
//
void AaMergeStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{

	srcfile << "// merge " << this->Get_Source_Info() << endl;
	headerfile << "\n#define " << this->Get_C_Preamble_Macro_Name() << " ";

	string run_block_name = this->Get_VC_Name() + "_run";
	string entry_flag_name = this->Get_VC_Name() + "_entry_flag";
	headerfile << "uint8_t " << entry_flag_name << ";\\" << endl;

	if(this->Get_In_Do_While())
	{
		headerfile << entry_flag_name << " = do_while_entry_flag;\\" << endl;
	}
	else
	{
		headerfile << entry_flag_name << " = 1;\\" << endl;
	}

	for(unsigned int i=0; i < this->_wait_on_statements.size(); i++)
		headerfile << "uint8_t " << this->_wait_on_statements[i]->C_Reference_String() << "_flag = 0;\\" << endl;
	headerfile  << "goto " << run_block_name << ";\\" << endl;

	for(unsigned int i=0; i < this->_wait_on_statements.size(); i++)
	{ 
		headerfile  << this->_wait_on_statements[i]->C_Reference_String() << ": ";
		headerfile  << this->_wait_on_statements[i]->C_Reference_String() << "_flag = 1;\\" << endl;
		for(unsigned int j = 0; j < this->_wait_on_statements.size(); j++)
		{
			if(j != i)
				headerfile  << this->_wait_on_statements[j]->C_Reference_String() << "_flag = 0;\\" << endl;

		}
		headerfile  << "goto " << run_block_name << ";\\" << endl;
	}
	headerfile   << run_block_name << ": ;\\" << endl;

	srcfile << this->Get_C_Preamble_Macro_Name() << "; " << endl;

	if(this->_statement_sequence != NULL)
	{
		this->_statement_sequence->PrintC(srcfile, headerfile);
	}
	headerfile << ";" <<  endl;

	headerfile << "\n#define " << this->Get_C_Postamble_Macro_Name() << " ";

	for(unsigned int i=0; i < this->_wait_on_statements.size(); i++)
		headerfile  << this->_wait_on_statements[i]->C_Reference_String() << "_flag = 0;\\" << endl;
	headerfile << entry_flag_name << " = 0;" << endl;
	srcfile << this->Get_C_Postamble_Macro_Name() << "; " << endl;
}

void AaMergeStatement::Map_Source_References()
{
	for(unsigned int i=0; i < this->_merge_label_vector.size(); i++)
	{
		if((this->_merge_label_vector[i] != "$entry") &&
				(this->_merge_label_vector[i] != "$loopback"))
		{
			AaRoot* child = 
				((AaScope*)this->Get_Scope())->Find_Child_Here(this->_merge_label_vector[i]);
			if(child != NULL)
			{
				if(child->Is("AaPlaceStatement"))
				{
					this->_wait_on_statements.push_back((AaPlaceStatement*)child);
					((AaPlaceStatement*)child)->Mark_As_Merged();
				}
				else
					AaRoot::Error("did not find place statement with label " + this->_merge_label_vector[i],this);
			}
			else 
			{
				AaRoot::Error("did not find place statement with label " + this->_merge_label_vector[i],this);
			}
		}
		else
		{
			this->_wait_on_entry = 1;
		}
	}

	// also the phi statements!
	this->AaBlockStatement::Map_Source_References();
}
  
void AaMergeStatement::Map_Targets()
{
	this->AaBlockStatement::Map_Targets();
}


void AaMergeStatement::Set_In_Do_While(bool v)
{ 
	_in_do_while = v; 
	if(_statement_sequence != NULL)
	{
		for(unsigned int idx = 0; idx < this->Get_Statement_Count(); idx++)
		{
			AaPhiStatement* pstmt = (AaPhiStatement*) this->Get_Statement(idx);
			pstmt->Set_In_Do_While(v);
		}
	}
}

void AaMergeStatement::Write_VC_Control_Path(ostream& ofile)
{

	ofile << "// control-path for merge  " << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	string source_link = this->Get_VC_Entry_Place_Name();


	// this has an entry place (because its predecessor
	// was not a place statement).
	//
	// to preserve static connectivity of the containing
	// branch region, we introduce a dead link
	// connection from the entry place to the exit place
	// (otherwise there will be a dangle.. which is flagged
	// as an error).
	if(this->_has_entry_place)
	{
		string dead_link = this->Get_VC_Name() + "_dead_link";
		ofile << ";;[" << dead_link << "] { $T [dead_transition] $dead } " << endl;
		// tie up the dead link..
		ofile << this->Get_VC_Entry_Place_Name() << " |-> (" << dead_link << ")" << endl;
		ofile << this->Get_VC_Exit_Place_Name() << " <-| (" << dead_link << ")" << endl;
	}

	// first, for each element of the merge-label set,
	// find the phi statements that depend on it.
	map<string,set<AaPhiStatement*> > phi_dependency_map;
	ofile << "//---------------------   merge statement " << this->Get_Source_Info() << "  --------------------------" << endl;
	if(_statement_sequence != NULL)
	{
		for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = _statement_sequence->Get_Statement(idx);
			assert(stmt->Is("AaPhiStatement"));

			AaPhiStatement* pstmt = (AaPhiStatement*) stmt;
			for(set<string,StringCompare>::iterator iter= _merge_label_set.begin();
					iter != _merge_label_set.end();
					iter++)
			{
				if(pstmt->Is_Merged(*iter))
					phi_dependency_map[(*iter)].insert(pstmt);
			}
		}
	}


	// for each merge-label create a parallel region
	// in which requests are generated to all the phi-statements
	// which depend on this label..
	for(set<string,StringCompare>::iterator iter= _merge_label_set.begin();
			iter != _merge_label_set.end();
			iter++)
	{
		string mlabel = (*iter);
		string mplace = ((mlabel == "$entry") ? source_link : mlabel);

		if(mplace  != "")
		{

			ofile << "||[" << Make_VC_Legal(mplace) << "_PhiReq] {" << endl; 
			if(phi_dependency_map[mlabel].size() > 0)
			{
				for(set<AaPhiStatement*>::iterator siter = phi_dependency_map[mlabel].begin();
						siter != phi_dependency_map[mlabel].end();
						siter++)
				{
					AaPhiStatement* pp = *siter;
					if(!pp->Get_Target()->Is_Constant())
					{

						ofile << ";;[" << (*siter)->Get_VC_Name() 
							<< "] {" << endl;

						ofile << "||[" << (*siter)->Get_VC_Name()
							 << "_sources] {" << endl;
						// the sources to the phi must be computed.
						(*siter)->Write_VC_Source_Control_Paths(mlabel, 
							ofile);


						ofile << "}" << endl;

						// issue a req to the phi.
						ofile << "$T [" << (*siter)->Get_VC_Name() 
							<< "_req] " << endl;
						ofile << "}" << endl;
					}
					else
					{
						ofile << "// skipped constant phi " 
								<< pp->Get_VC_Name() << endl;
					}
				}
			}
			else
			{
				ofile << "// no phi statements in merge.." << endl;
			}
			ofile << "}" << endl;


			// merge-labels 
			ofile << mplace << " |-> (" << Make_VC_Legal(mplace) << "_PhiReq)" << endl;
		}
	}

	// all the parallel regions created above will merge into 
	// a single place.
	ofile << "$P [" << this->Get_VC_Name() << "_PhiReqMerge] " << endl;
	ofile << this->Get_VC_Name() << "_PhiReqMerge <-| (";
	for(set<string,StringCompare>::iterator iter= _merge_label_set.begin();
			iter != _merge_label_set.end();
			iter++)
	{
		string mlabel = (*iter);
		string mplace = ((mlabel == "$entry") ? this->Get_VC_Entry_Place_Name() : mlabel);
		if(mplace != "")
			ofile << " " << Make_VC_Legal(mplace) << "_PhiReq "; 
	}
	ofile << ")" << endl;

	// now a parallel region, in which we wait for all
	// the acks from the phi statements associated with
	// this merge statement.
	// 
	// note that the delay from the req to the phi
	// to this transition should be at most one tick..
	// 
	//
	ofile << "||[" << this->Get_VC_Name() << "_PhiAck] {" << endl;

	if(_statement_sequence)
	{
		for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = _statement_sequence->Get_Statement(idx);
			assert(stmt->Is("AaPhiStatement"));
			AaPhiStatement* pp = (AaPhiStatement*) stmt;
			if(!pp->Get_Target()->Is_Constant())
			{
				ofile << "$T [" << stmt->Get_VC_Name() << "_ack] " << endl; 
			}
			else
			{
				ofile << "// skipped constant phi " << pp->Get_VC_Name() << endl;
			}
		}
	}
	else
		ofile << "$T [dummy] " << endl;

	ofile << "}";

	// the PhiAck parallel CPR merges into the exit place for this merge
	ofile << this->Get_VC_Name() << "_PhiReqMerge |-> (" << this->Get_VC_Name() << "_PhiAck)" << endl;
	ofile << this->Get_VC_Exit_Place_Name() << "  <-| (" << this->Get_VC_Name() << "_PhiAck)" << endl;

	// thats it..
	ofile << "//---------------------  end of merge statement " << this->Get_Source_Info() << "  --------------------------" << endl;
}

void AaMergeStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
	if(_statement_sequence != NULL)
	{
		ofile << "// merge-statement  " << endl;
		ofile << "// " << this->Get_Source_Info() << endl;


		for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
		{
			_statement_sequence->Get_Statement(idx)->Write_VC_Wire_Declarations(ofile);
		}
	}
}
void AaMergeStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
	if(_statement_sequence != NULL)
	{
		ofile << "// data-path instances for merge  " << endl;
		ofile << "// " << this->Get_Source_Info() << endl;

		for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
		{
			_statement_sequence->Get_Statement(idx)->Write_VC_Datapath_Instances(ofile);
		}
	}
}

void AaMergeStatement::Write_VC_Links(string hier_id, ostream& ofile)
{
	ofile << "// CP-DP links for merge  " << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	if(_statement_sequence)
	{
		for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = _statement_sequence->Get_Statement(idx);
			assert(stmt->Is("AaPhiStatement"));

			vector<string> reqs;
			AaPhiStatement* phi_stmt = (AaPhiStatement*) stmt;
			
			// skip phi if it is a constant..
			if(phi_stmt->Get_Target()->Is_Constant())
			{
				ofile << "// In merge, skipped links for constant phi "
					<< phi_stmt->Get_VC_Name() << endl;
				continue;
			}

			// phi reqs..
			for(int pidx = 0; pidx < phi_stmt->_source_pairs.size(); pidx++)
			{

				string mlabel = phi_stmt->_source_pairs[pidx].first;
				string mplace = ((mlabel == "$entry") ? this->Get_VC_Entry_Place_Name() : mlabel);

				// in the request block, you compute the inputs and then  hang the
				// req..
				string req_hier_id = Augment_Hier_Id(hier_id , Make_VC_Legal(mplace) + "_PhiReq/" + 
						phi_stmt->Get_VC_Name());

				// finish all the sources for the phi's...
				string src_hier_id = Augment_Hier_Id(req_hier_id,
						phi_stmt->Get_VC_Name() + "_sources");

				phi_stmt->_source_pairs[pidx].second->Write_VC_Links(src_hier_id,ofile);
				AaExpression* src_expr = phi_stmt->_source_pairs[pidx].second;
				if(!src_expr->Is_Constant() &&
						(src_expr->Is_Implicit_Variable_Reference() ||
						 src_expr->Is_Signal_Read() ||
						 src_expr->Is_Volatile_Function_Call() ||
						 (src_expr->Is_Trivial() && src_expr->Get_Is_Intermediate())))
				{
					string dpe_name = src_expr->Get_VC_Driver_Name() +  "_" 
						+ Int64ToStr(src_expr->Get_Index()) + "_buf";
					vector<string> reqs;	
					vector<string> acks;	
					reqs.push_back(src_hier_id + "/Interlock/Sample/req");
					reqs.push_back(src_hier_id + "/Interlock/Update/req");
					acks.push_back(src_hier_id + "/Interlock/Sample/ack");
					acks.push_back(src_hier_id + "/Interlock/Update/ack");
					Write_VC_Link(dpe_name, reqs, acks, ofile);
					reqs.clear(); acks.clear();
				}

				reqs.push_back(req_hier_id + "/" + phi_stmt->Get_VC_Name() + "_req");
			}


			string ack_name = hier_id + "/"  +  this->Get_VC_Name() + "_PhiAck/" + 
				phi_stmt->Get_VC_Name() + "_ack";

			vector<string> acks;
			acks.push_back(ack_name);
			Write_VC_Link(phi_stmt->Get_VC_Name(),reqs,acks,ofile);

			reqs.clear(); acks.clear();
		}
	}
}

//---------------------------------------------------------------------
// AaPhiStatement: public AaStatement
//---------------------------------------------------------------------
AaPhiStatement::AaPhiStatement(AaBranchBlockStatement* scope, AaMergeStatement* pm):AaStatement(scope) 
{
	this->_target = NULL;
	this->_parent_merge = pm;
	this->_in_do_while = false;
	this->_barrier_flag = false;
}
AaPhiStatement::~AaPhiStatement() 
{
}

void AaPhiStatement::Print(ostream& ofile)
{
	ofile << this->Tab() << "$phi ";
	this->_target->Print(ofile);
	ofile << " := ";
	for(map<AaExpression*,vector<string> >::iterator iter = this->_source_label_vector.begin(),
		fiter = this->_source_label_vector.end(); iter != fiter; iter++)
	{
		ofile << this->Tab() << "  ";
		AaExpression* expr = (*iter).first;
		AaExpression* ge = expr->Get_Guard_Expression();
		if(ge != NULL)
		{
			ofile << "$guard (";
			if(expr->Get_Guard_Complement())
				ofile << "~ ";
			ge->Print(ofile);
			ofile << ") ";
		}
		expr->Print(ofile);
		ofile << " $on ";
		for(int J = 0, fJ = (*iter).second.size(); J < fJ; J++)
		{
			if(J > 0) ofile << ", ";
			ofile << "  " << (*iter).second[J] << " ";
		}
	}

	if(this->Get_Barrier_Flag())
		ofile << " $barrier";

	if(this->Get_Relaxed_Flag())
		ofile << " $relaxed ";

	ofile << endl;
	if(this->_target->Get_Type())
	{
		ofile <<" // type of target is ";
		this->_target->Get_Type()->Print(ofile);
	}

	ofile << endl;
}

void AaPhiStatement::Set_Target(AaObjectReference* tgt)
{ 
	this->_target = tgt; 
	this->_target->Set_Is_Target(true);

	tgt->Set_Associated_Statement(this);
	tgt->Set_Is_Intermediate(false);

	if(this->_source_pairs.size() > 0)
	{
		for(int idx = 0; idx < this->_source_pairs.size(); idx++)
		{
			this->_source_pairs[idx].second->Add_Target(this->_target);
			this->_target->Add_RHS_Source(this->_source_pairs[idx].second);
		}

	}
}


void AaPhiStatement::Add_Source_Pair(string label, AaExpression* expr)
{
	_merged_labels.insert(label);
	int curr_index = this->_source_pairs.size();


	AaExpression* ge = expr->Get_Guard_Expression();
	if(ge != NULL)
	{
		// phi statements do not have guards, only their
		// sources can have guards.
		ge->Set_Associated_Statement(this);
		ge->Set_Phi_Source_Index(curr_index);
	}

	expr->Set_Associated_Statement(this);
	expr->Set_Is_Intermediate(false);
	expr->Set_Phi_Source_Index(curr_index);

	if(this->_target)
	{
		expr->Add_Target(this->_target);
		this->_target->Add_RHS_Source(expr);
	}

	this->_source_pairs.push_back(pair<string,AaExpression*>(label,expr));
}


void AaPhiStatement::Add_Source_Label_Vector(AaExpression* expr, vector<string>& labels)
{
	for(int I = 0,fI = labels.size(); I < fI; I++)
	{
		this->_source_label_vector[expr].push_back(labels[I]);
	}
}

void AaPhiStatement::Map_Targets()
{
	this->Map_Target(this->_target);
	if(!this->_target->Is_Implicit_Variable_Reference())
	{
		AaRoot::Error("target of a PHI statement must be an implicit (SSA) variable.", this);
	}
	else if(this->_target->Is_Interface_Object_Reference())
	{
		// This warning should be an error if the module is
		// a pipelined one.
		AaRoot::Warning("target of a PHI statement is an interface object!", this);
	}

}


void AaPhiStatement::Map_Source_References()
{
	this->_target->Map_Source_References(this->_target_objects);

	for(unsigned int i=0; i < this->_source_pairs.size(); i++)
	{
		AaProgram::Add_Type_Dependency(this->_target, this->_source_pairs[i].second);

		this->_source_pairs[i].second->Map_Source_References(this->_source_objects);

		AaExpression* ge = this->_source_pairs[i].second->Get_Guard_Expression();
		if(ge != NULL)
			ge->Map_Source_References(this->_source_objects);

		bool special_place = (this->_source_pairs[i].first == "$entry");
		if(this->Get_In_Do_While())
			special_place = special_place || (this->_source_pairs[i].first == "$loopback");

		if(!special_place)
		{
			AaRoot* child = this->Get_Scope()->Find_Child(this->_source_pairs[i].first);
			if(child == NULL)
			{
				AaRoot::Error("could not find place statement with label " + (this->_source_pairs[i].first),this);
			}
			else if(!child->Is("AaPlaceStatement"))
			{
				AaRoot::Error("in phi statement, statement with label " + (this->_source_pairs[i].first) 
						+ " is not a place statement : line " ,this);

			}
		}
	}
}

AaSimpleObjectReference* AaPhiStatement::Get_Implicit_Target(string tgt_name)
{
	AaSimpleObjectReference* ret = NULL;
	AaExpression* oarg = this->_target;
	if(oarg->Is("AaSimpleObjectReference"))
	{
		string oarg_name = ((AaSimpleObjectReference*)oarg)->Get_Object_Root_Name();
		if(oarg_name == tgt_name)
		{
			ret = (AaSimpleObjectReference*) oarg;
		}
	}	
	return(ret);
}

void AaPhiStatement::Set_Pipeline_Parent(AaStatement* dws)
{
	_pipeline_parent = dws;
	this->_target->Set_Pipeline_Parent(dws);
	for(int idx = 0; idx < this->_source_pairs.size(); idx++)
	{
		this->_source_pairs[idx].second->Set_Pipeline_Parent(dws);
	}
}

void AaPhiStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "// " << this->To_String(); //includes newline
	headerfile << "\n#define " << this->Get_C_Macro_Name() << " ";
	srcfile <<  this->Get_C_Macro_Name() << "; " << endl;

	AaExpression* default_src = NULL;
	set<AaExpression*> decl_set;
	for(unsigned int i=0; i < this->_source_pairs.size(); i++)
	{
		AaExpression* src_expr = this->_source_pairs[i].second;
		if(decl_set.find(src_expr) == decl_set.end())
		{
			decl_set.insert(src_expr);

			AaExpression* ge = this->_source_pairs[i].second->Get_Guard_Expression();
			if(ge != NULL)
			{
				ge->PrintC_Declaration(headerfile);
				ge->PrintC(headerfile);
			}
			this->_source_pairs[i].second->PrintC_Declaration(headerfile);
		}
	}

	if(this->_target->Get_Root_Object() != ((AaRoot*) this))
	{
		this->_target->PrintC_Declaration(headerfile);
	}

	string tgt_name;
	tgt_name = this->_target->C_Reference_String();
	bool at_least_one = false;
	for(unsigned int i=0; i < this->_source_pairs.size(); i++)
	{

		string mlabel = this->_source_pairs[i].first;

		if(mlabel == "$entry")
		{
			assert(this->_parent_merge != NULL);
			default_src = this->_source_pairs[i].second;
		}
		else
		{
			AaExpression* ge = this->_source_pairs[i].second->Get_Guard_Expression();
			bool gc = false;
			if(ge != NULL)
			{
				gc = this->_source_pairs[i].second->Get_Guard_Complement();
			}

			string check_string;
			if(mlabel == "$loopback")
			{
				check_string = "do_while_loopback_flag";
			}
			else
			{
				AaRoot* child = this->Get_Scope()->Find_Child(mlabel);
				assert(child);
				check_string = child->C_Reference_String();
				check_string += "_flag";
			}

			if(at_least_one)
			{
				headerfile << " else ";
			}

			headerfile << "if(" << check_string << ") {\\" << endl;
			if(ge != NULL)
			{
				headerfile << "if(" <<  (gc ? "!" : "");
				Print_C_Value_Expression(ge->C_Reference_String(), ge->Get_Type(), headerfile);
				headerfile << ") {\\" << endl;
			}
			this->_source_pairs[i].second->PrintC(headerfile);
			Print_C_Assignment(tgt_name, this->_source_pairs[i].second->C_Reference_String(),
					this->_source_pairs[i].second->Get_Type(), headerfile);
			if(ge != NULL)
				headerfile << "}\\" << endl;
			headerfile << "}\\" << endl;
			at_least_one = true;
		}
	}

	if(default_src != NULL)
	{

		AaExpression* ge = default_src->Get_Guard_Expression();
		bool gc = false;
		if(ge != NULL)
		{
			gc = default_src->Get_Guard_Complement();
		}

		if(at_least_one)
		{
			headerfile << "else {\\" << endl;
			if(ge != NULL)
			{
				headerfile << "if(" <<  (gc ? "!" : "");
				Print_C_Value_Expression(ge->C_Reference_String(), ge->Get_Type(), headerfile);
				headerfile << ") {\\" << endl;
			}
			default_src->PrintC_Declaration(headerfile);
			default_src->PrintC(headerfile);
			Print_C_Assignment(tgt_name,  default_src->C_Reference_String(),
					default_src->Get_Type(), headerfile);
			if(ge != NULL)
				headerfile << "}\\" << endl;
			headerfile << "}\\" << endl;
		}
		else
		{
			if(ge != NULL)
			{
				headerfile << "if(" <<  (gc ? "!" : "");
				Print_C_Value_Expression(ge->C_Reference_String(), ge->Get_Type(), headerfile);
				headerfile << ") {\\" << endl;
			}
			default_src->PrintC_Declaration(headerfile);
			default_src->PrintC(headerfile);
			Print_C_Assignment(tgt_name,  default_src->C_Reference_String(),
					default_src->Get_Type(), headerfile);
			if(ge != NULL)
				headerfile << "}\\" << endl;
		}
	}

	// pipe write if necessary..
	this->_target->PrintC(headerfile);
	headerfile << ";" << endl;
}

void AaPhiStatement::PrintC_Implicit_Declarations(ofstream& ofile)
{
	if(this->_target->Get_Root_Object() == ((AaRoot*) this))
	{
		this->_target->PrintC_Declaration(ofile);
	}
}

void AaPhiStatement::Write_VC_Control_Path(ostream& ofile)
{

	ofile << "// control-path for phi:  ";
	this->Print(ofile);
	ofile << "// " << this->Get_Source_Info() << endl;

	// the phi-statement is totally handled by
	// the AaMergeStatement which contains it.

	// however, the source expressions need to be handled..
	// separately..

}


// the merge statement calls this
void AaPhiStatement::Write_VC_Source_Control_Paths(string& mplace, ostream& ofile)
{
	ofile << "// sources for " << this->To_String();
	set<AaExpression*> printed_expr_set;
	for(int idx = 0; idx < _source_pairs.size(); idx++)
	{
		AaExpression* src_expr = _source_pairs[idx].second;
		if(printed_expr_set.find(src_expr) == printed_expr_set.end())
		{
			printed_expr_set.insert(src_expr);
			bool src_is_constant = src_expr->Is_Constant();
			bool src_has_no_dpe  = (src_expr->Is_Implicit_Variable_Reference() ||  src_expr->Is_Signal_Read());
			bool src_has_trivial_dpe = (!src_has_no_dpe && (src_expr->Is_Trivial() && src_expr->Get_Is_Intermediate()));
			bool src_is_volatile_fn_call = src_expr->Is_Volatile_Function_Call();

			string place_name = _source_pairs[idx].first;

			if(mplace != place_name)
				continue;

			if(src_expr->Is_Constant())
			{
				// constant source. nothing is necessary..
				ofile << "// constant source .... delay transition " << endl;
				ofile << "$T [" << src_expr->Get_VC_Name() << "_konst_delay_trans] $delay" << endl;
			}
			else
			{
				ofile << "// trivial non-constant source .... interlock-buffer introduced " << endl;
				if(src_expr->Get_Guard_Expression())
					src_expr->Get_Guard_Expression()->Write_VC_Control_Path(ofile);
				if(src_has_no_dpe || src_has_trivial_dpe ||
						src_is_volatile_fn_call)
				{
					ofile << "|| [Interlock] {" << endl;
					ofile << " ;;[Sample] {" << endl;
					ofile << "$T [req] $T [ack]" << endl;
					ofile << "}" << endl;
					ofile << " ;;[Update] {" << endl;
					ofile << "$T [req] $T [ack]" << endl;
					ofile << "}" << endl;
					ofile << "}" << endl;
				}
				else
				{
					src_expr->Write_VC_Control_Path(ofile);
				}
			}
		}
		else
		{
			AaRoot::Error("multiple merge labels mapped to the same expression not implemented in non-opt case.", this);
		}
	}
}



void AaPhiStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
	ofile << "// constant-declarations for phi:  ";
	this->Print(ofile);
	ofile << "// " << this->Get_Source_Info() << endl;
	if(this->_target->Is_Constant())
	{
		if(!this->_target->Is_Interface_Object_Reference())
		{
			// declare the target as a constant...
			Write_VC_Constant_Declaration(this->_target->Get_VC_Constant_Name(),
					this->_target->Get_Type()->Get_VC_Name(),
					this->_target->Get_Expression_Value()->To_VC_String() + " // " +
					this->_target->Get_Expression_Value()->To_C_String(),
					ofile);
		}

	}
	else
	{
		set<AaExpression*> printed_expr_set;
		for(int idx = 0; idx < _source_pairs.size(); idx++)
		{
			AaExpression* src_expr = _source_pairs[idx].second;

			if(printed_expr_set.find(src_expr) == printed_expr_set.end())
			{
				printed_expr_set.insert(src_expr);
				src_expr->Write_VC_Constant_Wire_Declarations(ofile);
			}
		}
	}
}

void AaPhiStatement::Write_VC_Wire_Declarations(ostream& ofile)
{

	if(!this->_target->Is_Constant())
	{
		ofile << "// " << this->To_String() << endl;
		ofile << "// " << this->Get_Source_Info() << endl;


		set<AaExpression*> printed_expr_set;
		for(int idx = 0; idx < _source_pairs.size(); idx++)
		{
			AaExpression* src_expr = _source_pairs[idx].second;
			if(printed_expr_set.find(src_expr) == printed_expr_set.end())
			{
				printed_expr_set.insert(src_expr);

				bool src_is_constant = src_expr->Is_Constant();
				bool src_has_no_dpe  = (src_expr->Is_Implicit_Variable_Reference() ||  src_expr->Is_Signal_Read());
				bool src_has_trivial_dpe = 
					(!src_has_no_dpe && (src_expr->Is_Trivial() && src_expr->Get_Is_Intermediate()));
				bool src_is_volatile_fn_call = 
							src_expr->Is_Volatile_Function_Call();

				src_expr->Write_VC_Wire_Declarations(false,ofile);

				// additional wire for the buffer.
				if(!src_is_constant && 
					(src_is_volatile_fn_call ||
						src_has_no_dpe || src_has_trivial_dpe))
				{
					Write_VC_Wire_Declaration(src_expr->Get_VC_Driver_Name() +  "_" + 
							Int64ToStr(src_expr->Get_Index()) + "_buffered",
							src_expr->Get_Type(), ofile);	
				}
			}
		}

		this->_target->Write_VC_Wire_Declarations_As_Target(ofile);
	}
}

// Some ordering problem here!
void AaPhiStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	if(this->_target->Is_Constant())
	{
		ofile << "// constant phi data-path element skipped " <<
			this->Get_VC_Name()  << endl;
		return;
	}

	AaStatement* dws = this->Get_Pipeline_Parent();
	bool full_rate = this->Is_Part_Of_Fullrate_Pipeline();

	set<AaExpression*> printed_expr_set;
	vector<pair<string,AaType*> > sources;
	for(int i = 0; i < _source_pairs.size(); i++)
	{
		AaExpression* src_expr = _source_pairs[i].second;
		if(printed_expr_set.find(src_expr) == printed_expr_set.end())
		{
			printed_expr_set.insert(src_expr);

			bool src_is_constant = src_expr->Is_Constant();
			bool src_has_no_dpe  = (src_expr->Is_Implicit_Variable_Reference() ||  src_expr->Is_Signal_Read());
			bool src_is_volatile_fn_call = src_expr->Is_Volatile_Function_Call();

			string src_driver_name = src_expr->Get_VC_Driver_Name();

			if(!src_is_constant && 
				(src_has_no_dpe || src_is_volatile_fn_call))
			{
				src_driver_name = src_expr->Get_VC_Driver_Name() +  "_"  + 
					Int64ToStr(src_expr->Get_Index()) + "_buffered";
				string dpe_name = src_expr->Get_VC_Driver_Name() + "_" + 
					Int64ToStr(src_expr->Get_Index()) +  "_buf";
				Write_VC_Interlock_Buffer(dpe_name, src_expr->Get_VC_Driver_Name(),
						src_driver_name, "", false, full_rate, false, ofile);
				if(dws != NULL)
				{
					int src_buffering = src_expr->Get_Buffering();
					ofile << "$buffering $out " << dpe_name <<  " " << 
						src_driver_name  << "  " << src_expr->Get_Buffering()  << endl;
				}
			}

			if(!src_is_constant)
			{
				src_expr->Write_VC_Datapath_Instances(NULL,ofile);
			}

			sources.push_back(pair<string,AaType*>(src_driver_name, src_expr->Get_Type()));
		}
	}

	string dpe_name = this->Get_VC_Name();
	string tgt_name = _target->Get_VC_Receiver_Name(); 

	if(this->Is_Single_Source() && (dws != NULL))
	//
	// This corresponds to the pipelined loop case..
	//
	{
		AaExpression* ssrc_expr = (* _source_label_vector.begin()).first;	
		string ssrc_driver_name = ssrc_expr->Get_VC_Driver_Name();

		bool ssrc_is_constant = ssrc_expr->Is_Constant();
		bool ssrc_has_no_dpe  = (ssrc_expr->Is_Implicit_Variable_Reference() ||  ssrc_expr->Is_Signal_Read());
		bool ssrc_is_volatile_fn_call = ssrc_expr->Is_Volatile_Function_Call();
		if(!ssrc_is_constant && (ssrc_has_no_dpe || ssrc_is_volatile_fn_call))
			ssrc_driver_name += "_" + 
					Int64ToStr(ssrc_expr->Get_Index()) + "_buffered";
	
		Write_VC_Interlock_Buffer("ssrc_" + dpe_name,
				ssrc_driver_name,
				tgt_name,
				"",
				true, // flow-through-flag
				true,
				false, // cut-through
				ofile);
	}
	else
	{


		Write_VC_Phi_Operator(dpe_name,
				sources,
				tgt_name,
				_target->Get_Type(),
				this->Get_In_Do_While(), // pipelined case.
				full_rate,
				ofile);

		// in the extreme pipelining case, output buffering
		// will be kept to 2...  NOTE: not relevant in new scheme
		// since source expressions will be buffered.
		if(dws != NULL)
		{
			// PHI statement is always double buffered
			// to cut long combinational paths.
			ofile << "// $buffering  $out " << dpe_name << " "
				<< tgt_name << " 2" << endl;
		}
	}
}




bool AaPhiStatement::Is_Constant()
{
	return(this->_target->Is_Constant());
}


void AaPhiStatement::Propagate_Constants()
{
	bool all_values_equal = true;
	AaValue* last_expr_value = NULL;
	set<AaExpression*>  sset;
	for(int idx = 0; idx < _source_pairs.size(); idx++)
	{
		AaExpression* expr = _source_pairs[idx].second;
		if(sset.find(expr) == sset.end())
		{
			sset.insert(expr);
			expr->Evaluate();
			if(all_values_equal && expr->Is_Constant())
			{
				if( last_expr_value  == NULL)
					last_expr_value = expr->Get_Expression_Value();
				else
					all_values_equal = 
						last_expr_value->Equals(expr->Get_Expression_Value());
			}
			else 
			{
				all_values_equal = false;
			}
		}
	}

	if(all_values_equal)
		_target->Assign_Expression_Value(_source_pairs[0].second->Get_Expression_Value());
}

//---------------------------------------------------------------------
// AaSwitchStatement: public AaStatement
//---------------------------------------------------------------------
AaSwitchStatement::AaSwitchStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
	this->_select_expression = NULL;
	this->_default_sequence = NULL;
}
AaSwitchStatement::~AaSwitchStatement() {}


void AaSwitchStatement::Set_Select_Expression(AaExpression* expr) 
{
	this->_select_expression = expr;
	if(expr != NULL)
		expr->Set_Associated_Statement(this);
}

void AaSwitchStatement::Add_Choice(AaExpression* cond, AaStatementSequence* sseq)
{
	this->_choice_pairs.push_back(pair<AaExpression*,AaStatementSequence*>(cond,sseq));
	if(cond != NULL)
		cond->Set_Associated_Statement(this);
}

bool AaSwitchStatement::Can_Block(bool pipeline_flag)
{
	if(this->AaStatement::Can_Block(pipeline_flag))
		return(true);


	for(int i = 0, imax = _choice_pairs.size(); i < imax; i++)
	{
		AaStatementSequence* sseq = _choice_pairs[i].second;
		if(sseq)
		{
			if(sseq->Can_Block(pipeline_flag))
				return(true);
		}
	}	
	if(_default_sequence && _default_sequence->Can_Block(pipeline_flag))
		return(true);

	return(false);
}

void AaSwitchStatement::Coalesce_Storage()
{
	for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
		this->_choice_pairs[i].second->Coalesce_Storage();

	if(this->_default_sequence)
		this->_default_sequence->Coalesce_Storage();
}

void AaSwitchStatement::Map_Source_References()
{

	if(this->_select_expression)
		this->_select_expression->Map_Source_References(this->_source_objects);

	for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
	{
		this->_choice_pairs[i].first->Map_Source_References(this->_source_objects);
		if(this->_choice_pairs[i].first->Is("AaSimpleObjectReference"))
		{
			AaRoot* obj = ((AaSimpleObjectReference*)(this->_choice_pairs[i].first))->Get_Object();
			if(!obj->Is_Constant())
				AaRoot::Error("Choice in switch statement must be a constant", this);
		}
		else if(!this->_choice_pairs[i].first->Is("AaConstantLiteralReference"))
		{
			AaRoot::Error("Choice in switch statement must be a scalar constant", this);
		}

		this->_choice_pairs[i].second->Map_Source_References();
	}
	if(this->_default_sequence)
		this->_default_sequence->Map_Source_References();
}
void AaSwitchStatement::Map_Targets()
{
	for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
	{
		this->_choice_pairs[i].second->Map_Targets();
	}
	if(this->_default_sequence)
		this->_default_sequence->Map_Targets();
}

void AaSwitchStatement::Print(ostream& ofile)
{
	assert(this->_select_expression);

	ofile << this->Tab();
	ofile << "$switch ";
	this->_select_expression->Print(ofile);
	ofile << endl;

	for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
	{
		ofile << this->Tab();
		ofile << "  $when ";
		this->_choice_pairs[i].first->Print(ofile);
		ofile << " $then " << endl;
		this->_choice_pairs[i].second->Print(ofile);
		ofile << endl;
	}

	if(this->_default_sequence)
	{
		ofile << this->Tab() << "  $default " << endl;
		this->_default_sequence->Print(ofile);
		ofile << endl;
	}
	ofile << this->Tab();
	ofile << "$endswitch " << endl;
}

void AaSwitchStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	// 
	//
	srcfile << "// switch statement : " <<  this->Get_Source_Info() <<  endl;
	this->_select_expression->PrintC_Declaration(srcfile);
	this->_select_expression->PrintC(srcfile);

	if(!this->_select_expression->Is_Constant())
	{
		Print_C_Assert_If_Bitvector_Undefined(this->_select_expression->C_Reference_String(), srcfile);
		srcfile << endl;
	}

	for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
	{
		this->_choice_pairs[i].first->PrintC_Declaration(srcfile);
		this->_choice_pairs[i].first->PrintC(srcfile);
	}
	srcfile << "switch (";
	Print_C_Value_Expression(this->_select_expression->C_Reference_String(), this->_select_expression->Get_Type(), srcfile);
	srcfile << ")";
	srcfile << " { " << endl;
	for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
	{
		srcfile << " case ";
		srcfile << this->_choice_pairs[i].first->Get_Expression_Value()->To_C_String();
		srcfile << " : {" << endl;
		this->_choice_pairs[i].second->PrintC(srcfile, headerfile);
		srcfile << "break;}" << endl;
	}
	srcfile << " default : {" << endl;
	if(this->_default_sequence)
	{
		this->_default_sequence->PrintC(srcfile, headerfile);
	}
	srcfile << "break;}" << endl;
	srcfile << "}" << endl;
}


void AaSwitchStatement::Write_VC_Control_Path( ostream& ofile)
{
	this->Write_VC_Control_Path(false,ofile);
}
void AaSwitchStatement::Write_VC_Control_Path(bool optimize_flag,
		ostream& ofile)
{

	ofile << "// control-path for switch  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	string exit_place = this->Get_VC_Exit_Place_Name();

	// first declare a dead region.
	string dead_link = this->Get_VC_Name() + "_dead_link";
	ofile << ";;[" << dead_link << "] { $T [dead_transition] $dead } " << endl;

	// tie up the dead link..
	ofile << this->Get_VC_Entry_Place_Name() << " |-> (" << dead_link << ")" << endl;
	ofile << exit_place << " <-| (" << dead_link << ")" << endl;


	AaScope* pscope = this->Get_Scope();
	assert(pscope->Is("AaBranchBlockStatement"));

	// first evaluate the switch expression..
	ofile << "//---------------------    switch statement " << this->Get_Source_Info() << "  --------------------------" << endl;
	ofile << "$P [" << this->Get_VC_Name() << "__condition_check_place__] " << endl;

	// the select expression... may be trivial ...
	if(!this->_select_expression->Is_Implicit_Variable_Reference())
	{
		this->_select_expression->Write_VC_Control_Path(ofile);
		ofile << this->Get_VC_Name() << "__entry__ |-> (" << this->_select_expression->Get_VC_Name() << ")" << endl;
		ofile << this->Get_VC_Name() << "__condition_check_place__ <-| (" 
			<< this->_select_expression->Get_VC_Name() << ")" << endl;
	}
	else
	{
		ofile << this->Get_VC_Name() << "__entry__ |-> (" 
			<< this->Get_VC_Name() << "__condition_check_place__)"  << endl;
	}


	ofile << "||[" << this->Get_VC_Name() << "__condition_check__] { // condition computation" << endl;
	for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{

		ofile << ";;[condition_" << idx << "] {" << endl;

		// one comparison per choice
		ofile << "|| [SplitProtocol] { " << endl;
		ofile << ";; [Sample] {" << endl;
		ofile << "$T[rr] $T[ra]" << endl;
		ofile << "}" << endl;
		ofile << ";; [Update] {" << endl;
		ofile << "$T [cr] $T [ca] " << endl;
		ofile << "}" << endl;
		ofile << "}" << endl;

		// one branch operator per choice
		ofile << " $T [cmp] // cmp will trigger choice comparison" << endl;
		ofile << "}" << endl;
	}

	// need one branch operator for the default.
	// $exit of condition_check will trigger default branch comparison.
	ofile << "}" << endl;
	ofile << this->Get_VC_Name() << "__condition_check_place__ |-> (" << this->Get_VC_Name() << "__condition_check__)" << endl;

	// select place..
	ofile << "$P [" << this->Get_VC_Name() << "__select__] " << endl;

	// condition check will merge into select.
	ofile << this->Get_VC_Name() << "__select__ <-| (" << this->Get_VC_Name() << "__condition_check__)" << endl;
	// follow the place by "n+1" choices.  The +1 choice
	// corresponds to the default..

	for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{
		ofile << "// switch choice " << idx << endl;

		// link ack1 of the corresponding branch operator
		// to choice_K/ack1.
		//
		// the ack0 transition from the branch operator
		// will be ignored..
		string source_element = this->Get_VC_Name() + "_choice_" + IntToStr(idx);
		ofile << ";;[" << source_element  << "] { $T [ack1]  // ack0 will be ignored..\n }"  << endl;

		if(optimize_flag)
			((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path_Optimized(source_element,
				_choice_pairs[idx].second,
				exit_place,
				ofile);
		else
			((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(source_element,
				_choice_pairs[idx].second,
				exit_place,
				ofile);

	}
	if(_default_sequence != NULL)
	{
		// link ack0 of the default branch operator to
		// choice_default/ack0.
		//
		// the ack1 transition from the branch operator
		// will be ignored.
		//
		string source_element = this->Get_VC_Name() + "_choice_default";
		ofile << ";;[" << source_element << "] { $T [ack0] // ack1 will be ignored..\n  }"  << endl;


		// the default sequence will use the ack0 signal from a branch
		// operator whose input is the concatenation of the comparisons
		// carried out in the condition-check parallel block
		ofile << "// switch default choice " << endl;

		if(!optimize_flag)
			((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(source_element,
				_default_sequence,
				exit_place,
				ofile);
		else
			((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path_Optimized(source_element,
				_default_sequence,
				exit_place,
				ofile);
	}

	// select will branch off to one of the choice
	// regions.
	ofile << this->Get_VC_Name() << "__select__ |-> (";
	for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{
		if(idx > 0)
			ofile << " ";

		string source_element = this->Get_VC_Name() + "_choice_" + IntToStr(idx);
		ofile << source_element;
	}

	if(_default_sequence != NULL)
	{
		string source_element = this->Get_VC_Name() + "_choice_default";
		ofile << " " << source_element;
	}
	ofile << ")" << endl;


	ofile << "//---------------------   end of switch statement " << this->Get_Source_Info() << "  --------------------------" << endl;
}

void AaSwitchStatement::Write_VC_Constant_Declarations(ostream& ofile)
{
	for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{
		this->_choice_pairs[idx].second->Write_VC_Constant_Declarations(ofile);
	}
	if(this->_default_sequence)
		this->_default_sequence->Write_VC_Constant_Declarations(ofile);

}

void AaSwitchStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

	ofile << "// constant-declarations  for switch  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	this->_select_expression->Write_VC_Constant_Wire_Declarations(ofile);
	// constant literal expressions will be declared as constants..
	for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{
		this->_choice_pairs[idx].first->Write_VC_Constant_Wire_Declarations(ofile);
		this->_choice_pairs[idx].second->Write_VC_Constant_Wire_Declarations(ofile);
	}
	if(this->_default_sequence)
		this->_default_sequence->Write_VC_Constant_Wire_Declarations(ofile);
}

void AaSwitchStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
	ofile << "// switch-statement  " << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	// wire declarations..
	this->_select_expression->Write_VC_Wire_Declarations(false,ofile);
	for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{
		AaExpression* expr = this->_choice_pairs[idx].first;
		Write_VC_Wire_Declaration(expr->Get_VC_Constant_Name() + "_cmp", "$int<1>",ofile);
		this->_choice_pairs[idx].second->Write_VC_Wire_Declarations(ofile);
	}
	if(this->_default_sequence)
		this->_default_sequence->Write_VC_Wire_Declarations(ofile);

}
void AaSwitchStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
	ofile << "// datapath-instances  for switch  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	vector<pair<string,AaType*> > default_branch_inputs;
	this->_select_expression->Write_VC_Datapath_Instances(NULL,ofile);
	for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{
		AaExpression* expr = this->_choice_pairs[idx].first;
		vector<pair<string,AaType*> > br_input;

		// one comparison operator per switch choice.
		Write_VC_Binary_Operator(__EQUAL, 
				this->Get_VC_Name() + "_select_expr_" + IntToStr(idx),
				_select_expression->Get_VC_Driver_Name(),
				_select_expression->Get_Type(),
				expr->Get_VC_Constant_Name(),
				expr->Get_Type(),
				expr->Get_VC_Constant_Name() + "_cmp",
				expr->Get_Type(),
				this->Get_VC_Guard_String(),
				false,
				false,
				false, // no switches in pipelines.
				ofile);

		br_input.push_back(pair<string,AaType*>(expr->Get_VC_Constant_Name() + "_cmp",
					expr->Get_Type()));
		default_branch_inputs.push_back(pair<string,AaType*>(expr->Get_VC_Constant_Name() + "_cmp",
					expr->Get_Type()));

		// one branch instance per switch choice.
		Write_VC_Branch_Instance(this->Get_VC_Name() + "_branch_" + IntToStr(idx),
				br_input,
				ofile);
		this->_choice_pairs[idx].second->Write_VC_Datapath_Instances(ofile);
	}

	if(this->_default_sequence != NULL)
	{
		// one branch instance for the default.
		Write_VC_Branch_Instance(this->Get_VC_Name() + "_branch_default",
				default_branch_inputs,
				ofile);
		this->_default_sequence->Write_VC_Datapath_Instances(ofile);
	}
}

void AaSwitchStatement::Write_VC_Links(string hier_id, ostream& ofile)
{
	this->Write_VC_Links(false,hier_id,ofile);
}

void AaSwitchStatement::Write_VC_Links(bool optimize_flag,
		string hier_id, ostream& ofile)
{

	ofile << "// CP-DP links for switch  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	AaScope* pscope = this->Get_Scope();
	assert(pscope->Is("AaBranchBlockStatement"));

	vector<string> reqs, acks;
	// links in the expression tree.
	this->_select_expression->Write_VC_Links(hier_id,ofile);

	//  links for each of the choices.  Note that there will
	//  be a single branch instance for each choice.
	for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{


		// for the comparison operation.
		reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/SplitProtocol/Sample/rr");
		reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/SplitProtocol/Update/cr");
		acks.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/SplitProtocol/Sample/ra");
		acks.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/SplitProtocol/Update/ca");
		Write_VC_Link(this->Get_VC_Name() + "_select_expr_" + IntToStr(idx),reqs,acks,ofile);

		reqs.clear();
		acks.clear();

		// for the branch operator
		reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/cmp");
		acks.push_back("$open"); // ack0 is ignored. 
		acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_choice_" + IntToStr(idx) + "/ack1");
		Write_VC_Link(this->Get_VC_Name() + "_branch_" + IntToStr(idx),
				reqs,
				acks,
				ofile);

		reqs.clear();
		acks.clear();

		// choice sequence has links too..
		if(!optimize_flag)
			this->_choice_pairs[idx].second->Write_VC_Links(hier_id, ofile);
		else
		{
			((AaBranchBlockStatement*)pscope)->
				Write_VC_Links_Optimized(hier_id,
						this->_choice_pairs[idx].second,
						ofile);	  

		}

	}

	// link for the default branch.
	if(this->_default_sequence != NULL)
	{
		string req_hier_id = hier_id + "/" + this->Get_VC_Name() + "__condition_check__";

		// the branch operator for the default.
		reqs.push_back(req_hier_id + "/$exit");
		acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_choice_default/ack0");
		acks.push_back("$open"); // ack1 is ignored.
		Write_VC_Link(this->Get_VC_Name() + "_branch_default",reqs,acks,ofile);
		reqs.clear();
		acks.clear();

		// default sequence has links too..
		if(!optimize_flag)
			this->_default_sequence->Write_VC_Links(hier_id,ofile);
		else
		{
			((AaBranchBlockStatement*)pscope)->
				Write_VC_Links_Optimized(hier_id,
						this->_default_sequence,
						ofile);	  
		}

	}
}

void AaSwitchStatement::Propagate_Constants()
{
	if(this->_select_expression->Get_Type() == NULL)
	{
		AaRoot::Error("Could not determine type of select expression in switch statement.. ", this);
	}
	else
	{
		this->_select_expression->Evaluate();
		for(int idx = 0; idx < _choice_pairs.size(); idx++)
		{
			if(this->_choice_pairs[idx].first->Is("AaSimpleObjectReference"))
				this->_choice_pairs[idx].first->Evaluate();
			else
			{
				if(!this->_choice_pairs[idx].first->Get_Type())
				{
					this->_choice_pairs[idx].first->Set_Type(this->_select_expression->Get_Type());
				}
				this->_choice_pairs[idx].first->Evaluate();
			}
			this->_choice_pairs[idx].second->Propagate_Constants();
		}

		if(this->_default_sequence)
			this->_default_sequence->Propagate_Constants();
	}
}

void AaSwitchStatement::Get_Target_Places(set<AaPlaceStatement*>& target_places)
{
	int idx;
	for(idx = 0; idx < _choice_pairs.size(); idx++)
	{
		_choice_pairs[idx].second->Get_Target_Places(target_places);
	}
}

//---------------------------------------------------------------------
// AaIfStatement: public AaStatement
//---------------------------------------------------------------------
AaIfStatement::AaIfStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
	this->_test_expression = NULL;
	this->_if_sequence = NULL;
	this->_else_sequence = NULL;
}
AaIfStatement::~AaIfStatement() {}

void AaIfStatement::Set_Test_Expression(AaExpression* te) 
{ 
	this->_test_expression = te; 
	if(te != NULL)
		te->Set_Associated_Statement(this);
}

void AaIfStatement::Coalesce_Storage()
{
	if(this->_if_sequence)
		this->_if_sequence->Coalesce_Storage();

	if(this->_else_sequence)
		this->_if_sequence->Coalesce_Storage();
}


void AaIfStatement::Print(ostream& ofile)
{
	assert(this->_test_expression);
	assert(this->_if_sequence);

	ofile << this->Tab();
	ofile << "$if ";
	this->_test_expression->Print(ofile);
	ofile << " $then " << endl;
	this->_if_sequence->Print(ofile);
	ofile << endl;
	if(this->_else_sequence)
	{
		ofile << this->Tab() << "$else " << endl;
		this->_else_sequence->Print(ofile);
		ofile << endl;
	}
	ofile << this->Tab() << "$endif" << endl;
}

bool AaIfStatement::Can_Block(bool pipeline_flag)
{
	if(this->AaStatement::Can_Block(pipeline_flag))
		return(true);

	if(this->_if_sequence)
	{
		if(this->_if_sequence->Can_Block(pipeline_flag))
			return(true);
	}
	if(this->_else_sequence)
	{
		if(this->_else_sequence->Can_Block(pipeline_flag))
			return(true);
	}
	return(false);
}


void AaIfStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{
	srcfile << "// if statement : " <<  this->Get_Source_Info() <<  endl;
	this->_test_expression->PrintC_Declaration(srcfile);
	this->_test_expression->PrintC(srcfile);
	if(!this->_test_expression->Is_Constant())
	{
		Print_C_Assert_If_Bitvector_Undefined(this->_test_expression->C_Reference_String(), srcfile);
		srcfile << endl;
	}

	srcfile << "if (";
	Print_C_Value_Expression(this->_test_expression->C_Reference_String(), this->_test_expression->Get_Type(), srcfile);
	srcfile << ") { " << endl;
	if(this->_if_sequence)
	{
		this->_if_sequence->PrintC(srcfile, headerfile);
	}
	else
	{
		srcfile <<  " ;" << endl;
	}
	srcfile << "} " << endl; 
	srcfile << "else {" << endl;
	if(this->_else_sequence)
	{
		this->_else_sequence->PrintC(srcfile, headerfile);
	}
	else
	{
		srcfile <<  " ;" << endl;
	}
	srcfile << "}" << endl;
}



void AaIfStatement::Write_VC_Control_Path(ostream& ofile)
{
	this->Write_VC_Control_Path(false,ofile);
}

void AaIfStatement::Write_VC_Control_Path(bool optimize_flag, ostream& ofile)
{

	ofile << "// if-statement  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	string exit_place = this->Get_VC_Exit_Place_Name();

	// a dead-link: to show that the normal path of control
	// flow is from entry to exit.. but this normal path is
	// not taken.
	//
	// this is needed because we do structure checks on
	// CP regions which would fail otherwise.
	string dead_link = this->Get_VC_Name() + "_dead_link";
	ofile << ";;[" << dead_link << "] { $T [dead_transition] $dead } " << endl;

	// tie up the dead link..
	ofile << this->Get_VC_Entry_Place_Name() << " |-> (" << dead_link << ")" << endl;
	ofile << exit_place << " <-| (" << dead_link << ")" << endl;


	AaScope* pscope = this->Get_Scope();
	assert(pscope->Is("AaBranchBlockStatement"));

	// first the CP for the test expression
	string eval_test_region = this->Get_VC_Name() + "_eval_test";
	string if_link = this->Get_VC_Name() + "_if_link";
	string else_link = this->Get_VC_Name() + "_else_link";


	ofile << ";;[" << eval_test_region << "] { // test expression evaluate and trigger branch "  << endl;
	this->_test_expression->Write_VC_Control_Path(ofile);

	ofile << " $T [branch_req] " << endl;
	ofile << "}" << endl;
	ofile << this->Get_VC_Name() << "__entry__ |-> (" << eval_test_region << ")" << endl;

	// now the test-place.
	ofile << "$P [" << _test_expression->Get_VC_Name() << "_place]" << endl;
	ofile << _test_expression->Get_VC_Name() << "_place <-| (" << eval_test_region << ")" << endl;
	string test_place_successors = if_link + " " + else_link;

	ofile << ";;[" << if_link << "] { $T [if_choice_transition] } " << endl;
	ofile << ";;[" << else_link << "] { $T [else_choice_transition] } " << endl;

	ofile << _test_expression->Get_VC_Name() << "_place |-> (" << test_place_successors << ")" << endl;  


	// now the if-sequence of statments
	if(_if_sequence != NULL)
	{

		if(!optimize_flag)
			((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(if_link,
				_if_sequence,
				exit_place,
				ofile);
		else
			((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path_Optimized(if_link,
				_if_sequence,
				exit_place,
				ofile);

	}
	else
	{
		ofile << exit_place << " <-| (" << if_link << ")" << endl;
	}

	if(_else_sequence != NULL)
	{
		if(!optimize_flag)
			((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(else_link,
				_else_sequence,
				exit_place,
				ofile);
		else
			((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path_Optimized(else_link,
				_else_sequence,
				exit_place,
				ofile);
	}
	else
	{
		ofile << exit_place << " <-| (" << else_link << ")" << endl;
	}

}

void AaIfStatement::Write_VC_Constant_Declarations(ostream& ofile)
{
	if(this->_if_sequence)
		this->_if_sequence->Write_VC_Constant_Declarations(ofile);
	if(this->_else_sequence)
		this->_else_sequence->Write_VC_Constant_Declarations(ofile);
}

void AaIfStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

	ofile << "// if-statement  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	// one wire for the test expression result.
	this->_test_expression->Write_VC_Constant_Wire_Declarations(ofile);

	if(this->_if_sequence)
		this->_if_sequence->Write_VC_Constant_Wire_Declarations(ofile);

	if(this->_else_sequence)
		this->_else_sequence->Write_VC_Constant_Wire_Declarations(ofile);
}
void AaIfStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
	ofile << "// if statement  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	// one wire for the test expression result.
	this->_test_expression->Write_VC_Wire_Declarations(false,ofile);

	// wires from the if-sequence
	if(this->_if_sequence)
		this->_if_sequence->Write_VC_Wire_Declarations(ofile);

	// wires from the else-sequence
	if(this->_else_sequence)
		this->_else_sequence->Write_VC_Wire_Declarations(ofile);

}
void AaIfStatement::Write_VC_Datapath_Instances(ostream& ofile)
{

	ofile << "// datapath-instances for if  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	// test expression needs to be computed.
	this->_test_expression->Write_VC_Datapath_Instances(NULL, ofile);

	// followed by a branch.
	vector<pair<string,AaType*> > branch_inputs;
	branch_inputs.push_back(pair<string,AaType*>(this->_test_expression->Get_VC_Driver_Name(),
				this->_test_expression->Get_Type()));

	Write_VC_Branch_Instance(this->Get_VC_Name()+"_branch",
			branch_inputs,
			ofile);

	if(this->_if_sequence)
		this->_if_sequence->Write_VC_Datapath_Instances(ofile);

	if(this->_else_sequence)
		this->_else_sequence->Write_VC_Datapath_Instances(ofile);
}

void AaIfStatement::Write_VC_Links(string hier_id,ostream& ofile)
{
	this->Write_VC_Links(false,hier_id,ofile);
}

void AaIfStatement::Write_VC_Links(bool optimize_flag, string hier_id,ostream& ofile)
{

	ofile << "// CP-DP links for if  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	this->_test_expression->Write_VC_Links(hier_id + "/" + this->Get_VC_Name() + "_eval_test",ofile);
	vector<string> reqs;
	vector<string> acks;

	reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "_eval_test/branch_req");
	acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_else_link/else_choice_transition");
	acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_if_link/if_choice_transition");

	Write_VC_Link(this->Get_VC_Name()+"_branch",reqs,acks,ofile);

	AaScope* pscope = this->Get_Scope();
	assert(pscope->Is("AaBranchBlockStatement"));

	if(this->_if_sequence)
	{
		if(!optimize_flag)
			this->_if_sequence->Write_VC_Links(hier_id,ofile);
		else
		{
			((AaBranchBlockStatement*)pscope)->Write_VC_Links_Optimized(hier_id,
				_if_sequence,
				ofile);
		}
	}

	if(this->_else_sequence)
	{
		if(!optimize_flag)
			this->_else_sequence->Write_VC_Links(hier_id,ofile);
		else
		{
			((AaBranchBlockStatement*)pscope)->Write_VC_Links_Optimized(hier_id,
				_else_sequence,
				ofile);
		}
	}
}

void AaIfStatement::Propagate_Constants()
{
	if(this->_test_expression->Get_Type() == NULL)
	{
		if(AaProgram::_verbose_flag)
			AaRoot::Warning("Could not determine type of test expression in if statement.. will assume that it is $uint<1> ", this);
		this->_test_expression->Set_Type(AaProgram::Make_Uinteger_Type(1));
	}
	this->_test_expression->Evaluate();
	if(this->_if_sequence)
		this->_if_sequence->Propagate_Constants();
	if(this->_else_sequence)
		this->_else_sequence->Propagate_Constants();
}

void AaIfStatement::Get_Target_Places(set<AaPlaceStatement*>& target_places)
{
	if(this->_if_sequence)
		this->_if_sequence->Get_Target_Places(target_places);
	if(this->_else_sequence)
		this->_if_sequence->Get_Target_Places(target_places);
}

//---------------------------------------------------------------------
// AaPlaceStatement: public AaStatement
//---------------------------------------------------------------------
AaPlaceStatement::AaPlaceStatement(AaBranchBlockStatement* parent_tpr,string lbl):AaStatement(parent_tpr) 
{
	this->_label = lbl;
	this->_multiplicity = 1;
	parent_tpr->Map_Child(lbl,this);
};
AaPlaceStatement::~AaPlaceStatement() {};


string AaPlaceStatement::C_Reference_String()
{
	string ret_val = this->Get_Label();
	if(this->Get_Scope() != NULL)
		ret_val += "_" + Int64ToStr(this->Get_Scope()->Get_Index());
	return(ret_val);
}


//---------------------------------------------------------------------
// AaDoWhileStatement: public AaStatement
//---------------------------------------------------------------------
AaDoWhileStatement::AaDoWhileStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
	this->_pipeline_depth = 1;
	this->_pipeline_buffering = 1;
	this->_pipeline_full_rate_flag = false;
	this->_test_expression = NULL;
	this->_merge_statement = NULL;
	this->_loop_body_sequence = NULL;
}
AaDoWhileStatement::~AaDoWhileStatement() {}


bool AaDoWhileStatement::Can_Block(bool pipeline_flag)
{

	assert(this->_merge_statement != NULL);

	if(this->_merge_statement->Can_Block(pipeline_flag))
		return(true);

	if((this->_loop_body_sequence != NULL) && this->_loop_body_sequence->Can_Block(pipeline_flag))
		return(true);

	return(false);
}

void AaDoWhileStatement::Set_Test_Expression(AaExpression* te) 
{ 
	this->_test_expression = te;  
	te->Set_Associated_Statement(this);
}

void AaDoWhileStatement::Set_Loop_Body_Sequence(AaStatementSequence* lbs) 
{ 
	this->_loop_body_sequence = lbs; 
	lbs->Set_Pipeline_Parent(this);
}

void AaDoWhileStatement::Coalesce_Storage()
{
	if(this->_merge_statement)
		this->_merge_statement->Coalesce_Storage();

	if(this->_loop_body_sequence)
		this->_loop_body_sequence->Coalesce_Storage();
}


void AaDoWhileStatement::Print(ostream& ofile)
{
	assert(this->_test_expression);
	assert(this->_loop_body_sequence);

	if(AaProgram::_balance_loop_pipeline_bodies)
	{
		AaModule* m = this->Get_Module();
		if((m != NULL) && (!m->Get_Noopt_Flag()))
		{
			AaRoot::Info(" started equalizing paths for do-while statement " + this->Get_VC_Name() + " in module " + m->Get_Label());
			this->Equalize_Paths_For_Pipelining();
		}
	}

	ofile << this->Tab();
	ofile << "$dopipeline $depth " << this->Get_Pipeline_Depth();
	ofile << " $buffering " << this->Get_Pipeline_Buffering() <<  endl;
	if(this->Get_Pipeline_Full_Rate_Flag())
		ofile << " $fullrate " << endl;

	this->_merge_statement->Print(ofile);
	this->_loop_body_sequence->Print(ofile);
	ofile << " $while " ;
	this->_test_expression->Print(ofile);
	ofile << endl;
}

void AaDoWhileStatement::PrintC(ofstream& srcfile, ofstream& headerfile)
{

	srcfile << "{" << endl;
	srcfile << "// do-while:  " << this->Get_Source_Info() << endl;
	assert(this->_test_expression);

	this->_test_expression->PrintC_Declaration(srcfile);
	srcfile << "uint8_t do_while_entry_flag;" << endl;
	srcfile << "do_while_entry_flag = 1;" << endl;
	srcfile << "uint8_t do_while_loopback_flag;" << endl;
	srcfile << "do_while_loopback_flag = 0;" << endl;
	srcfile << "while(1) {" << endl;
	this->_merge_statement->PrintC(srcfile, headerfile);
	this->_loop_body_sequence->PrintC(srcfile, headerfile);
	srcfile << "do_while_entry_flag = 0;" << endl;
	srcfile << "do_while_loopback_flag = 1;" << endl;
	this->_test_expression->PrintC(srcfile);

	if(!this->_test_expression->Is_Constant())
	{
		Print_C_Assert_If_Bitvector_Undefined(this->_test_expression->C_Reference_String(), srcfile);
		srcfile << endl;
	}

	srcfile << "if (!";
	Print_C_Value_Expression(this->_test_expression->C_Reference_String(), 
			this->_test_expression->Get_Type(), srcfile);
	srcfile << ") break;" << endl;
	srcfile << "} " << endl;
	srcfile << "}" << endl;
}


void AaDoWhileStatement::Write_VC_Control_Path(ostream& ofile)
{
	// for the moment, DoWhile is always written in optimized
	// fashion.
	this->Write_VC_Control_Path(true,ofile);
}

void AaDoWhileStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	this->Write_VC_Control_Path(true,ofile);
}

void AaDoWhileStatement::Write_VC_Control_Path(bool optimize_flag, ostream& ofile)
{
	// in the optimized case, there are two regions in
	// the CP for the dowhile.  An outer loop region
	// and an inner region for the loop-body.
	//
	// The inner region has two input places (bound to 
	// corresponding transitions) and is a pipelined
	// fork body.  The PHI statements are included
	// in the inner body and their sequencing is
	// handled inside the inner body.
	// 
	ofile << "// do-while-statement  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	// the outer region name
	string vc_block_id = "loop_" + Int64ToStr(this->Get_Index());

	// the inner region name
	string vc_loop_body_id = this->Get_VC_Name() + "_loop_body";

	// start the outer region
	ofile << "<o> [" << this->Get_VC_Name() << "]  $depth " << this->Get_Pipeline_Depth() 
		<< " $buffering " << this->Get_Pipeline_Buffering() << " {" << endl;

	// entry and exit places.
	string entry_place_name = this->Get_VC_Name() + "__entry__";
	string exit_place_name = this->Get_VC_Name() + "__exit__";
	__Place(entry_place_name);
	__Place(exit_place_name);

	// the syntax is very strict about the ordering of
	// declarations:
	//    First the loop_back place.
	__Place("loop_back");

	//    then the condition_done place (which is bound to 
	//    the condition evaluation transition in the loop body).
	__Place("condition_done");

	// a place to indicate the the loop-body has finished
	// an iteration.
	__Place("loop_body_done");

	// next: the loop_body, which is a pipeline.
	// to write its control-path, we must pass in the
	// test-expression as well as the list of PHI statements
	// which act as sources for the expressions within
	// the loop body.
	AaScope* pscope = this->Get_Scope();
	assert(pscope->Is("AaBranchBlockStatement"));

	// get the list of Phi-stmts.
	vector<AaStatement*> phi_stmts;
	bool has_relaxed = false;
	bool has_strict  = false;
	for(unsigned int idx = 0; idx < this->_merge_statement->Get_Statement_Count(); idx++)
	{
		AaPhiStatement* ps = (AaPhiStatement*) (this->_merge_statement->Get_Statement(idx));
		phi_stmts.push_back(ps);

		if(ps->Get_Relaxed_Flag())
			has_relaxed = true;
		else
			has_strict = true;


	}


	AaBlockStatement* pstmt = (AaBlockStatement*) pscope;

	// Now the inner body.
	ofile << "$pipeline [" << vc_loop_body_id << "] {" << endl;

	// The loop body will be triggered from one of two points
	// merge these to the entry transition.
	ofile << "// Pipelined!" << endl;
	__T("back_edge_to_loop_body");
	__T("first_time_through_loop_body");
	__T("loop_body_start");
	__T("condition_evaluated");

	ofile << "$transitionmerge [entry_tmerge] (back_edge_to_loop_body first_time_through_loop_body) (loop_body_start)" << endl;
	__J("$entry","loop_body_start");

	set<AaRoot*> visited_elements;
	map<AaMemorySpace*, vector<AaRoot*> > load_store_ordering_map;
	map<AaPipeObject*, vector<AaRoot*> >  pipe_map;


	//
	// PHI statements will run concurrently, in a synchronized manner.
	//
	if(phi_stmts.size() > 0)
	{
		__T("aggregated_phi_sample_req");

		__T("aggregated_phi_sample_ack");
		__TD("aggregated_phi_sample_ack_d");
		__J("aggregated_phi_sample_ack_d", "aggregated_phi_sample_ack");

		if(has_strict)
		{
			__T("aggregated_phi_update_req");
		}

		__T("aggregated_phi_update_ack");

		// do not loop-back unless all phi's have used
		// up their triggering tokens.  Delay introduced
		ofile << "// do not loop-back unless all phi's have used up their triggering tokens." << endl;
		__J("condition_evaluated", "aggregated_phi_sample_ack_d");
		__J("condition_evaluated", "aggregated_phi_update_ack");

		//
		// do not re-sample unless the result of the previous
		// sample has been updated at the output.
		//
		// This takes care of a RAW dependency between one phi cycle
		// and the next.
		//
		__MJ("aggregated_phi_sample_req", "aggregated_phi_update_ack", true);

		//
		// Note that within the SAME cycle, there is a WAR dependency
		// across statements that is not enforced by the default PHI
		// control scheme.  If you need to enforce this, you will 
		// have to use a $barrier on the PHI which is a victim
		// of this race.
		//
	}

	// write the PHI statements.
	vector<AaPhiStatement*> barriers;
	for(unsigned int idx = 0; idx < phi_stmts.size(); idx++)
	{
		AaStatement* curr_phi = phi_stmts[idx];
		curr_phi->Write_VC_Control_Path_Optimized(true,
				visited_elements,
				load_store_ordering_map,
				pipe_map,
				NULL,
				ofile);



		// sampling ordering to control race
		// issues
		if(barriers.size() > 0) {

			string curr_ust = (((AaPhiStatement*)curr_phi)->Is_Single_Source() ?
						__UST(((AaPhiStatement*)curr_phi)->Get_Source_Expression(0)) : __UST(curr_phi) + "_ps");


			int J;
			for(J=0; J < barriers.size(); J++)
			{

				AaPhiStatement* last_phi = barriers[J];
 				string barrier_sct = (last_phi->Is_Single_Source() ?
                                                	__SCT(last_phi->Get_Source_Expression(0)) : __SCT(last_phi) + "_ps");

				ofile << "// Race prevention dependency in ordered.. PHI's." << endl;
				__J(curr_ust,barrier_sct)
			}
		}

		if(((AaPhiStatement*) curr_phi)->Get_Barrier_Flag())
			barriers.push_back((AaPhiStatement*) curr_phi);		
	}


	// write the Loop-body-sequence
	AaRoot* trailing_barrier = NULL;
	pstmt->Write_VC_Control_Path_Optimized(true, 
			_loop_body_sequence,
			visited_elements,
			load_store_ordering_map,
			pipe_map,
			trailing_barrier,
			ofile); 

	AaExpression* condition_expr = this->_test_expression;
	assert(condition_expr != NULL);
	condition_expr->Write_VC_Control_Path_Optimized(true,
			visited_elements,
			load_store_ordering_map,
			pipe_map,
			trailing_barrier,
			ofile);


	// this delay prevents a loop in the whole shebang.. we will
	// be making branch-base have the option of bypass.
	ofile << "$T [loop_body_delay_to_condition_start] $delay" << endl;
	__F("loop_body_start", "loop_body_delay_to_condition_start");
	__F("loop_body_delay_to_condition_start", "condition_evaluated");
	if(!condition_expr->Is_Constant())
	{
		condition_expr->Write_Forward_Dependency_From_Roots("condition_evaluated",-1,visited_elements, ofile);
	}

	__F("condition_evaluated", "$null");



	// dependencies.
	pstmt->Write_VC_Load_Store_Dependencies(true, load_store_ordering_map,ofile);
	pstmt->Write_VC_Pipe_Dependencies(true, pipe_map,ofile);

	// from condition_evaluated to entry, there is an arc to be used
	// while computing strongly connected components.
	ofile << "// SCC arc from condition_evaluated to entry" << endl;
	ofile << "$scc_arc condition_evaluated => $entry" << endl;

	ofile << "}"; // end of loop-body.
	//exports
	ofile << "( first_time_through_loop_body  back_edge_to_loop_body) " << endl;
	ofile << "( condition_evaluated )" << endl;

	//    following the loop body, the branch options (exit/taken)
	ofile << ";; [loop_exit] { $T [ack] } " << endl;
	ofile << ";; [loop_taken] { $T [ack] } " << endl;

	//    merges.
	ofile << entry_place_name << " <-| ($entry)" << endl;
	ofile << "loop_body_done <-| ( " << vc_loop_body_id << " ) " << endl;

	// branches.
	ofile << "condition_done |-> (loop_exit loop_taken)" << endl;
	// ofile << entry_place_name << " |-> ( " << vc_loop_body_id<< " ) " << endl;
	ofile << exit_place_name << " |-> ($exit)" << endl;

	//    the binding of the condition_done to the test expression completion.
	ofile << "$bind condition_done <= " << vc_loop_body_id << " : condition_evaluated" << endl; 

	// the binding of the loop-entry contol places to the loop body.
	ofile << "$bind " << entry_place_name << "  => " << vc_loop_body_id << " : first_time_through_loop_body " << endl; 
	ofile << "$bind loop_back  => " << vc_loop_body_id << " : back_edge_to_loop_body " << endl; 

	//    the terminator!
	ofile << "$terminate (loop_exit loop_taken loop_body_done) (loop_back " << exit_place_name << ")" << endl;
	ofile << "}" << endl;
}

void AaDoWhileStatement::Write_VC_Constant_Declarations(ostream& ofile)
{
	this->_merge_statement->Write_VC_Constant_Declarations(ofile);
	if(this->_loop_body_sequence)
		this->_loop_body_sequence->Write_VC_Constant_Declarations(ofile);
}

void AaDoWhileStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

	ofile << "// do-while statement  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	// one wire for the test expression result.
	this->_test_expression->Write_VC_Constant_Wire_Declarations(ofile);

	if(this->_merge_statement)
		this->_merge_statement->Write_VC_Constant_Wire_Declarations(ofile);

	if(this->_loop_body_sequence)
		this->_loop_body_sequence->Write_VC_Constant_Wire_Declarations(ofile);
}
void AaDoWhileStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
	ofile << "// do-while statement  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	// one wire for the test expression result.
	this->_test_expression->Write_VC_Wire_Declarations(false,ofile);

	// wires from the if-sequence
	if(this->_merge_statement)
		this->_merge_statement->Write_VC_Wire_Declarations(ofile);

	// wires from the else-sequence
	if(this->_loop_body_sequence)
		this->_loop_body_sequence->Write_VC_Wire_Declarations(ofile);

}
void AaDoWhileStatement::Write_VC_Datapath_Instances(ostream& ofile)
{

	ofile << "// datapath-instances for do-while  ";
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	// test expression needs to be computed.
	this->_test_expression->Write_VC_Datapath_Instances(NULL, ofile);

	// followed by a branch.
	vector<pair<string,AaType*> > branch_inputs;
	branch_inputs.push_back(pair<string,AaType*>(this->_test_expression->Get_VC_Driver_Name(),
				this->_test_expression->Get_Type()));

	Write_VC_Branch_With_Bypass_Instance(this->Get_VC_Name()+"_branch",
			branch_inputs,
			ofile);

	if(this->_merge_statement)
		this->_merge_statement->Write_VC_Datapath_Instances(ofile);

	if(this->_loop_body_sequence)
		this->_loop_body_sequence->Write_VC_Datapath_Instances(ofile);
}

void AaDoWhileStatement::Write_VC_Links(string hier_id,ostream& ofile)
{
	this->Write_VC_Links(true,hier_id,ofile);
}

void AaDoWhileStatement::Write_VC_Links_Optimized(string hier_id,ostream& ofile)
{
	this->Write_VC_Links(true,hier_id,ofile);
}

void AaDoWhileStatement::Write_VC_Links(bool optimize_flag, string hier_id,ostream& ofile)
{
	ofile << "// CP-DP links for do-while  " << this->Get_VC_Name();
	ofile << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	string this_hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name());
	string loop_body_id = this->Get_VC_Name() + "_loop_body";
	string loop_body_seq_hier_id = Augment_Hier_Id(this_hier_id,loop_body_id);

	// in the PHI statements in the do-while.
	for(int idx=0, fidx = this->_merge_statement->Get_Statement_Count(); idx < fidx; idx++)
	{
		AaStatement* cphi = this->_merge_statement->Get_Statement(idx);
		cphi->Write_VC_Links_Optimized(loop_body_seq_hier_id, ofile);
	}

	// in the loop body
	_loop_body_sequence->Write_VC_Links_Optimized(loop_body_seq_hier_id, ofile);

	// test expression sits inside the loop-body.
	_test_expression->Write_VC_Links_Optimized(loop_body_seq_hier_id,ofile);

	// branch instance..
	vector<string> reqs;
	vector<string> acks;
	// req to branch is produced by completion of test expression..
	// which is inside the loop-body
	reqs.push_back(loop_body_seq_hier_id + "/condition_evaluated");
	// acks from branch in loop-exit and loop-taken which are in here.
	acks.push_back(this_hier_id + "/loop_exit/ack");
	acks.push_back(this_hier_id + "/loop_taken/ack");
	string br_inst_name = this->Get_VC_Name() + "_branch";
	Write_VC_Link(br_inst_name, reqs,acks,ofile);

}

void AaDoWhileStatement::Propagate_Constants()
{
	if(this->_test_expression->Get_Type() == NULL)
	{
		if(AaProgram::_verbose_flag)
			AaRoot::Warning("Could not determine type of test expression in do-while statement.. will assume that it is $uint<1> ", this);
		this->_test_expression->Set_Type(AaProgram::Make_Uinteger_Type(1));
	}
	this->_test_expression->Evaluate();
	if(this->_merge_statement)
		this->_merge_statement->Propagate_Constants();
	if(this->_loop_body_sequence)
		this->_loop_body_sequence->Propagate_Constants();
}

void AaDoWhileStatement::Get_Target_Places(set<AaPlaceStatement*>& target_places)
{
	// do nothing.
}


void AaDoWhileStatement::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	// first put the phi-statements in the visited_statements set..
	//
	for(int idx=0, fidx = this->_merge_statement->Get_Statement_Count(); idx < fidx; idx++)
	{
		AaStatement* cphi = (this->_merge_statement->Get_Statement(idx));
		cphi->Update_Adjacency_Map(adjacency_map, visited_elements);
	}

	// now update the adjacencies.
	for(int idx=0, fidx = this->_loop_body_sequence->Get_Statement_Count(); idx < fidx; idx++)
	{
		AaStatement* curr_stmt = this->_loop_body_sequence->Get_Statement(idx);
		curr_stmt->Update_Adjacency_Map(adjacency_map, visited_elements);
	}
}


void AaDoWhileStatement::Add_Delayed_Versions( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		set<AaRoot*>& visited_elements,
		map<AaRoot*, int>& longest_paths_from_root_map)
{

	for(set<AaRoot*>::iterator iter = visited_elements.begin(), fiter = visited_elements.end();
			iter != fiter; iter++)
	{
		AaRoot* curr = *iter;
		this->AaStatement::Add_Delayed_Versions(curr, adjacency_map, visited_elements,
				longest_paths_from_root_map, this->_loop_body_sequence);
	}
}

void AaPhiStatement::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	// delays start from phi-statements.. so no need for sources.
	AaExpression* tgt_expression = this->Get_Target();
	__InsMap(adjacency_map,NULL,this,0);
	__InsMap(adjacency_map,this,tgt_expression,PHI_OPERATOR_DELAY);
	visited_elements.insert(this);
}

void AaAssignmentStatement::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	AaExpression* src_expression = this->_source;
	src_expression->Update_Adjacency_Map(adjacency_map, visited_elements);
	__InsMap(adjacency_map,src_expression,this,0);



	AaExpression* tgt_expression = this->Get_Target();
	tgt_expression->Update_Adjacency_Map(adjacency_map,visited_elements);

	if(this->_guard_expression != NULL)
	{
		this->_guard_expression->Update_Adjacency_Map(adjacency_map, visited_elements);

		// guard has dependency to statement.
		__InsMap(adjacency_map, this->_guard_expression, this, this->_guard_expression->Get_Delay());
	}

	int delay = 0;
	// check if delay not accounted for.
	if(!this->Get_Is_Volatile())
	{
		if(src_expression->Is_Implicit_Variable_Reference())
		{
			if(tgt_expression->Is_Implicit_Variable_Reference())
				delay = INTERLOCK_DELAY;
		}
		else
			delay = src_expression->Get_Delay();
	}
	else if(!src_expression->Is_Trivial())
	{
		delay = src_expression->Get_Delay();
	}

	// arc from root to tgt_expression.
	__InsMap(adjacency_map,this,tgt_expression,delay);

	this->Update_Marked_Delay_Adjacencies(adjacency_map, visited_elements);
	visited_elements.insert(this);

}


// specified delays.
void AaStatement::Update_Marked_Delay_Adjacencies(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		set<AaRoot*>& visited_elements)
{
	if(this->_marked_delay_statements.size() > 0)
	{
		for(map<AaStatement*,int>::iterator miter = _marked_delay_statements.begin(), 
				fmiter = _marked_delay_statements.end();
				miter != fmiter; miter++)
		{
			AaStatement* ss =  (*miter).first;
			int marked_delay  = (*miter).second;
			if(visited_elements.find(ss) != visited_elements.end())
			{
				__InsMap(adjacency_map,ss,this,marked_delay);
			}
		}
	}

}

void AaCallStatement::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{

	int delay = (this->Get_Is_Volatile() ? 0 : this->_called_module->Get_Delay());
	for(int idx = 0, fidx = _input_args.size(); idx < fidx; idx++)
	{
		AaExpression* src = _input_args[idx];
		src->Update_Adjacency_Map(adjacency_map, visited_elements);
		__InsMap(adjacency_map,src,this,src->Get_Delay());
	}


	for(int idx = 0, fidx = _output_args.size(); idx < fidx; idx++)
	{
		AaExpression* tgt = _output_args[idx];
		tgt->Update_Adjacency_Map(adjacency_map, visited_elements);
		__InsMap(adjacency_map,this,tgt,delay);
	}


	if(this->_guard_expression != NULL)
	{
		this->_guard_expression->Update_Adjacency_Map(adjacency_map, visited_elements);

		// guard has dependency to statement.
		__InsMap(adjacency_map, this->_guard_expression, this, this->_guard_expression->Get_Delay());
	}

	this->Update_Marked_Delay_Adjacencies(adjacency_map, visited_elements);
	visited_elements.insert(this);
}

void AaCallStatement::Collect_Root_Sources(set<AaRoot*>& root_sources)
{
	if(this->Get_Is_On_Collect_Root_Sources_Stack())
		AaRoot::Error("Cycle in collect-root-sources", this);
	this->Set_Is_On_Collect_Root_Sources_Stack(true);

	if(this->Get_Is_Volatile())
	{
		for(int idx = 0, fidx = _input_args.size(); idx < fidx; idx++)
		{
			_input_args[idx]->Collect_Root_Sources(root_sources);
		}
	}
	else
	{
		root_sources.insert(this);
	}
	this->Set_Is_On_Collect_Root_Sources_Stack(false);

}

void AaCallStatement::Get_Non_Trivial_Source_References(set<AaRoot*>& tgt_sources, set<AaRoot*>& visited_elements)
{
	if(this->Get_Is_On_Search_For_Non_Trivial_Refs_Stack())
	{
		AaRoot::Error("Cycle in searching for non-trivial source refs ", this);
		return;
	}
	this->Set_Is_On_Search_For_Non_Trivial_Refs_Stack(true);
	if(visited_elements.find(this) != visited_elements.end())
	{
		if(this->Get_Is_Volatile())
		{
			for(int idx = 0, fidx = _output_args.size(); idx < fidx; idx++)
			{
				_output_args[idx]->Get_Non_Trivial_Source_References(tgt_sources, visited_elements);
			}
		}
		else
		{
			tgt_sources.insert(this);
		}
	}
	this->Set_Is_On_Search_For_Non_Trivial_Refs_Stack(false);
}


AaSimpleObjectReference* AaCallStatement::Get_Implicit_Target(string tgt_name)
{
	AaSimpleObjectReference* ret = NULL;
	for(int idx = 0, fidx = _output_args.size(); idx < fidx; idx++)
	{
		AaObjectReference* oarg = _output_args[idx];
		if(oarg->Is_Implicit_Variable_Reference())
		{
			string oarg_name = oarg->Get_Object_Root_Name();
			if(oarg_name == tgt_name)
			{
				ret = (AaSimpleObjectReference*) oarg;
				break;
			}
		}
	}	
	return(ret);
}

bool AaCallStatement::Is_Write_To_Pipe(AaPipeObject* obj)
{
	bool ret_val = false;
	if(this->_called_module)
	{
		ret_val = this->_called_module->Writes_To_Pipe(obj);
	}
	return(ret_val);
}

bool AaCallStatement::Writes_To_Memory_Space(AaMemorySpace* ms)
{
	bool ret_val = false;
	if(this->_called_module && !this->_called_module->Get_Foreign_Flag())
	{
		ret_val = this->_called_module->Writes_To_Memory_Space(ms);
	}
	return(ret_val);
}


bool AaCallStatement::Is_Opaque_Call_Statement()
{
	return(_called_module->Get_Opaque_Flag());
}

// return true on error.
bool Make_Split_Statement(AaScope* scope, string src, vector<int>& sizes, vector<AaExpression*>& targets, 
		vector<AaStatement*>& slist, int buffering, int line_number)
{
	if(sizes.size() != targets.size())
	{
		return(true);
	}
	// total size

	int SIZE = 0;
	for(int I = 0, fI = sizes.size(); I < fI; I++)
		SIZE += sizes[I];

	int HIGH = SIZE-1;
	int LOW  = HIGH;
	for(int J = 0, fJ = sizes.size(); J < fJ; J++)
	{
		int slice_width = sizes[J];
		LOW = (HIGH - slice_width)+1;

		AaExpression* tgt_expr = targets[J];

		AaSimpleObjectReference* root_ref = new AaSimpleObjectReference(scope, src);
		root_ref->Set_Object_Root_Name(src);
		root_ref->Set_Line_Number(line_number);

		AaType* slice_type = AaProgram::Make_Uinteger_Type(slice_width);
		AaExpression* src_expr = new AaSliceExpression(scope, slice_type, LOW, root_ref);

		AaAssignmentStatement* new_stmt = new AaAssignmentStatement(scope, tgt_expr, src_expr, line_number);
		new_stmt->Set_Buffering(buffering);
		slist.push_back(new_stmt);

		HIGH = LOW-1;
	}

	return(false);
}


string AaStatement::Get_C_Macro_Name()
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Root_Scope()->Get_Label() + "_" 
			+ this->Get_VC_Name() + "_c_macro_");
}

string AaStatement::Get_C_Mutex_Name()
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Root_Scope()->Get_Label() + "_" 
			+ this->Get_VC_Name() + "_c_mutex_");
}

string AaStatement::Get_Export_Declare_Macro()
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Root_Scope()->Get_Label() + "_" 
			+ this->Get_VC_Name() + "_c_export_decl_macro_");
}

string AaStatement::Get_Export_Apply_Macro()
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Root_Scope()->Get_Label() + "_" 
			+ this->Get_VC_Name() + "_c_export_apply_macro_");
}

string AaStatement::Get_C_Preamble_Macro_Name() 
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Root_Scope()->Get_Label() + "_" 
			+ this->Get_VC_Name() + "_c_preamble_macro_");
}


string AaStatement::Get_C_Postamble_Macro_Name()
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Root_Scope()->Get_Label() + "_" 
			+ this->Get_VC_Name() + "_c_postamble_macro_");
}



