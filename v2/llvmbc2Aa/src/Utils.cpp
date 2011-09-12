#include <llvm/DerivedTypes.h>
#include <llvm/Instructions.h>
#include <llvm/Constants.h>
#include <llvm/GlobalVariable.h>
#include <llvm/Module.h>
#include <llvm/Target/TargetData.h>

#include <iostream>
#include <sstream>
#include <deque>
#include <string>
#include "Utils.hpp"
#include <stdio.h>
#include <limits.h>

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
      // null pointer.. assume max value is 2**64-1
      ret_val = "_b1111111111111111111111111111111111111111111111111111111111111111";
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

		case READ_POINTER:
			ret_val = "$pointer< $void >";
			break;

		case WRITE_POINTER:
			ret_val = "$pointer< $void >";
			break;

		case READ_UINT16:
			ret_val = "$uint<16>";
			break;

		case WRITE_UINT16:
			ret_val = "$uint<16>";
			break;

		case READ_UINT8:
			ret_val = "$uint<8>";
			break;

		case WRITE_UINT8:
			ret_val = "$uint<8>";
			break;

		case READ_UINT64:
			ret_val = "$uint<64>";
			break;

		case WRITE_UINT64:
			ret_val = "$uint<64>";
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
	if(ioc == READ_UINT32 || ioc == READ_FLOAT32 || ioc == READ_UINTPTR || ioc == READ_POINTER || ioc == READ_UINT16 || ioc == READ_UINT8 || ioc == READ_UINT64)
		return(true);
	else
		return(false);
}
bool Aa::is_io_write(IOCode ioc)
{
	if(ioc == WRITE_UINT32 || ioc == WRITE_FLOAT32 || ioc == WRITE_UINTPTR || ioc == WRITE_POINTER || ioc == WRITE_UINT16 || ioc == WRITE_UINT8 || ioc == WRITE_UINT64)
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
								: (name.equals("write_pointer") ? WRITE_POINTER
									: (name.equals("read_pointer") ? READ_POINTER
										: (name.equals("write_uint16") ? WRITE_UINT16
											: (name.equals("read_uint16") ? READ_UINT16
												: (name.equals("write_uint8") ? WRITE_UINT8
													: (name.equals("read_uint8") ? READ_UINT8
														: (name.equals("write_uint64") ? WRITE_UINT64
															: (name.equals("read_uint64") ? READ_UINT64
																: NOT_IO))))))))))))));

	return ioc;
}


// chase down the indices until you reach an array of int8's.  
// return the string correspondig to the array.
std::string Aa::locate_portname_from_gep(llvm::Constant *konst,
		std::vector<llvm::Value*>& indices)
{
	std::string ret_string;
	llvm::ConstantArray* konst_array = NULL;

	std::cerr << "Info: locating portname in constant GEP ";
	konst->dump();
	std::cerr << std::endl;

	// check that the first index is 0.
	llvm::Value* idx = indices[0];
	int idx_val = 0;
	if(isa<ConstantInt>(idx))
	{
		ConstantInt *cint= dyn_cast<ConstantInt>(idx);
		idx_val = cint->getLimitedValue(INT_MAX);
	}
	else
	{
		std::cerr << "Error: in locating pipe name in io call: argument to GEP is not an integer" << std::endl;
		return(ret_string);
	}

	if(idx_val != 0)
	{
		std::cerr << "Error: in locating pipe name in io call: first index to GEP must be 0" << std::endl;
		return(ret_string);
	}

	// walk the indices until you get to a string..
	konst_array = dyn_cast<ConstantArray>(konst);
	if(konst_array && konst_array->isString())
	{
		ret_string = konst_array->getAsString();
	}
	else
	{
		for (unsigned i = 1; i < indices.size(); ++i)
		{

			llvm::Value* idx = indices[i];
			int idx_val = 0;

			if(isa<ConstantInt>(idx))
			{
				ConstantInt *cint= dyn_cast<ConstantInt>(idx);
				idx_val = cint->getLimitedValue(INT_MAX);
			}
			else
			{
				std::cerr << "Error: in locating pipe name in io call: argument to GEP is not an integer" << std::endl;
				break;
			}

			if(!(idx_val < konst->getNumOperands()))
			{
				std::cerr << "Error: in locating pipe name in io call: index in GEP out of range.." << std::endl;		  
				break;
			}

			llvm::Value* element_val = konst->getOperand(idx_val);
			konst = dyn_cast<Constant>(element_val);

			if(konst == NULL)
			{
				std::cerr << "Error: in locating pipe name in io call: in GEP reached a non-constant element.." << std::endl;		  
				break;
			}

			konst_array = dyn_cast<ConstantArray>(konst);
			if(konst_array && konst_array->isString())
			{
				ret_string = konst_array->getAsString();
				break;
			}
		}
	}

	return(ret_string);
}


