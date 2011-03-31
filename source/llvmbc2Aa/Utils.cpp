#include <llvm/DerivedTypes.h>
#include <llvm/Instructions.h>
#include <llvm/Constants.h>
#include <llvm/GlobalVariable.h>
#include <llvm/Module.h>
#include <llvm/Target/TargetData.h>

#include <iostream>
#include <sstream>
#include <deque>
#include "Utils.hpp"

using namespace llvm;
using namespace Aa;

unsigned Aa::getTypeSizeInBits(TargetData *TD, const llvm::Type *type)
{
  return TD->getTypeSizeInBits(type);
}

unsigned Aa::getTypePaddedSize(TargetData *TD, const llvm::Type *type)
{
  return TD->getTypeStoreSize(type);
}

std::string Aa::getTypeDescription(const llvm::Type *type)
{
  return type->getDescription();
}

std::string Aa::getTypeName(const llvm::Type *type)
{
	//\todo need to change this!
  std::string retval;
  if (type->getTypeID() == llvm::Type::PointerTyID)
    retval = "APInt";
  else if (type->isIntegerTy())
    retval = "APInt";
  else if (type->isFloatingPointTy())
    retval = "APFloat";
  else
    retval = type->getDescription();

  return retval;
}

std::string get_string(const APInt &api)
{
  std::ostringstream str;
  str << "_b";
  for (unsigned count = api.countLeadingZeros(); count > 0; count--)
    str << "0";

  if (api != 0)
    str << api.toString(2, false /* treat as  unsigned */);
  return str.str();
}

std::string Aa::get_aa_constant_string(llvm::Constant *konst)
{
  std::string ret_val;
  const llvm::Type *type = konst->getType();
    
  if (isa<CompositeType>(type)) 
    {
      if (isa<PointerType>(type)) 
	{ 
	  // constant pointer must be globally declared..
	  llvm::GlobalVariable *g = cast<llvm::GlobalVariable>(konst);
	  std::ostringstream id;

	  //TODO: revisit.
	  ret_val =  g->getNameStr();
	} 
      else 
	{
	  assert(isa<ArrayType>(type) || isa<StructType>(type));
	  ret_val = "(";
	  for (unsigned int i = 0; i != konst->getNumOperands(); ++i) 
	    {
	      if(i > 0)
		ret_val += " ";

	      llvm::Value *el = konst->getOperand(i);
	      assert(isa<llvm::Constant>(el) && "constants expected here");
	      ret_val += get_aa_constant_string(cast<llvm::Constant>(el));

	    }
	  ret_val += ")";
	}
    } 
  else 
    {
      assert((type->isInteger() || type->isFloatingPoint())
	     && "unsupported type");
      if (isa<UndefValue>(konst)) 
	{
	  ret_val =  "0";
	} 
      else if (isa<ConstantPointerNull>(konst)) 
	{
	  ret_val = "0";
	} 
      else 
	{
	  if (const ConstantInt *cint = dyn_cast<ConstantInt>(konst)) 
	    {
	      ret_val =  get_string(cint->getValue());
	    } 
	  else if (const ConstantFP *fkonst = dyn_cast<ConstantFP>(konst)) 
	    {
	      // fix this.  this should be a binary string..
	      char buffer[1024];
	      if(type->isFloatTy())
		{
		  sprintf(buffer,"%e",fkonst->getValueAPF().convertToFloat());
		}
	      else if(type->isDoubleTy())
		{
		  sprintf(buffer,"%e",fkonst->getValueAPF().convertToDouble());
		}
	      else
		std::cerr << "Error: unsupported floating point type (only float and double are allowed)"
			  << std::endl;
	      ret_val = "_f" + std::string(buffer);
	    } 
	  else
	    {
	      std::cerr << "Error: unhandled constant class";
	      ret_val = "UNSUPPORTED_CONSTANT";
	    }
	}
    }
  
  return ret_val;
}


std::string Aa::getValue(const Constant *konst)
{
  // should never be called.
  assert(0);
}



std::string Aa::get_aa_type_name(IOCode ioc)
{
  std::string ret_val;
  switch (ioc) {
  case READ_FLOAT32:
    ret_val = "$float<8,23>";
    break;
    
  case READ_UINT32:
    ret_val = "$uint<32>";
    break;
    
  case WRITE_FLOAT32:
    ret_val = "$float<8,23>";
    break;
    
  case WRITE_UINT32:
    ret_val = "$uint<32>";
    break;
  default:
    assert(false);
    break;
  }
  return(ret_val);
}

std::string Aa::to_aa(std::string x)
{
  std::string ret_string;
  for(int i = 0; i < x.size(); i++)
    {
      if(x[i] != 0)
	{
	  if(isalnum(x[i]) || x[i] == '_')
	    ret_string += x[i];
	  else
	    ret_string += "x_x";
	}
    }
  return(ret_string);
}

IOCode Aa::get_io_code(Use &u)
{
  return get_io_code(u.getUser());
}
IOCode Aa::get_io_code(User *u) 
{
  if (CallInst *C = dyn_cast<CallInst>(u))
    return get_io_code(*C);
  return NOT_IO;
}

IOCode Aa::get_io_code(CallInst &C)
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


