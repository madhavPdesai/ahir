#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcValue.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcOperator.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>

vcEquivalence::vcEquivalence(string id, 
			     vector<vcWire*>& inwires, 
			     vector<vcWire*>& outwires):
  vcOperator(id)
{
  _flow_through = true;

  int in_width = 0;
  for(int idx = 0; idx < inwires.size(); idx++)
    {
      in_width += inwires[idx]->Get_Size();
      _inwires.push_back(inwires[idx]);
      inwires[idx]->Connect_Receiver(this);
    }

  int out_width = 0;
  for(int idx = 0; idx < outwires.size(); idx++)
    {
      out_width += outwires[idx]->Get_Size();
      _outwires.push_back(outwires[idx]);
      outwires[idx]->Connect_Driver(this);
    }

  if(in_width != out_width)
    {
      vcSystem::Error("in equivalence operator " + id + ", total input width is not equal to total output width");
    }

  _width = in_width;
}

void vcEquivalence::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__EQUIVALENCE_OP] << " " << this->Get_Label() << " ";
  ofile << vcLexerKeywords[__LPAREN];
  for(int idx = 0; idx < _inwires.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << _inwires[idx]->Get_Id();
    }
  ofile << vcLexerKeywords[__RPAREN];
  ofile << " " 	<< vcLexerKeywords[__LPAREN];
  for(int idx = 0; idx < _outwires.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << _outwires[idx]->Get_Id();
    }
  ofile << vcLexerKeywords[__RPAREN] << endl;
}


void   vcOperator::Add_Reqs(vector<vcTransition*>& reqs)
{
  assert(reqs.size() == 1);
  this->_reqs = reqs;
}

void vcOperator::Add_Acks(vector<vcTransition*>& acks)
{
  assert(acks.size() == 1);
  this->_acks = acks;
}


void   vcSplitOperator::Add_Reqs(vector<vcTransition*>& reqs)
{
  assert(reqs.size() == 2);
  this->_reqs = reqs;

}

void vcSplitOperator::Add_Acks(vector<vcTransition*>& acks)
{
  assert(acks.size() == 2);
  this->_acks = acks;
}


vcLoadStore::vcLoadStore(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data):vcSplitOperator(id)
{
  _memory_space = ms;
  _address = addr;
  _data = data;

  
  assert(ms != NULL);

  if(ms->Get_Address_Width() != addr->Get_Type()->Size())
    {
      string err_msg = string("load/store operator address-wire width must\n") +
	"be the same as the memory space address width\n" +
	"for load/store with id " + id + 
	" (memory space " + ms->Get_Id() + ")"; 

      vcSystem::Error(err_msg);

    }
  if(ms->Get_Word_Size() != data->Get_Type()->Size())
    {
      string err_msg = string("load/store operator data-wire width must\n") +
	"be the same as the memory space data width\n" +
	"for load/store with id " + id + 
	" (memory space " + ms->Get_Id() + ")";
      vcSystem::Error(err_msg);
    }
}


vcLoad::vcLoad(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data):vcLoadStore(id,ms,addr,data) 
{
  addr->Connect_Receiver(this);
  data->Connect_Driver(this);
}
void vcLoad::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__LOAD] 	<< " "
	<< this->Get_Label() << " " << vcLexerKeywords[__FROM] << " "
	<< this->_memory_space->Get_Hierarchical_Id() << " "
	<< vcLexerKeywords[__LPAREN] << " "
	<< this->_address->Get_Id() << " "
	<< vcLexerKeywords[__RPAREN] << " "
	<< vcLexerKeywords[__LPAREN] << " "
	<< this->_data->Get_Id() <<  " "
	<< vcLexerKeywords[__RPAREN] << endl;

}
vcStore::vcStore(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data):vcLoadStore(id,ms,addr,data) 
{
  addr->Connect_Receiver(this);
  data->Connect_Receiver(this);
}
void vcStore::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__STORE] 	<< " "
	<< this->Get_Label() << " " << vcLexerKeywords[__TO] << " "
	<< this->_memory_space->Get_Hierarchical_Id() << " "
	<< vcLexerKeywords[__LPAREN] << " "
	<< this->_address->Get_Id() << " "
	<< this->_data->Get_Id() << " "
	<< vcLexerKeywords[__RPAREN] << endl;
}