std::string Aa::locate_portname_from_constant_expression(llvm::ConstantExpr* konst_expr)
{
	std::string ret_string;
	llvm::Constant* konst = NULL;
	llvm::ConstantArray* konst_array = NULL;

	unsigned opcode = konst_expr->getOpcode();
	if (opcode == Instruction::GetElementPtr) 
	{
		llvm::Value* ptr = konst_expr->getOperand(0);
		std::vector<llvm::Value*> indices;
		for(unsigned int i = 1; i < konst_expr->getNumOperands(); i++)
		{
			indices.push_back(konst_expr->getOperand(i));
		}

		llvm::Constant* konst = dyn_cast<Constant>(ptr);

		if(konst)
			ret_string = locate_portname_from_gep(konst,indices);
		else
			std::cerr << "Error: pipe name must be part of a global constant (if accessed through GEP expression)" << std::endl;	
	}
	else
	{
		std::cerr << "Error: cannot locate portname from constant expression which is not a GEP" << std::endl;
		konst_expr->dump();
		std::cerr << std::endl;
	}
	return(ret_string);
}

std::string Aa::locate_portname_from_gep_instruction(llvm::GetElementPtrInst* gep_instr)
{
	std::string ret_string;
	llvm::Value* ptr = gep_instr->getPointerOperand();
	llvm::GlobalVariable* gv;
	llvm::Constant* konst = NULL;

	if(isa<GlobalVariable>(ptr))
	{
		gv = dyn_cast<GlobalVariable>(ptr);
		konst = gv->getInitializer();
		if(gv->isConstant())
		{
			konst = gv->getInitializer();
		}
	}
	else if(isa<Constant>(ptr))
		konst = dyn_cast<Constant>(ptr);

	if(konst == NULL)
	{
		std::cerr << "Error: pipe name must be part of a global constant (if accessed through GEP instruction)" << std::endl;
		gep_instr->dump();
	}
	else
	{
		std::vector<llvm::Value*> indices;
		for(unsigned int i = 1; i < gep_instr->getNumOperands(); i++)
		{
			indices.push_back(gep_instr->getOperand(i));
		}

		ret_string = locate_portname_from_gep(konst,indices);
	}

	return(ret_string);
}

// hunt back till you find the string..
std::string Aa::locate_portname_for_io_call(llvm::Value *strptr)
{
	std::string ret_string;
	ConstantArray* konst = NULL;
	ConstantExpr* konst_expr = NULL;
	GetElementPtrInst* gep_instr;

	std::deque<llvm::Value*> queue;
	queue.push_back(strptr);

	while (!queue.empty()) {
		llvm::Value *val = queue.front();
		queue.pop_front();
		konst = dyn_cast<ConstantArray>(val);
		if (konst != NULL)
			break;


		konst_expr = dyn_cast<ConstantExpr>(val);
		if (konst_expr != NULL)
		{
			ret_string = locate_portname_from_constant_expression(konst_expr);
			break;
		}

		gep_instr = dyn_cast<GetElementPtrInst>(val);
		if(gep_instr != NULL)
		{
			ret_string = locate_portname_from_gep_instruction(gep_instr);
			break;
		}

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

bool Aa::is_a_supported_constant(llvm::Constant* konst)
{
  if(isa<ConstantInt>(konst) || isa<ConstantFP>(konst))
    {
      return(true);
    }
  if(isa<ConstantPointerNull>(konst))
    {
      return(true);
    }
  else if(isa<ConstantArray>(konst) || isa<ConstantVector>(konst) 
	  || isa<ConstantStruct>(konst))
    {
      int dim = konst->getNumOperands();
      for (unsigned int i = 0; i != konst->getNumOperands(); ++i) 
	{
	  llvm::Value *el = konst->getOperand(i);
	  if(isa<llvm::Constant>(el))
	    {
	      llvm::Constant* el_c = dyn_cast<llvm::Constant>(el);
	      if(!is_a_supported_constant(el_c))
		{
		  return(false);
		}
	    }
	  else
	    return(false);
	}
      return(true);
    }
  else if(isa<ConstantAggregateZero>(konst))
    {
      return(true);
    }
  else
    {
      return(false);
    }
}

bool Aa::is_used_in_module(llvm::GlobalVariable &G, std::set<std::string>& module_names)
{
  for(llvm::Value::use_iterator ui = G.use_begin(), uf = G.use_end();
      ui != uf;
      ui++)
    {
      if(isa<Instruction>(*ui))
	{
	  llvm::Instruction* I = dyn_cast<llvm::Instruction>(*ui);
	  llvm::BasicBlock* pb = I->getParent();
	  if(pb != NULL)
	    {
	      llvm::Function* f = pb->getParent();
	      if(f != NULL)
		{
		  std::string fname = f->getNameStr();
		  if(module_names.count(fname) > 0)
		    {
		      return(true);
		    }
		}
	    }
	}
    }
  return (false);
}

void Aa::write_storage_object(std::string& obj_name, llvm::GlobalVariable &G, llvm::Module& tst,
			      std::vector<std::string>& init_obj_vector,
			      bool create_initializer,
			      bool skip_zero_initializers)
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

		  if(is_a_supported_constant(init))
		    {
		      if(!(isa<ConstantAggregateZero>(init) && skip_zero_initializers))
			{
			  std::string initializer_name = "default_initializer_" + obj_name;
			  init_obj_vector.push_back(initializer_name);
			  
			  std::cerr << "Info: Initial value specified for " << obj_name << ": will create initializer module" << std::endl;
			  std::cout << "$module [" << initializer_name << "] $in () $out () $is {" << std::endl;
			  write_storage_initializer_statements(obj_name,init,skip_zero_initializers);
			  std::cout << "$attribute nooptimize " << std::endl;
			  std::cout << "}" << std::endl;
			}
		    }
		  else
		    {
		      std::cerr << "Warning: Unsupprted initial value specified for " << obj_name << ": will ignore it! " << std::endl;

		    }
		}
	      else
		{
		  std::cerr << "Warning: Initial value specified for " << obj_name << " will be ignored" << std::endl;		
		}
	    }
	}
}

