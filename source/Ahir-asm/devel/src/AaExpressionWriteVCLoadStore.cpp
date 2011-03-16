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


// common operations across loads/stores.
void AaObjectReference::Write_VC_Load_Control_Path(AaExpression* address_expression,
						   ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);


  ofile << "// CP for expression: ";
  ofile << ps;
  ofile << endl;

  ofile << ";;[" << this->Get_VC_Name() << "] { // load: " << ps  << endl;

  // address calculation
  // 1. compute agross = base + (offset*scale-factor)
  // 2. in parallel, compute aI = agross + I
  //       optimization: if number is 2**N then append.
  this->Write_VC_Address_Calculation_Control_Path(address_expression, ofile);

  // load operations
  //    in parallel, load..
  this->Write_VC_Load_Store_Control_Path(address_expression, "read", ofile);

  ofile << "}" << endl;

}

void AaObjectReference::Write_VC_Store_Control_Path(AaExpression* address_expression,
						    ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);

  ofile << "// CP for expression: ";
  ofile << ps;
  ofile << endl;

  ofile << ";;[" << this->Get_VC_Name() << "] { // store: " << ps  << endl;
  // address calculation
  // 1. compute agross = base + (offset*scale-factor)
  // 2. in parallel, compute aI = agross + I
  //       optimization: if number is 2**N then append.
  this->Write_VC_Address_Calculation_Control_Path(address_expression, ofile);

  //    in parallel, store
  this->Write_VC_Load_Store_Control_Path(address_expression,"write", ofile);

  ofile << "}" << endl;
}

void AaObjectReference::Write_VC_Load_Store_Constants(AaExpression* address_expression,
						      ostream& ofile)
{

  // the constant base address and index-multiplier
  // of the object are assumed to have been
  // declared earlier..

  // constant wires for each individual word operation are
  // also assumed to have been declared "earlier".
  // these will figure in the address calculation and will appear as
  // operands to  compute final word addresses.

  // if this is a constant.. no need to proceed..
  if(this->Is_Constant())
    return;

  // the address width is determined by the object.
  AaUintType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());

  if(address_expression != NULL)
    address_expression->Write_VC_Constant_Wire_Declarations(ofile);

  if((address_expression == NULL) || (address_expression->Is_Constant()))
    {
      // calculate the address = base_address + (addr_expr * size/wordsize)
      // and declare the constant read/write pointer.
      // todo..
      int base_addr = this->Get_Base_Address();
      int offset = 
	(address_expression == NULL ? 0 : 
	 address_expression->Get_Expression_Value()->To_Integer());
      
      int address = base_addr + 
	(offset * ((this->Get_Type()->Size())/this->Get_Word_Size()));

      for(int idx = 0; idx < (this->Get_Type()->Size()/this->Get_Word_Size()); idx++)
	{
	  string val_string = To_VC_String(address+idx,this->Get_Address_Width());
	  
	  // final address.., one for each word.
	  Write_VC_Constant_Pointer_Declaration(this->Get_VC_Memory_Space_Name(),
						this->Get_VC_Driver_Name() 
						+ "_address_" 
						+ IntToStr(idx),
						addr_type,
						val_string,
						ofile);
	}
    }
}


