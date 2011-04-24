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
#include <Aa2VC.h>


// AaObjectReference
bool AaObjectReference::Is_Load()
{
  bool ret_val = false;
  assert(this->_object);
  if(this->_object->Is_Storage_Object())
    {
      if(!this->Get_Is_Target())
	{
	  ret_val = true;
	}
    }
  return(ret_val);
}
bool AaObjectReference::Is_Store()
{
  bool ret_val = false;
  assert(this->_object);
  if(this->_object->Is_Storage_Object())
    {
      if(this->Get_Is_Target())
	{
	  ret_val = true;
	}
    }
  return(ret_val);
}

// AaSimpleObjectReference
void AaSimpleObjectReference::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
  if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
    {
      ofile << "// " << this->To_String() << endl;

      vector<string> reqs;
      vector<string> acks;

      if(this->_object->Is("AaStorageObject"))
	{
	  this->AaObjectReference::Write_VC_Load_Links_Optimized(hier_id,NULL,NULL,ofile);
	}
      else if(this->_object->Is("AaPipeObject"))
	{
	  string inst_name = this->Get_VC_Datapath_Instance_Name();
	  reqs.push_back(hier_id + "/" + this->Get_VC_Complete_Region_Name() + "/req");
	  acks.push_back(hier_id + "/" + this->Get_VC_Complete_Region_Name() + "/ack");
	  Write_VC_Link(inst_name, reqs,acks,ofile);
	}
    }
}
void AaSimpleObjectReference::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{

  if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
    {

      ofile << "// " << this->To_String() << endl;
      vector<string> reqs;
      vector<string> acks;

      if(this->_object->Is("AaStorageObject"))
	{
	  this->AaObjectReference::Write_VC_Store_Links_Optimized(hier_id,NULL,NULL,ofile);
	}
      else if(this->_object->Is("AaPipeObject"))
	{
	  string inst_name = this->Get_VC_Datapath_Instance_Name();
	  reqs.push_back(hier_id + "/" + this->Get_VC_Complete_Region_Name() + "/pipe_wreq");
	  acks.push_back(hier_id + "/" + this->Get_VC_Complete_Region_Name() + "/pipe_wack");
	  Write_VC_Link(inst_name, reqs,acks,ofile);
	}
    }
}

void AaSimpleObjectReference::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							      map<string,vector<AaExpression*> >& ls_map,
							      map<string, vector<AaExpression*> >& pipe_map,
							      ostream& ofile)
{
  if(!this->Is_Constant())
    {
      ofile << "// " << this->To_String() << endl;

      // if this is a statement...
      if(this->Is_Implicit_Variable_Reference())
	{
	  ofile << "// implicit reference" << endl;
	  __T(this->Get_VC_Complete_Region_Name());

	  AaRoot* root = this->Get_Root_Object();
	  if(visited_elements.find(root) != visited_elements.end())
	    {
	      __J(this->Get_VC_Complete_Region_Name(), root->Get_VC_Completed_Transition_Name());
	    }
	}
      else if(this->_object->Is("AaStorageObject"))
	{

	  // complete region name is in Write_VC_Load_Control...
	  __T(this->Get_VC_Start_Transition_Name());
	  __T(this->Get_VC_Active_Transition_Name());
	  this->Write_VC_Load_Control_Path_Optimized(visited_elements,ls_map,pipe_map,NULL,NULL,ofile);
	  ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
	}
      // else if the object being referred to is
      // a pipe, instantiate a series r-a
      // chain for the inport operation
      else if(this->_object->Is("AaPipeObject"))
	{
	  // needed to hook up pipe dependencies.
	  __T(this->Get_VC_Start_Transition_Name());

	  ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // pipe read" << endl;
	  ofile << "$T [req] $T [ack] " << endl;
	  ofile << "}" << endl;

	  // complete the chain.
	  __F(this->Get_VC_Start_Transition_Name(),this->Get_VC_Complete_Region_Name());

	  // record the pipe!
	  pipe_map[this->_object->Get_VC_Name()].push_back(this);
	}

      // at the end!
      visited_elements.insert(this);
    }
}
void AaSimpleObjectReference::Write_VC_Control_Path_As_Target_Optimized(set<AaRoot*>& visited_elements,
									map<string,vector<AaExpression*> >& ls_map,
									map<string, vector<AaExpression*> >& pipe_map,
									ostream& ofile)
{

  if( this->Is_Implicit_Variable_Reference())
    {
      ofile << "// " << this->To_String() << endl << "// implicit reference" << endl;
    }
  else if(this->_object->Is("AaStorageObject"))
    {
      __T(this->Get_VC_Start_Transition_Name());
      __T(this->Get_VC_Active_Transition_Name());  

      // address calculation..
      // several parallel stores will be peformed..
      // must compute all of them..
      
      // followed by several parallel stores..
      // note that you will need a split operation here
      ofile << "// " << this->To_String() << endl;
      this->Write_VC_Store_Control_Path_Optimized(visited_elements,ls_map,pipe_map,NULL,NULL,ofile);
      ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
    }
  // else if the object being referred to is
  // a pipe, instantiate a series r-a
  // chain for the inport operation
  else if(this->_object->Is("AaPipeObject"))
    {
      ofile << "// " << this->To_String() << endl;
      __T(this->Get_VC_Start_Transition_Name());
      ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // pipe write ";
      this->Print(ofile);
      ofile << endl;
      ofile << "$T [pipe_wreq] $T [pipe_wack] " << endl;
      ofile << "}" << endl;
      __F(this->Get_VC_Start_Transition_Name(),this->Get_VC_Complete_Region_Name());
      pipe_map[this->_object->Get_VC_Name()].push_back(this);
    }
}
    


