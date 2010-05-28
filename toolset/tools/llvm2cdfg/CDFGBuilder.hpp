#ifndef __CDFGBUILDER_HPP__
#define __CDFGBUILDER_HPP__

#include <llvm/Support/InstVisitor.h>

namespace llvm {
  class TargetData;
  class AliasAnalysis;
};

namespace hls {
  class Program;
  class Addressable;
};

namespace cdfg {

  class AccessAnalysis;
  
  struct CDFGBuilder : public llvm::InstVisitor<CDFGBuilder> {
    CDFGBuilder(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA);

    llvm::TargetData *TD;
    AccessAnalysis *AA;
    hls::Program *program;
    
    void create_program(const std::string &id);
    void create_addressable(llvm::GlobalVariable &G);
    virtual void create_cdfg(llvm::Function &F) = 0;
    virtual void initialise_with_function(llvm::Function &F) = 0;
    virtual void finalise_function() = 0;
    
    virtual void control_flow(llvm::Instruction *pred, llvm::Instruction *succ) = 0;
    virtual void connect_to_exit(llvm::Instruction *I) = 0;
  };
};

cdfg::CDFGBuilder* cdfg_builder_new(llvm::TargetData *TD, llvm::AliasAnalysis *AA);

#endif