void AaObjectReference::Write_VC_Load_Store_Wires(AaExpression* address_expression,
						  ostream& ofile)
{

  // if address expression is not null, declare the
  // wires necessary for the address calculation.
  if(address_expression != NULL && !address_expression->Is_Constant())
    {
      address_expression->Write_VC_Wire_Declarations(false, ofile);
      
      ofile << "// wire-declarations for expression: ";
      this->Print(ofile);
      ofile << endl;
      
      // a wire which resizes the address expression to 
      // the required width.
      AaUintType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());
      Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name() + "_resized_address",
					     addr_type,
					     ofile);
      
      
      // for the product of multiplier*addresswire.
      Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name() + "_scaled_offset_address",
					     addr_type,
					     ofile);
      
      // for the sum base + offset
      Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name() + "_address",
					     addr_type,
					     ofile);
      

      
      
      for(int idx = 0; idx < (this->Get_Type()->Size()/this->Get_Word_Size()); idx++)
	{
	  // the address for each of the individual words being accessed.
	  Write_VC_Pointer_Declaration(this->Get_VC_Memory_Space_Name(),
				       this->Get_VC_Driver_Name() + "_address_" + IntToStr(idx),
				       addr_type,
				       ofile);
	}
    }

  // data..
  AaUintType* data_type = AaProgram::Make_Uinteger_Type(this->Get_Word_Size());
  for(int idx = 0; idx < (this->Get_Type()->Size()/this->Get_Word_Size()); idx++)
    {
      // the data for each of the individual words being accessed.
      Write_VC_Wire_Declaration(this->Get_VC_Driver_Name() + "_" 
				+ IntToStr(idx),
				data_type,
				ofile);
    }
}

void AaObjectReference::Write_VC_Load_Data_Path(AaExpression* address_expression,
						AaExpression* load_target_expression,
						ostream& ofile)
{
  this->Write_VC_Address_Calculation_Data_Path(address_expression,ofile);
  this->Write_VC_Load_Store_Data_Path(address_expression, 
				      load_target_expression, 
				      "read", 
				      ofile);
}

void AaObjectReference::Write_VC_Store_Data_Path(AaExpression* address_expression,
						 AaExpression* store_source_expression,
						 ostream& ofile)
{
  this->Write_VC_Address_Calculation_Data_Path(address_expression, ofile);
  this->Write_VC_Load_Store_Data_Path(address_expression,
				      store_source_expression,
				      "write", ofile);
}


void AaObjectReference::Write_VC_Load_Links(string hier_id,
					    AaExpression* address_expression,
					    ostream& ofile)
{
  hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());

  this->Write_VC_Address_Calculation_Links(hier_id, address_expression, ofile);
  this->Write_VC_Load_Store_Links(hier_id, "read", address_expression,ofile);
}

void AaObjectReference::Write_VC_Store_Links(string hier_id,
					     AaExpression* address_expression,
					     ostream& ofile)
{
  hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());

  this->Write_VC_Address_Calculation_Links(hier_id, address_expression, ofile);
  this->Write_VC_Load_Store_Links(hier_id, "write", address_expression,ofile);
}
			       

void AaObjectReference::Write_VC_Address_Calculation_Control_Path(AaExpression* address_expression, 
								  ostream& ofile)
{


  // address expression needs to be computed.
  // let this calculated expression be A
  if(address_expression != NULL && !address_expression->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "_address_calculate] {" << endl;
      address_expression->Write_VC_Control_Path(ofile);
      
      // next A is resized, to produce A_resized
      ofile << "$T [resize_req] $T [resize_ack]" << endl;
      
      bool scale_flag = (this->Get_Type()->Size() > this->Get_Word_Size());
      if(scale_flag)
	{
	  // A_scaled = A_resized * scale_factor
	  ofile << "$T [scale_rr] $T [scale_ra] $T [scale_cr] $T [scale_ca]" << endl;
	}
      else
	{
	  ofile << "$T [scale_req] $T [scale_ack] " << endl;
	}
      
      // A_final = base + A_scaled.
      if(this->Get_Base_Address() > 0)
	ofile << "$T [plus_base_rr] $T [plus_base_ra] $T [plus_base_cr] $T [plus_base_ca]" << endl;
      else
	ofile << "$T [plus_base_req] $T [plus_base_ack] " << endl;
      
      // individual word addresses (in parallel)
      if(this->Get_Type()->Size() > this->Get_Word_Size())
	{
	  ofile << "||[words] {" << endl;
	  for(int idx = 0; idx < (this->Get_Type()->Size() / this->Get_Word_Size()); idx++)
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
	  ofile << "$T [rename_req] $T [rename_ack]" << endl;
	}
      
      ofile << "}" << endl;
    }

}

