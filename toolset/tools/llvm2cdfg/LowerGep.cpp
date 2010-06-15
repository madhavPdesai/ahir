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
using namespace cdfg;

namespace cdfg {

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

namespace {
  RegisterPass<cdfg::LowerGepPass>
  X("lower-gep", "Convert GEP into mul-add trees");
}

LowerGepPass::LowerGepPass() : ModulePass((intptr_t)&ID)
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

void cdfg::LowerGepPass::getAnalysisUsage(AnalysisUsage &AU) const
{
  AU.addRequired<TargetData>();
}

bool cdfg::LowerGepPass::runOnFunction(Function &F)
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