vcPhi::vcPhi(string id, vector<vcWire*>& inwires, vcWire* outwire):vcDatapathElement(id)
{
  assert(inwires.size() > 0 && outwire != NULL);

  // all wires must have the same type
  vcType* t = outwire->Get_Type();
  for(int idx = 0; idx < inwires.size(); idx++)
    assert(t == inwires[idx]->Get_Type());

  this->_inwires = inwires;
  for(int idx =0; idx < _inwires.size(); idx++)
    _inwires[idx]->Connect_Receiver(this);

  this->_outwire = outwire;
  _outwire->Connect_Driver(this);

}

void vcPhi::Add_Reqs(vector<vcTransition*>& reqs)
{
  assert(reqs.size() > 0);
  this->_reqs = reqs;
}

void vcPhi::Add_Acks(vector<vcTransition*>& acks)
{
  assert(acks.size() == 1);
  this->_acks = acks;
}

void vcPhi::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__PHI] << " " << this->Get_Label() << " ";
  ofile << vcLexerKeywords[__LPAREN];
  for(int idx = 0; idx < this->_inwires.size(); idx++)
    {
      ofile << this->_inwires[idx]->Get_Id() << " ";
    }
  ofile << vcLexerKeywords[__RPAREN] 
	<< " ";
  ofile << vcLexerKeywords[__LPAREN];
  ofile << this->_outwire->Get_Id();
  ofile << vcLexerKeywords[__RPAREN] ;
  ofile << endl;
}

vcCall::vcCall(string id, vcModule* m, vector<vcWire*>& in_wires, vector<vcWire*> out_wires, bool inline_flag):vcSplitOperator(id)
{
  _called_module = m;

  _in_wires = in_wires;
  for(int idx =0; idx < _in_wires.size(); idx++)
    _in_wires[idx]->Connect_Receiver(this);

  _out_wires = out_wires;
  for(int idx =0; idx < _out_wires.size(); idx++)
    _out_wires[idx]->Connect_Driver(this);

  _inline_flag = inline_flag;
}

void vcCall::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__CALL] << " "
	<< (_inline_flag ? vcLexerKeywords[__INLINE] : "") <<  " " 
	<< this->Get_Label() << " "
	<< vcLexerKeywords[__MODULE] << " "
	<< this->_called_module->Get_Id() << " ";

  // input arguments.
  ofile << vcLexerKeywords[__LPAREN] << " ";
  for(int idx = 0; idx < _in_wires.size(); idx++)
    ofile << _in_wires[idx]->Get_Id() << " ";
  ofile << vcLexerKeywords[__RPAREN] << " ";


  // output arguments.
  ofile << vcLexerKeywords[__LPAREN] << " ";
  for(int idx = 0; idx < _out_wires.size(); idx++)
    ofile << _out_wires[idx]->Get_Id() << " ";
  ofile << vcLexerKeywords[__RPAREN] << " ";
}

vcIOport::vcIOport(string id, string pipe_id, vcWire* w): vcOperator(id)
{
  _pipe_id = pipe_id;
  _data = w;
}


vcInport::vcInport(string id, string pipe_id, vcWire* w):vcIOport(id,pipe_id,w) 
{
  w->Connect_Driver(this);
}
void vcInport::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__IOPORT] << " " <<  vcLexerKeywords[__IN] << " " << this->Get_Label() << "  " 
	<< vcLexerKeywords[__LPAREN] << this->_pipe_id << vcLexerKeywords[__RPAREN] << " "
	<< vcLexerKeywords[__LPAREN] << this->_data->Get_Id() << vcLexerKeywords[__RPAREN] << endl;
}

