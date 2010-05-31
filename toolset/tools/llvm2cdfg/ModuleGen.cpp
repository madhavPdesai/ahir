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

    bool runOnModule(llvm::Module &M)
    {
      TD = &getAnalysis<TargetData>();
      AA = &getAnalysis<AliasAnalysis>();
      cbuilder = cdfg_builder_new(TD, AA);
      cbuilder->create_program(M.getModuleIdentifier());
  
      for (llvm::Module::global_iterator gi = M.global_begin(), ge = M.global_end();
           gi != ge; ++gi) {
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
      cbuilder->initialise_with_function(F);
      
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

