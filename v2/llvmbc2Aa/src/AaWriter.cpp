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

  AaWriter::AaWriter(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA, std::set<std::string>& mnames, bool consider_all_functions)
    : TD(_TD), AA(_AA), _module_names(mnames), _consider_all_functions(consider_all_functions)
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
	bool is_constant = isa<Constant>(eI.getPointerOperand());
	std::string root_name = to_aa(get_name(eI.getPointerOperand()));

	if(is_global)
	  {
	    llvm::GlobalVariable* gv = dyn_cast<llvm::GlobalVariable>(eI.getPointerOperand());
	    if(gv->isConstant())
	      {
		if(!is_used_in_module(*gv,_module_names,_consider_all_functions))
		  {
		    std::cerr << "Info: ignoring get-element-ptr to " 
			      << root_name 
			      << " since it is not (really) used in any function.." 
			      << std::endl;
		    return;
		  }
	      }
	  }

	// if this instruction is only used in IO calls, then it should be 
	// ignored.
	if(used_only_in_io_calls(eI))
	  {
	    std::cerr << "Info: ignoring get-element-ptr to " 
		      << root_name 
		      << " since it is used only in IO calls.." 
		      << std::endl;
	    return;
	  }

	// if it takes the reference of a constant string which is a pointer-id      
	// 	if(is_constant)
	// 	  {
	// 	    std::string port_name = to_aa(locate_portname_for_io_call(eI.getPointerOperand()));
	// 	    if(this->Is_Pipe(port_name))
	// 	      {
	// 		std::cerr << "Info: ignoring get-element-ptr to " 
	// 			  << root_name 
	// 			  << " since it points to a constant string which is a pipe-id" 
	// 			  << std::endl;
	// 		return;
	// 	      }
	// 	  }


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
		std::cout << prepare_operand(eI.getOperand(idx));
		std::cout << "]";
	      }
	  }
	else
	  {
	    for(int idx = 1; idx < eI.getNumOperands(); idx++)
	      {
		std::cout << "[";
		std::cout << prepare_operand(eI.getOperand(idx));
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

	if(isa<Constant>(v) && !isa<GlobalVariable>(v))	  
	  {
	    ret_string = "( $bitcast (" + get_aa_type_name(v->getType(),*_module) + " ) " + 
	      get_aa_constant_string(dyn_cast<Constant>(v)) + " ) ";
	  }
	else
	  ret_string = to_aa(get_name(v));

	return(ret_string);
      }
    else
      {
	std::cerr << "Warning: operands which are functions will be ignored" << std::endl;
	std::string op_name = to_aa(v->getNameStr() + "_ret_" + int_to_str(op_index));
	std::cout << op_name << ":= (($bitcast ($pointer<$void>) _b11111111111111111111111111111111)" << std::endl;

	op_index++;
	return(op_name);
      }
  }

  std::string AaWriter::get_name(llvm::Value* v)
  {
    std::string ret_string;
    if(v->getNameStr() != "")
      {
	ret_string = to_aa(v->getNameStr());
	if(isa<GlobalVariable>(v))
	  {
	    llvm::GlobalVariable* gv = dyn_cast<llvm::GlobalVariable>(v);
	    if(is_private_storage_object(gv))
	      {
		ret_string = this->_module->getModuleIdentifier() + "_iNtErNal_" + ret_string;
	      }
	  }
      }
    else
      {
	if(value_name_map.find(v) != value_name_map.end())
	  ret_string = (value_name_map[v]);
	else
	  {
	    std::string new_val = this->_module->getModuleIdentifier() + "_oBjEcT_" + int_to_str(value_name_map.size());
	    value_name_map[v] = new_val;
	    ret_string = to_aa(new_val);
	    v->setName(ret_string);
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

  void AaWriter::Print_Pipe_Declarations(std::ostream& ofile, std::map<std::string,int>& pipe_depths)
  {
    for(std::map<std::string,std::string>::iterator i = this->pipe_map.begin(), e = this->pipe_map.end();
	i != e;
	i++)
      {
	int pipe_depth = 1;
	std::map<std::string,int>::iterator miter = pipe_depths.find((*i).first);
	if(miter != pipe_depths.end())
	  {
	    pipe_depth = (*miter).second;
	  }
	ofile << "$pipe " << (*i).first << " : " << (*i).second << " $depth " << pipe_depth << std::endl;
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

  // the next three (write_storage_*) were moved from Utils.cpp to AaWriter.cpp
  // to make use of AaWriter functions such as get_name..
  void AaWriter::write_storage_object(llvm::GlobalVariable *G, 
				      std::vector<std::string>& init_obj_vector,
				      bool create_initializer,
				      bool skip_zero_initializers)
  {
    
    // if already printed, return
    if(printed_global_variables.find(G) != printed_global_variables.end())
      return;



    const llvm::Type *ptr = G->getType();
    std::string obj_name = to_aa(get_name(G));

    const llvm::PointerType* pptr = dyn_cast<PointerType>(G->getType());
    assert(pptr != NULL);
    const llvm::Type* el_type = pptr->getElementType();
    assert(el_type);
    std::string type_name = get_aa_type_name(el_type,*(_module)); 

    if(obj_name == "")
      {
	std::cerr << "Error: could not find name of storage object" << std::endl;
	obj_name = "UNKNOWN_STORAGE_OBJECT";
      }

    std::cout << "$storage " << to_aa(obj_name) << ":" << type_name << std::endl;
    printed_global_variables.insert(G);

    if (G->hasInitializer()) 
      {
	llvm::Constant *init = G->getInitializer();
	if(!isa<UndefValue>(init))
	  {
	    if(create_initializer)
	      {
		if(is_a_supported_constant(init))
		  {
		    if(!(is_zero(init) && skip_zero_initializers))
		      {
			std::string initializer_name = to_aa(obj_name + "_initializer_in_" + this->_module->getModuleIdentifier());
			init_obj_vector.push_back(initializer_name);
			  
			std::cerr << "Info: Initial value specified for " << obj_name << ": will create initializer module" << std::endl;
			std::cout << "$module [" << initializer_name << "] $in () $out () $is {" << std::endl;
			this->write_storage_initializer_statements(obj_name,init,skip_zero_initializers);
			std::cout << "$attribute nooptimize " << std::endl;
			std::cout << "}" << std::endl;

			// some new global variables may be referred to while printing
			// the initializers.  declare them.
			while(!global_variables_used_in_initialization.empty())
			  {
			    llvm::GlobalVariable* nG = *(global_variables_used_in_initialization.begin());
			    global_variables_used_in_initialization.erase(nG);

			    if(printed_global_variables.find(nG) == printed_global_variables.end())			    
			      {
				this->write_storage_object(nG,
							   init_obj_vector,
							   create_initializer,
							   skip_zero_initializers);
			      }
			  }
		      }
		  }
		else
		  {
		    std::cerr << "Warning: Unsupprted initial value specified for " << obj_name << ": will ignore it! " << std::endl;

		  }
	      }
	    else
	      {
		std::cerr << "Warning: Initial value specified for " << obj_name << " will be ignored" << std::endl;		
	      }
	  }
      }
  }

  void AaWriter::write_storage_initializer_statements(std::string& prefix, llvm::Constant* konst, bool skip_zero_initializers)
  {
    const llvm::Type *konst_type = konst->getType();

    if(isa<GlobalVariable>(konst))
      {
	llvm::GlobalVariable* gv = dyn_cast<GlobalVariable>(konst);
	std::cout << prefix << " := @(" << to_aa(this->get_name(gv)) << ")" <<  std::endl;
	global_variables_used_in_initialization.insert(gv);

	return;
      }

    if(isa<ConstantExpr>(konst))
      {
	llvm::ConstantExpr* ce = dyn_cast<ConstantExpr>(konst);
	unsigned opcode = ce->getOpcode();

	if(opcode == Instruction::GetElementPtr)
	  {
	    bool is_pointer = false;

	    llvm::Value *ptr = ce->getOperand(0);
	    const llvm::Type* ptr_type = ptr->getType();

	    const llvm::PointerType* pptr_type = dyn_cast<llvm::PointerType>(ptr_type);
	    const llvm::Type* pointed_type = pptr_type->getElementType();

	    is_pointer = isa<llvm::PointerType>(pointed_type);


	    if(is_pointer)
	      {
		std::cout << prefix << " := ";
	      }
	    else
	      std::cout << prefix << " := @(";


	    std::cout << get_name(ptr);

	    if(isa<GlobalVariable>(ptr))
	      {
		llvm::GlobalVariable* gv = dyn_cast<GlobalVariable>(ptr);
		global_variables_used_in_initialization.insert(gv);
	      }

	    if(!is_pointer)
	      {
		// skip the first, it must be zero.
		for (unsigned i = 2; i < ce->getNumOperands(); ++i)
		  std::cout << "[" << prepare_operand((llvm::Value*)ce->getOperand(i)) << "]";
	      }
	    else
	      {
		for (unsigned i = 1; i < ce->getNumOperands(); ++i)
		  std::cout << "[" << prepare_operand((llvm::Value*)ce->getOperand(i)) << "]";
	      }


	    if(!is_pointer)
	      std::cout << ")" << std::endl;
	  }
	else
	  {
	    std::cerr << "Warning: unsupported constant expression in storage initializer ";
	    ce->dump();
	    std::cerr << std::endl;
	  }
	return;
      }

    if(isa<ConstantInt>(konst) || isa<ConstantFP>(konst))
      {
	if(skip_zero_initializers && isa<ConstantInt>(konst))
	  {
	    if(is_zero(konst))
	      return;
	  }

	std::cout << prefix << " := " << get_aa_constant_string(konst) << std::endl;
      }
    else if(isa<ConstantPointerNull>(konst))
      {
	std::cout << prefix << " := "; 
	// NULL is mapped to all 1's.
	std::cout << "_b1111111111111111111111111111111111111111111111111111111111111111";
	std::cout << std::endl;
      }
    else if(isa<ConstantArray>(konst) || isa<ConstantVector>(konst) 
	    || isa<ConstantStruct>(konst))
      {
	int dim = konst->getNumOperands();
	for (unsigned int i = 0; i != konst->getNumOperands(); ++i) 
	  {
	    std::string forward_prefix = prefix + "[" +  int_to_str(i) + "]";
	    llvm::Value *el = konst->getOperand(i);
	    assert(isa<llvm::Constant>(el) && "constants expected here");
	    this->write_storage_initializer_statements(forward_prefix,cast<llvm::Constant>(el), skip_zero_initializers);
	  }
      }
    else if(isa<ConstantAggregateZero>(konst))
      {
	if(!skip_zero_initializers)
	  this->write_zero_initializer_recursive(prefix,konst->getType(),0);      
      }
    else
      {
	std::cerr << "Error: constant must be one of int/fp/array/struct/vector/aggregate-zero/pointer-null" 
		  << std::endl;
	std::cout << prefix << " := UNSUPPORTED_CONSTANT" << std::endl;
      }
  }


  void AaWriter::write_zero_initializer_recursive(std::string prefix,const llvm::Type* ptr, int depth)
  {

    if(isa<PointerType>(ptr) || isa<IntegerType>(ptr) )
      {
	std::cout << prefix << " := _b0" << std::endl;
      }
    else if(ptr->isFloatTy() || ptr->isDoubleTy())
      {
	std::cout << prefix << " := _f0.0e+0" << std::endl;
      }
    else if(isa<ArrayType>(ptr) || isa<VectorType>(ptr))
      {
	const llvm::SequentialType *ptr_seq = dyn_cast<llvm::SequentialType>(ptr);
	const llvm::Type* el_type = ptr_seq->getElementType();

	int dim = 0;
	const llvm::ArrayType* ptr_array = dyn_cast<llvm::ArrayType>(ptr);
	if(ptr_array != NULL)
	  dim = ptr_array->getNumElements();
	else
	  {
	    const llvm::VectorType* ptr_vec = dyn_cast<llvm::VectorType>(ptr);
	    dim = ptr_vec->getNumElements();
	  }

	std::cout << "$branchblock [zeroinit_" << depth << "] {" << std::endl;
	std::cout << "$merge $entry loopback " << std::endl;
	std::cout << "$phi I_" << depth << " :=  ($cast ($uint< "
		  << number_of_bits_needed_to_represent(dim) 
		  << " >) 0) $on $entry next_I $on loopback" << std::endl;
	std::cout << "$endmerge " << std::endl;
	std::cout << "next_I := (I_" << depth << " + 1)" << std::endl;
	std::string forward_prefix = prefix + "[I_" + int_to_str(depth) + "]";
	this->write_zero_initializer_recursive(forward_prefix, el_type,depth+1);
	std::cout << "$if (next_I < " << dim << ") $then $place [loopback] $else $null $endif" << std::endl;
	std::cout << "}" << std::endl;
      }
    else if(isa<StructType>(ptr))
      {
	const llvm::StructType *ptr_struct = dyn_cast<llvm::StructType>(ptr);
	for(int idx = 0; idx < ptr_struct->getNumElements(); idx++)
	  {
	    std::string forward_prefix = prefix + "[" + int_to_str(idx) + "]";
	    const llvm::Type* el_type = ptr_struct->getElementType(idx);
	    this->write_zero_initializer_recursive(forward_prefix, el_type,depth+1);
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
    
    AaWriterImpl(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA, std::set<std::string>& mnames, bool consider_all_functions)
      : AaWriter(_TD, _AA, mnames, consider_all_functions)
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
      std::vector<BasicBlock*> in_bbs;
      std::vector<llvm::Value*> in_vals;

      std::set<BasicBlock*> bb_set;

      
      // no repetitions on source label allowed in 
      // Aa (because of exclusivity)
      int num_sources = pnode.getNumIncomingValues();
      int real_sources = 0;
      for (unsigned i = 0; i < num_sources; i++) 
	{
	  BasicBlock *inbb = pnode.getIncomingBlock(i);
	  if(bb_set.find(inbb) == bb_set.end())
	    {
	      bb_set.insert(inbb);

	      llvm::Value *inval = pnode.getIncomingValue(i);
	      std::string source_op = prepare_operand(inval);

	      source_ops.push_back(source_op);
	      in_bbs.push_back(inbb);
	      in_vals.push_back(inval);


	      real_sources++;
	    }
	}

      std::cout << "$phi " << phi_name << " :=  ";
      BasicBlock* parent = pnode.getParent();
      for (unsigned i = 0; i < real_sources; i++) 
	{

	  BasicBlock *inbb = in_bbs[i];
	  llvm::Value *inval = in_vals[i];
	  std::string source_op = source_ops[i];
	  std::cout << "( $cast (" << get_aa_type_name(inval->getType(),*_module) 
		    << ") " << source_op << ") $on " << get_name(inbb) << "_"
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
	  if(_num_ret_instructions > 1)
	    std::cout << "stored_ret_val__ := " 
		      << ret_op << std::endl;
	  //else
	  //std::cout << "ret_val__ := " 
	  //      << ret_op << std::endl;
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
		  {
		    if(port_type_name != ret_type_name)
		      {
			std::cout << to_aa(C.getNameStr()) <<  " := " 
				  << "($bitcast (" << ret_type_name << " ) "
				  <<  portname << " ) " 
				  << std::endl;
		      }
		    else
		      {
			std::cout << to_aa(C.getNameStr()) <<  " := " 
				  <<  portname 
				  << std::endl;
			
		      }
		  }
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
		std::string wtype_name = get_aa_type_name(C.getArgOperand(1)->getType(), *_module);
		if(portname != "")
		  {
		    
		    if(port_type_name != wtype_name)
		      {
			std::cout << portname << " := " 
				  << "($bitcast ( " << port_type_name << " ) " 
				  << wname << " )"
				  << std::endl;
		      }
		    else
		      {
			std::cout << portname << " := "  << wname  << std::endl;
		      }
		  }
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
      
      std::string op_name = to_aa(get_name(L.getPointerOperand()));
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

      std::string ptr_name  = to_aa(get_name(S.getPointerOperand()));
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

AaWriter* AaWriter_New(llvm::TargetData *TD, llvm::AliasAnalysis *AA, std::set<std::string>& mnames, bool consider_all_functions)
{
  return new AaWriterImpl(TD, AA, mnames, consider_all_functions);
}
