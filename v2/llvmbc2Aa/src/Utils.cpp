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
#include <stdio.h>

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
  std::string ret_val = to_aa(konst->getNameStr());
  if(ret_val != "")
    return(ret_val);

  const llvm::Type *type = konst->getType();

  if(isa<GlobalVariable>(konst))
    {
      llvm::GlobalVariable* gv = dyn_cast<GlobalVariable>(konst);
      ret_val = gv->getName();
      if(ret_val != "")
	{
	  return(ret_val);
	}
      if(gv->isConstant())
	{
	  llvm::Constant* cgv = gv->getInitializer();
	  ret_val = get_aa_constant_string(cgv);
	}
    }
  else if(isa<UndefValue>(konst))
    {
      ret_val = "_b0";
    }
  else if(isa<ConstantInt>(konst))
    {
      const ConstantInt *cint = dyn_cast<ConstantInt>(konst);
      ret_val =  get_string(cint->getValue());
    }
  else if(isa<ConstantFP>(konst))
    {
      const ConstantFP *fkonst = dyn_cast<ConstantFP>(konst);

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
	{
	  std::cerr << "Error: unsupported floating point type (only float and double are allowed)"
		    << std::endl;
	}
      ret_val = "_f" + std::string(buffer);
    }
  else if(isa<ConstantArray>(konst) || isa<ConstantStruct>(konst) || isa<ConstantVector>(konst))
    {
      if(isa<ConstantArray>(konst))
	{
	  llvm::ConstantArray* ka = dyn_cast<ConstantArray>(konst);
	  if(ka->isString())
	    {
	      ret_val = ka->getAsString();
	      return(ret_val);
	    }
	}

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
  else if(isa<ConstantAggregateZero>(konst))
    {
      ret_val = get_zero_value(konst->getType());
    }
  else if(isa<ConstantPointerNull>(konst))
    {
      ret_val = "_b0";
    }
  else
    {
      std::cerr << "Error: constant must be one of int/fp/array/struct/vector/aggregate-zero/pointer-null" 
		<< std::endl;
      ret_val = "UNSUPPORTED_CONSTANT";
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

  case READ_UINTPTR:
    ret_val = "$pointer< $uint<32> >";
    break;

  case WRITE_UINTPTR:
    ret_val = "$pointer< $uint<32> >";
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
      if(i == 0 && !isalpha(x[i]))
	ret_string += "x";

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

bool Aa::is_io_read(IOCode ioc)
{
  if(ioc == READ_UINT32 || ioc == READ_FLOAT32 || ioc == READ_UINTPTR)
    return(true);
  else
    return(false);
}
bool Aa::is_io_write(IOCode ioc)
{
  if(ioc == WRITE_UINT32 || ioc == WRITE_FLOAT32 || ioc == WRITE_UINTPTR)
    return(true);
  else
    return(false);
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

  if(f == NULL)
    {
      return NOT_IO;
    }
  
  if (!f->isDeclaration())
    return NOT_IO;

  StringRef name = f->getName();
  IOCode ioc = (name.equals("read_uint32") ? READ_UINT32
                : (name.equals("write_uint32") ? WRITE_UINT32
                   : (name.equals("read_float32") ? READ_FLOAT32
                      : (name.equals("write_float32") ? WRITE_FLOAT32
			 : (name.equals("write_uintptr") ? WRITE_UINTPTR
			    : (name.equals("read_uintptr") ? READ_UINTPTR
			       : NOT_IO))))));
  
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
  {
    if(konst->isString())
    	ret_string = konst->getAsString();
  }

  return(ret_string);
}

std::string Aa::get_zero_value(const llvm::Type* ptr)
{
  std::string ret_string;
  if(isa<PointerType>(ptr))
    {
      ret_string = "_b0";
    }
  else if(isa<ArrayType>(ptr) || isa<VectorType>(ptr))
    {

      const llvm::SequentialType *ptr_seq = dyn_cast<llvm::SequentialType>(ptr);
      const llvm::Type* el_type = ptr_seq->getElementType();
      
      int dim = 0;
      const llvm::ArrayType* ptr_array = dyn_cast<llvm::ArrayType>(ptr);
      if(ptr_array != NULL)
	dim = ptr_array->getNumElements();
      else
	{
	  const llvm::VectorType* ptr_vec = dyn_cast<llvm::VectorType>(ptr);
	  dim = ptr_vec->getNumElements();
	}
      
      ret_string = "( ";
      std::string el_zero_string = get_zero_value(el_type);
      for(int idx = 0; idx < dim; idx++)
	{
	  ret_string += el_zero_string;
	}
      ret_string += " )";
    }
  else if(isa<StructType>(ptr))
    {
      const llvm::StructType *ptr_struct = dyn_cast<llvm::StructType>(ptr);
      ret_string = "( ";
      for(int idx = 0; idx < ptr_struct->getNumElements(); idx++)
	{
	  ret_string += " " ;
	  ret_string += get_zero_value(ptr_struct->getElementType(idx));
	  ret_string += " ";
	}
      ret_string +=  " )";
    }
  else if(isa<IntegerType>(ptr))
    {
      ret_string = "_b0";
    }
  else if(ptr->isFloatTy())
    {
      ret_string = "_f0.0e+1";
    }
  else if(ptr->isDoubleTy())
    {
      ret_string = "_f0.0e+1";
    }
  else if(ptr->isVoidTy())
    {
      std::cerr << "Error: void type cannot have zero value" << std::endl;
      ret_string = "UNDEFINED_VOID_VALUE";
    }
  else if(ptr->isFunctionTy())
    {
      ret_string = "_b0";
    } 
  else
    {
      std::cerr << "Error: unsupported type" << std::endl;
      ret_string = "Unsupported_Type";
    }
  return(ret_string);
}

std::string Aa::get_aa_type_name(const llvm::Type* ptr, llvm::Module& tst)
{

  if(ptr->isVoidTy())
	return("$void");
  std::string ret_string = tst.getTypeName(ptr);
  if(ret_string != "")
	return(to_aa(ret_string));

  
  
  if(isa<PointerType>(ptr))
    {
      ret_string = "$pointer< ";
      const llvm::PointerType *ptr_pointer = dyn_cast<llvm::PointerType>(ptr);
      const llvm::Type* el_type = ptr_pointer->getElementType();
      ret_string += get_aa_type_name(el_type,tst);
      ret_string += " >"; 
    }
  else if(isa<ArrayType>(ptr) || isa<VectorType>(ptr))
    {

      const llvm::SequentialType *ptr_seq = dyn_cast<llvm::SequentialType>(ptr);
      const llvm::Type* el_type = ptr_seq->getElementType();
      
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
      ret_string += get_aa_type_name(el_type,tst);
    }
  else if(isa<StructType>(ptr))
    {
      const llvm::StructType *ptr_struct = dyn_cast<llvm::StructType>(ptr);
      ret_string = "$record ";
      for(int idx = 0; idx < ptr_struct->getNumElements(); idx++)
	{
	  ret_string += "< " ;
	  ret_string += get_aa_type_name(ptr_struct->getElementType(idx),tst);
	  ret_string += " > ";
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
  else if(ptr->isVoidTy())
    {
      ret_string = "$void";
    }
  else if(ptr->isFunctionTy())
    {
      std::cerr << "Warning: function type converted to void*" << std::endl;
      ret_string = "$pointer < $void > ";
    } 
  else
    {
      std::cerr << "Error: unsupported type" << std::endl;
      ret_string = "Unsupported_Type";
    }
  return(ret_string);
}

std::string Aa::get_aa_value_string(const llvm::Value* val)
{
   return("TBD");
}


void Aa::write_type_declaration(llvm::Type *T, llvm::Module& tst)
{
  std::string type_name = to_aa(tst.getTypeName(T));
  if(type_name == "")
	return;

  if(!T->isStructTy())
	return;

  std::cout << "$record [" << type_name << "] ";
  const llvm::StructType *ptr_struct = dyn_cast<llvm::StructType>(T);
  for(int idx = 0; idx < ptr_struct->getNumElements(); idx++)
  {
	  std::cout << "< " ;
	  std::cout << get_aa_type_name(ptr_struct->getElementType(idx),tst);
	  std::cout << " > ";
  }
  std::cout << std::endl;
}


void Aa::write_storage_object(std::string& obj_name, llvm::GlobalVariable &G, llvm::Module& tst,
			      std::vector<std::string>& init_obj_vector,
			      bool create_initializer)
{
    const llvm::Type *ptr = G.getType();
    const llvm::PointerType* pptr = dyn_cast<PointerType>(G.getType());
    assert(pptr != NULL);
    const llvm::Type* el_type = pptr->getElementType();
    assert(el_type);
    std::string type_name = get_aa_type_name(el_type,tst); 
    
    if(obj_name == "")
      {
	std::cerr << "Error: could not find name of storage object" << std::endl;
	obj_name = "UNKNOWN_STORAGE_OBJECT";
      }
    
    std::cout << "$storage " << to_aa(obj_name) << ":" << type_name << std::endl;
    if (G.hasInitializer()) 
      {
      	llvm::Constant *init = G.getInitializer();
	if(!isa<UndefValue>(init))
	  {
	    if(create_initializer)
	      {
		init_obj_vector.push_back(obj_name + "_initializer_");
		
		std::cerr << "Info: Initial value specified for " << obj_name << ": will create initializer module" << std::endl;
		std::cout << "$module [" << obj_name << "_initializer_] $in () $out () $is {" << std::endl;
		write_storage_initializer_statements(obj_name,init);
		std::cout << "}" << std::endl;
	      }
	    else
	      {
		std::cerr << "Warning: Initial value specified for " << obj_name << " will be ignored" << std::endl;		
	      }
	  }
      }
}
void Aa::write_storage_initializer_statements(std::string& prefix, llvm::Constant* konst)
{
  const llvm::Type *konst_type = konst->getType();

  if(isa<GlobalVariable>(konst))
    {
      llvm::GlobalVariable* gv = dyn_cast<GlobalVariable>(konst);
      if(gv->isConstant())
	{
	  konst = gv->getInitializer();
	}
    }
    
  if(isa<ConstantInt>(konst) || isa<ConstantFP>(konst))
    {
      std::cout << prefix << " := " << get_aa_constant_string(konst) << std::endl;
    }
  else if(isa<ConstantPointerNull>(konst))
    {
      std::cout << prefix << " := _b0" << std::endl;
    }
  else if(isa<ConstantArray>(konst) || isa<ConstantVector>(konst) 
	  || isa<ConstantStruct>(konst))
    {
      int dim = konst->getNumOperands();
      for (unsigned int i = 0; i != konst->getNumOperands(); ++i) 
	{
	  std::string forward_prefix = prefix + "[" +  int_to_str(i) + "]";
	  llvm::Value *el = konst->getOperand(i);
	  assert(isa<llvm::Constant>(el) && "constants expected here");
	  write_storage_initializer_statements(forward_prefix,cast<llvm::Constant>(el));
	}
    }
  else if(isa<ConstantAggregateZero>(konst))
    {
      write_zero_initializer_recursive(prefix,konst->getType(),0);      
    }
  else
    {
      std::cerr << "Error: constant must be one of int/fp/array/struct/vector/aggregate-zero/pointer-null" 
		<< std::endl;
      std::cout << prefix << " := UNSUPPORTED_CONSTANT";
    }
}


void Aa::write_zero_initializer_recursive(std::string prefix,const llvm::Type* ptr, int depth)
{
  
  if(isa<PointerType>(ptr) || isa<IntegerType>(ptr) )
    {
      std::cout << prefix << " := _b0" << std::endl;
    }
  else if(ptr->isFloatTy() || ptr->isDoubleTy())
    {
      std::cout << prefix << " := _f0.0e+0" << std::endl;
    }
  else if(isa<ArrayType>(ptr) || isa<VectorType>(ptr))
    {
      const llvm::SequentialType *ptr_seq = dyn_cast<llvm::SequentialType>(ptr);
      const llvm::Type* el_type = ptr_seq->getElementType();
      
      int dim = 0;
      const llvm::ArrayType* ptr_array = dyn_cast<llvm::ArrayType>(ptr);
      if(ptr_array != NULL)
	dim = ptr_array->getNumElements();
      else
	{
	  const llvm::VectorType* ptr_vec = dyn_cast<llvm::VectorType>(ptr);
	  dim = ptr_vec->getNumElements();
	}
      
      std::cout << "$branchblock [zeroinit_" << depth << "] {" << std::endl;
      std::cout << "$merge $entry loopback " << std::endl;
      std::cout << "$phi I_" << depth << " :=  ($cast ($uint< "
		<< number_of_bits_needed_to_represent(dim) 
		<< " >) 0) $on $entry next_I $on loopback" << std::endl;
      std::cout << "$endmerge " << std::endl;
      std::cout << "next_I := (I_" << depth << " + 1)" << std::endl;
      std::string forward_prefix = prefix + "[I_" + int_to_str(depth) + "]";
      write_zero_initializer_recursive(forward_prefix, el_type,depth+1);
      std::cout << "$if (next_I < " << dim << ") $then $place [loopback] $else $null $endif" << std::endl;
      std::cout << "}" << std::endl;
    }
  else if(isa<StructType>(ptr))
    {
      const llvm::StructType *ptr_struct = dyn_cast<llvm::StructType>(ptr);
      for(int idx = 0; idx < ptr_struct->getNumElements(); idx++)
	{
	  std::string forward_prefix = prefix + "[" + int_to_str(idx) + "]";
	  const llvm::Type* el_type = ptr_struct->getElementType(idx);
	  write_zero_initializer_recursive(forward_prefix, el_type,depth+1);
	}
    }
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

int Aa::number_of_bits_needed_to_represent(int m)
{
  int ret_val = 1;
  while(m > 1)
    {
      m = m/2;
      ret_val++;
    }
  return(ret_val);
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
