#include <llvm/Constants.h>
#include <llvm/Function.h>
#include <llvm/Target/TargetData.h>
#include <llvm/User.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Support/CFG.h>
#include <llvm/Type.h>

#include <iostream>
#include <deque>

#include "AaWriter.hpp" 
#include "Utils.hpp"

using namespace llvm;

namespace llvm {
  class AliasAnalysis;
}

namespace Aa {

  AaWriter::AaWriter(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA)
    : TD(_TD), AA(_AA)
  {}

  void AaWriter::start_program(std::string id)
  {
	std::cerr << "Info: starting to write program " << id << std::endl;
  }

  void AaWriter::print_storage(llvm::GlobalVariable &G)
  {
	// get type etc.  do not allow initialized values
	// for now.
  }

  void AaWriter::visitInstruction(llvm::Instruction &I)
  {
    if(isa<llvm::GetElementPtrInst>(&I))
      {
	llvm::GetElementPtrInst& eI = static_cast<llvm::GetElementPtrInst&>(I);
	std::string inst_name = I.getNameStr();
	std::cout << inst_name << " := @(" ;

	bool is_alloca = isa<AllocaInst>(eI.getPointerOperand());
	std::string root_name = get_name(eI.getPointerOperand());
	std::cout << root_name;
	if(eI.getNumIndices() > 1)
	  {
	    if(is_alloca)
	      {
		for(int idx = 2; idx < eI.getNumOperands(); idx++)
		  {
		    std::cout << "[";
		    std::cout << get_name(eI.getOperand(idx));
		    std::cout << "]";
		  }
	      }
	    else
	      {
		for(int idx = 1; idx < eI.getNumOperands(); idx++)
		  {
		    std::cout << "[";
		    std::cout << get_name(eI.getOperand(idx));
		    std::cout << "]";
		  }
	      }
	  }
	std::cout << ")" << std::endl;
      }
    else
      {
	assert(0 && "unsupported instruction");
      }
  }

  std::string AaWriter::get_name(llvm::Value* v)
  {

    if(isa<llvm::Constant>(*v))
      {
	return(get_aa_constant_string(dyn_cast<Constant>(v)));
      }
    else
      {
	if(v->getNameStr() != "")
	  return(v->getNameStr());
	else
	  {
	    if(value_name_map.find(v) != value_name_map.end())
	      return(value_name_map[v]);
	    else
	      {
		std::string new_val = "v" + int_to_str(value_name_map.size());
		value_name_map[v] = new_val;
		return(new_val);
	      }
	  }
      }
  }
}

using namespace Aa;

namespace {

  struct BBNode
  {
    llvm::BasicBlock *bb;
    std::string id;

    // std::map<llvm::BasicBlock*, CDFGNode*> phi_forks;

    BBNode(const std::string &_id)
    {
      id = _id;
    }

  };
  
  struct AaWriterImpl : public AaWriter
  {

    /* ---- Initialisation ---- */
    
    AaWriterImpl(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA)
      : AaWriter(_TD, _AA)
    {
      this->clear();
    };


    void initialise_with_function(llvm::Function &F)
    {
    }

    void finalise_function()
    {
      clear();
    }

    void visitBasicBlock(BasicBlock &BB)
    {
      std::string bb_name = BB.getNameStr();
      std::cout << "//begin: basic-block " << bb_name << std::endl;

      // first name all instructions.
      int iidx = 0;
      for(llvm::BasicBlock::iterator iiter = BB.begin(),fiter = BB.end(); 
	  iiter != fiter;  ++iiter)
	{
	  if((*iiter).getNameStr() == "")
	    {
	      std::string iname = "I_" + int_to_str(iidx); 
	      (*iiter).setName(iname);
	      iidx++;

	    }
	}

      if(this->bb_predecessor_map[bb_name].size() > 0)
	{
	  std::cout << "$merge";
	  for(std::set<std::string>::iterator siter = this->bb_predecessor_map[bb_name].begin();
	      siter != this->bb_predecessor_map[bb_name].end();
	      siter++)
	    {
	      std::cout << " " << (*siter) << "_" << bb_name;
	    }
	  std::cout << std::endl;

	  // phi statements..
	  for(llvm::BasicBlock::iterator iiter = BB.begin(),fiter = BB.end(); 
	      iiter != fiter;  ++iiter)
	    {
	      if(isa<PHINode>(*iiter))
		{
		  Write_PHI_Node(static_cast<PHINode&>((*iiter)));
		}
	    }
	  std::cout << "$endmerge" << std::endl;

	}
      
    }

