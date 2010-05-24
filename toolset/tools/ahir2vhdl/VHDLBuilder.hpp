#ifndef __VHDL_BUILDER_HPP__
#define __VHDL_BUILDER_HPP__

#include "typedefs.hpp"

namespace hls {
  class Program;
}

namespace vhdl {

  void ahir2vhdl(hls::Program *program);
  
}

#endif
