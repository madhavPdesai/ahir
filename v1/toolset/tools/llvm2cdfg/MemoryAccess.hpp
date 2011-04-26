#ifndef __MEMORYACCESS_HPP__
#define __MEMORYACCESS_HPP__

#include <map>
#include <set>
#include <vector>

namespace llvm {
  class AliasAnalysis;
  class TargetData;
  class Instruction;
  class LoadInst;
  class StoreInst;
  class CallInst;
  class TerminatorInst;
}

namespace cdfg {

  class CDFGBuilder;

  struct AccessAnalysis {

    void handleInstruction(llvm::Instruction *inst);

    AccessAnalysis(llvm::AliasAnalysis *_AA
		   , llvm::TargetData *_TD
		   , CDFGBuilder *_CB);

    llvm::AliasAnalysis *AA;
    llvm::TargetData *TD;
    CDFGBuilder *cbuilder;
    
    typedef std::set<llvm::Instruction*> SI;
    typedef std::vector<llvm::Instruction*> VI;

    std::map<llvm::Instruction*, SI> closure;
    SI roots;

    void insert_edge(llvm::Instruction *pred, llvm::Instruction *succ);
    bool aliases(llvm::Instruction *a, llvm::Instruction *b);
    void get_dependences(llvm::Instruction *inst, SI &deps);
    void remove_deps(llvm::Instruction *inst, SI &candidates);
    bool check_control_flow(llvm::Instruction *pred, llvm::Instruction *succ);
    void control_flow(llvm::Instruction *pred, llvm::Instruction *succ);
    void locate_boundary(SI &candidates);
    
    SI range;
    llvm::CallInst *previous_call;
    bool path_to_exit;
    
    void clear(void);

    void handleGenericInstruction(llvm::Instruction *inst);
    void handleLoadStore(llvm::Instruction *node);
    void handleCallInst(llvm::Instruction *node, bool connect_entry);
    void handleTerminatorInst();
  };

}

#endif