// hunt back till you find the string..
std::string Aa::locate_portname_for_io_call(llvm::Value *strptr)
{
  std::string ret_string;
  ConstantArray* konst = NULL;

  std::deque<llvm::Value*> queue;
  queue.push_back(strptr);
  
  while (!queue.empty()) {
    llvm::Value *val = queue.front();
    queue.pop_front();
    konst = dyn_cast<ConstantArray>(val);
    if (konst != NULL)
      break;
    
    if (!isa<User>(val))
      continue;
    
    User *u = dyn_cast<User>(val);
    for (User::op_iterator oi = u->op_begin(), oe = u->op_end(); oi != oe; ++oi) {
      llvm::Value *opnd = oi->get();
      queue.push_back(opnd);
    }
  }
  
  if(konst != NULL)
    ret_string = konst->getAsString();

  return(ret_string);
}

std::string Aa::get_aa_type_name(const llvm::Type* ptr)
{
  std::string ret_string;
  // if ptr is a pointer.
  if(isa<PointerType>(ptr))
    {
      ret_string = "$pointer< ";
      const llvm::PointerType *ptr_pointer = dyn_cast<llvm::PointerType>(ptr);
      const llvm::Type* el_type = ptr_pointer->getElementType();
      ret_string += get_aa_type_name(el_type);
      ret_string += " >"; 
    }
  else if(isa<ArrayType>(ptr) || isa<VectorType>(ptr))
    {

      const llvm::SequentialType *ptr_seq = dyn_cast<llvm::SequentialType>(ptr);
      const llvm::Type* el_type = ptr_seq->getElementType();

      if(isa<PointerType>(el_type) || !isa<CompositeType>(el_type))
	{
	  int dim = 0;
	  const llvm::ArrayType* ptr_array = dyn_cast<llvm::ArrayType>(ptr);
	  if(ptr_array != NULL)
	    dim = ptr_array->getNumElements();
	  else
	    {
	      const llvm::VectorType* ptr_vec = dyn_cast<llvm::VectorType>(ptr);
	      dim = ptr_vec->getNumElements();
	    }
	  
	  ret_string = "$array [" + int_to_str(dim) + "] $of ";
	  ret_string += get_aa_type_name(el_type);
	}
      else
	{
	  std::cerr <<"Error: at present elements of array types must be scalars." << std::endl;
	  ret_string = "Unsupported_Array_Type";
	}
    }
  else if(isa<IntegerType>(ptr))
    {
      ret_string = "$uint<";
      const llvm::IntegerType*   ptr_int = dyn_cast<llvm::IntegerType>(ptr);
      ret_string += int_to_str(ptr_int->getBitWidth()) + ">";
    }
  else if(ptr->isFloatTy())
    {
      ret_string = "$float<8,23>";
    }
  else if(ptr->isDoubleTy())
    {
      ret_string = "$float<11,52>";
    }
  else
    {
      std::cerr << "Error: unsupported type" << std::endl;
      ret_string = "Unsupported_Array_Type";
    }
  return(ret_string);
}

std::string Aa::get_aa_value_string(const llvm::Value* val)
{
   return("TBD");
}


void Aa::write_storage_object(llvm::GlobalVariable &G)
{
    const llvm::Type *ptr = G.getType();

    std::string obj_name = to_aa(G.getNameStr());
    const llvm::PointerType* pptr = dyn_cast<PointerType>(G.getType());

    assert(pptr != NULL);
    const llvm::Type* el_type = pptr->getElementType();
    assert(el_type);
    std::string type_name = get_aa_type_name(el_type); 

    if (G.hasInitializer()) {
      	llvm::Constant *init = G.getInitializer();
	std::cerr << "Warning: Initial value for " << obj_name << " ignored" << std::endl;
    }
    std::cout << "$storage " << obj_name << ":" << type_name << std::endl;
}


std::string Aa::int_to_str(int a)
{
	bool minus_flag = false;
	std::string ret_string;
	char buffer[1024];
	sprintf(buffer,"%d", a);
	ret_string = buffer;
	return(ret_string);
}


std::string Aa::llvm_opcode_to_string(unsigned opcode)
{
  std::string ret_string;

  if((opcode == Instruction::Add) || (opcode == Instruction::FAdd))
    {
      ret_string = "+";
    }
  else  if((opcode == Instruction::Sub) || (opcode == Instruction::FSub))
    {
      ret_string = "-";
    }
  else if((opcode == Instruction::Mul) || (opcode == Instruction::FMul))
    {
      ret_string = "*";
    }
  else if((opcode == Instruction::UDiv) || (opcode == Instruction::SDiv) || (opcode == Instruction::FDiv))
    {
      ret_string = "/";
    }
  else if((opcode == Instruction::LShr) || (opcode == Instruction::AShr))
    {
      ret_string = ">>";
    }
  else if((opcode == Instruction::Shl))
    {
      ret_string = "<<";
    }
  else if((opcode == Instruction::And))
    {
      ret_string = "&";
    }
  else if((opcode == Instruction::Or))
    {
      ret_string = "|";
    }
  else if((opcode == Instruction::Xor))
    {
      ret_string = "^";
    }
  else if((opcode == Instruction::URem) || (opcode == Instruction::SRem) || (opcode == Instruction::FRem))
    {
      std::cerr << "Error: Unsupported Rem instruction " << std::endl;
      ret_string = "UNSUPPORTED_REM";
    }
  else
    {
      std::cerr << "Error: Unsupported instruction " << std::endl;
      ret_string = "UNSUPPORTED_INSTRUCTION";
    }

  // TODO shift operators, logical operators!

  return(ret_string);
}
