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
	bool is_global = isa<GlobalVariable>(eI.getPointerOperand());
	std::string root_name = get_name(eI.getPointerOperand());

	// if it takes the reference of a constant string which is a pointer-id      
	if(is_global)
	  {
	    std::string port_name = to_aa(locate_portname_for_io_call(eI.getPointerOperand()));
	    if(this->pipe_map.find(port_name) != this->pipe_map.end())
	      {
		std::cerr << "Info: ignoring get-element-ptr to " 
			  << root_name 
			  << " since it points to a constant string which is a pipe-id" 
			  << std::endl;
		return;
	      }
	  }



	// get element-ptr is of this form
	//  a = p[i0][i1][i2]..[ik]
	//
	// p is always a pointer.  If it was declared
	// to point to a statically allocated or global
	// object a, then p is anchored to a particular value,
	// and we will treat p as the name of
	// the object, and in Aa, the reference will
	// be of the form
	//     &(a[i1][i2]...[ik])
	// because i0 must be 0. If i0 is not zero,
	// this would be an error because what does
	// p point to?
	//
	// if not declared in an alloca/global, then
	// p is a floating pointer, and can point to
	// "anything". Thus, we treat the reference
	// as an address calculation
	//   p[i0][i1]...[ik]
	//
	std::string inst_name = to_aa(I.getNameStr());
	std::cout << inst_name << " := @(" ;

	// if the ptr-operand corresponds to either an alloca
	// or a global, then this ptr must point to a declared
	// object.  
	bool is_alloca = isa<AllocaInst>(eI.getPointerOperand());

	std::cout << root_name;
	if(eI.getNumIndices() > 1)
	  {
	    if(is_alloca || is_global)
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
    std::string ret_string;
    if(isa<llvm::Constant>(*v))
      {
	ret_string = (get_aa_constant_string(dyn_cast<Constant>(v)));
      }
    else
      {
	if(v->getNameStr() != "")
	  ret_string = to_aa(v->getNameStr());
	else
	  {
	    if(value_name_map.find(v) != value_name_map.end())
	      ret_string = (value_name_map[v]);
	    else
	      {
		std::string new_val = "oBjEct_" + int_to_str(value_name_map.size());
		value_name_map[v] = new_val;
		ret_string = to_aa(new_val);
	      }
	  }
      }
    return(ret_string);
  }

  void AaWriter::Collect_Pipes(llvm::Function& F)
  {
    for(llvm::Function::iterator i = F.begin(), e = F.end(); i != e; ++i)
      {
	llvm::BasicBlock& bb = *i;
	for(llvm::BasicBlock::iterator bi = bb.begin(), be = bb.end(); bi != be; ++bi)
	  {
	    if(isa<CallInst>(*bi))
	      {
		CallInst& C = static_cast<CallInst&>(*bi);
		IOCode ioc = get_io_code(C);
		  
		if(!(ioc == NOT_IO))
		  {
		    std::string portname = to_aa(locate_portname_for_io_call(C.getArgOperand(0)));
		    assert(portname != "");
		      
		    std::string type_name = get_aa_type_name(ioc);
		    this->Add_Pipe(portname,type_name);
		  }
	      }
	  }
      } 
  }

  void AaWriter::Add_Pipe(std::string portname, std::string type_name)
  {
    if(this->pipe_map.find(portname) == this->pipe_map.end())
      {
	this->pipe_map[portname] = type_name;
      }
    else
      {
	std::string old_type_name = this->pipe_map[portname];
	if(old_type_name != type_name)
	  {
	    std::cerr << "Error: conflicting types for pipe " << portname << std::endl;
	  }
      }
  }

  void AaWriter::Print_Pipe_Declarations(std::ostream& ofile)
  {
    for(std::map<std::string,std::string>::iterator i = this->pipe_map.begin(), e = this->pipe_map.end();
	i != e;
	i++)
      {
	ofile << "$pipe " << (*i).first << " : " << (*i).second << std::endl;
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
      std::string bb_name = to_aa(BB.getNameStr());
      std::cout << "//begin: basic-block " << bb_name << std::endl;

      // first name all instructions.
      int iidx = 0;
      for(llvm::BasicBlock::iterator iiter = BB.begin(),fiter = BB.end(); 
	  iiter != fiter;  ++iiter)
	{
	  if((*iiter).getNameStr() == "")
	    {
	      std::string iname = "iNsTr_" + int_to_str(iidx); 
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
	      std::cout << " " << to_aa(*siter) << "_" << to_aa(bb_name);
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
      std::string phi_name = to_aa(pnode.getNameStr());
      int num_sources = pnode.getNumIncomingValues();
      std::cout << "$phi " << phi_name << " :=  ";

      BasicBlock* parent = pnode.getParent();
      for (unsigned i = 0; i < num_sources; i++) 
	{
	  llvm::Value *inval = pnode.getIncomingValue(i);
	  BasicBlock *inbb = pnode.getIncomingBlock(i);
	  std::string val_id = this->get_name(inval);

	  std::cout << "( $cast (" << get_aa_type_name(inval->getType()) 
		    << ") " << val_id << ") $on " << get_name(inbb) << "_"
		    << get_name(parent) << " ";
	}
      std::cout << std::endl;
    }

    void visitBinaryOperator(BinaryOperator &I)
    {
      std::string iname = to_aa(I.getNameStr());
      
      std::string ntype;
      unsigned opcode = I.getOpcode();
      
      ntype = llvm_opcode_to_string(opcode);
      std::string op1 = get_name(I.getOperand(0));
      std::string op2 = get_name(I.getOperand(1));

      // TODO: if binary operator is shra then need to cast 
      //       the operands to $int!
      if(opcode == Instruction::AShr)
	{
	    int size = I.getType()->getScalarSizeInBits();
	    std::cout << iname << " :=  ( ($cast ( $int<" << size << ">) "  <<  op1  << ") "
		      << ntype 
		      << "  ($cast ( $int<" << size << ">) "  <<   op2 << " ) )" 
		      << std::endl;
	}
      else
	{
	  std::cout << iname << " := (";
	  std::cout << op1 << " " << ntype << " " << op2 << ")" << std::endl;
	}
    }


    void visitReturnInst(ReturnInst &R)
    {
	if(R.getReturnValue())
	{
		std::cout << "stored_ret_val__ := " 
			<< get_name(R.getReturnValue()) << std::endl;
	}
	std::cout << "$place [return__]" << std::endl;
	this->Set_Return_Flag(true);
    }
  
    void visitAllocaInst(AllocaInst &I)
    {
      std::string iname = to_aa(I.getNameStr());
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
      std::string cname = to_aa(C.getNameStr());

	IOCode ioc = get_io_code(C);
	if(ioc == NOT_IO)
	  {
	    const llvm::Function* called_function  = C.getCalledFunction();
	    const llvm::Type* called_function_return_type = called_function->getReturnType();

	    bool has_ret_val = true;
	    if(C.getType()->isVoidTy())
	      has_ret_val = false;
	    
	    std::cout << "$call " << to_aa(called_function->getNameStr());
	    std::cout << " (";
	    for(int idx = 0; idx < C.getNumArgOperands(); idx++)
	      std::cout << get_name(C.getArgOperand(idx)) << " ";
	    std::cout << ") " ;
	    
	    std::cout << " (";
	    if(has_ret_val)
	      std::cout << to_aa(C.getNameStr());
	    std::cout << ")" << std::endl;
	  }
	else
	  {
	    std::string portname = to_aa(locate_portname_for_io_call(C.getArgOperand(0)));
	    if(ioc == READ_FLOAT32 || ioc == READ_UINT32)
	      {
		std::cout << to_aa(C.getNameStr()) <<  " := " <<  portname << std::endl;
	      }
	    else 
	      {
		std::string wname = get_name(C.getArgOperand(1));
		std::cout << portname << " := " << wname << std::endl;
	      }
	  }
    }

    void visitCastInst(CastInst& C)
    {
      // TODO: i/o port stuff..
      std::string cname = to_aa(C.getNameStr());
      std::cout << "//    In visitCastInst " << cname << std::endl;
      const llvm::Type *dest = C.getDestTy();
      llvm::Value *val = C.getOperand(0);
      
      std::cout << cname << " := ($cast (" << get_aa_type_name(dest) << ") "  << get_name(val) << ")"
		<< std::endl;
    }

    void visitLoadInst(LoadInst &L)
    {
      std::string lname = to_aa(L.getNameStr());
      std::cout << lname << " := " ;
      
      bool is_alloca = isa<AllocaInst>(L.getPointerOperand());
      bool is_global = isa<GlobalVariable>(L.getPointerOperand());
      if(is_alloca || is_global)
	std::cout << get_name(L.getPointerOperand()) << std::endl;
      else
	std::cout << "->(" << get_name(L.getPointerOperand()) << ") " << std::endl;
      
    }

    void visitStoreInst(StoreInst &S)
    {
      std::string sname = to_aa(S.getNameStr());
      
      bool is_alloca = isa<AllocaInst>(S.getPointerOperand());
      bool is_global = isa<GlobalVariable>(S.getPointerOperand());
      if(is_alloca || is_global)
	std::cout << get_name(S.getPointerOperand()) << " := ";
      else
	std::cout << "->(" << get_name(S.getPointerOperand()) << ") := ";
      
      std::cout << get_name(S.getValueOperand()) << std::endl;
    }
    
    void visitCmpInst(CmpInst &C)
    {
      std::string cname = to_aa(C.getNameStr());

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
      std::string sname = to_aa( S.getNameStr());
      std::cout << sname << " := ( $mux " << get_name(S.getCondition()) 
		<< " " << get_name(S.getTrueValue()) 
		<< " " << get_name(S.getFalseValue()) << ")" << std::endl;
    }

    void visitBranchInst(BranchInst &br)
    {
      std::string brname = to_aa(br.getNameStr());
      BasicBlock* from_bb = br.getParent();
	if(br.isUnconditional())
	  {

	    BasicBlock* to_bb = br.getSuccessor(0);
	    std::cout << "$place [" << get_name(from_bb) << "_" << get_name(to_bb) << "]" << std::endl;
	  }
	else
	  {
	    BasicBlock* dest0 = br.getSuccessor(0);
	    BasicBlock* dest1 = br.getSuccessor(1);
	    std::cout << "$if " << get_name(br.getCondition()) << " $then " ;
	    std::cout << " $place [" << get_name(from_bb) << "_" << get_name(dest0) << "] ";
	    std::cout << "$else ";
	    std::cout << "$place [" << get_name(from_bb) << "_" << get_name(dest1) << "] ";
	    std::cout << "$endif " << std::endl;
	  }
    }
  
  };
}

AaWriter* AaWriter_New(llvm::TargetData *TD, llvm::AliasAnalysis *AA)
{
  return new AaWriterImpl(TD, AA);
}
