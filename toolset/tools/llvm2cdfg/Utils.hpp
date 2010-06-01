#ifndef __HLS_LLVM_TYPE_UTILS_HPP__
#define __HLS_LLVM_TYPE_UTILS_HPP__

#include <string>

namespace hls {
  class Value;
  class Type;
  class Program;
}

namespace llvm {
  class Type;
  class Constant;
  class TargetData;
  class Use;
  class CallInst;
  class User;
}

namespace cdfg {
  
  typedef enum {
    NOT_IO
    , READ_UINT32, WRITE_UINT32
    , READ_FLOAT32, WRITE_FLOAT32
  } IOCode;

  unsigned getTypeSizeInBits(llvm::TargetData *TD, const llvm::Type *type);
  unsigned getTypePaddedSize(llvm::TargetData *TD, const llvm::Type *type);
  
  std::string getTypeDescription(const llvm::Type *type);
  std::string getTypeName(const llvm::Type *type);
  
  std::string getValue(const llvm::Constant *konst);
  hls::Value* getAddressableValue(llvm::Constant *konst
                                  , hls::Program *program
				  , llvm::TargetData *TD);

  const hls::Type* get_type(hls::Program *program, llvm::TargetData *TD
                            , const llvm::Type *type);

  IOCode get_io_code(llvm::Use &u);
  IOCode get_io_code(llvm::User *u);
  IOCode get_io_code(llvm::CallInst &C);
}

#endif