void AaObjectReference::Write_VC_Load_Store_Control_Path(AaExpression* 
							 address_expression, 
							 string read_or_write,
							 ostream& ofile)
{
  ofile << ";;[" << this->Get_VC_Name() << "_" << read_or_write << "] {" << endl;

  if(read_or_write == "write")
    {
      // split the data into words..
      ofile << "$T [split_req] $T [split_ack]" << endl;
    }

  // in parallel access the words.
  ofile << "||[word_access] {" << endl;
  for(int idx = 0; idx < (this->Get_Type()->Size() / this->Get_Word_Size()); idx++)
    {
      // each word access.
      ofile << ";;[word_access_" << idx << "] {" << endl
	    << "$T [rr] $T [ra] $T [cr] $T [ca]" << endl
	    << "}" << endl;
    }
  ofile << "}" << endl;

  if(read_or_write == "read")
    {
      // merge the words into the data..
      ofile << "$T [merge_req] $T [merge_ack]" << endl;
    }

  ofile << "}" << endl;
}


void AaObjectReference::Write_VC_Address_Calculation_Data_Path(AaExpression* address_expression, 
							       ostream& ofile)
{
  AaUintType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());

  if((address_expression != NULL) && !address_expression->Is_Constant())
    {

      string addr_expr_name =  address_expression->Get_VC_Driver_Name();
      string inst_root_name = this->Get_VC_Name();
      string resized_addr_name = this->Get_VC_Driver_Name() + "_resized_address";
      string scaled_offset_name = this->Get_VC_Driver_Name() + "_scaled_offset_address";
      string final_root_address_name = this->Get_VC_Driver_Name() + "_address";



      // basic address.
      address_expression->Write_VC_Datapath_Instances(NULL,ofile);

      // resize or equivalent?
      bool resize_flag = false;
      if(address_expression->Get_Type()->Size() != this->Get_Address_Width())
	{
	  resize_flag = true;
	  // write resize operator.
	  // address -> resized_address
	  
	  Write_VC_Unary_Operator(__NOP,
				  inst_root_name + "_addr_resize",
				  addr_expr_name,
				  address_expression->Get_Type(),
				  resized_addr_name,
				  addr_type,
				  ofile);
				  
	}
      else
	{
	  vector<string> inwires; inwires.push_back(addr_expr_name);
	  vector<string> outwires; outwires.push_back(resized_addr_name);
	  Write_VC_Equivalence_Operator(inst_root_name + "_addr_resize",
					inwires,
					outwires,
					ofile);
	}
      
      // scale operation
      bool scale_flag = (this->Get_Type()->Size() > this->Get_Word_Size());
      if(scale_flag)
	{
	  // write multiply operator..
	  // resized_address -> scaled_offset
	  Write_VC_Binary_Operator(__MUL,
				   inst_root_name + "_scale_offset",
				   resized_addr_name,
				   addr_type,
				   this->Get_VC_Offset_Scale_Factor_Name(),
				   addr_type,
				   scaled_offset_name,
				   addr_type,
				   ofile
				   );
	  
	}
      else
	{
	  vector<string> inwires; inwires.push_back(resized_addr_name);
	  vector<string> outwires; outwires.push_back(scaled_offset_name);
	  Write_VC_Equivalence_Operator(inst_root_name + "_scale_offset",
					inwires,
					outwires,
					ofile);
	}
      
      // base+offset operation
      if(this->Get_Base_Address() > 0)
	{
	  // write multiply operator..
	  // addr = base + scaled_offset
	  Write_VC_Binary_Operator(__PLUS,
				   inst_root_name + "_plus_base",
				   scaled_offset_name,
				   addr_type,
				   this->Get_VC_Base_Address_Name(),
				   addr_type,
				   final_root_address_name,
				   addr_type,
				   ofile
				   );

	}
      else
	{
	  // an equivalence
	  // scaled_offset -> final_root.
	  vector<string> inwires; 
	  inwires.push_back(scaled_offset_name);
	  vector<string> outwires; 
	  outwires.push_back(final_root_address_name);
	  
	  Write_VC_Equivalence_Operator(inst_root_name + "_plus_base",
					inwires,
					outwires,
					ofile);

	}
      
      if(scale_flag)
	{
	  
	  for(int idx = 0;
	      idx < (this->Get_Type()->Size() / this->Get_Word_Size());
	      idx++)
	    {
	      // write add operator to generate each word address.
	      Write_VC_Binary_Operator(__PLUS,
				       inst_root_name 
				       + "_addr_"
				       + IntToStr(idx),
				       final_root_address_name,
				       addr_type,
				       this->Get_VC_Word_Offset_Name(idx),
				       addr_type,
				       final_root_address_name 
				       + "_" 
				       + IntToStr(idx),
				       addr_type,
				       ofile
				       );
	    }
	}
      else
	{
	  // write equivalence to obtain word_0 address.
	  // an equivalence
	  // scaled_offset -> final_root.
	  vector<string> inwires; inwires.push_back(final_root_address_name);
	  vector<string> outwires; outwires.push_back(final_root_address_name + "_0");
	  Write_VC_Equivalence_Operator(inst_root_name + "_addr_0",
					inwires,
					outwires,
					ofile);

	}
    }
}

