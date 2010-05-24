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
}

namespace cdfg {
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
}

#endif
