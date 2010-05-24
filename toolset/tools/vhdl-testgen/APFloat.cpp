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

void generate_floats(std::vector<llvm::APFloat> &x
                     , unsigned exp, unsigned frc, unsigned num_cases)
{
  for (unsigned i = 0; i < num_cases; ++i) {
    int width = exp - frc + 1;
    x.push_back(llvm::APFloat(llvm::APInt
                              (width, random_bitstring(width), 2)));
  }
}

void generate_f2f_tests(std::ostream &ofs
                        , const std::vector<llvm::APFloat> &x
                        , int exp, int frc)
{
  for (unsigned i = 0, e = x.size(); i != e; ++i) {

    llvm::APFloat apf = x[i];
    bool ignored;

    ofs << get_padded_string(apf);
    apf.convert((exp == 8 ? llvm::APFloat::IEEEsingle
                 : (exp == 11 ? llvm::APFloat::IEEEdouble
                    : llvm::APFloat::Bogus))
                , llvm::APFloat::rmTowardZero, &ignored);
    ofs << " " << get_padded_string(apf) << "\n";
  }
}

void generate_f2i_tests(std::ostream &ofs
                        , const std::vector<llvm::APFloat> &x
                        , bool is_signed
                        , unsigned width) 
{
  for (unsigned i = 0, e = x.size(); i != e; ++i) {
    const llvm::APFloat &apf = x[i];
    bool ignored;
    uint64_t x[2];
    apf.convertToInteger(x, width, is_signed,
                         llvm::APFloat::rmTowardZero, &ignored);
    llvm::APInt Val(width, 2, x);
    ofs << get_padded_string(apf) << " " << get_padded_string(Val) << "\n";
  }
}

void generate_apfloat_binary_tests(std::ostream &out
                                   , const std::vector<llvm::APFloat> &x
                                   , const std::vector<llvm::APFloat> &y
                                   , hls::NodeType ntype)
{
  llvm::Instruction::BinaryOps opcode = llvm::Instruction::Mul;
  llvm::CmpInst::Predicate cmp = llvm::CmpInst::FCMP_FALSE;

  switch (ntype) {
    case hls::Sub:
    case hls::Mul:
    case hls::SDiv:
    case hls::UDiv:
    case hls::SRem:
    case hls::URem:
    case hls::And:
    case hls::Or:
    case hls::Xor:
      throw TGE("instruction not supported:" + hls::str(ntype));
      break;

    default:
      break;
  }

  switch (ntype) {
    
#define HANDLE_BINARY(op) case hls::op:         \
    opcode = llvm::Instruction::op;             \
    break;
#define HANDLE_FCMP(op)
#define HANDLE_ICMP(op)
#include <Base/NodeType.inc>

#define HANDLE_FCMP(op) case hls::op:           \
    cmp = llvm::CmpInst::op;                    \
    break;
#include <Base/NodeType.inc>
    
    default:
      throw TGE("instruction not supported:" + hls::str(ntype));
  }
    
  for (unsigned i = 0, e = x.size(); i != e; ++i) {

    llvm::ConstantFP *first = llvm::ConstantFP::get(LC, x[i]);
    llvm::ConstantFP *second = llvm::ConstantFP::get(LC, y[i]);

    llvm::Constant *k;
    if (opcode != llvm::Instruction::Mul) {
      if (cmp != llvm::CmpInst::FCMP_FALSE)
        throw TGE("unexpected state");
      k = llvm::ConstantExpr::get(opcode, first, second);

      llvm::ConstantFP *ki = llvm::cast<llvm::ConstantFP>(k);
      out << "\n" << get_padded_string(first->getValueAPF())
          << " " << get_padded_string(second->getValueAPF())
          << " " << get_padded_string(ki->getValueAPF());
    } else {
      if (cmp == llvm::CmpInst::FCMP_FALSE)
        throw TGE("unexpected state");
      k = llvm::ConstantExpr::getCompare(cmp, first, second);
      
      llvm::ConstantInt *ki = llvm::cast<llvm::ConstantInt>(k);
      out << "\n" << get_padded_string(first->getValueAPF())
          << " " << get_padded_string(second->getValueAPF())
          << " " << get_padded_string(ki->getValue());
    }
  }

  out << "\n";
}

void generate_apfloat_tests(std::ostream &ofs
                            , unsigned num_cases
                            , const std::string &opcode_fraction
                            , const std::string &input_details
                            , const std::string &output_details)
{
  std::string opcode = opcode_fraction;

  int exp, frc;
  parse_float_type(input_details, exp, frc);

  std::vector<llvm::APFloat> x;
  generate_floats(x, exp, frc, num_cases);

  if (boost::istarts_with(opcode, "toapint")) {
    unsigned output_size;
    parse_integer_type(output_details, output_size);
    boost::ierase_first(opcode, "toapint");
    generate_f2i_tests(ofs, x, boost::iequals(opcode, "signed"), output_size);
  } else if (boost::istarts_with(opcode, "toapfloat")) {
    boost::ierase_first(opcode, "toapfloat");
    int exp_out, frc_out;
    parse_float_type(output_details, exp_out, frc_out);
    if (exp == exp_out)
      throw TGE("null operation: " + input_details + " " + output_details);
    generate_f2f_tests(ofs, x, exp_out, frc_out);
  } else {
    hls::NodeType ntype = hls::ntype("f" + opcode);
    if (ntype == hls::DUMMY) {
      ntype = hls::ntype("fcmp_" + opcode);
      if (ntype == hls::DUMMY)
        throw TGE("unknown floating point opcode: " + opcode);
    }
    
    if (!is_binary(ntype))
      throw TGE("expected binary floating point operation here: " + opcode);
  
    std::vector<llvm::APFloat> y;
    generate_floats(y, exp, frc, num_cases);
  
    generate_apfloat_binary_tests(ofs, x, y, ntype);
  }
}