// AaArrayObjectReference
void AaArrayObjectReference::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
  if(this->Is_Constant())
    return;
  
  ofile << "// " << this->To_String() << endl;


  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);

  if(this->Get_Object_Type()->Is_Pointer_Type())
    {


      if(this->_object->Is_Storage_Object())
	{
	  // the object needs to be loaded..  
	  // do the needful..
	  this->_pointer_ref->Write_VC_Links_Optimized(hier_id,ofile);
	}
      
      // the return value is a pointer,
      // calculate the address.
      this->Write_VC_Root_Address_Calculation_Links_Optimized(hier_id,
							      this->Get_Index_Vector(),
							      &scale_factors,
							      ofile);

      hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());
      vector<string> reqs;
      vector<string> acks;
      reqs.push_back(hier_id + "/final_reg_req");
      acks.push_back(hier_id + "/final_reg_ack");
      Write_VC_Link(this->Get_VC_Name() + "_final_reg",
		    reqs,
		    acks,
		    ofile);
    }
  else
    this->AaObjectReference::Write_VC_Load_Links_Optimized(hier_id,
							   this->Get_Index_Vector(),
							   &scale_factors,
							   ofile);
}
 
void AaArrayObjectReference::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
  if(this->Is_Constant())
    return;
    
  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);

  this->AaObjectReference::Write_VC_Store_Links_Optimized(hier_id,
							  &_indices,
							  &scale_factors,
							  ofile);

}

void AaArrayObjectReference::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							     map<string,vector<AaExpression*> >& ls_map,
							     map<string, vector<AaExpression*> >& pipe_map,
							     ostream& ofile)
{
  if(!this->Is_Constant())
    {
      ofile << "// " << this->To_String() << endl;

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      __T(this->Get_VC_Start_Transition_Name());
      __T(this->Get_VC_Active_Transition_Name());

      if(this->Get_Object_Type()->Is_Pointer_Type())
	{

	  // need start, active and complete for each expression.
	  __J(this->Get_VC_Active_Transition_Name(), this->Get_VC_Start_Transition_Name());

	  string base_addr_calc = this->Get_VC_Name() + "_base_address_calculated";
	  __T(base_addr_calc);

	  if(this->_object->Is_Storage_Object())
	    {
	      // please load the object.
	      this->_pointer_ref->Write_VC_Control_Path_Optimized(visited_elements,ls_map,pipe_map,ofile);
	      if(!this->_pointer_ref->Is_Constant())
		__J(base_addr_calc, this->_pointer_ref->Get_VC_Complete_Region_Name());
	      
	    }
	  else if(this->_object->Is_Expression())
	    {
	      AaRoot* root = (((AaExpression*)this->_object)->Get_Root_Object());
	      if(root && root->Is_Statement())
		{
		  if(visited_elements.find(root) != visited_elements.end())
		    {
		      __J(base_addr_calc, ((AaStatement*)root)->Get_VC_Completed_Transition_Name());
		    }
		}
	    }



	  // this will link to complete region.
	  this->Write_VC_Root_Address_Calculation_Control_Path_Optimized(visited_elements,
									 ls_map,
									 pipe_map,
									 &_indices,
									 &scale_factors,
									 ofile);




	  ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
	  ofile << "$T [final_reg_req] $T [final_reg_ack]" << endl;
	  ofile << "}" << endl;

	  __J(this->Get_VC_Active_Transition_Name(),this->Get_VC_Name()+ "_root_address_calculated");
	  __F(this->Get_VC_Active_Transition_Name(),this->Get_VC_Complete_Region_Name());

	}
      else
	{ 
	  // this is just a regular object load
	  // using the indices, which returns the
	  // value stored at the computed address.
	  this->Write_VC_Load_Control_Path_Optimized(visited_elements,
						     ls_map,pipe_map,
						     &(_indices),
						     &scale_factors,
						     ofile);

	  ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
	}
      
      visited_elements.insert(this);
    }

}
void AaArrayObjectReference::Write_VC_Control_Path_As_Target_Optimized(set<AaRoot*>& visited_elements,
								       map<string,vector<AaExpression*> >& ls_map,
								       map<string, vector<AaExpression*> >& pipe_map,
								       ostream& ofile)
{

  if(this->_object->Is("AaStorageObject"))
    {
      ofile << "// " << this->To_String() << endl;
      __T(this->Get_VC_Start_Transition_Name());
      __T(this->Get_VC_Active_Transition_Name());

      int word_size = ((AaStorageObject*)(this->_object))->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      this->Write_VC_Store_Control_Path_Optimized(visited_elements,
						  ls_map,pipe_map,
						  &(_indices),
						  &(scale_factors), 
						  ofile);
      ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
    }
  else
    {
      // a target can only be an indexed storage object.
      assert(0);
    }
}


// AaPointerDereferenceExpression
void AaPointerDereferenceExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }

  this->_reference_to_object->Write_VC_Links_Optimized(hier_id,ofile);
  this->AaObjectReference::Write_VC_Load_Links_Optimized(hier_id,
							 NULL,
							 NULL,
							 ofile);
}

void AaPointerDereferenceExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }


  this->_reference_to_object->Write_VC_Links_Optimized(hier_id,ofile);
  this->AaObjectReference::Write_VC_Store_Links_Optimized(hier_id,
							  NULL,
							  NULL,
							  ofile);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
								     map<string,vector<AaExpression*> >& ls_map,
								     map<string, vector<AaExpression*> >& pipe_map,
								     ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      AaRoot::Error("pointer dereference to foreign object!", this);
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }

  __T(this->Get_VC_Start_Transition_Name());
  __T(this->Get_VC_Active_Transition_Name());
  
  string base_addr_calc = (this->Get_VC_Name() + "_base_address_calculated");
  __T(base_addr_calc);

  this->_reference_to_object->Write_VC_Control_Path_Optimized(visited_elements,
							      ls_map,
							      pipe_map,
							      ofile);
  this->Write_VC_Load_Control_Path_Optimized(visited_elements,
					     ls_map,pipe_map,
					     NULL,NULL,ofile);

  if(!this->_reference_to_object->Is_Constant())
    {
      __J(base_addr_calc,this->_reference_to_object->Get_VC_Complete_Region_Name());
      __J(this->Get_VC_Start_Transition_Name(),base_addr_calc);
    }

  ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_As_Target_Optimized(set<AaRoot*>& visited_elements,
									       map<string,vector<AaExpression*> >& ls_map,
									       map<string, vector<AaExpression*> >& pipe_map,
									       ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      AaRoot::Error("pointer dereference to foreign object!", this);
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }


  __T(this->Get_VC_Start_Transition_Name());
  __T(this->Get_VC_Active_Transition_Name());

  string base_addr_calc = (this->Get_VC_Name() + "_base_address_calculated");
  __T(base_addr_calc);

  this->_reference_to_object->Write_VC_Control_Path_Optimized(visited_elements,
							      ls_map,
							      pipe_map,
							      ofile);
  this->Write_VC_Store_Control_Path_Optimized(visited_elements,
					      ls_map,pipe_map,
					      NULL,NULL,ofile);
  if(!this->_reference_to_object->Is_Constant())
    {
      __J(base_addr_calc,this->_reference_to_object->Get_VC_Complete_Region_Name());
      __J(this->Get_VC_Start_Transition_Name(),base_addr_calc);
    }

  ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
}



// AaAddressOfExpression
void AaAddressOfExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
  if(this->Is_Constant())
    return;
  else
    {
      assert(this->_reference_to_object->Is("AaArrayObjectReference"));
      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);


      obj_ref->Write_VC_Root_Address_Calculation_Links_Optimized(hier_id,
								 obj_ref->Get_Index_Vector(),
								 &scale_factors,
								 ofile);
				
      hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Complete_Region_Name());		       
      vector<string> reqs;
      vector<string> acks;
      reqs.push_back(hier_id + "/final_reg_req");
      acks.push_back(hier_id + "/final_reg_ack");
      Write_VC_Link(this->Get_VC_Name() + "_final_reg",
		    reqs,
		    acks,
		    ofile);
    }
}
void AaAddressOfExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
  assert(0);
}

void AaAddressOfExpression::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							    map<string,vector<AaExpression*> >& ls_map,
							    map<string, vector<AaExpression*> >& pipe_map,
							    ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;

  if(!this->Is_Constant())
    {
      __T(this->Get_VC_Active_Transition_Name());
      __T(this->Get_VC_Start_Transition_Name());

      __J(this->Get_VC_Active_Transition_Name(),this->Get_VC_Start_Transition_Name());

      assert(this->_reference_to_object->Is("AaArrayObjectReference"));

      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);

      obj_ref->Write_VC_Root_Address_Calculation_Control_Path_Optimized(visited_elements,
									ls_map,pipe_map,
									obj_ref->Get_Index_Vector(),
									&scale_factors,
									ofile);

      ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
      ofile << "$T [final_reg_req] $T [final_reg_ack]" << endl;
      ofile << "}" << endl;


      __J(this->Get_VC_Active_Transition_Name(), obj_ref->Get_VC_Name() + "_root_address_calculated");
      __F(this->Get_VC_Active_Transition_Name(),this->Get_VC_Complete_Region_Name());
    }
  else
    {
      __T(this->Get_VC_Complete_Region_Name());
    }
}

void AaAddressOfExpression::Write_VC_Control_Path_As_Target_Optimized(set<AaRoot*>& visited_elements,
								      map<string,vector<AaExpression*> >& ls_map,
								      map<string, vector<AaExpression*> >& pipe_map,
								      ostream& ofile)
{
  assert(0);
}




// AaTypeCastExpression
void AaTypeCastExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
  if(!this->Is_Constant())
    {

      this->_rest->Write_VC_Links_Optimized(hier_id, ofile);

      ofile << "// " << this->To_String() << endl;
      
      hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());

      vector<string> reqs,acks;
      if(_bit_cast || Is_Trivial_VC_Type_Conversion(_rest->Get_Type(), this->Get_Type()))
	{
	  reqs.push_back(hier_id + "/req");
	  acks.push_back(hier_id + "/ack");
	  Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
	}
      else
	{
	  reqs.push_back(hier_id + "/rr");
	  reqs.push_back(hier_id + "/cr");
	  acks.push_back(hier_id + "/ra");
	  acks.push_back(hier_id + "/ca");

	  Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
	}
    }

}

void AaTypeCastExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
  assert(0);
}

void AaTypeCastExpression::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							   map<string,vector<AaExpression*> >& ls_map,
							   map<string, vector<AaExpression*> >& pipe_map,
							   ostream& ofile)
{
  if(!this->Is_Constant())
    {
      
      ofile << "// " << this->To_String() << endl;
      __T(this->Get_VC_Active_Transition_Name());
      __T(this->Get_VC_Start_Transition_Name());
      __J(this->Get_VC_Active_Transition_Name(),this->Get_VC_Start_Transition_Name());      

      this->_rest->Write_VC_Control_Path_Optimized(visited_elements,
						   ls_map,pipe_map,
						   ofile);


      __J(this->Get_VC_Active_Transition_Name(),this->_rest->Get_VC_Complete_Region_Name());

      // either it will be a register or a split conversion
      // operator..
      ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "]{ " << endl;
      if(_bit_cast || Is_Trivial_VC_Type_Conversion(_rest->Get_Type(), this->Get_Type()))
	ofile << "$T [req] $T [ack] //  type-conversion (bit-cast) " << endl;
      else
	ofile << "$T [rr] $T [ra] $T [cr] $T [ca] //  type-conversion.. " << endl;
      ofile << "}" << endl;

      __F(this->Get_VC_Active_Transition_Name(),this->Get_VC_Complete_Region_Name());
    }

}
void AaTypeCastExpression::Write_VC_Control_Path_As_Target_Optimized(set<AaRoot*>& visited_elements,
								     map<string,vector<AaExpression*> >& ls_map,
								     map<string, vector<AaExpression*> >& pipe_map,
								     ostream& ofile)
{
  assert(0);
}



