//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
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

  if(isa<llvm::CallInst>(inst))
    {
      CallInst* ci = dyn_cast<CallInst>(inst);
      for(int idx = 0; idx < ci->getNumArgOperands(); idx++) 
	{
	  llvm::Value *opnd = ci->getArgOperand(idx);
	  if (ConstantExpr *ce = dyn_cast<ConstantExpr>(opnd)) {
	    lower(ce, inst);
	  }
	}
    }
  else
    {
      for (unsigned oi = 0, oe = inst->getNumOperands();
	   oi != oe; oi++) {
	llvm::Value *opnd = inst->getOperand(oi);
	
	if (ConstantExpr *ce = dyn_cast<ConstantExpr>(opnd)) {
	  lower(ce, inst);
	}
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
  } 
  else
    {
      std::cerr << "Warning: unhandled constant expression! ";
      ce->dump();
      std::cerr << std::endl;
    }

  if (cinst) {
    inst->replaceUsesOfWith(ce, cinst);
    process(cinst);
  }
}