void AaObjectReference::Write_VC_Load_Store_Data_Path(AaExpression* address_expression, 
						      AaExpression* data_expression,
						      string read_or_write,  
						      ostream& ofile)
{
  string final_root_address_name = this->Get_VC_Driver_Name() + "_address";


  if(address_expression != NULL)
    address_expression->Write_VC_Datapath_Instances(NULL,ofile);

  bool scale_flag = (this->Get_Type()->Size() > this->Get_Word_Size());
  for(int idx = 0;
      idx < (this->Get_Type()->Size() / this->Get_Word_Size());
      idx++)
    {
      // load-store operator
      if(read_or_write == "read")
	{
	  // load
	  Write_VC_Load_Operator(this->Get_VC_Memory_Space_Name(),
				 this->Get_VC_Name() + "_load_" + IntToStr(idx),
				 this->Get_VC_Driver_Name() + "_" + IntToStr(idx),
				 this->Get_VC_Driver_Name() + "_address_" + IntToStr(idx),
				 ofile);
				 
	}
      else
	{
	  // store
	  Write_VC_Store_Operator(this->Get_VC_Memory_Space_Name(), 
				 this->Get_VC_Name() + "_store_" + IntToStr(idx),
				 this->Get_VC_Driver_Name() + "_" + IntToStr(idx),
				 this->Get_VC_Driver_Name() + "_address_" + IntToStr(idx),
				 ofile);
	}
    }


  // equivalence operator.
  vector<string> inwires;
  vector<string> outwires;
  for(int idx = 0; idx < ((this->Get_Type()->Size())/this->Get_Word_Size()); idx++)
    {
      if(read_or_write == "read")
	{
	  inwires.push_back(this->Get_VC_Driver_Name() + "_" + IntToStr(idx));
	}
      else
	{
	  outwires.push_back(this->Get_VC_Driver_Name() + "_" + IntToStr(idx));
	}
    }
  if(read_or_write == "read")
    outwires.push_back(data_expression->Get_VC_Driver_Name());
  else
    inwires.push_back(data_expression->Get_VC_Driver_Name());

  Write_VC_Equivalence_Operator(this->Get_VC_Name() + "_gather_scatter",
				inwires,
				outwires,
				ofile);
}


