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
    , READ_FLOAT64, WRITE_FLOAT64
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
  bool is_used_in_module(llvm::GlobalVariable &G, std::set<std::string>& module_names, bool consider_all_modules);

  std::string locate_portname_from_gep_instruction(llvm::GetElementPtrInst* gep_instr);
  std::string locate_portname_from_gep(llvm::Constant* konst,
				       std::vector<llvm::Value*>& indices);
  std::string locate_portname_from_constant_expression(llvm::ConstantExpr* konst_expr);
  std::string locate_portname_for_io_call(llvm::Value *strptr);
  void write_type_declaration(llvm::Type *T,llvm::Module& tst);

  std::string get_aa_type_name(const llvm::Type* ptr, llvm::Module& tst);
  std::string get_zero_value(const llvm::Type* ptr);
  std::string get_aa_type_name(IOCode ioc);
  std::string get_aa_value_string(const llvm::Value* val);
  std::string get_aa_constant_string(llvm::Constant *konst);

  unsigned int get_uint32(llvm::Constant* konst);

  bool used_only_in_io_calls(llvm::GetElementPtrInst &I);

  std::string int_to_str(int a);
  std::string llvm_opcode_to_string(unsigned op_code);


  int number_of_bits_needed_to_represent(int m);

  int type_width(const llvm::Type* t, int ptr_width);

  bool parse_pipe_depth_spec(std::string line, std::string& pipe_name, int& pipe_depth, bool& lifo_flag);
  bool is_private_storage_object(llvm::GlobalVariable* gv);
  bool is_zero(llvm::Constant* konst);

  bool is_marked_as_a_do_while_loop(llvm::BasicBlock& BB, int& pd, int& bd, bool& frflag);
  bool get_loop_pipelining_info(llvm::BasicBlock& BB,int& pipelining_depth, int& buffering, bool& full_rate_flag);

  llvm::BasicBlock* have_unique_common_successor(llvm::BasicBlock* u, llvm::BasicBlock* v);

  bool has_bb_successor(llvm::BasicBlock* succ, llvm::BasicBlock* bb);
  void write_reduction_expression(std::vector<std::string>& names, std::string op, std::ostream& ofile);
  
}

#endif
