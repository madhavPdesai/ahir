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
	std::string root_name = to_aa(get_name(eI.getPointerOperand()));

	// if it takes the reference of a constant string which is a pointer-id      
	if(is_global)
	  {
	    //	    std::string port_name = to_aa(locate_portname_for_io_call(eI.getPointerOperand()));
	    if(this->Is_Pipe(root_name))
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
	//     @(a[i1][i2]...[ik])
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

	if(is_global)
	  {
	    std::cout << inst_name << " := @(" ;
	  }
	else
	  {
	    std::cout << inst_name << " := " ;
	  }

	std::cout << root_name;

	if(is_global)
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

	if(is_global)
	  std::cout << ")" << std::endl;
	else
	  std::cout << std::endl;
      }
    else 
      {
	std::cerr << "Error: unsupported instruction " << std::endl;
	I.dump();
	std::cerr << std::endl;
      }
  }

  std::string AaWriter::prepare_operand(llvm::Value* v)
  {
    int op_index = 0;

    if(!isa<Function>(v))
      {
	std::string ret_string;

	if(isa<Constant>(v))
	  {
	    ret_string = "( $bitcast (" + get_aa_type_name(v->getType(),*_module) + " ) " + get_name(v) + " ) ";
	  }
	else
	  ret_string = get_name(v);

	return(ret_string);
      }
    else
      {
	std::cerr << "Warning: operands which are functions will be ignored" << std::endl;
	std::string op_name = v->getNameStr() + "_ret_" + int_to_str(op_index);
	std::cout << op_name << ":= (($bitcast ($pointer<$void>) _b11111111111111111111111111111111)" << std::endl;

	op_index++;
	return(op_name);
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
		v->setName(ret_string);
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
		    if(portname != "")
		      {
			std::string type_name;
			type_name = get_aa_type_name(ioc);
			this->Add_Pipe(portname,type_name);
		      }
		  }
	      }
	  }
      } 
  }

  bool AaWriter::Is_Pipe(std::string port_name)
  {
    return(this->pipe_map.find(port_name) != this->pipe_map.end());
  }

  void AaWriter::Add_Pipe(std::string portname, std::string type_name)
  {
    if(this->pipe_map.find(portname) == this->pipe_map.end())
      {
	this->pipe_map[portname] = type_name;
	std::cerr << "Info: added pipe " << portname << " with type " << type_name << std::endl;
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

  void AaWriter::name_all_instructions(llvm::BasicBlock &BB, int& iidx)
  {

    // first name all instructions.
    for(llvm::BasicBlock::iterator iiter = BB.begin(),fiter = BB.end(); 
	iiter != fiter;  ++iiter)
      {
	if((*iiter).getNameStr() == "")
	  {
           if (!iiter->getType()->isVoidTy()) {
	     std::string iname = "iNsTr_" + int_to_str(iidx); 
	     (*iiter).setName(iname);
	   }
	   iidx++;
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
      std::string bb_name = to_aa(BB.getNameStr());
      std::cout << "//begin: basic-block " << bb_name << std::endl;

      // the alloca objects.
      for(llvm::BasicBlock::iterator iiter = BB.begin(),fiter = BB.end(); 
	  iiter != fiter;  ++iiter)
	{
	  if(isa<AllocaInst>(*iiter))
	    {
	      llvm::AllocaInst& I = static_cast<AllocaInst&>(*iiter);
	      std::string iname = to_aa(I.getNameStr());
	      const llvm::PointerType* ptr = dyn_cast<PointerType>(I.getType());
	      const llvm::Type* el_type = ptr->getElementType();
      
	      std::cout << "$storage " 
			<< iname << "_alloc : " << get_aa_type_name(el_type,*_module) << std::endl;

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
      std::vector<std::string> source_ops;
      int num_sources = pnode.getNumIncomingValues();
      for (unsigned i = 0; i < num_sources; i++) 
	source_ops.push_back(prepare_operand(pnode.getIncomingValue(i)));

      std::cout << "$phi " << phi_name << " :=  ";

      BasicBlock* parent = pnode.getParent();
      for (unsigned i = 0; i < num_sources; i++) 
	{
	  llvm::Value *inval = pnode.getIncomingValue(i);
	  BasicBlock *inbb = pnode.getIncomingBlock(i);

	  std::cout << "( $cast (" << get_aa_type_name(inval->getType(),*_module) 
		    << ") " << source_ops[i] << ") $on " << get_name(inbb) << "_"
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
      std::string op1 = prepare_operand(I.getOperand(0));
      std::string op2 = prepare_operand(I.getOperand(1));

      // if binary operator is shra then need to cast 
      //       the operands to $int!
      if(opcode == Instruction::AShr)
	{
	  int size = type_width(I.getType(), this->Get_Pointer_Width());

	    // take it to int and back to uint...
	    std::cout << iname << " :=  ($bitcast ($uint<" << size << ">) ( ($bitcast ( $int<" << size << ">) "  <<  op1  << ") "
		      << ntype 
		      << "  ($bitcast ( $int<" << size << ">) "  <<   op2 << " )))" 
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
	  std::string ret_op = prepare_operand(R.getReturnValue());
	  std::cout << "stored_ret_val__ := " 
		    << ret_op << std::endl;
	}
	std::cout << "$place [return__]" << std::endl;
	this->Set_Return_Flag(true);
    }
  
    void visitAllocaInst(AllocaInst &I)
    {
      std::string iname = to_aa(I.getNameStr());
      const llvm::PointerType* ptr = dyn_cast<PointerType>(I.getType());
      const llvm::Type* el_type = ptr->getElementType();
      
      std::cout << iname << " := @(" << iname << "_alloc)" << std::endl;
    }

    void visitPHINode(PHINode &P)
    {
      // already visited in the basic block
    }

    void visitCallInst(CallInst &C)
    {
      std::string cname = to_aa(C.getNameStr());
      const llvm::Function* called_function  = C.getCalledFunction();
      if(called_function == NULL)
	{
	  const llvm::Value* called_function_pointer = C.getCalledValue();
	  if(isa<Constant>(called_function_pointer))
	    {
	      std::cerr << "Info: indirect function call instruction " << cname << " looking for called function.." << std::endl;
	      const ConstantExpr* ce =  dyn_cast<ConstantExpr>(called_function_pointer);
	      if(ce != NULL)
		{
		  if(ce->isCast())
		    {
		      llvm::Value* cast_op = ce->getOperand(0);
		      if((called_function = dyn_cast<Function>(cast_op)) != NULL)
			{
			  std::cerr << "Info: found function " << called_function->getNameStr() <<
			    " as target of indirect function call instruction " << cname << std::endl;
			}
		    }
		}
	    }
	}

      if(called_function == NULL)
	{
	  std::cerr << "Error: unsupported indirect function call instruction " << cname << std::endl;  
	}
      
      const llvm::Type* called_function_return_type = called_function->getReturnType();
      std::string ret_type_name = get_aa_type_name(called_function_return_type,*_module);
      
      IOCode ioc = get_io_code(C);
      if(ioc == NOT_IO)
	  {
	    
	    bool has_ret_val = true;
	    if(C.getType()->isVoidTy())
	      has_ret_val = false;
	    
	    std::vector<const llvm::Type*>  argument_types;
	    std::vector<std::string>  argument_names;
	    for(llvm::Function::const_arg_iterator args = (*called_function).arg_begin(), 
		  Eargs = (*called_function).arg_end();
		args != Eargs;
		++args)
	      {
		argument_types.push_back((*args).getType());
	      }

	    for(int idx = 0; idx < C.getNumArgOperands(); idx++)
	      {
		argument_names.push_back(prepare_operand(C.getArgOperand(idx)));
	      }

	    std::string fname = to_aa(called_function->getNameStr());
	    std::cout << "$call " << fname ;
	    std::cout << " (";
	    for(int idx = 0; idx < C.getNumArgOperands(); idx++)
	      {
		const llvm::Type* arg_type = (idx < argument_types.size() ? argument_types[idx] : NULL);

		if(arg_type == NULL || (arg_type == C.getArgOperand(idx)->getType()))
		  std::cout << argument_names[idx] << " ";
		else
		  {
		    std::cout << "($bitcast (" << get_aa_type_name(C.getArgOperand(idx)->getType(),
								   *_module)
			      << ") "
			      << argument_names[idx] << ") ";
		  }
	      }
	    std::cout << ") " ;
	    
	    std::cout << " (";
	    if(has_ret_val)
	      std::cout << to_aa(C.getNameStr());
	    std::cout << ")" << std::endl;
	  }
	else
	  {
	    std::string portname = to_aa(locate_portname_for_io_call(C.getArgOperand(0)));
	    std::string port_type_name = this->pipe_map[portname];

	    if(is_io_read(ioc))
	      {
		if(portname != "")
		  std::cout << to_aa(C.getNameStr()) <<  " := " 
			    << "($bitcast (" << ret_type_name << " ) "
			    <<  portname << " ) " 
			    << std::endl;
		else
		  {
		    std::cerr << "Error: call statement " << to_aa(C.getNameStr())
			      << " is an io read, but the port name is not statically known"
			      << std::endl;
		    C.dump();
		    std::cerr << std::endl;

		    std::cout << "// ERROR: io-read tied to 0, because it is not possible to id the pipe" 
			      << std::endl;
		    std::cout << to_aa(C.getNameStr()) <<  " := " <<  get_zero_value(C.getType())
			      << std::endl;
		  }
		
	      }
	    else 
	      {
		std::string wname = prepare_operand(C.getArgOperand(1));
		if(portname != "")
		  std::cout << portname << " := " 
			    << "($bitcast ( " << port_type_name << " ) " 
			    << wname << " )"
			    << std::endl;
		else
		  {
		    std::cerr << "Warning: call statement " << to_aa(C.getNameStr())
			      << " is an io write, but the port name is not statically known"
			      << std::endl;
		    C.dump();
		    std::cout << "// ERROR: io-write ignored, because it is not possible to id the pipe" 
			      << std::endl;
		  }
	      }
	  }
    }

    void visitSExtInst(SExtInst& C)
    {
      std::string cname = to_aa(C.getNameStr());

      const llvm::Type *dest = C.getDestTy();
      int size = type_width(dest, this->Get_Pointer_Width());

      llvm::Value *val = C.getOperand(0);
      std::string op_name = prepare_operand(val);
      std::cout << cname << " := " ;
      // cout = (bit-cast uint) ((int) val)
      std::cout << " ($bitcast (" << get_aa_type_name(dest,*_module) << ") ( $cast ("  
		<< "$int< " << size << " > ) " 
		<< op_name << ") )"
		<< std::endl;	  

    }

    void visitSIToFPInst(SIToFPInst& C)
    {
      std::string cname = to_aa(C.getNameStr());

      const llvm::Type *dest = C.getDestTy();

      int size = type_width(dest, this->Get_Pointer_Width());

      llvm::Value *val = C.getOperand(0);
      std::string op_name = prepare_operand(val);

      std::cout << cname << " := ";
      // cout = ((destType) ((bitcast int) val)) 
      std::cout << " ( $cast ("  
		<< get_aa_type_name(dest,*_module) << ") "  
		<<  " ( $bitcast ( $int< " 
		<< size << " > ) " 
		<< op_name 
		<< ") ) "
		<< std::endl;	  
    }

    void visitFPToSIInst(FPToSIInst& C)
    {
      std::string cname = to_aa(C.getNameStr());

      const llvm::Type *dest = C.getDestTy();

      int size = type_width(dest, this->Get_Pointer_Width());

      llvm::Value *val = C.getOperand(0);
      std::string op_name = prepare_operand(val);

      std::cout << cname << " := ";
      // cout = (bitcast uint) ((int) val) 
      std::cout << "( $bitcast (" << get_aa_type_name(dest,*_module) << " ) " 
		<< "( $cast ( $int< " << size << " > ) " 
		<< op_name << ") )" << std::endl; 
    }

    void visitCastInst(CastInst& C)
    {
      // TODO: i/o port stuff..
      std::string cname = to_aa(C.getNameStr());

      const llvm::Type *dest = C.getDestTy();

      int size = type_width(dest, this->Get_Pointer_Width());

      llvm::Value *val = C.getOperand(0);
      std::string op_name = prepare_operand(val);

      std::cout << cname << " := ($cast (" 
		<< get_aa_type_name(dest,*_module) << ") "  << op_name << ")"
		<< std::endl;
    }

    void visitLoadInst(LoadInst &L)
    {
      std::string lname = to_aa(L.getNameStr());
      std::cout << "// load " << std::endl;

      std::cout << lname << " := " ;
      
      bool is_global = isa<GlobalVariable>(L.getPointerOperand());

      if(isa<UndefValue>(L.getPointerOperand()))
	{
	  std::cerr << "Warning: load with undef pointer" << std::endl;
	  std::cout << "// load with undef pointer" << std::endl;
	  std::cout << get_zero_value(L.getType()) << std::endl;

	  return;
	}
      
      std::string op_name = prepare_operand(L.getPointerOperand());
      if(is_global)
	std::cout << op_name << std::endl;
      else
	std::cout << "->(" << op_name << ") " << std::endl;
      
    }

    void visitStoreInst(StoreInst &S)
    {
      std::string sname = to_aa(S.getNameStr());
      
      bool is_global = isa<GlobalVariable>(S.getPointerOperand());

      if((isa<UndefValue>(S.getPointerOperand())) ||
	 (isa<UndefValue>(S.getValueOperand())))
	{
	  std::cerr << "Warning: ignoring store with undef pointer or value" << std::endl;
	  std::cout << "// skipped with undef pointer and/or value" << std::endl;
	  return;
	}

      std::string ptr_name = prepare_operand(S.getPointerOperand());
      std::string data_name = prepare_operand(S.getValueOperand());
      if(is_global)
	std::cout << ptr_name << " := ";
      else
	std::cout << "->(" << ptr_name << ") := ";
      
      std::cout << data_name << std::endl;
    }
    
    void visitCmpInst(CmpInst &C)
    {
      std::string cname = to_aa(C.getNameStr());

      std::string op1 = prepare_operand(C.getOperand(0));
      std::string op2 = prepare_operand(C.getOperand(1));

	if((op1 == "") | (op2 == ""))
	{
		std::cerr << "Error: anonymous operand in compare instruction " << cname << 			std::endl;
	}

	std::cout << "// compare instruction" << std::endl;

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
	    int size = type_width(C.getOperand(0)->getType(), this->Get_Pointer_Width());
	    std::cout << "( ($bitcast ( $int<" << size << ">) "  <<  op1  << ") < " 
		      << "  ($bitcast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_OLE || cmp_op == CmpInst::FCMP_ULE || cmp_op == CmpInst::ICMP_ULE)
	  {
	    std::cout << "(" <<  op1 << " <= " << op2 << " )" << std::endl;
	  }
	else if(cmp_op == CmpInst::ICMP_SLE)
	  {

	    int size = type_width(C.getOperand(0)->getType(), this->Get_Pointer_Width());
	    std::cout << "( ($bitcast ( $int<" << size << ">) "  <<  op1  << ") <= " 
		      << "  ($bitcast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_OGT || cmp_op == CmpInst::FCMP_UGT || cmp_op == CmpInst::ICMP_UGT)
	  {
	    std::cout << "(" <<  op1 << " > " << op2 << " )" << std::endl;
	  }
	else if(cmp_op == CmpInst::ICMP_SGT)
	  {
	    int size = type_width(C.getOperand(0)->getType(), this->Get_Pointer_Width());
	    std::cout << "( ($bitcast ( $int<" << size << ">) "  <<  op1  << ") > " 
		      << " ($bitcast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_OGE || cmp_op == CmpInst::FCMP_UGE || cmp_op == CmpInst::ICMP_UGE)
	  {
	    std::cout << "(" <<  op1 << " >= " << op2 << " )" << std::endl;
	  }
	else if(cmp_op == CmpInst::ICMP_SGE)
	  {

	    int size = type_width(C.getOperand(0)->getType(), this->Get_Pointer_Width());
	    std::cout << "( ($bitcast ( $int<" << size << ">) "  <<  op1  << ") >= " 
		      << "  ($bitcast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::ICMP_NE)
	  {

	    int size = type_width(C.getOperand(0)->getType(), this->Get_Pointer_Width());
	    std::cout << "( ($bitcast ( $int<" << size << ">) "  <<  op1  << ") != " 
		      << "  ($bitcast ( $int<" << size << ">) "  <<   op2 << " ) )" << std::endl;
	  }
	else if(cmp_op == CmpInst::FCMP_UNE || cmp_op == CmpInst::FCMP_ONE)
	  {
	    std::cout << "(" <<  op1 << " != " << op2 << " )" << std::endl;
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
      std::string sel_name = prepare_operand(S.getCondition());
      std::string true_name = prepare_operand(S.getTrueValue());
      std::string false_name = prepare_operand(S.getFalseValue());

      std::cout << sname << " := ( $mux " << sel_name
		<< " " << true_name
		<< " " << false_name << ")" << std::endl;
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
	    std::string cond_name = prepare_operand(br.getCondition());

	    std::cout << "$if " << cond_name << " $then " ;
	    std::cout << " $place [" << get_name(from_bb) << "_" << get_name(dest0) << "] ";
	    std::cout << "$else ";
	    std::cout << "$place [" << get_name(from_bb) << "_" << get_name(dest1) << "] ";
	    std::cout << "$endif " << std::endl;
	  }
    }

    void visitSwitchInst(llvm::SwitchInst &I) 
    { 
      llvm::Value* test_val = I.getCondition();
      std::string test_op = prepare_operand(test_val);
      BasicBlock* from_bb = I.getParent();
      BasicBlock* to_bb = NULL;
      std::cout << "$switch " << test_op << std::endl;
      for(int idx=1; idx < I.getNumCases(); idx++)
	{
	  std::cout << "$when " << get_aa_constant_string(I.getCaseValue(idx)) << " $then " << std::endl;
	  to_bb = I.getSuccessor(idx);
	  std::cout << "$place [" << get_name(from_bb) << "_" << get_name(to_bb) << "]" << std::endl;
	}
      std::cout << "$default " << std::endl;
      to_bb = I.getSuccessor(0);
      std::cout << "$place [" << get_name(from_bb) << "_" << get_name(to_bb) << "]" << std::endl;
      std::cout << "$endswitch" << std::endl;
    }
  
  };
}

AaWriter* AaWriter_New(llvm::TargetData *TD, llvm::AliasAnalysis *AA)
{
  return new AaWriterImpl(TD, AA);
}
