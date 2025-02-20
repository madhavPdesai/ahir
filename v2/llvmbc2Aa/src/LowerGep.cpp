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
#include <llvm/Target/TargetData.h>
#include <llvm/Module.h>
#include "Utils.hpp"


#include <iostream>
#include <fstream>
#include <sstream>
#include <numeric>
#include <functional>

using namespace llvm;

namespace Aa {

  struct LowerGepPass : public ModulePass {
    static char ID;
    virtual bool runOnModule(Module &M);
    bool runOnFunction(Function &F);
    virtual void getAnalysisUsage(AnalysisUsage &AU) const;

    TargetData *TD;

    LowerGepPass();
  };

  ModulePass* createLowerGepPass()
  {
    return new LowerGepPass();
  }

  char LowerGepPass::ID = 0;
}

using namespace Aa;
namespace {
  RegisterPass<Aa::LowerGepPass>
  X("lower-gep", "Convert GEP into mul-add trees");
}

LowerGepPass::LowerGepPass() : ModulePass(ID)
{
  TD = NULL;
};

bool LowerGepPass::runOnModule(Module &M)
{
  TD = &getAnalysis<TargetData>();
  
  for (Module::iterator fi = M.begin(), fe = M.end();
       fi != fe; ++fi) {
    runOnFunction(*fi);
  }
  
  return false; // we didn't touch anything
}

void Aa::LowerGepPass::getAnalysisUsage(AnalysisUsage &AU) const
{
  AU.addRequired<TargetData>();
}

bool Aa::LowerGepPass::runOnFunction(Function &F)
{
  const llvm::Type *ptr_int_type = TD->getIntPtrType(F.getContext());

  for (Function::iterator bi = F.begin(), be = F.end(); bi != be; ++bi) {
    BasicBlock *bb = bi;

    BasicBlock::iterator ii = bb->begin();
    while (ii != bb->end()) {
      GetElementPtrInst *gep = dyn_cast<GetElementPtrInst>(ii);
      BasicBlock::iterator gi = ii++;
      if (!gep) {
	continue;
      }

      for (llvm::Value::use_iterator ui = gep->use_begin(), ue = gep->use_end();
           ui != ue; ++ui) {
        Use &u = ui.getUse();

        IOCode ioc = get_io_code(u);

        if (ioc == NOT_IO)
          continue;

        u.set(CastInst::CreatePointerCast(gep->getPointerOperand()
                                          , gep->getType()
                                          , "", gep));
      }

      assert(gep->hasIndices() && "GEP without indices??");
      llvm::Value *ptr = gep->getPointerOperand();
      const Type *ctype = ptr->getType();

      // deal with the base pointer first
      llvm::Value *base = gep->getPointerOperand();
      std::string base_name = gep->getNameStr() + ".base";
      llvm::Value *address = new PtrToIntInst(base, ptr_int_type, base_name + ".cast", gi);
      
      unsigned i = 0;
      for (User::op_iterator oi = gep->idx_begin(), oe = gep->idx_end();
	   oi != oe; ++oi, ++i) {
	llvm::Value *index = *oi;
	llvm::Value *offset = NULL;

	std::stringstream index_name;
	index_name << gep->getNameStr() << ".idx." << i;
	
	if (const SequentialType *qtype = dyn_cast<SequentialType>(ctype)) {
	  // multiply index by size of element

	  unsigned element_size = getTypePaddedSize(TD, qtype->getElementType());
	  const llvm::IntegerType *index_type = cast<IntegerType>(index->getType());
	  ConstantInt *cint = ConstantInt::get(index_type, element_size);
	  assert(cint && "uh oh!");
	  offset = BinaryOperator::Create(Instruction::Mul
					  , cint
					  , index
					  , index_name.str()
					  , gi);
	  ctype = qtype->getElementType();
	} else if (const StructType *stype = dyn_cast<StructType>(ctype)) {
	  // calculate offset into the struct

	  const StructLayout *layout = TD->getStructLayout(stype);
	  unsigned idx = cast<ConstantInt>(index)->getValue().getZExtValue();
	  unsigned struct_offset = layout->getElementOffset(idx);
	  offset = ConstantInt::get(ptr_int_type, struct_offset);
	  ctype = stype->getElementType(idx);
	} else
	  assert(false && "unhandled offset into composite type");
	
	// add offset to the address

	assert(address && "uh oh!");
	std::stringstream add_name;
	add_name << gep->getNameStr() << ".lvl." << i;
	
	if (offset->getType() != address->getType()) {
	  offset = CastInst::CreateIntegerCast(offset, address->getType()
					       , false, offset->getName() + ".resized"
					       , gi);
	}
	
	address = BinaryOperator::Create(Instruction::Add
					 , address, offset
					 , add_name.str(), gi);
      }

      if (address->getType() != ptr_int_type)
	address = CastInst::CreateIntegerCast(address, ptr_int_type
					      , false, address->getName() + ".final", gi);
      Instruction *new_ptr = new IntToPtrInst(address, gep->getType()
					  , gep->getName() + ".cast");
      ReplaceInstWithInst(bb->getInstList(), gi, new_ptr);
    }
  }

  return true;
}
