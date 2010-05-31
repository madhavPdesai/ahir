#include "Utils.hpp"
#include <Base/Program.hpp>
#include <Base/Values.hpp>
#include <Base/Type.hpp>

#include <llvm/DerivedTypes.h>
#include <llvm/Instructions.h>
#include <llvm/Constants.h>
#include <llvm/GlobalVariable.h>
#include <llvm/Module.h>
#include <llvm/Target/TargetData.h>

#include <boost/lexical_cast.hpp>
#include <iostream>
#include <sstream>

using namespace llvm;
using namespace cdfg;
using namespace hls;

hls::Value* cdfg::getAddressableValue(llvm::Constant *konst
                                      , Program *program
				      , llvm::TargetData *TD)
{
  hls::Value *retval = NULL;
  const llvm::Type *type = konst->getType();
    
  if (isa<CompositeType>(type)) {

    if (isa<PointerType>(type)) {
      llvm::GlobalVariable *g = cast<llvm::GlobalVariable>(konst);
      std::ostringstream id;
      id << "global_" << g->getNameStr();
      AddressValue *av = new AddressValue(id.str(), TD->getPointerSize());
      retval = av;
    } else {
      assert(isa<ArrayType>(type) || isa<StructType>(type));
      CompositeValue *cv = new CompositeValue(getTypeName(type));
	
      for (unsigned int i = 0; i != konst->getNumOperands(); ++i) {
	llvm::Value *el = konst->getOperand(i);
	assert(isa<llvm::Constant>(el) && "constants expected here");
        hls::Value *val = getAddressableValue(cast<llvm::Constant>(el), program, TD);
	cv->elements.push_back(val);
        cv->size += val->size;
      }
      retval = cv;
    }
  } else {
    assert((type->isInteger() || type->isFloatingPoint())
	   && "unsupported type");
    ScalarValue *sv = new ScalarValue(get_type(program, TD, type));
    sv->value = getValue(konst);
    retval = sv;
  }
  return retval;
}

unsigned cdfg::getTypeSizeInBits(TargetData *TD, const llvm::Type *type)
{
  return TD->getTypeSizeInBits(type);
}

unsigned cdfg::getTypePaddedSize(TargetData *TD, const llvm::Type *type)
{
  return TD->getTypeStoreSize(type);
}

std::string cdfg::getTypeDescription(const llvm::Type *type)
{
  return type->getDescription();
}

std::string cdfg::getTypeName(const llvm::Type *type)
{
  std::string retval;
  if (type->getTypeID() == llvm::Type::PointerTyID)
    retval = "APInt";
  else if (type->isInteger())
    retval = "APInt";
  else if (type->isFloatingPoint())
    retval = "APFloat";
  else
    retval = type->getDescription();

  return retval;
}

std::string get_string(const APInt &api)
{
  std::ostringstream str;
  for (unsigned count = api.countLeadingZeros(); count > 0; count--)
    str << "0";

  if (api != 0)
    str << api.toString(2, false /* treat as  unsigned */);
  return str.str();
}

std::string cdfg::getValue(const Constant *konst)
{
  if (isa<UndefValue>(konst)) {
    return "0";
  } else if (isa<ConstantPointerNull>(konst)) {
    return "0";
  } else {
    if (const ConstantInt *cint = dyn_cast<ConstantInt>(konst)) {
      return get_string(cint->getValue());
    } else if (const ConstantFP *fkonst = dyn_cast<ConstantFP>(konst)) {
      return get_string(fkonst->getValueAPF().bitcastToAPInt());
    } else
      assert(false && "unhandled Constant subclass");
  }
}

const hls::Type* cdfg::get_type(Program *program, TargetData *TD, const llvm::Type *type)
{
  unsigned size = getTypeSizeInBits(TD, type);
  std::string id;
  const hls::Type *retval;
  
  if (type->getTypeID() == llvm::Type::PointerTyID
      || type->isInteger()) {
    id = hls::get_apint_description(size);
    retval = program->find_type(id);
    if (retval)
      return retval;
    retval = new hls::Type(size);
  } else {
    assert(type->isFloatingPoint());
    unsigned f = type->getFPMantissaWidth();
    unsigned e = size - f;
    --f; /* sign bit */
    
    id = hls::get_apfloat_description(e, f);
    retval = program->find_type(id);
    if (retval)
      return retval;
    retval = new hls::Type(e, f);
  }
  
  program->register_type(id, retval);
  return retval;
}

IOCode cdfg::get_io_code(Use &u)
{
  if (CallInst *C = dyn_cast<CallInst>(u.getUser()))
    return get_io_code(*C);
  return NOT_IO;
}

IOCode cdfg::get_io_code(CallInst &C)
{
  llvm::Function *f = C.getCalledFunction();
  assert(f && "function pointers are not currently supported");
  
  if (!f->isDeclaration())
    return NOT_IO;

  StringRef name = f->getName();
  IOCode ioc = (name.equals("read_uint32") ? READ_UINT32
                : (name.equals("write_uint32") ? WRITE_UINT32
                   : (name.equals("read_float32") ? READ_FLOAT32
                      : (name.equals("write_float32") ? WRITE_FLOAT32
                         : NOT_IO))));
  
  return ioc;
}