vcOutport::vcOutport(string id, string pipe_id, vcWire* w):vcIOport(id,pipe_id,w) 
{
  w->Connect_Receiver(this);
}
void vcOutport::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__IOPORT] << " " <<  vcLexerKeywords[__OUT] << " " << this->Get_Label() << "  " 
	<< vcLexerKeywords[__LPAREN] << this->_data->Get_Id() << vcLexerKeywords[__RPAREN] << " " 
	<< vcLexerKeywords[__LPAREN] << this->_pipe_id << vcLexerKeywords[__RPAREN] << endl;
}

vcUnarySplitOperator::vcUnarySplitOperator(string id, string op_id, vcWire* x, vcWire* z):vcSplitOperator(id)
{
  
  assert(x != NULL && z != NULL);
  
  this->_op_id = op_id;

  this->_x = x;
  x->Connect_Receiver(this);

  this->_z = z;
  z->Connect_Driver(this);
}

bool vcUnarySplitOperator::Is_Shareable_With(vcDatapathElement* other)
{
  // unary operations are too trivial to share..
  return(false);
}


void vcUnarySplitOperator::Print(ostream& ofile)
{
  ofile << this->_op_id << " " << this->Get_Label() << " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_x->Get_Id() << " "
	<< vcLexerKeywords[__RPAREN] 
	<< " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_z->Get_Id()
	<< vcLexerKeywords[__RPAREN] 
	<< endl;
}


vcUnaryOperator::vcUnaryOperator(string id, string op_id, vcWire* x, vcWire* z):vcOperator(id)
{
  assert(x != NULL && z != NULL);
  
  this->_op_id = op_id;

  this->_x = x;
  x->Connect_Receiver(this);

  this->_z = z;
  z->Connect_Driver(this);
}


void vcUnaryOperator::Print(ostream& ofile)
{
  ofile << this->_op_id << " " << this->Get_Label() << " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_x->Get_Id() << " "
	<< vcLexerKeywords[__RPAREN] 
	<< " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_z->Get_Id()
	<< vcLexerKeywords[__RPAREN] 
	<< endl;
}


vcBinarySplitOperator::vcBinarySplitOperator(string id, string op_id, vcWire* x, vcWire* y, vcWire* z):vcSplitOperator(id)
{
  assert(x != NULL && y != NULL && z != NULL);
  
  this->_op_id = op_id;


  if(x->Is("vcConstantWire"))
    {
      // both cannot be constants!
      assert(!y->Is("vcConstantWire"));
      if(Is_Symmetric_Op(op_id))
	{
	  vcWire* tmp = y;
	  y = x;
	  x = tmp;
	}
    }
  
  this->_x = x;
  x->Connect_Receiver(this);

  this->_y = y;
  y->Connect_Receiver(this);

  this->_z = z;
  z->Connect_Driver(this);
}


bool vcBinarySplitOperator::Is_Shareable_With(vcDatapathElement* other)
{

  // trivial operations are not worth sharing..
  if(Is_Trivial_Op(this->_op_id))
    return(false);

  bool ret_val = ((this->Kind() == other->Kind()) 
		  && 
		  (this->_op_id == ((vcBinarySplitOperator*)other)->Get_Op_Id()));
  if(!ret_val)
    return(ret_val);

  vector<vcWire*> iw1, iw2;
  this->Append_Inwires(iw1);
  other->Append_Inwires(iw2);

  if(!Check_If_Equivalent(iw1,iw2))
    return(false);

  vector<vcWire*> ow1, ow2;
  this->Append_Outwires(iw1);
  other->Append_Outwires(iw2);

  if(!Check_If_Equivalent(ow1,ow2))
    return(false);

  if(_y->Is("vcConstantWire") && Is_Shift_Op(this->_op_id))
    return(false);

  if(_y->Is("vcConstantWire") && (((vcBinarySplitOperator*)other)->Get_Y()->Is("vcConstantWire")))
    {
      vcConstantWire* cy = (vcConstantWire*) _y;
      vcValue* cyv = cy->Get_Value();
      
      vcConstantWire* coy = (vcConstantWire*) ((vcBinarySplitOperator*) other)->Get_Y();
      vcValue* coyv = coy->Get_Value();

      if(cyv->Kind() == coyv->Kind())
	{
	  if(cyv->Get_Type()->Is_Int_Type())
	    {
	      if(!(*((vcIntValue*)cyv) == *((vcIntValue*) coyv)))
		return(false);
	    }
	  else
	    {
	      if(!(*((vcFloatValue*)cyv) == *((vcFloatValue*) coyv)))
		return(false);
	    }
	}
    }

  return(true);
}



