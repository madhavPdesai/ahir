#include "LLVM.hpp"
#include "typedefs.hpp"
#include "Exception.hpp"
#include "Utils.hpp"

#include <Base/NodeType.hpp>

#include <llvm/ADT/APInt.h>
#include <llvm/Constants.h>
#include <llvm/Instruction.h>
#include <llvm/InstrTypes.h>
#include <llvm/ADT/APFloat.h>

#include <boost/lexical_cast.hpp>
#include <boost/program_options.hpp>
namespace po = boost::program_options;

#include <string>
#include <sstream>
#include <cstdlib>
#include <vector>
#include <fstream>
#include <limits>
#include <iostream>

void generate_i2i_tests(std::ostream &ofs
                        , const std::vector<llvm::APInt> &x
                        , bool is_signed
                        , unsigned output_size) 
{
  for (unsigned i = 0, e = x.size(); i != e; ++i) {

    llvm::APInt apint = x[i];
    unsigned input_size = apint.getBitWidth();
    ofs << get_padded_string(apint);

    if (output_size < input_size) {
      apint.trunc(output_size);
    } else if (output_size > input_size) {
      if (!is_signed) {
        apint.zext(output_size);
      } else {
        apint.sext(output_size);
      }
    } else
      throw TGE("unreachable code!");

    ofs << " " << get_padded_string(apint) << "\n";
  }
}

void generate_i2f_tests(std::ostream &ofs
                        , const std::vector<llvm::APInt> &x
                        , bool is_signed
                        , const std::string &output_desc) 
{
  int exp, frc;

  parse_float_type(output_desc, exp, frc);

  llvm::APFloat apf(llvm::APInt::getNullValue(exp - frc + 1), true);
  for (unsigned i = 0, e = x.size(); i != e; ++i) {
    apf.convertFromAPInt(x[i], is_signed, llvm::APFloat::rmTowardZero);
    ofs << get_padded_string(x[i]) << " "
        << get_padded_string(apf) << "\n"; 
  }
}

void generate_apint_binary_tests(std::ostream &out
                                 , const std::vector<llvm::APInt> &x
                                 , const std::vector<llvm::APInt> &y
                                 , hls::NodeType ntype)
{
  llvm::Instruction::BinaryOps opcode = llvm::Instruction::FMul;
  llvm::CmpInst::Predicate cmp = llvm::CmpInst::FCMP_FALSE;

  switch (ntype) {

    case hls::FAdd:
    case hls::FSub:
    case hls::FMul:
    case hls::FDiv:
    case hls::FRem:
      throw TGE("instruction not supported:" + hls::str(ntype));
      break;
      
    default:
      break;
  }
  
  switch (ntype) {
    
#define HANDLE_BINARY(op) case hls::op:                   \
    opcode = llvm::Instruction::op;                       \
    break;
#define HANDLE_FCMP(op)
#define HANDLE_ICMP(op)
#include <Base/NodeType.inc>

#define HANDLE_ICMP(op) case hls::op:           \
    cmp = llvm::CmpInst::op;                    \
    break;
#include <Base/NodeType.inc>
    
    default:
      throw TGE("instruction not supported:" + hls::str(ntype));
  }
    
  for (unsigned i = 0, e = x.size(); i != e; ++i) {

    llvm::ConstantInt *first = llvm::ConstantInt::get(LC, x[i]);
    llvm::ConstantInt *second = llvm::ConstantInt::get(LC, y[i]);

    switch (opcode) {
      case llvm::Instruction::Shl:
      case llvm::Instruction::AShr:
      case llvm::Instruction::LShr: {
        // Second argument cannot be larger than the width. Hence we
        // use URem to reduce it.
        llvm::ConstantInt *cw = llvm::ConstantInt::get(first->getType()
                                                       , first->getValue().getBitWidth());
        llvm::Constant *sec = llvm::ConstantExpr::get(llvm::Instruction::URem
                                                      , second, cw);
        second = llvm::cast<llvm::ConstantInt>(sec);
      }
        break;

      default:
        break;
    }

    llvm::Constant *k;
    if (opcode != llvm::Instruction::FMul) {
      if (cmp != llvm::CmpInst::FCMP_FALSE)
        throw TGE("unexpected state");
      k = llvm::ConstantExpr::get(opcode, first, second);
    } else {
      if (cmp == llvm::CmpInst::FCMP_FALSE)
        throw TGE("unexpected state");
      k = llvm::ConstantExpr::getCompare(cmp, first, second);
    }
    
    llvm::ConstantInt *ki = llvm::cast<llvm::ConstantInt>(k);
    out << "\n" << get_padded_string(first->getValue())
        << " " << get_padded_string(second->getValue())
        << " " << get_padded_string(ki->getValue());
  }

  out << "\n";
}

void generate_integers(std::vector<llvm::APInt> &x
                       , unsigned width, unsigned count)
{
  for (unsigned i = 0; i < count; ++i) {
    x.push_back(llvm::APInt(width, random_bitstring(width), 2));
  }
}

void generate_apint_tests(std::ostream &ofs
                          , unsigned num_cases
                          , const std::string &opcode_fraction
                          , const std::string &input_details
                          , const std::string &output_details)
{
  std::string opcode = opcode_fraction;

  unsigned size;
  parse_integer_type(input_details, size);

  std::vector<llvm::APInt> x;
  generate_integers(x, size, num_cases);

  if (boost::istarts_with(opcode, "toapint")) {
    unsigned output_size;
    parse_integer_type(output_details, output_size);
    if (size == output_size)
      throw TGE("null operation: " + opcode_fraction);
    boost::ierase_first(opcode, "toapint");
    generate_i2i_tests(ofs, x, boost::iequals(opcode, "signed"), output_size);
  } else if (boost::istarts_with(opcode, "toapfloat")) {
    boost::ierase_first(opcode, "toapfloat");
    generate_i2f_tests(ofs, x, boost::iequals(opcode, "signed"), output_details);
  } else {

    hls::NodeType ntype = hls::ntype(opcode);
    if (ntype == hls::DUMMY) {
      ntype = hls::ntype("icmp_" + opcode);
      if (ntype == hls::DUMMY)
        throw TGE("unknown integer opcode: " + opcode);
    }
    
    if (!is_binary(ntype))
      throw TGE("expected binary integer operation here");
    
    std::vector<llvm::APInt> y;
    generate_integers(y, size, num_cases);

    generate_apint_binary_tests(ofs, x, y, ntype);
  }
}
