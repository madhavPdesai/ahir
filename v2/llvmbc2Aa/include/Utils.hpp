#ifndef __HLS_LLVM_TYPE_UTILS_HPP__
#define __HLS_LLVM_TYPE_UTILS_HPP__

#include <string>

namespace llvm {
  class Type;
  class Constant;
  class TargetData;
  class Use;
  class CallInst;
  class User;
}

namespace Aa {
  
  typedef enum {
    NOT_IO
    , READ_UINT32, WRITE_UINT32
    , READ_FLOAT32, WRITE_FLOAT32
    , READ_UINTPTR, WRITE_UINTPTR
    , READ_POINTER, WRITE_POINTER
    , READ_UINT16, WRITE_UINT16
    , READ_UINT8, WRITE_UINT8
    , READ_UINT64, WRITE_UINT64
  } IOCode;

  unsigned getTypeSizeInBits(llvm::TargetData *TD, const llvm::Type *type);
  unsigned getTypePaddedSize(llvm::TargetData *TD, const llvm::Type *type);
  
  std::string getTypeDescription(const llvm::Type *type);
  std::string getTypeName(const llvm::Type *type);
  
  std::string to_aa(std::string x);
  std::string getValue(const llvm::Constant *konst);
  IOCode get_io_code(llvm::Use &u);
  IOCode get_io_code(llvm::User *u);
  IOCode get_io_code(llvm::CallInst &C);

  bool is_io_read(IOCode ioc);
  bool is_io_write(IOCode ioc);
  bool is_a_supported_constant(llvm::Constant* konst);
  bool is_used_in_module(llvm::GlobalVariable &G, std::set<std::string>& module_names);

  std::string locate_portname_from_gep_instruction(llvm::GetElementPtrInst* gep_instr);
  std::string locate_portname_from_gep(llvm::Constant* konst,
				       std::vector<llvm::Value*>& indices);
  std::string locate_portname_from_constant_expression(llvm::ConstantExpr* konst_expr);
  std::string locate_portname_for_io_call(llvm::Value *strptr);
  void write_type_declaration(llvm::Type *T,llvm::Module& tst);
  void write_storage_object(std::string& obj_name, llvm::GlobalVariable &G,llvm::Module& tst,
			    std::vector<std::string>& init_obj_vector,
			    bool create_initializers);
  std::string get_aa_type_name(const llvm::Type* ptr, llvm::Module& tst);
  std::string get_zero_value(const llvm::Type* ptr);
  std::string get_aa_type_name(IOCode ioc);
  std::string get_aa_value_string(const llvm::Value* val);
  std::string get_aa_constant_string(llvm::Constant *konst);
  std::string int_to_str(int a);
  std::string llvm_opcode_to_string(unsigned op_code);

  void write_zero_initializer_recursive(std::string prefix,const llvm::Type* ptr, int depth);
  void write_storage_initializer_statements(std::string& prefix, llvm::Constant* konst);
  int number_of_bits_needed_to_represent(int m);

  int type_width(const llvm::Type* t, int ptr_width);

  bool parse_pipe_depth_spec(std::string line, std::string& pipe_name, int& pipe_depth);
}

#endif
