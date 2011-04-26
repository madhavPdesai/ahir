#ifndef __HLS_TYPE_HPP__
#define __HLS_TYPE_HPP__

#include <map>
#include <string>
#include <assert.h>

namespace hls {

  typedef enum { NoType, APIntID, APFloatID } TypeID;
  
  struct Type 
  {
    const TypeID type_id;

    const unsigned int_width;
    const unsigned exp_width;
    const unsigned frc_width;

    unsigned width() const
    {
      switch (type_id) {
        case APIntID:
          return int_width;
          break;

        case APFloatID:
          return exp_width + frc_width + 1;
          break;

        default:
          assert(false);
          return 0;
      }
    }

    Type(unsigned i)
      : type_id(APIntID)
      , int_width(i), exp_width(0), frc_width(0)
    {}

    Type(unsigned e, unsigned f)
      : type_id(APFloatID)
      , int_width(0), exp_width(e), frc_width(f)
    {}
  };

  std::string str(TypeID t); // "APInt" or "APFloat" 
  std::string str(const Type *t);
  std::string get_apint_description(unsigned w);
  std::string get_apfloat_description(unsigned e, unsigned f);
}

#endif