void vcBinarySplitOperator::Print(ostream& ofile)
{
  ofile << this->_op_id << " " << this->Get_Label() << " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_x->Get_Id() << " "
	<< this->_y->Get_Id() << " "
	<< vcLexerKeywords[__RPAREN] 
	<< " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_z->Get_Id()
	<< vcLexerKeywords[__RPAREN] 
	<< endl;
}

vcBinaryOperator::vcBinaryOperator(string id, string op_id, vcWire* x, vcWire* y, vcWire* z):vcOperator(id)
{
  assert(x != NULL && y != NULL && z != NULL);
  
  this->_op_id = op_id;
  
  this->_x = x;
  x->Connect_Receiver(this);

  this->_y = y;
  y->Connect_Receiver(this);

  this->_z = z;
  z->Connect_Driver(this);
}

void vcBinaryOperator::Print(ostream& ofile)
{
  ofile << this->_op_id << " " << this->Get_Label() << " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_x->Get_Id() << " "
	<< this->_y->Get_Id() << " "
	<< vcLexerKeywords[__RPAREN] 
	<< " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_z->Get_Id()
	<< vcLexerKeywords[__RPAREN] 
	<< endl;
}

vcSelect::vcSelect(string id, vcWire* sel, vcWire* x, vcWire* y, vcWire* z):vcOperator(id)
{
  this->_x = x;
  _x->Connect_Receiver(this);

  this->_y = y;
  _y->Connect_Receiver(this);

  this->_sel = sel;
  _sel->Connect_Receiver(this);

  this->_z = z;
  _z->Connect_Driver(this);
}


void vcSelect::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__SELECT_OP] << " " << this->Get_Label() << " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_sel->Get_Id() << " "
	<< this->_x->Get_Id() << " "
	<< this->_y->Get_Id() << " "
	<< vcLexerKeywords[__RPAREN] 
	<< " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_z->Get_Id()
	<< vcLexerKeywords[__RPAREN] 
	<< endl;
}

vcRegister::vcRegister(string id, vcWire* din, vcWire* dout):vcOperator(id)
{
  assert(din && dout);

  _din = din;
  din->Connect_Receiver(this);

  _dout = dout;
  dout->Connect_Driver(this);
}

void vcRegister::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__ASSIGN_OP] << " " << this->Get_Label() << " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_din->Get_Id() << " "
	<< vcLexerKeywords[__RPAREN] 
	<< " "
	<< vcLexerKeywords[__LPAREN] 
	<< this->_dout->Get_Id()
	<< vcLexerKeywords[__RPAREN] 
	<< endl;
}

vcBranch::vcBranch(string id, vector<vcWire*>& wires): vcDatapathElement(id) 
{
  for(int idx = 0; idx < wires.size(); idx++)
    {
      _inwires.push_back(wires[idx]);
      wires[idx]->Connect_Receiver(this);
    }
}

void vcBranch::Add_Reqs(vector<vcTransition*>& reqs)
{
  assert(reqs.size() == 1);
  this->_reqs = reqs;
}

void vcBranch::Add_Acks(vector<vcTransition*>& acks)
{
  assert(acks.size() == 2);
  this->_acks = acks;
}

void vcBranch::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__BRANCH_OP] << " " << this->Get_Label() << " " 
	<< vcLexerKeywords[__LPAREN];
  for(int idx =0; idx < _inwires.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << _inwires[idx]->Get_Id();
    }
  ofile << vcLexerKeywords[__RPAREN] << endl;
}


