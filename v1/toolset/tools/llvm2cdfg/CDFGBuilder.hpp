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
    
    void create_program(std::string id);
    void create_memory_location(llvm::GlobalVariable &G);
    virtual void create_cdfg(llvm::Function &F) = 0;
    
    virtual void initialise_with_function(llvm::Function &F) = 0;
    virtual void finalise_function() = 0;
    
    virtual void control_flow(llvm::Instruction *pred, llvm::Instruction *succ) = 0;
    virtual void connect_to_exit(llvm::Instruction *I) = 0;

    virtual void visitBasicBlock(llvm::BasicBlock &BB) {};
    
    virtual void visitInstruction(llvm::Instruction &I);

    virtual void visitBinaryOperator(llvm::BinaryOperator &I) { visitInstruction(I); }
    virtual void visitReturnInst(llvm::ReturnInst &I) { visitInstruction(I); }
    virtual void visitAllocaInst(llvm::AllocaInst &I) { visitInstruction(I); }
    virtual void visitPHINode(llvm::PHINode &I) { visitInstruction(I); }
    virtual void visitCallInst(llvm::CallInst &I) { visitInstruction(I); }
    virtual void visitCastInst(llvm::CastInst &I) { visitInstruction(I); }
    virtual void visitLoadInst(llvm::LoadInst &I) { visitInstruction(I); }
    virtual void visitStoreInst(llvm::StoreInst &I) { visitInstruction(I); }
    virtual void visitCmpInst(llvm::CmpInst &I) { visitInstruction(I); }
    virtual void visitSelectInst(llvm::SelectInst &I) { visitInstruction(I); }
    virtual void visitBranchInst(llvm::BranchInst &I) { visitInstruction(I); }

  };
};

cdfg::CDFGBuilder* cdfg_builder_new(llvm::TargetData *TD, llvm::AliasAnalysis *AA);

#endif