    void Write_PHI_Node(llvm::PHINode& pnode) 
    {
      std::string phi_name = pnode.getName();
      int num_sources = pnode.getNumIncomingValues();
      std::cout << "$phi " << phi_name << " :=  ";

      BasicBlock* parent = pnode.getParent();
      for (unsigned i = 0; i < num_sources; i++) 
	{
	  llvm::Value *inval = pnode.getIncomingValue(i);
	  BasicBlock *inbb = pnode.getIncomingBlock(i);
	  std::string val_id = this->get_name(inval);

	  std::cout << val_id << " $on " << inbb->getNameStr() << "_"
		    << parent->getNameStr() << " ";
	}
      std::cout << std::endl;
    }

    void visitBinaryOperator(BinaryOperator &I)
    {
      std::string iname = I.getName();
      
      std::string ntype;
      unsigned opcode = I.getOpcode();
      
      ntype = llvm_opcode_to_string(opcode);

      std::cout << iname << " := (";
      std::cout << get_name(I.getOperand(0)) << " " << ntype << " " << get_name(I.getOperand(1)) << ")" << std::endl;
    }

    void visitReturnInst(ReturnInst &R)
    {
	if(R.getReturnValue())
	{
		std::cout << "stored_ret_value__ := " 
			<< get_name(R.getReturnValue()) << std::endl;
	}
	std::cout << "$place [return__]" << std::endl;
	this->Set_Return_Flag(true);
    }
  
    void visitAllocaInst(AllocaInst &I)
    {
	std::string iname = I.getName();
	std::cerr << "//    In alloca " << iname << std::endl;

	const llvm::PointerType* ptr = dyn_cast<PointerType>(I.getType());
	const llvm::Type* el_type = ptr->getElementType();

	std::cout << "$storage " << iname << " : " << get_aa_type_name(el_type) << std::endl;
    }

    void visitPHINode(PHINode &P)
    {
      // already visited in the basic block
    }

    void visitCallInst(CallInst &C)
    {
	std::string cname = C.getName();
	const llvm::Function* called_function  = C.getCalledFunction();
	const llvm::Type* called_function_return_type = called_function->getReturnType();
	bool has_ret_val = true;

	std::cout << "$call " << called_function->getNameStr();
	std::cout << " (";
	for(int idx = 0; idx < C.getNumArgOperands(); idx++)
		std::cout << get_name(C.getArgOperand(idx)) << " ";
	std::cout << ") " ;

	std::cout << " (";
	if(has_ret_val)
		std::cout << C.getNameStr();
	std::cout << ")" << std::endl;
	
    }

    void visitCastInst(CastInst& C)
    {
	std::string cname = C.getName();
	std::cout << "//    In visitCastInst " << cname << std::endl;
    }

    void visitLoadInst(LoadInst &L)
    {
	std::string lname = L.getName();
	std::cout << lname << " := " ;

	bool is_alloca = isa<AllocaInst>(L.getPointerOperand());
	if(is_alloca)
		std::cout << get_name(L.getPointerOperand()) << std::endl;
	else
		std::cout << "->(" << get_name(L.getPointerOperand()) << ") " << std::endl;

    }

    void visitStoreInst(StoreInst &S)
    {
	std::string sname = S.getName();
	bool is_alloca = isa<AllocaInst>(S.getPointerOperand());
	if(is_alloca)
		std::cout << get_name(S.getPointerOperand()) << " := ";
	else
		std::cout << "->(" << get_name(S.getPointerOperand()) << ") := ";

	std::cout << get_name(S.getValueOperand()) << std::endl;
    }