// AaUnaryExpression
void AaUnaryExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
  if(!this->Is_Constant())
    {

      this->_rest->Write_VC_Links_Optimized(hier_id, ofile);

      ofile << "// " << this->To_String() << endl;

      hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Complete_Region_Name());
      vector<string> reqs,acks;
      reqs.push_back(hier_id + "/rr");
      reqs.push_back(hier_id + "/cr");
      acks.push_back(hier_id + "/ra");
      acks.push_back(hier_id + "/ca");

      Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
    }
}
void AaUnaryExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
  assert(0);
}

void AaUnaryExpression::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							map<string,vector<AaExpression*> >& ls_map,
							map<string, vector<AaExpression*> >& pipe_map,
							ostream& ofile)
{
  

  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;
      __T(this->Get_VC_Active_Transition_Name());
      __T(this->Get_VC_Start_Transition_Name());
      __J(this->Get_VC_Active_Transition_Name(),this->Get_VC_Start_Transition_Name());      

      this->_rest->Write_VC_Control_Path_Optimized(visited_elements,
						   ls_map,pipe_map,
						   ofile);


      if(!this->_rest->Is_Constant())
	__J(this->Get_VC_Active_Transition_Name(),this->_rest->Get_VC_Complete_Region_Name());

      ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // unary expression " << endl;      
      ofile << "$T [rr] $T [ra] $T [cr] $T [ca] //(split) unary operation" << endl;
      ofile << "}" << endl;
      __F(this->Get_VC_Active_Transition_Name(), this->Get_VC_Complete_Region_Name());
    }
}
void AaUnaryExpression::Write_VC_Control_Path_As_Target_Optimized(set<AaRoot*>& visited_elements,
								  map<string,vector<AaExpression*> >& ls_map,
								  map<string, vector<AaExpression*> >& pipe_map,
								  ostream& ofile)
{
  assert(0);
}




// AaBinaryExpression
void AaBinaryExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
  if(!this->Is_Constant())
    {

      this->_first->Write_VC_Links_Optimized(hier_id, ofile);
      this->_second->Write_VC_Links_Optimized(hier_id, ofile);

      ofile << "// " << this->To_String() << endl;

      hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Complete_Region_Name());
      vector<string> reqs,acks;
      reqs.push_back(hier_id + "/rr");
      reqs.push_back(hier_id + "/cr");
      acks.push_back(hier_id + "/ra");
      acks.push_back(hier_id + "/ca");
      Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
    }
}
void AaBinaryExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
  assert(0);
}

void AaBinaryExpression::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							 map<string,vector<AaExpression*> >& ls_map,
							 map<string, vector<AaExpression*> >& pipe_map,
							 ostream& ofile)
{
  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;
      __T(this->Get_VC_Active_Transition_Name());
      __T(this->Get_VC_Start_Transition_Name());
      __J(this->Get_VC_Active_Transition_Name(),this->Get_VC_Start_Transition_Name());      


      this->_first->Write_VC_Control_Path_Optimized(visited_elements,ls_map,pipe_map, ofile);
      this->_second->Write_VC_Control_Path_Optimized(visited_elements,ls_map,pipe_map,ofile);


      if(!this->_first->Is_Constant())
	__J(this->Get_VC_Active_Transition_Name(),this->_first->Get_VC_Complete_Region_Name());

      if(!this->_second->Is_Constant())
	__J(this->Get_VC_Active_Transition_Name(),this->_second->Get_VC_Complete_Region_Name());

      ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // binary expression " << endl;
      ofile << "$T [rr] $T [ra] $T [cr] $T [ca] // (split) binary operation " << endl;
      ofile << "}" << endl;
      __F(this->Get_VC_Active_Transition_Name(),this->Get_VC_Complete_Region_Name());
    }
}
void AaBinaryExpression::Write_VC_Control_Path_As_Target_Optimized(set<AaRoot*>& visited_elements,
								   map<string,vector<AaExpression*> >& ls_map,
								   map<string, vector<AaExpression*> >& pipe_map,
								   ostream& ofile)
{
  assert(0);
}


// AaTernaryExpression
void AaTernaryExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
  if(!this->Is_Constant())
    {

      this->_test->Write_VC_Links_Optimized(hier_id,ofile);
      this->_if_true->Write_VC_Links_Optimized(hier_id,ofile);
      this->_if_false->Write_VC_Links_Optimized(hier_id,ofile);

      ofile << "// " << this->To_String() << endl;

      hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Complete_Region_Name());
      vector<string> reqs,acks;
      reqs.push_back(hier_id + "/req");
      acks.push_back(hier_id + "/ack");

      Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),
		    reqs,
		    acks,
		    ofile);
    }

}

void AaTernaryExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
  assert(0);
}

void AaTernaryExpression::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							  map<string,vector<AaExpression*> >& ls_map,
							  map<string, vector<AaExpression*> >& pipe_map,
							  ostream& ofile)
{
  if(this->Is_Constant())
    return;

  ofile << "// " << this->To_String() << endl;
  __T(this->Get_VC_Start_Transition_Name());
  __T(this->Get_VC_Active_Transition_Name());
  __J(this->Get_VC_Active_Transition_Name(),this->Get_VC_Start_Transition_Name());      


  this->_test->Write_VC_Control_Path_Optimized(visited_elements,ls_map,pipe_map,ofile);
  if(this->_if_true)
    this->_if_true->Write_VC_Control_Path_Optimized(visited_elements,ls_map,pipe_map,ofile);
  if(this->_if_false)
    this->_if_false->Write_VC_Control_Path_Optimized(visited_elements,ls_map,pipe_map,ofile);


  if(!this->_test->Is_Constant())
    __J(this->Get_VC_Active_Transition_Name(),this->_test->Get_VC_Complete_Region_Name());
  if(this->_if_true && !this->_if_true->Is_Constant())
    __J(this->Get_VC_Active_Transition_Name(),this->_if_true->Get_VC_Complete_Region_Name());
  if(this->_if_false && !this->_if_false->Is_Constant())
    __J(this->Get_VC_Active_Transition_Name(),this->_if_false->Get_VC_Complete_Region_Name());
  
  ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // ternary expression: " << endl;
  ofile << "$T [req] $T [ack] // select req/ack" << endl;
  ofile << "}" << endl;
  __F(this->Get_VC_Active_Transition_Name(),this->Get_VC_Complete_Region_Name());
}

