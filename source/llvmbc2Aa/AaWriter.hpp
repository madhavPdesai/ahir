#ifndef __CDFGBUILDER_HPP__
#define __CDFGBUILDER_HPP__

#include <llvm/Support/InstVisitor.h>
#include <set>
#include <map>
#include <string>
#include <iostream>

namespace llvm {
  class TargetData;
  class AliasAnalysis;
};


namespace Aa {

  struct AaWriter : public llvm::InstVisitor<AaWriter> {

    AaWriter(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA);
    llvm::TargetData *TD;
    llvm::AliasAnalysis *AA;

    std::map<std::string,std::set<std::string> > bb_predecessor_map;
    std::map<llvm::Value*, std::string> value_name_map;
    std::map<std::string,std::string> pipe_map;

    bool _return_flag;
    void Set_Return_Flag(bool v) {_return_flag = v;}
    bool Get_Return_Flag() {return(_return_flag);}

    void clear() { 
      Set_Return_Flag(false); 
      clear_bb_predecessor_map(); 
      value_name_map.clear();
    }

    void Collect_Pipes(llvm::Function& F);
    void Add_Pipe(std::string pname, std::string aa_type_name);
    void Print_Pipe_Declarations(std::ostream& ofile);

    void start_program(std::string id);
    void print_storage(llvm::GlobalVariable &G);

    void clear_bb_predecessor_map() {bb_predecessor_map.clear();}
    void add_bb_predecessor_map_entry(std::string p, std::string q)
    {
      bb_predecessor_map[p].insert(q);
    }

    std::string get_name(llvm::Value* v);

    virtual void initialise_with_function(llvm::Function &F) = 0;
    virtual void finalise_function() = 0;

    virtual void Write_PHI_Node(llvm::PHINode& pnode) {};
    virtual void visitBasicBlock(llvm::BasicBlock &BB) {};
    virtual void visitInstruction(llvm::Instruction &I);
    virtual void visitBinaryOperator(llvm::BinaryOperator &I) { visitInstruction(I); }
    virtual void visitReturnInst(llvm::ReturnInst &I) { visitInstruction(I); }
    virtual void visitAllocaInst(llvm::AllocaInst &I) { visitInstruction(I); }
    virtual void visitPHINode(llvm::PHINode &I) { visitInstruction(I); }
    virtual void visitCallInst(llvm::CallInst &I) { visitInstruction(I); }
    virtual void visitSExtInst(llvm::SExtInst& C)  { visitInstruction(C); }
    virtual void visitSIToFPInst(llvm::SIToFPInst& C) { visitInstruction(C); }
    virtual void visitFPToSIInst(llvm::FPToSIInst& C) { visitInstruction(C); }
    virtual void visitCastInst(llvm::CastInst &I) { visitInstruction(I); }
    virtual void visitLoadInst(llvm::LoadInst &I) { visitInstruction(I); }
    virtual void visitStoreInst(llvm::StoreInst &I) { visitInstruction(I); }
    virtual void visitCmpInst(llvm::CmpInst &I) { visitInstruction(I); }
    virtual void visitSelectInst(llvm::SelectInst &I) { visitInstruction(I); }
    virtual void visitBranchInst(llvm::BranchInst &I) { visitInstruction(I); }
  };
};

Aa::AaWriter* AaWriter_New(llvm::TargetData *TD, llvm::AliasAnalysis *AA);

#endif
