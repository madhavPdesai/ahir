#include "Type.hpp"

#include <sstream>

using namespace hls;

std::string hls::str(TypeID t) 
{
  switch (t) {
    case APIntID: return "APInt"; break;
    case APFloatID: return "APFloat"; break;
    default: break;
  }

  assert(false);
  return "xyzzy";
}

std::string hls::str(const Type *t)
{
  switch (t->type_id) {
    case APIntID:
      return get_apint_description(t->int_width);
      break;

    case APFloatID:
      return get_apfloat_description(t->exp_width, t->frc_width);
      break;

    default:
      assert(false);
      return "xyzzy";
      break;
  }
}

std::string hls::get_apint_description(unsigned w)
{
  std::ostringstream str;
  str << hls::str(APIntID) << "(" << w << ")";

  return str.str();
}

std::string hls::get_apfloat_description(unsigned e, unsigned f)
{
  std::ostringstream str;
  str << hls::str(APFloatID) << "(" << e << ", " << f << ")";

  return str.str();
}
