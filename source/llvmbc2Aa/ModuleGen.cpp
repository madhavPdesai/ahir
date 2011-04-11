#include <llvm/Target/TargetData.h>
#include <llvm/Support/InstIterator.h>
#include <llvm/Instructions.h>
#include <llvm/Constants.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Module.h>
#include <llvm/GlobalVariable.h>
#include <llvm/Analysis/AliasAnalysis.h>

#include <sstream>
#include <list>
#include <set>
#include <iostream>
#include <fstream>
#include "AaWriter.hpp"
#include "Utils.hpp"

namespace llvm {
  class AliasAnalysis;
}


using namespace llvm;
using namespace Aa;


namespace {

  struct ModuleGenPass : public ModulePass {

    static char ID;
    ModuleGenPass() : ModulePass(ID) {};
    
    virtual void getAnalysisUsage(AnalysisUsage &AU) const {
      AU.addRequired<AliasAnalysis>();
      AU.addRequired<TargetData>();
    }

    TargetData *TD;
    AliasAnalysis *AA;
    BasicBlock *curr_block;
    AaWriter *aa_writer;

    bool isConstantUsed(const Constant *konst) const
    {
      for (llvm::Value::const_use_iterator UI = konst->use_begin(), E = konst->use_end();
           UI != E; ++UI) {
        const Constant *UC = dyn_cast<Constant>(*UI);
        if (UC == 0 || isa<GlobalValue>(UC))
          return true;
        
        if (isConstantUsed(UC))
          return true;
      }
      return false;
    }

    bool is_ioport_identifier(GlobalVariable &G)
    {
      bool is_ioport = true;
      
      for (llvm::Value::use_iterator ui = G.use_begin(), ue = G.use_end();
           ui != ue; ++ui) {
        User *user = *ui;
	
        if (BitCastInst *inst = dyn_cast<BitCastInst>(user)) {
          if (inst->getNumUses() > 1) {
            is_ioport = false;
            break;
          }
          
          IOCode ioc = get_io_code(*(inst->use_begin()));
          if (ioc == NOT_IO) {
            is_ioport = false;
            break;
          }
        } else {
          if (Constant *konst = dyn_cast<Constant>(user)) {
            if (!isConstantUsed(konst))
              continue;
          }
          
          is_ioport = false;
          break;
        }
      }
      return is_ioport;
    }

    bool runOnModule(llvm::Module &M)
    {
      TD = &getAnalysis<TargetData>();
      AA = &getAnalysis<AliasAnalysis>();
    
      aa_writer = AaWriter_New(TD, AA);  
      aa_writer->Set_Module(&M);

      for (llvm::Module::global_iterator gi = M.global_begin(), ge = M.global_end();
           gi != ge; ++gi) {
        if (!is_ioport_identifier(*gi))
	  {
	    // not if it is a pointer to a function
	    if(!(*gi).getType()->isFunctionTy())
	      write_storage_object(*gi,M);
	  }
      }

      
      for (llvm::Module::iterator fi = M.begin(), fe = M.end();
           fi != fe; ++fi) {
	aa_writer->Collect_Pipes(*fi);
      }

      aa_writer->Print_Pipe_Declarations(std::cout);
  
      for (llvm::Module::iterator fi = M.begin(), fe = M.end();
           fi != fe; ++fi) {
        runOnFunction(*fi);
      }

  
      return false; // we didn't touch anything
    }

    void runOnFunction(llvm::Function &F)
    {
      std::string fname = F.getNameStr();

      std::cerr<<"Info: visiting function " << fname << std::endl;

      aa_writer->clear();

      if (F.isDeclaration())
      {
	std::cerr<<"Info: ignoring external function " << fname << std::endl;
        return;
      }

      // scan the list of basic blocks and name them 
      // if they were not already named..
      int idx = 0;
      for(llvm::Function::iterator iter = F.begin(); iter != F.end(); ++iter)
	{
	  if((*iter).getNameStr() == "")
	    {
	      std::string bbname = "bb_" + int_to_str(idx);
	      (*iter).setName(bbname);
	    }

	  idx++;
	}

    
      //TODO: is this needed?
      //   cbuilder->initialise_with_function(F);

      // BFS to figure out predecessors of a block, since there
      // appears to be (?) no way of getting them from llvm.
      std::set<BasicBlock*> blocks_queued;
      std::list<BasicBlock*> queue;
    

      queue.push_back(&(F.getEntryBlock()));
      blocks_queued.insert(&(F.getEntryBlock()));
      int iidx = 0;

      while (!queue.empty()) 
	{
	  BasicBlock *bb = queue.front();
	  queue.pop_front();
	  
	  curr_block = bb;

	  aa_writer->name_all_instructions(*bb,iidx);
	  
	  TerminatorInst *T = bb->getTerminator();
	  if(T->getNumSuccessors() == 0)
	    {
	    }

	  for (unsigned i = 0, e = T->getNumSuccessors(); i != e; ++i) 
	    {
	      BasicBlock *S = T->getSuccessor(i);
	      aa_writer->add_bb_predecessor_map_entry(to_aa(S->getNameStr()),to_aa(bb->getNameStr()));

	      if (blocks_queued.count(S) != 0)
		continue;

	      queue.push_back(S);
	      blocks_queued.insert(S);
	    }
	}

      std::cout << "$module [" << fname << "] " << std::endl;

      std::cout << "// arguments" << std::endl;
	std::cout << " $in (";
	for(Function::arg_iterator args = F.arg_begin(), Eargs = F.arg_end();
		args != Eargs;
		++args)
	{
	  
	  std::cout << (*args).getNameStr() << " : "
		    << get_aa_type_name((*args).getType(), aa_writer->Get_Module()) << " ";
	}
	std::cout << ")" << std::endl;
	std::cout << " $out (";
	const llvm::Type* ret_type = F.getReturnType();
	bool has_ret_val = true;
	if(ret_type->isVoidTy())
	  has_ret_val = false;

	if(has_ret_val)
	   std::cout << "ret_val__ : " << get_aa_type_name(ret_type, aa_writer->Get_Module());
	std::cout << ")" << std::endl;

	std::cout << " $is " << std::endl<< "{" << std::endl;

	if(has_ret_val)
		std::cout << "$storage stored_ret_val__ : " << get_aa_type_name(ret_type, aa_writer->Get_Module()) << std::endl;

	
	std::cout << "$branchblock [" << fname << "] {"  << std::endl;

	// visit the basic blocks.. twice.
	for(llvm::Function::iterator iter = F.begin(); iter != F.end(); ++iter)
	  {
	    llvm::BasicBlock* pred = (*iter).getSinglePredecessor();
	    aa_writer->visit(*iter);
	  }
	
	if(aa_writer->Get_Return_Flag())
	  {
	    std::cout << "$merge return__ $endmerge" << std::endl;
	    if(has_ret_val)
	      std::cout << "ret_val__ := stored_ret_val__ "  << std::endl;
	  }
	
	std::cout << "}" << std::endl;
	
	std::cout << "}" << std::endl;
	
	//TODO: is this needed?
	// cbuilder->finalise_function();
    }
    
  };

  char ModuleGenPass::ID = 0;
  RegisterPass<ModuleGenPass> X("modulegen", "generates Aa description");

} // end anonymous namespace

namespace Aa {

  ModulePass* createModuleGenPass() { return new ModuleGenPass(); }
}

