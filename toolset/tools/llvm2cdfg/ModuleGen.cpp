#include "CDFGBuilder.hpp"
#include "Utils.hpp"
#include <CDFG/Printer.hpp>

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

#include <boost/lexical_cast.hpp>

namespace llvm {
  class AliasAnalysis;
}

namespace cdfg {
  class CDFG;
  void print(hls::Program *program);
}

using namespace llvm;
using namespace cdfg;
using namespace hls;

namespace {

  struct ModuleGenPass : public ModulePass {

    static char ID;
    ModuleGenPass() : ModulePass((intptr_t) &ID) {};
    
    virtual void getAnalysisUsage(AnalysisUsage &AU) const {
      AU.addRequired<AliasAnalysis>();
      AU.addRequired<TargetData>();
    }

    TargetData *TD;
    AliasAnalysis *AA;
    
    CDFGBuilder *cbuilder;
    
    CDFG *cdfg;
    BasicBlock *curr_block;

    bool isConstantUsed(const Constant *konst) const
    {
      for (llvm::Value::use_const_iterator UI = konst->use_begin(), E = konst->use_end();
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
      cbuilder = cdfg_builder_new(TD, AA);
      cbuilder->create_program(M.getModuleIdentifier());

      for (llvm::Module::global_iterator gi = M.global_begin(), ge = M.global_end();
           gi != ge; ++gi) {
        if (!is_ioport_identifier(*gi))
          cbuilder->create_addressable(*gi);
      }
  
      for (llvm::Module::iterator fi = M.begin(), fe = M.end();
           fi != fe;) {
    
        llvm::Function &f = *fi;
    
        if (fi->isDeclaration()) {
          std::cerr << "ModuleGen: dropping external function: "
                    << fi->getNameStr()
                    << "\n";
          ++fi;
          continue;
        }

        cbuilder->create_cdfg(f);
        ++fi;
      }

      for (llvm::Module::iterator fi = M.begin(), fe = M.end();
           fi != fe; ++fi) {
        runOnFunction(*fi);
      }

      cdfg::Printer printer;
      printer.print(cbuilder->program, ".cdfg.xml");
  
      return false; // we didn't touch anything
    }

    void runOnFunction(llvm::Function &F)
    {
      if (F.isDeclaration())
        return;
    
      cbuilder->initialise_with_function(F);

      std::set<BasicBlock*> blocks_queued;
      std::list<BasicBlock*> queue;
    
      queue.push_back(&(F.getEntryBlock()));
      blocks_queued.insert(&(F.getEntryBlock()));

      while (!queue.empty()) {
        BasicBlock *bb = queue.front();
        queue.pop_front();

        curr_block = bb;
        cbuilder->visit(bb);

        TerminatorInst *T = bb->getTerminator();
        for (unsigned i = 0, e = T->getNumSuccessors(); i != e; ++i) {
          BasicBlock *S = T->getSuccessor(i);
          if (blocks_queued.count(S) != 0)
            continue;
          queue.push_back(S);
          blocks_queued.insert(S);
        }
      }

      cbuilder->finalise_function();
    }

  };

  char ModuleGenPass::ID = 0;
  RegisterPass<ModuleGenPass> X("modulegen", "Generates AHIR XML");

} // end anonymous namespace

namespace cdfg {

  ModulePass* createModuleGenPass() { return new ModuleGenPass(); }
}