void Aa::write_storage_initializer_statements(std::string& prefix, llvm::Constant* konst, bool skip_zero_initializers)
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
			write_storage_initializer_statements(forward_prefix,cast<llvm::Constant>(el), skip_zero_initializers);
		}
	}
	else if(isa<ConstantAggregateZero>(konst))
	{
	  if(!skip_zero_initializers)
	    write_zero_initializer_recursive(prefix,konst->getType(),0);      
	}
	else
	{
		std::cerr << "Error: constant must be one of int/fp/array/struct/vector/aggregate-zero/pointer-null" 
			<< std::endl;
		std::cout << prefix << " := UNSUPPORTED_CONSTANT" << std::endl;
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


int Aa::type_width(const llvm::Type* ptr, int ptr_width)
{
  if(ptr->isPointerTy())
    {
      return(ptr_width);
    }

  if(ptr->isVoidTy())
    return(0);
  
  if(isa<ArrayType>(ptr) || isa<VectorType>(ptr))
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
      
      return(dim*type_width(el_type,ptr_width));
    }
	
  if(isa<StructType>(ptr))
    {
      const llvm::StructType *ptr_struct = dyn_cast<llvm::StructType>(ptr);
      int ret_width = 0;
      for(int idx = 0; idx < ptr_struct->getNumElements(); idx++)
	{
	  ret_width += type_width(ptr_struct->getElementType(idx),ptr_width);
	}

      return(ret_width);
    }
  
  if(isa<IntegerType>(ptr))
    {
      const llvm::IntegerType*   ptr_int = dyn_cast<llvm::IntegerType>(ptr);
      return(ptr_int->getBitWidth());
    }
  
  if(ptr->isFloatTy())
    {
      return(32);
    }
  
  if(ptr->isDoubleTy())
    {
      return(64);
    }
  
  if(ptr->isVoidTy())
    {
      return(0);
    }
  
  if(ptr->isFunctionTy())
    {
      return(ptr_width);
    } 

  
  std::cerr << "Error: unsupported type (type width unknown, return -1)" << std::endl;
  return(-1);
}

bool Aa::parse_pipe_depth_spec(std::string line, std::string& pipe_name, int& pipe_depth)
{
  bool ret_val = false;
  char* line_str = (char*) line.c_str();

  char* name_str = strtok(line_str," ");
  if(name_str != NULL)
    {
      pipe_name = std::string(name_str);
      char* wid_str = strtok(NULL," \n");
      if(wid_str != NULL)
	{
	  int wid = atoi(wid_str);
	  if(wid > 0)
	    {
	      pipe_depth = wid;
	      ret_val = true;
	    }
	}
    }
  
  return(ret_val);
}