bool Is_Shift_Op(string vc_op_id)
{
  bool ret_val = false;
  if(vc_op_id == vcLexerKeywords[__SHL_OP]                ) { ret_val = true;} 
  else if(vc_op_id == vcLexerKeywords[__SHR_OP]           ) { ret_val = true;} 
  else if(vc_op_id == vcLexerKeywords[__SHRA_OP]          ) { ret_val = true;} 
  return(ret_val);
}

bool Is_Trivial_Op(string vc_op_id)
{
  bool ret_val = false;
  if(vc_op_id == vcLexerKeywords[__BITSEL_OP]             ) { ret_val = true;      } 
  else if(vc_op_id == vcLexerKeywords[__CONCAT_OP]        ) { ret_val = true; } 
  else if(vc_op_id == vcLexerKeywords[__OR_OP]            ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__AND_OP]           ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__XOR_OP]           ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__NOR_OP]           ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__NAND_OP]          ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__XNOR_OP]          ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__ASSIGN_OP]        ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__UtoS_ASSIGN_OP]   ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__StoU_ASSIGN_OP]   ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__StoS_ASSIGN_OP]   ) { ret_val = true; }
  return(ret_val);
}

bool Is_Symmetric_Op(string vc_op_id)
{
  bool ret_val = false;
  if(vc_op_id == vcLexerKeywords[__PLUS_OP]               )      { ret_val = true;      } 
  else if(vc_op_id == vcLexerKeywords[__MUL_OP]           ) { ret_val = true; } 
  else if(vc_op_id == vcLexerKeywords[__EQ_OP]            ) { ret_val = true; } 
  else if(vc_op_id == vcLexerKeywords[__OR_OP]            ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__AND_OP]           ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__XOR_OP]           ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__NOR_OP]           ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__NAND_OP]          ) { ret_val = true; }
  else if(vc_op_id == vcLexerKeywords[__XNOR_OP]          ) { ret_val = true; }
  return(ret_val);
}

bool Is_Unary_Op(string vc_op_id)
{
  return((vc_op_id == vcLexerKeywords[__NOT_OP]) ||
	 (vc_op_id == vcLexerKeywords[__ASSIGN_OP]) ||
	 (vc_op_id == vcLexerKeywords[__StoS_ASSIGN_OP]) ||
	 (vc_op_id == vcLexerKeywords[__UtoS_ASSIGN_OP]) ||
	 (vc_op_id == vcLexerKeywords[__StoU_ASSIGN_OP]) ||
	 (vc_op_id == vcLexerKeywords[__FtoS_ASSIGN_OP]) ||
	 (vc_op_id == vcLexerKeywords[__FtoU_ASSIGN_OP]) ||
	 (vc_op_id == vcLexerKeywords[__UtoF_ASSIGN_OP]) ||
	 (vc_op_id == vcLexerKeywords[__StoF_ASSIGN_OP]) ||
	 (vc_op_id == vcLexerKeywords[__FtoF_ASSIGN_OP]));
}