    void visitCmpInst(CmpInst &C)
    {
	std::string cname = C.getName();

	std::string op1 = get_name(C.getOperand(0));
	std::string op2 = get_name(C.getOperand(1));

	std::cout << cname << " := " ;

	llvm::CmpInst::Predicate cmp_op = C.getPredicate();
	if(cmp_op == CmpInst::FCMP_OEQ || cmp_op == CmpInst::FCMP_UEQ || cmp_op == CmpInst::ICMP_EQ)
	  {
	    std::cout << "(" <<  op1 << " == " << op2 << " )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_OLT || cmp_op == CmpInst::FCMP_ULT || cmp_op == CmpInst::ICMP_ULT)
	  {
	    std::cout << "(" <<  op1 << " < " << op2 << " )" << std::endl;
	  }
	else if(cmp_op == CmpInst::ICMP_SLT)
	  {
	    int size = C.getOperand(0)->getType()->getScalarSizeInBits();
	    std::cout << "( ($cast ( $int<" << size << ">) "  <<  op1  << ") < " 
		      << "  ($cast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_OLE || cmp_op == CmpInst::FCMP_ULE || cmp_op == CmpInst::ICMP_ULE)
	  {
	    std::cout << "(" <<  op1 << " <= " << op2 << " )" << std::endl;
	  }
	else if(cmp_op == CmpInst::ICMP_SLE)
	  {
	    int size = C.getOperand(0)->getType()->getScalarSizeInBits();
	    std::cout << "( ($cast ( $int<" << size << ">) "  <<  op1  << ") <= " 
		      << "  ($cast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_OGT || cmp_op == CmpInst::FCMP_UGT || cmp_op == CmpInst::ICMP_UGT)
	  {
	    std::cout << "(" <<  op1 << " > " << op2 << " )" << std::endl;
	  }
	else if(cmp_op == CmpInst::ICMP_SGT)
	  {
	    int size = C.getOperand(0)->getType()->getScalarSizeInBits();
	    std::cout << "( ($cast ( $int<" << size << ">) "  <<  op1  << ") > " 
		      << " ($cast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_OGE || cmp_op == CmpInst::FCMP_UGE || cmp_op == CmpInst::ICMP_UGE)
	  {
	    std::cout << "(" <<  op1 << " >= " << op2 << " )" << std::endl;
	  }
	else if(cmp_op == CmpInst::ICMP_SGE)
	  {
	    int size = C.getOperand(0)->getType()->getScalarSizeInBits();
	    std::cout << "( ($cast ( $int<" << size << ">) "  <<  op1  << ") >= " 
		      << "  ($cast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_FALSE)
	  {
	    std::cout << "_b0" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_TRUE)
	  {
	    std::cout << "_b1" << std::endl;
	  }
	else
	  {
	    std::cerr << "Error: unsupported compare operation" << std::endl;
	  }
    }

    void visitSelectInst(SelectInst &S)
    {
	std::string sname = S.getName();
	std::cout << sname << " := ( $mux " << get_name(S.getCondition()) 
		  << " " << get_name(S.getTrueValue()) 
		  << " " << get_name(S.getFalseValue()) << ")" << std::endl;
    }

    void visitBranchInst(BranchInst &br)
    {
	std::string brname = br.getName();
	BasicBlock* from_bb = br.getParent();
	if(br.isUnconditional())
	  {

	    BasicBlock* to_bb = br.getSuccessor(0);
	    std::cout << "$place [" << from_bb->getNameStr() << "_" << to_bb->getNameStr() << "]" << std::endl;
	  }
	else
	  {
	    BasicBlock* dest0 = br.getSuccessor(0);
	    BasicBlock* dest1 = br.getSuccessor(1);
	    std::cout << "$if " << get_name(br.getCondition()) << " $then " ;
	    std::cout << " $place [" << from_bb->getNameStr() << "_" << dest0->getNameStr() << "] ";
	    std::cout << "$else ";
	    std::cout << "$place [" << from_bb->getNameStr() << "_" << dest1->getNameStr() << "] ";
	    std::cout << "$endif " << std::endl;
	  }
    }
  
  };
}

AaWriter* AaWriter_New(llvm::TargetData *TD, llvm::AliasAnalysis *AA)
{
  return new AaWriterImpl(TD, AA);
}
