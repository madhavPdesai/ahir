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

  std::string locate_portname_for_io_call(llvm::Value *strptr);
  void write_type_declaration(llvm::Type *T,llvm::Module& tst);
  void write_storage_object(llvm::GlobalVariable &G,llvm::Module& tst);
  std::string get_aa_type_name(const llvm::Type* ptr, llvm::Module& tst);
  std::string get_aa_type_name(IOCode ioc);
  std::string get_aa_value_string(const llvm::Value* val);
  std::string get_aa_constant_string(llvm::Constant *konst);
  std::string int_to_str(int a);
  std::string llvm_opcode_to_string(unsigned op_code);
}

#endif
