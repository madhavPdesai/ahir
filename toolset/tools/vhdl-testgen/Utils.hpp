#ifndef UTILS_HPP
#define UTILS_HPP

#include "Exception.hpp"

#include <llvm/ADT/APInt.h>
#include <llvm/ADT/APFloat.h>

#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>

#include <string>
#include <sstream>

inline std::string get_padded_string(const llvm::APInt &x)
{
  std::ostringstream os;

  // This creates enough zeroes if x itself is zero.
  for (unsigned i = 0, e = x.countLeadingZeros(); i != e; ++i)
    os << "0";

  // Hence we check it here.
  if (x != 0)
    os << x.toString(2, false);
  return os.str();
}

inline std::string get_padded_string(const llvm::APFloat &x)
{
  return get_padded_string(x.bitcastToAPInt());
}

inline void parse_float_type(const std::string &desc
                             , int &exp, int &frc)
{
  SV space_parts;
  boost::split(space_parts, desc, boost::is_any_of(" "));
  if (space_parts.size() == 0)
    throw TGE("insufficient details for floating point: " + desc);
  std::string &first_input = space_parts[0];
  SV comma_parts;
  boost::split(comma_parts, first_input, boost::is_any_of(","));
  if (comma_parts.size() != 2)
    throw TGE("incorrect details for floating point: " + desc);

  exp = boost::lexical_cast<int>(comma_parts[0]);
  frc = boost::lexical_cast<int>(comma_parts[1]);

  if (exp == 8) {
    if (frc != -23)
      throw TGE("unsupported floating type: " + desc);
  } else if (exp == 11) {
    if (frc != -52)
      throw TGE("unsupported floating type: " + desc);
  } else
      throw TGE("unsupported floating type: " + desc);
}

inline void parse_integer_type(const std::string &desc, unsigned &size)
{
  SV space_parts;
  boost::split(space_parts, desc, boost::is_any_of(" "));
  if (space_parts.size() == 0)
    throw TGE("insufficient details for input");
  std::string &first_input = space_parts[0];
  
  SV comma_parts;
  boost::split(comma_parts, first_input, boost::is_any_of(","));
  if (comma_parts.size() != 2)
    throw TGE("incorrect details for input");

  size = boost::lexical_cast<unsigned>(comma_parts[0]) + 1;
}

inline std::string random_bitstring(unsigned w)
{
  std::ostringstream s;

  for (unsigned i = 0; i < w; ++i) {
    s << (rand() & 1);
  }

  return s.str();
}

#endif