void AaObjectReference::Write_VC_Address_Calculation_Links(string hier_id,
							   AaExpression* address_expression, 
							   ostream& ofile)
{

  //  ofile << ";;[" << this->Get_VC_Name() << "_address_calculate] {" << endl;
  hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name() + "_address_calculate");
 
  // address expression needs to be computed.
  // let this calculated expression be A
  if(address_expression != NULL && !address_expression->Is_Constant())
    {
      address_expression->Write_VC_Links(hier_id,ofile);
      
      vector<string> reqs;
      vector<string> acks;
  
      // next A is resized, to produce A_resized
      //  ofile << "$T [resize_req] $T [resize_ack]" << endl;
      reqs.push_back(hier_id + "/resize_req");
      acks.push_back(hier_id + "/resize_ack");
      Write_VC_Link(this->Get_VC_Name() + "_addr_resize",
		    reqs,
		    acks,
		    ofile);
      reqs.clear();
      acks.clear();
      
      
      bool scale_flag = (this->Get_Type()->Size() > this->Get_Word_Size());
      
      if(scale_flag)
	{
	  // A_scaled = A_resized * scale_factor
	  //  ofile << "$T [scale_rr] $T [scale_ra] $T [scale_cr] $T [scale_ca]" << endl;
	  reqs.push_back(hier_id + "/scale_rr");
	  reqs.push_back(hier_id + "/scale_cr");
	  acks.push_back(hier_id + "/scale_ra");
	  acks.push_back(hier_id + "/scale_ca");
	}
      else
	{
	  reqs.push_back(hier_id + "/scale_req");
	  acks.push_back(hier_id + "/scale_ack");
	}
      Write_VC_Link(this->Get_VC_Name() + "_scale_offset",
		    reqs,
		    acks,
		    ofile);
      reqs.clear();
      acks.clear();
      
      // A_final = base + A_scaled.
      // ofile << "$T [offset_rr] $T [offset_ra] $T [offset_cr] $T [offset_ca]" << endl;
      if(this->Get_Base_Address() > 0)
	{
	  reqs.push_back(hier_id + "/plus_base_rr");
	  reqs.push_back(hier_id + "/plus_base_cr");
	  acks.push_back(hier_id + "/plus_base_ra");
	  acks.push_back(hier_id + "/plus_base_ca");
	}
      else
	{
	  reqs.push_back(hier_id + "/plus_base_req");
	  acks.push_back(hier_id + "/plus_base_ack");
	}
      Write_VC_Link(this->Get_VC_Name() + "_plus_base",
		    reqs,
		    acks,
		    ofile);
      reqs.clear();
      acks.clear();
      
      // individual word addresses (in parallel)
      if(this->Get_Type()->Size() > this->Get_Word_Size())
	{
	  hier_id = hier_id + "/words" ;
	  for(int idx = 0; idx < (this->Get_Type()->Size() / this->Get_Word_Size()); idx++)
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
	  reqs.push_back(hier_id + "/rename_req");
	  acks.push_back(hier_id + "/rename_ack");
	  Write_VC_Link(this->Get_VC_Name() + "_addr_0",
			reqs,
			acks,
			ofile);
	  reqs.clear();
	  acks.clear();
	}
    }
}


