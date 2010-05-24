#ifndef __HLS_COMMON_UTILS_HPP__
#define __HLS_COMMON_UTILS_HPP__

#include <string>

namespace hls {

  //! Useful for DFS traversal of various structures.
  typedef enum {WHITE, GRAY, BLACK, RED, GREEN, BLUE} Colour;
  typedef enum {IN, OUT} IOType;

  std::string create_bitstring(unsigned value, unsigned size);
}

namespace ahir {

  // Constants used in the control path. They are here so that users
  // don't have to include ControlPath.hpp just for these.
  const unsigned marked_place_id = 0;
  const unsigned init_id = 1;
  const unsigned fin_id = 2;

};


#endif
