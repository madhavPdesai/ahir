#ifndef __HLS_COMMON_UTILS_HPP__
#define __HLS_COMMON_UTILS_HPP__

#include <string>

namespace hls {

  //! Useful for DFS traversal of various structures.
  typedef enum {WHITE, GRAY, BLACK, RED, GREEN, BLUE} Colour;
  typedef enum {IN, OUT} IOType;

  std::string create_bitstring(unsigned value, unsigned size);
}

#endif
