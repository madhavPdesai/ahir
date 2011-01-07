#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcValue.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcOperator.hpp>


vcLoadStore::vcLoadStore(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data):vcSplitOperator(id)
{
  _memory_space = ms;
  _address = addr;
  _data = data;
}

vcLoad::vcLoad(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data):vcLoadStore(id,ms,addr,data) {}
void vcLoad::Print(ostream& ofile)
{

}
vcStore::vcStore(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data):vcLoadStore(id,ms,addr,data) {}
void vcStore::Print(ostream& ofile)
{
  //todo
}

vcPhi::vcPhi(string id, vector<vcWire*>& inwires, vcWire* outwire):vcRoot(id)
{
  assert(inwires.size() > 0 && outwire != NULL);

  // all wires must have the same type
  vcType* t = outwire->Get_Type();
  for(int idx = 0; idx < inwires.size(); idx++)
    assert(t == inwires[idx]->Get_Type());

  this->_inwires = inwires;
  this->_outwire = outwire;
  this->_ack = NULL;
}

void vcPhi::Set_Inreqs(vector<vcTransition*>& reqs)
{
  assert(reqs.size() == this->_inwires.size());
  this->_inreqs = reqs;
}

void vcPhi::Set_Ack(vcTransition* t)
{
  assert(this->_ack == NULL);
  assert(t->Get_Transition_Type() == _IN_TRANSITION);
  this->_ack = t;
}

void vcPhi::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__PHI] << " " << this->Get_Label() << " ";
  for(int idx = 0; idx < this->_inwires.size(); idx++)
    {
      ofile << this->_inwires[idx]->Get_Id() << " ";
    }
  ofile << vcLexerKeywords[__IMPLIES] << " " << this->_outwire->Get_Id();
  ofile << endl;
}

vcCall::vcCall(string id, vcModule* m, vector<vcWire*>& in_wires, vector<vcWire*> out_wires, bool inline_flag):vcSplitOperator(id)
{
  _called_module = m;
  _in_wires = in_wires;
  _out_wires = out_wires;
  _inline_flag = inline_flag;
}

void vcCall::Print(ostream& ofile)
{
  //todo
}

vcInport::vcInport(string id, string pipe_id, vcWire* w):vcIOport(id,pipe_id,w) {}
void vcInport::Print(ostream& ofile)
{
  //todo
}

vcOutport::vcOutport(string id, string pipe_id, vcWire* w):vcIOport(id,pipe_id,w) {}
void vcOutport::Print(ostream& ofile)
{
  //todo
}


vcUnarySplitOperator::vcUnarySplitOperator(string id, string op_id, vcWire* x, vcWire* z):vcSplitOperator(id)
{
  
  assert(x != NULL && z != NULL);
  
  this->_op_id = op_id;
  this->_x = x;
  this->_z = z;
}

void vcUnarySplitOperator::Print(ostream& ofile)
{
  ofile << this->_op_id << " "
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
  
  this->_x = x;
  this->_y = y;
  this->_z = z;
}

void vcBinarySplitOperator::Print(ostream& ofile)
{
  ofile << this->_op_id << " "
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

vcSelect::vcSelect(string id, vcWire* x, vcWire* y, vcWire* sel, vcWire* z):vcOperator(id)
{
  this->_x = x;
  this->_y = y;
  this->_sel = sel;
  this->_z = z;
}


void vcSelect::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__SELECT_OP] << " " 
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


vcBranch::vcBranch(string id, vcWire* twire): vcRoot(id) 
{
  _test = twire;
}

void vcBranch::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__BRANCH_OP] << " " << vcLexerKeywords[__LPAREN] << this->_test->Get_Id() << vcLexerKeywords[__RPAREN] << endl;
}
