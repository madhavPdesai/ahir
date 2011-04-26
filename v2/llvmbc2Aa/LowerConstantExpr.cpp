#include <llvm/Pass.h>
#include <llvm/Support/InstIterator.h>
#include <llvm/Instructions.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Constants.h>
#include <llvm/GlobalVariable.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>

#include "Utils.hpp"


#include <iostream>
#include <fstream>
#include <sstream>
#include <numeric>
#include <functional>

using namespace llvm;

namespace Aa {

  struct LowerConstantExpr : public FunctionPass {
    static char ID;
    virtual bool runOnFunction(Function &F);
    virtual void getAnalysisUsage(AnalysisUsage &AU) const;

    void process(Instruction *inst);
    void lower(ConstantExpr *ce, Instruction *inst);

    LowerConstantExpr() : FunctionPass(ID) {}
  };

  FunctionPass* createLowerConstantExprPass()
  {
    return new LowerConstantExpr();
  }

  char LowerConstantExpr::ID = 0;
}

namespace {
  RegisterPass<Aa::LowerConstantExpr>
  X("lower-const-expr", "Lower ConstantExprs to Insts to be eliminated");
}

void Aa::LowerConstantExpr::getAnalysisUsage(AnalysisUsage &AU) const {}

bool Aa::LowerConstantExpr::runOnFunction(Function &F)
{
  for (Function::iterator bi = F.begin(), be = F.end(); bi != be; ++bi) {
    BasicBlock *bb = bi;
    
    BasicBlock::iterator ii = bb->begin();
    while (ii != bb->end()) {
      Instruction *inst = ii;
      BasicBlock::iterator II = ii++;
      
      process(inst);
    }
  }

  return true;
}

void Aa::LowerConstantExpr::process(Instruction *inst)
{
  for (unsigned oi = 0, oe = inst->getNumOperands();
       oi != oe; oi++) {
    llvm::Value *opnd = inst->getOperand(oi);
    
    if (ConstantExpr *ce = dyn_cast<ConstantExpr>(opnd)) {
      lower(ce, inst);
    }
  }
}


void Aa::LowerConstantExpr::lower(ConstantExpr *ce, Instruction *inst)
{
  Instruction *cinst = NULL;

  unsigned opcode = ce->getOpcode();

  if (opcode == Instruction::GetElementPtr) {
    std::vector<llvm::Value*> idx;
    llvm::Value *ptr = ce->getOperand(0);

    for (unsigned i = 1; i < ce->getNumOperands(); ++i)
      idx.push_back((llvm::Value*)ce->getOperand(i));
    
    cinst = GetElementPtrInst::Create(ptr, idx.begin(), idx.end(), "", inst);
  } else if (ce->isCast()) {
    cinst = CastInst::Create(Instruction::CastOps(opcode)
			     , ce->getOperand(0), ce->getType(), "", inst);
  } else if (Instruction::isBinaryOp(opcode)) {
    cinst = BinaryOperator::Create(Instruction::BinaryOps(opcode)
				   , ce->getOperand(0)
				   , ce->getOperand(1)
				   , "", inst);
  } else
    assert(false && "unhandled ConstantExpr");

  if (cinst) {
    inst->replaceUsesOfWith(ce, cinst);
    process(cinst);
  }
}