void AaTernaryExpression::Write_VC_Control_Path_As_Target_Optimized(set<AaRoot*>& visited_elements,
								    map<string,vector<AaExpression*> >& ls_map,
								    map<string, vector<AaExpression*> >& pipe_map,
								    ostream& ofile)
{
  assert(0);
}




/// load-store related stuff.
void AaObjectReference::Write_VC_Load_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							     map<string, vector<AaExpression*> >& ls_map,
							     map<string, vector<AaExpression*> >& pipe_map,
							     vector<AaExpression*>* address_expressions,
							     vector<int>* scale_factors,
							     ostream& ofile)
{
  // address calculation
  // 1. compute agross = base + (offset*scale-factor)
  // 2. in parallel, compute aI = agross + I
  //       optimization: if number is 2**N then append.
  this->Write_VC_Address_Calculation_Control_Path_Optimized(visited_elements,ls_map,pipe_map,
							    address_expressions,scale_factors, ofile);

  // load operations
  //    in parallel, load..
  this->Write_VC_Load_Store_Control_Path_Optimized(visited_elements,
						   ls_map,pipe_map,
						   address_expressions, scale_factors, "read", ofile);

  __J(this->Get_VC_Start_Transition_Name(),this->Get_VC_Name() + "_word_address_calculated");

}
void AaObjectReference::Write_VC_Store_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							      map<string, vector<AaExpression*> >& ls_map, 
							      map<string, vector<AaExpression*> >& pipe_map,
							      vector<AaExpression*>* address_expressions,
							      vector<int>* scale_factors,
							      ostream& ofile)
{
  // address calculation
  // 1. compute agross = base + (offset*scale-factor)
  // 2. in parallel, compute aI = agross + I
  //       optimization: if number is 2**N then append.
  this->Write_VC_Address_Calculation_Control_Path_Optimized(visited_elements,
							    ls_map,pipe_map,
							    address_expressions, 
							    scale_factors, ofile);

  //    in parallel, store
  this->Write_VC_Load_Store_Control_Path_Optimized(visited_elements,
						   ls_map,pipe_map,
						   address_expressions, 
						   scale_factors, 
						   "write", 
						   ofile);

  __J(this->Get_VC_Start_Transition_Name(),this->Get_VC_Name() + "_word_address_calculated");
}

void AaObjectReference::Write_VC_Load_Store_Control_Path_Optimized(set<AaRoot*>& visited_elements,
								   map<string, vector<AaExpression*> >& ls_map, 
								   map<string, vector<AaExpression*> >& pipe_map,
								   vector<AaExpression*>* address_expressions,
								   vector<int>* scale_factors,
								   string read_or_write,
								   ostream& ofile)
{

  string start_trans = this->Get_VC_Start_Transition_Name();
  string active_trans = this->Get_VC_Active_Transition_Name();

  ofile << ";;[" << this->Get_VC_Request_Region_Name() << "] {" << endl;
  if(read_or_write == "write")
    {
      // split the data into words..
      ofile << "$T [split_req] $T [split_ack]" << endl;
    }

  // in parallel access the words.
  // how many words?
  int nwords = (address_expressions ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));

  ofile << "||[word_access] {" << endl;
  for(int idx = 0; idx < nwords; idx++)
    {
      // each word access.
      ofile << ";;[word_access_" << idx << "] {" << endl
	    << "$T [rr] $T [ra] " << endl
	    << "}" << endl;
    }
  ofile << "}" << endl;
  ofile << "}" << endl;

  ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
  ofile << "||[word_access] {" << endl;
  for(int idx = 0; idx < nwords; idx++)
    {
      // each word access.
      ofile << ";;[word_access_" << idx << "] {" << endl
	    << "$T [cr] $T [ca] " << endl
	    << "}" << endl;
    }
  ofile << "}" << endl;
  if(read_or_write == "read")
    {
      // merge the words into the data..
      ofile << "$T [merge_req] $T [merge_ack]" << endl;
    }
  ofile << "}" << endl;

  __F(start_trans,this->Get_VC_Request_Region_Name());
  __J(active_trans,this->Get_VC_Request_Region_Name());
  __F(active_trans,this->Get_VC_Complete_Region_Name());
}

  

void AaObjectReference::Write_VC_Load_Links_Optimized(string hier_id,
						      vector<AaExpression*>* address_expressions,
						      vector<int>* scale_factors,
						      ostream& ofile)
{
  this->Write_VC_Address_Calculation_Links_Optimized(hier_id, address_expressions, scale_factors, ofile);
  string rd_id = "read";
  this->Write_VC_Load_Store_Links_Optimized(hier_id, rd_id, address_expressions, scale_factors, ofile);
}
  
void AaObjectReference::Write_VC_Store_Links_Optimized(string hier_id,
						       vector<AaExpression*>* address_expressions,
						       vector<int>* scale_factors,
						       ostream& ofile)
{
  this->Write_VC_Address_Calculation_Links_Optimized(hier_id, address_expressions, scale_factors, ofile);
  string rd_id = "write";
  this->Write_VC_Load_Store_Links_Optimized(hier_id, rd_id, address_expressions, scale_factors, ofile);
}