string Get_VHDL_Op_Id(string vc_op_id, vcType* in_type, vcType* out_type)
{

  string ret_string;

  if((in_type->Kind() == "vcIntType" || in_type->Kind() == "vcPointerType") &&
     (out_type->Kind() == "vcIntType" || out_type->Kind() == "vcPointerType"))
    {
      if(vc_op_id == vcLexerKeywords[__PLUS_OP]          ) { ret_string = "ApIntAdd";} 
      else if(vc_op_id == vcLexerKeywords[__MINUS_OP]         ) { ret_string = "ApIntSub";} 
      else if(vc_op_id == vcLexerKeywords[__MUL_OP]           ) { ret_string = "ApIntMul";} 
      else if(vc_op_id == vcLexerKeywords[__DIV_OP]           ) { ret_string = "ApIntDiv";} 
      else if(vc_op_id == vcLexerKeywords[__SHL_OP]           ) { ret_string = "ApIntSHL";} 
      else if(vc_op_id == vcLexerKeywords[__SHR_OP]           ) { ret_string = "ApIntLSHR";} 
      else if(vc_op_id == vcLexerKeywords[__SHRA_OP]          ) { ret_string = "ApIntASHR";} 
      else if(vc_op_id == vcLexerKeywords[__SGT_OP]            ) { ret_string = "ApIntSgt";} 
      else if(vc_op_id == vcLexerKeywords[__SGE_OP]            ) { ret_string = "ApIntSge"  ;} 
      else if(vc_op_id == vcLexerKeywords[__EQ_OP]            ) { ret_string = "ApIntEq"  ;} 
      else if(vc_op_id == vcLexerKeywords[__SLT_OP]            ) { ret_string = "ApIntSlt"  ;} 
      else if(vc_op_id == vcLexerKeywords[__SLE_OP]            ) { ret_string = "ApIntSle"  ;}
      else if(vc_op_id == vcLexerKeywords[__UGT_OP]           ) { ret_string = "ApIntUgt"  ;}
      else if(vc_op_id == vcLexerKeywords[__UGE_OP]           ) { ret_string = "ApIntUge"  ;}
      else if(vc_op_id == vcLexerKeywords[__ULT_OP]           ) { ret_string = "ApIntUlt"  ;}
      else if(vc_op_id == vcLexerKeywords[__ULE_OP]           ) { ret_string = "ApIntUle"  ;}
      else if(vc_op_id == vcLexerKeywords[__NEQ_OP]           ) { ret_string = "ApIntNe"  ;} 
      else if(vc_op_id == vcLexerKeywords[__BITSEL_OP]        ) { ret_string = "ApBitsel"  ;} 
      else if(vc_op_id == vcLexerKeywords[__CONCAT_OP]        ) { ret_string = "ApConcat"  ;} 
      else if(vc_op_id == vcLexerKeywords[__ASSIGN_OP]        ) { ret_string = "ApIntToApIntUnsigned" ;}
      else if(vc_op_id == vcLexerKeywords[__StoS_ASSIGN_OP]   ) { ret_string = "ApIntToApIntSigned" ;}
      else if(vc_op_id == vcLexerKeywords[__UtoS_ASSIGN_OP]   ) { ret_string = "ApIntToApIntSigned" ;}
      else if(vc_op_id == vcLexerKeywords[__StoU_ASSIGN_OP]   ) { ret_string = "ApIntToApIntUnsigned" ;}
      else if(vc_op_id == vcLexerKeywords[__NOT_OP]           ) { ret_string = "ApIntNot"  ;}
      else if(vc_op_id == vcLexerKeywords[__OR_OP]            ) { ret_string = "ApIntOr"  ;}
      else if(vc_op_id == vcLexerKeywords[__AND_OP]           ) { ret_string = "ApIntAnd"  ;}
      else if(vc_op_id == vcLexerKeywords[__XOR_OP]           ) { ret_string = "ApIntXor"  ;}
      else if(vc_op_id == vcLexerKeywords[__NOR_OP]           ) { ret_string = "ApIntNor"  ;}
      else if(vc_op_id == vcLexerKeywords[__NAND_OP]          ) { ret_string = "ApIntNand"  ;}
      else if(vc_op_id == vcLexerKeywords[__XNOR_OP]          ) { ret_string = "ApIntXnor"  ;}
      else { vcSystem::Error("unsupported int X int -> int operation " + vc_op_id);}
    }

  if(in_type->Kind() == "vcFloatType" && out_type->Kind() == "vcFloatType")
    {
      if(vc_op_id == vcLexerKeywords[__PLUS_OP]               ) { ret_string = "ApFloatAdd";} 
      else if(vc_op_id == vcLexerKeywords[__MINUS_OP]         ) { ret_string = "ApFloatSub";} 
      else if(vc_op_id == vcLexerKeywords[__MUL_OP]           ) { ret_string = "ApFloatMul";} 
      else if(vc_op_id == vcLexerKeywords[__DIV_OP]           ) { ret_string = "ApFloatDiv";} 
      else if(vc_op_id == vcLexerKeywords[__ASSIGN_OP]        ) { ret_string = "ApFloatResize";}
      else if(vc_op_id == vcLexerKeywords[__FtoF_ASSIGN_OP]   ) { ret_string = "ApFloatResize";}
      else { vcSystem::Error("unsupported float <-> float operation " + vc_op_id);}
    }

  if(in_type->Kind() == "vcFloatType" && out_type->Kind() == "vcIntType")
    {
      // all float comparison operations will be unordered.. (no exception handling!)
      if(vc_op_id == vcLexerKeywords[__SGT_OP]            ) { ret_string = "ApFloatUgt" ;} 
      else if(vc_op_id == vcLexerKeywords[__SGE_OP]            ) { ret_string = "ApFloatUge"  ;} 
      else if(vc_op_id == vcLexerKeywords[__EQ_OP]            ) { ret_string = "ApFloatUeq"  ;} 
      else if(vc_op_id == vcLexerKeywords[__SLT_OP]            ) { ret_string = "ApFloatUlt"  ;} 
      else if(vc_op_id == vcLexerKeywords[__SLE_OP]            ) { ret_string = "ApFloatUle"  ;}
      else if(vc_op_id == vcLexerKeywords[__NEQ_OP]           ) { ret_string = "ApFloatUne"  ;} 
      else if(vc_op_id == vcLexerKeywords[__BITSEL_OP]        ) { ret_string = "ApBitsel"   ;} 
      else if(vc_op_id == vcLexerKeywords[__CONCAT_OP]        ) { ret_string = "ApConcat"   ;} 
      else if(vc_op_id == vcLexerKeywords[__FtoS_ASSIGN_OP]        ) { ret_string = "ApFloatToApIntSigned";}
      else if(vc_op_id == vcLexerKeywords[__FtoU_ASSIGN_OP]        ) { ret_string = "ApFloatToApIntUnsigned";}

      else { vcSystem::Error("unsupported float <-> int operation " + vc_op_id);}
    }
  if((in_type->Is("vcIntType") || in_type->Is("vcPointerType")) && out_type->Kind() == "vcFloatType")
    {
      if(vc_op_id == vcLexerKeywords[__ASSIGN_OP] ) { ret_string = "ApIntToApFloatUnsigned";}
      else if(vc_op_id == vcLexerKeywords[__StoF_ASSIGN_OP]        ) { ret_string = "ApIntToApFloatSigned";}
      else if(vc_op_id == vcLexerKeywords[__UtoF_ASSIGN_OP]        ) 
	{ 
	  ret_string = "ApIntToApFloatUnsigned";
	}      
      else { vcSystem::Error("unsupported int -> float operation " + vc_op_id);}
    }

  string q_ret_string = '"' + ret_string + '"';
  return(q_ret_string);
}


bool Check_If_Equivalent(vector<vcWire*>& iw1, vector<vcWire*>& iw2)
{
  bool ret_val = true;

  if(iw1.size() != iw2.size())
    return(false);
  
  for(int idx = 0; idx < iw1.size(); idx++)
    {
      vcWire* w1 = iw1[idx];
      vcWire* w2 = iw2[idx];
      
      if(w1->Get_Type()->Is_Int_Type() != w2->Get_Type()->Is_Int_Type())
	{
	  ret_val = false;
	  break;
	}

      if(w1->Is("vcConstantWire")  != w2->Is("vcConstantWire"))
	{
	  ret_val = false;
	  break;
	}

      if(w1->Get_Type()->Size() != w2->Get_Type()->Size())
	{
	  ret_val = false;
	  break;
	}
      
      if(!w1->Get_Type()->Is_Int_Type() && (w1->Get_Type() != w2->Get_Type()))
	{
	  ret_val = false;
	  break;
	}
    }
  
  return(ret_val);
}