void AaObjectReference::Write_VC_Load_Store_Links(string hier_id,
						  string read_or_write,
						  AaExpression* address_expression, 
						  ostream& ofile)
{
  vector<string> reqs;
  vector<string> acks;

  hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_" + read_or_write);

  // if read, then merge
  string ms_instance = this->Get_VC_Name() + "_gather_scatter";
  if(read_or_write == "read")
    {
      reqs.push_back(hier_id + "/merge_req");
      acks.push_back(hier_id + "/merge_ack");

    }
  else
    {
      reqs.push_back(hier_id + "/split_req");
      acks.push_back(hier_id + "/split_ack");
    }
  Write_VC_Link(ms_instance,reqs,acks, ofile);
  reqs.clear();
  acks.clear();

  // in parallel access the words.
  hier_id = Augment_Hier_Id(hier_id, "word_access");
  for(int idx = 0; idx < (this->Get_Type()->Size() / this->Get_Word_Size()); idx++)
    {
      // each word access.
      string word_hier_id = Augment_Hier_Id(hier_id , "word_access_" + IntToStr(idx));
      reqs.push_back(word_hier_id + "/rr");
      reqs.push_back(word_hier_id + "/cr");
      acks.push_back(word_hier_id + "/ra");
      acks.push_back(word_hier_id + "/ca");
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


string AaObjectReference::Get_VC_Memory_Space_Name()
{
  assert(this->_object->Is("AaStorageObject"));
  AaStorageObject* so = ((AaStorageObject*)(this->_object));
  return(so->Get_VC_Memory_Space_Name());
}

int AaObjectReference::Get_Base_Address()
{
  assert(this->_object->Is("AaStorageObject"));
  AaStorageObject* so = ((AaStorageObject*)(this->_object));
  return(so->Get_Base_Address());
}
int AaObjectReference::Get_Word_Size()
{
  assert(this->_object->Is("AaStorageObject"));
  AaStorageObject* so = ((AaStorageObject*)(this->_object));
  return(so->Get_Word_Size());
}
int AaObjectReference::Get_Address_Width()
{
  assert(this->_object->Is("AaStorageObject"));
  AaStorageObject* so = ((AaStorageObject*)(this->_object));
  return(so->Get_Address_Width());
}

string AaObjectReference::Get_VC_Base_Address_Name()
{
  assert(this->_object->Is("AaStorageObject"));
  AaStorageObject* so = ((AaStorageObject*)(this->_object));
  return(so->Get_VC_Base_Address_Name());
}

string AaObjectReference::Get_VC_Offset_Scale_Factor_Name()
{
  assert(this->_object->Is("AaStorageObject"));
  AaStorageObject* so = ((AaStorageObject*)(this->_object));
  return(so->Get_VC_Offset_Scale_Factor_Name());
}

string AaObjectReference::Get_VC_Word_Offset_Name(int idx)
{
  assert(this->_object->Is("AaStorageObject"));
  AaStorageObject* so = ((AaStorageObject*)(this->_object));
  return(so->Get_VC_Word_Offset_Name(idx));
}


string AaPointerDereferenceExpression::Get_VC_Memory_Space_Name()
{
  AaStorageObject* obj = this->Get_Addressed_Object_Representative();
  if(obj != NULL)
    {
      return (obj->Get_VC_Memory_Space_Name());
    }
  else
    {
      AaRoot::Error("could not associate memory space with pointer ", this);
    }
}

int AaPointerDereferenceExpression::Get_Word_Size()
{
 AaStorageObject* obj = this->Get_Addressed_Object_Representative();
  if(obj != NULL)
    {
      return (obj->Get_Word_Size());
    }
  else
    {
      AaRoot::Error("could not associate memory space with pointer ", this);
    }
}

int AaPointerDereferenceExpression::Get_Address_Width()
{
 AaStorageObject* obj = this->Get_Addressed_Object_Representative();
  if(obj != NULL)
    {
      return (obj->Get_Address_Width());
    }
  else
    {
      AaRoot::Error("could not associate memory space with pointer ", this);
    }
}

string AaPointerDereferenceExpression::Get_VC_Offset_Scale_Factor_Name()
{
 AaStorageObject* obj = this->Get_Addressed_Object_Representative();
  if(obj != NULL)
    {
      return (obj->Get_VC_Offset_Scale_Factor_Name());
    }
  else
    {
      AaRoot::Error("could not associate memory space with pointer ", this);
    }
}

string AaPointerDereferenceExpression::Get_VC_Word_Offset_Name(int idx)
{
 AaStorageObject* obj = this->Get_Addressed_Object_Representative();
  if(obj != NULL)
    {
      return (obj->Get_VC_Word_Offset_Name(idx));
    }
  else
    {
      AaRoot::Error("could not associate memory space with pointer ", this);
    }
}