void AaObjectReference::Write_VC_Load_Store_Links_Optimized( string hier_id,
							     string read_or_write,
							     vector<AaExpression*>* address_expressions,
							     vector<int>* scale_factors,
							     ostream& ofile)
{
  vector<string> reqs;
  vector<string> acks;

  string start_hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Request_Region_Name());
  string complete_hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());

  // if read, then merge
  string ms_instance = this->Get_VC_Name() + "_gather_scatter";
  if(read_or_write == "read")
    {
      reqs.push_back(complete_hier_id + "/merge_req");
      acks.push_back(complete_hier_id + "/merge_ack");

    }
  else
    {
      reqs.push_back(start_hier_id + "/split_req");
      acks.push_back(start_hier_id + "/split_ack");
    }
  Write_VC_Link(ms_instance,reqs,acks, ofile);
  reqs.clear();
  acks.clear();

  // in parallel access the words.
  string start_word_access_hier_id = Augment_Hier_Id(start_hier_id, "word_access");
  string complete_word_access_hier_id = Augment_Hier_Id(complete_hier_id, "word_access");

  for(int idx = 0; idx < (this->Get_Type()->Size() / this->Get_Word_Size()); idx++)
    {
      // each word access.
      string start_id = Augment_Hier_Id(start_word_access_hier_id , "word_access_" + IntToStr(idx));
      reqs.push_back(start_id + "/rr");
      acks.push_back(start_id + "/ra");

      string complete_id = Augment_Hier_Id(complete_word_access_hier_id , "word_access_" + IntToStr(idx));
      reqs.push_back(complete_id + "/cr");
      acks.push_back(complete_id + "/ca");

      string inst_name = this->Get_VC_Name() 
	+ ((read_or_write == "read") ? "_load_" : "_store_") 
	+ IntToStr(idx);

      Write_VC_Link(inst_name,
		    reqs,
		    acks,
		    ofile);
      reqs.clear();
      acks.clear();
    }
}




void AaObjectReference::
Write_VC_Address_Calculation_Control_Path_Optimized(set<AaRoot*>& visited_elements,
						    map<string,vector<AaExpression*> >& ls_map,
						    map<string, vector<AaExpression*> >& pipe_map,
						    vector<AaExpression*>* indices,
						    vector<int>* scale_factors,
						    ostream& ofile)
{
  int offset_val = 0;
  if(indices)
    offset_val = this->Evaluate(indices,scale_factors);
  int base_addr = this->Get_Base_Address();

  string root_addr_calculated = this->Get_VC_Name() + "_root_address_calculated"; 
  __T(root_addr_calculated);
  string word_addr_calculated = this->Get_VC_Name() + "_word_address_calculated"; 
  __T(word_addr_calculated);

  if(offset_val < 0 || base_addr < 0)
    {



      string word_region = this->Get_VC_Name() + "_word_addrgen"; 

      // calculates root address.. triggers a root-address-calculated transition
      // when it is done..
      this->Write_VC_Root_Address_Calculation_Control_Path_Optimized(visited_elements,
								     ls_map,pipe_map,
								     indices,
								     scale_factors,
								     ofile);
      
      
      // individual word addresses (in parallel)
      int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
      if(nwords > 1)
	{

	  ofile << "||[" << word_region << "] {" << endl;
	
	  for(int idx = 0; idx < nwords; idx++)
	    {
	      // each word address is a sum
	      ofile << ";;[word_" << idx << "] {" << endl
		    << "$T [rr] $T [ra] $T [cr] $T [ca]" << endl
		    << "}" << endl;
	    }
	  ofile << "}" << endl;
	}
      else
	{
	  // single word, no operation.. but rename it.
	  ofile << ";;[" << word_region << "] {" << endl;
	  ofile << "$T [root_rename_req] $T [root_rename_ack]" << endl;
	  ofile << "}" << endl;
	}


      __F(root_addr_calculated, word_region);
      __J(word_addr_calculated, word_region);
    }
  else
    {
      __J(word_addr_calculated, root_addr_calculated);
    }
}

void AaObjectReference::Write_VC_Address_Calculation_Links_Optimized(string hier_id,
								     vector<AaExpression*>* indices,
								     vector<int>* scale_factors,
								     ostream& ofile)
{
 
  int offset_val = 0;
  if(indices)
    offset_val = this->Evaluate(indices,scale_factors);
  int base_addr = this->Get_Base_Address();
 
  vector<string> reqs;
  vector<string> acks;

  if(offset_val < 0 || base_addr < 0)
    {
      this->Write_VC_Root_Address_Calculation_Links_Optimized(hier_id,indices,scale_factors,ofile);

      string word_region = this->Get_VC_Name() + "_word_addrgen"; 
      hier_id = Augment_Hier_Id(hier_id,word_region);

      // individual word addresses (in parallel)
      int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
      if(nwords > 1)
	{
	  for(int idx = 0; idx < nwords; idx++)
	    {
	      string word_hier_id = hier_id + "/word_" + IntToStr(idx); 
	      reqs.push_back(word_hier_id + "/rr");
	      reqs.push_back(word_hier_id + "/cr");
	      acks.push_back(word_hier_id + "/ra");
	      acks.push_back(word_hier_id + "/ca");
	      Write_VC_Link(this->Get_VC_Name() + "_addr_" + IntToStr(idx),
			    reqs,
			    acks,
			    ofile);
	      reqs.clear();
	      acks.clear();
	    }
	}
      else
	{
	  // single word, no operation.. but rename it.
	  // ofile << "$T [rename_req] $T [rename_ack]" << endl;
	  reqs.push_back(hier_id + "/root_rename_req");
	  acks.push_back(hier_id + "/root_rename_ack");
	  Write_VC_Link(this->Get_VC_Name() + "_addr_0",
			reqs,
			acks,
			ofile);
	  reqs.clear();
	  acks.clear();
	}
    }
 
}


// all operations are triggered immediately when the containing
// fork-block is entered.  dependencies as indicated..
// always produces a transition root_address_calculated.
void AaObjectReference::
Write_VC_Root_Address_Calculation_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							 map<string,vector<AaExpression*> >& ls_map,
							 map<string, vector<AaExpression*> >& pipe_map,
							 vector<AaExpression*>* index_vector,
							 vector<int>* scale_factors,
							 ostream& ofile)
{

  string root_address_calculated = this->Get_VC_Name() + "_root_address_calculated";
  __T(root_address_calculated);
  
  int offset_val = 0;
  if(index_vector)
    offset_val = this->Evaluate(index_vector,scale_factors);
  int base_addr = this->Get_Base_Address();

  // if both are constants.. give up.
  if(offset_val >= 0 && base_addr >= 0)
    return;
  
  bool all_indices_zero = (offset_val == 0);
  int num_non_constant = 0;
  bool const_index_flag = false;


  string indices_scaled = this->Get_VC_Name() + "_indices_scaled";
  string offset_calculated = this->Get_VC_Name() + "_offset_calculated";
  string base_address_resized = this->Get_VC_Name() + "_base_address_resized";

  string base_address_calculated = this->Get_VC_Name() + "_base_address_calculated";

  // if offset value is < 0, then it is not known at compile time.
  // calculate it at run time.
  if(offset_val < 0)
    {
      __T(indices_scaled);
      __T(offset_calculated);

      for(int idx = 0; idx < index_vector->size(); idx++)
	{
	  // if the index is a constant dont bother to compute it..
	  if(!(*index_vector)[idx]->Is_Constant())
	    {
	      string index_computed = this->Get_VC_Name() + "_index_computed_" + IntToStr(idx);
	      string index_resized = this->Get_VC_Name() + "_index_resized_" + IntToStr(idx);
	      __T(index_computed);
	      __T(index_resized);

	      num_non_constant++;
	      (*index_vector)[idx]->Write_VC_Control_Path_Optimized(visited_elements,
								    ls_map,pipe_map,
								    ofile);

	      __J(index_computed,(*index_vector)[idx]->Get_VC_Complete_Region_Name());

	      ofile << ";;[" << this->Get_VC_Name() << "_index_resize_" << idx << "] {" << endl;
	      if((*index_vector)[idx]->Get_Type()->Is_Uinteger_Type())
		ofile << "$T [index_resize_req] $T [index_resize_ack] // resize index to address-width" << endl;
	      else
		ofile << "$T [index_resize_rr] $T [index_resize_ra] $T [index_resize_cr] $T [index_resize_ca]  // resize index to address-width" << endl;

	      ofile << "}" << endl;
	      
	      __F(index_computed,(this->Get_VC_Name() + "_index_resize_" + IntToStr(idx)));
	      __J(index_resized,(this->Get_VC_Name() + "_index_resize_" + IntToStr(idx)));

	      ofile << ";;[" << this->Get_VC_Name() << "_index_scale_" << idx << "] {" << endl;
	      if((*scale_factors)[idx] > 1)
		{
		  ofile << "$T [scale_rr] $T [scale_ra] $T [scale_cr] $T [scale_ca] // scale index." << endl;
		}
	      else
		ofile << "$T [scale_rename_req] $T [scale_rename_ack] // rename " << endl;
	      
	      ofile << "}" << endl;

	      __F(index_resized,(this->Get_VC_Name() + "_index_scale_" + IntToStr(idx)));
	      __J(indices_scaled,(this->Get_VC_Name() + "_index_scale_" + IntToStr(idx)));

	    }
	  else
	    {
	      const_index_flag = true;
	    }
	}
      
      // then add them up.
      ofile << ";;[" << this->Get_VC_Name() << "_add_indices] {" << endl;
      int num_index_adds = (num_non_constant + (const_index_flag ? 1 : 0)) - 1;
      if(index_vector->size() > 1)
	{
	  for(int idx = 1; idx <= num_index_adds; idx++)
	    {
	      string prefix = "partial_sum_" + IntToStr(idx);
	      ofile << "$T [" << prefix << "_rr] $T [" << prefix << "_ra] $T [" 
		    << prefix << "_cr] $T [" << prefix << "_ca] // add index." << endl;
	    }
	}
      
      
      // the final index..
      ofile << "$T [final_index_req] $T [final_index_ack] // rename" << endl;
      ofile << "}" << endl;

      __F(indices_scaled,(this->Get_VC_Name() + "_add_indices"));
      __J(offset_calculated,(this->Get_VC_Name() + "_add_indices"));
    }
  
  // at this point you have a final-offset-index.
  // this needs to be added to a base address, which 
  // is either a constant (if _object is a declared storage object)
  if(base_addr < 0)
    {

      __T(base_address_resized);

      // base is not constant, resize it to the required address width..
      // otherwise, we will just declare the base as a constant
      // with the required width
      ofile << ";;[" << this->Get_VC_Name() << "_base_addr_resize] {" << endl;
      ofile << "$T [base_resize_req] $T [base_resize_ack]" << endl;
      ofile << "}" << endl;

      __F(base_address_calculated,(this->Get_VC_Name() + "_base_addr_resize"));  
      __J(base_address_resized,(this->Get_VC_Name() + "_base_addr_resize")); 
    }

  if(!all_indices_zero && (base_addr != 0))
    {
      // index was not zero and base was not zero..
      // we need to add two numbers, at most one of which
      // can be a constant..
      ofile << ";;[" << this->Get_VC_Name() << "_base_plus_offset] {" << endl;
      ofile << "$T [plus_base_rr] $T [plus_base_ra] $T [plus_base_cr] $T [plus_base_ca] // offset+base" 
	    << endl;
      ofile << "}" << endl;

      if(base_addr < 0)
	{
	  __F(base_address_resized,(this->Get_VC_Name() + "_base_plus_offset"));
	}
      if(offset_val < 0)
	{
	  __F(offset_calculated,(this->Get_VC_Name() + "_base_plus_offset"));
	}
    }
  else 
    {
      // at least one is zero.
      // just rename, no addition is needed.
      // the input operand is offset if it is non-zero, base if it is non-zero.
      ofile << ";;[" << this->Get_VC_Name() << "_base_plus_offset] {" << endl;
      ofile << "$T [sum_rename_req] $T [sum_rename_ack] // one gets through " << endl;
      ofile << "}" << endl;
      
      if(base_addr != 0)
	{
	  __F(base_address_resized,(this->Get_VC_Name() + "_base_plus_offset"));
	}
      else
	{
	  __F(offset_calculated,(this->Get_VC_Name() + "_base_plus_offset"));
	}
    }


  __J(root_address_calculated,(this->Get_VC_Name() + "_base_plus_offset"));
}



void AaObjectReference::
Write_VC_Root_Address_Calculation_Links_Optimized(string hier_id,
						  vector<AaExpression*>* indices,
						  vector<int>* scale_factors,
						  ostream& ofile)
{
  int offset_val = 0;
  if(indices)
    offset_val = this->Evaluate(indices,scale_factors);
  int base_addr = this->Get_Base_Address();

  
  bool all_indices_zero = (offset_val == 0);
  int num_non_constant = 0;
  bool const_index_flag = false;

  vector<string> reqs;
  vector<string> acks;
  string inst_name;

  
  if(offset_val < 0)
    {
      for(int idx = 0; idx < indices->size(); idx++)
	{
	  // if the index is a constant dont bother to compute it..
	  if(!(*indices)[idx]->Is_Constant())
	    {
	      num_non_constant++;
	      (*indices)[idx]->Write_VC_Links_Optimized(hier_id,ofile);

	      string index_resize =  this->Get_VC_Name() + "_index_resize_" + IntToStr(idx);
	      string hid = Augment_Hier_Id(hier_id,index_resize);

	      if((*indices)[idx]->Get_Type()->Is_Uinteger_Type())	      
		{
		  reqs.push_back(hid + "/index_resize_req");
		  acks.push_back(hid + "/index_resize_ack");
		}
	      else
		{
		  reqs.push_back(hid + "/index_resize_rr");
		  acks.push_back(hid + "/index_resize_ra");
		  reqs.push_back(hid + "/index_resize_cr");
		  acks.push_back(hid + "/index_resize_ca");
		}
	      inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_resize";
	      Write_VC_Link(inst_name,reqs,acks,ofile);
	      reqs.clear();
	      acks.clear();

	      string index_scale =   this->Get_VC_Name() + "_index_scale_" + IntToStr(idx);
	      hid = Augment_Hier_Id(hier_id,index_scale);
	      if((*scale_factors)[idx] > 1)
		{
		  reqs.push_back(hid + "/scale_rr");
		  reqs.push_back(hid + "/scale_cr");
		  acks.push_back(hid + "/scale_ra");
		  acks.push_back(hid + "/scale_ca");
		  inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_scale";
		  Write_VC_Link(inst_name,reqs,acks,ofile);
		  reqs.clear();
		  acks.clear();
		}
	      else
		{
		  reqs.push_back(hid + "/scale_rename_req");
		  acks.push_back(hid + "/scale_rename_ack");
		  inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_rename";
		  Write_VC_Link(inst_name,reqs,acks,ofile);
		  reqs.clear();
		  acks.clear();
		}
	    }
	  else
	    const_index_flag = true;
	}
	  

      // then add them up.
      string nhid = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_add_indices");
      if(indices->size() > 1)
	{
	  int num_index_adds = (num_non_constant + (const_index_flag ? 1 : 0)) - 1;
	  for(int idx = 1; idx <= num_index_adds; idx++)
	    {
	      string prefix = "partial_sum_" + IntToStr(idx);
	      reqs.push_back(nhid + "/" + prefix + "_rr");
	      reqs.push_back(nhid + "/" + prefix + "_cr");
	      acks.push_back(nhid + "/" + prefix + "_ra");
	      acks.push_back(nhid + "/" + prefix + "_ca");
	      inst_name= this->Get_VC_Name() + "_index_sum_" + IntToStr(idx);
	      Write_VC_Link(inst_name,reqs,acks,ofile);
	      reqs.clear();
	      acks.clear();
	    }
	}
      
      
      // the final index..
      reqs.push_back(nhid + "/final_index_req");
      acks.push_back(nhid + "/final_index_ack");
      inst_name = this->Get_VC_Name() + "_offset_inst";
      Write_VC_Link(inst_name,reqs,acks,ofile);
      reqs.clear();
      acks.clear();
    }

  // back to hier_id.

  // at this point you have a final-offset-index.
  // this needs to be added to a base address, which 
  // is either a constant (if _object is a declared storage object)
  if(base_addr < 0)
    {
      string hid = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_base_addr_resize");
      // base is not constant, resize it to the required address width..
      // otherwise, we will just declare the base as a constant
      // with the required width
      reqs.push_back(hid + "/base_resize_req");
      acks.push_back(hid + "/base_resize_ack");
      inst_name = this->Get_VC_Name() + "_base_resize";
      Write_VC_Link(inst_name,reqs,acks,ofile);
      reqs.clear();
      acks.clear();
    }


  if(!all_indices_zero && (base_addr != 0))
    {
      string hid = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_base_plus_offset");
      // index was not zero and base was not zero..
      // we need to add two numbers, at most one of which
      // can be a constant..
      reqs.push_back(hid + "/plus_base_rr");
      reqs.push_back(hid + "/plus_base_cr");
      acks.push_back(hid + "/plus_base_ra");
      acks.push_back(hid + "/plus_base_ca");
      inst_name =  this->Get_VC_Name() + "_root_address_inst",
	Write_VC_Link(inst_name,reqs,acks,ofile);
      reqs.clear();
      acks.clear();
    }
  else 
    {
      string hid = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_base_plus_offset");
      // at least one is zero.
      // just rename, no addition is needed.
      // the input operand is offset if it is non-zero, base if it is non-zero.
      reqs.push_back(hid + "/sum_rename_req");
      acks.push_back(hid + "/sum_rename_ack");
      inst_name = this->Get_VC_Name() + "_root_address_inst";
      Write_VC_Link(inst_name,reqs,acks,ofile);
      reqs.clear();
      acks.clear();
    }
}








