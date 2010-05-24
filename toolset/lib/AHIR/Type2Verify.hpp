#ifndef AHIR_TYPE2VERIFY_HPP
#define AHIR_TYPE2VERIFY_HPP

namespace hls {
  
  class Program;
}

namespace ahir {
  
  class ControlPath;
  
  bool verify_type2(ControlPath *cp);
  bool verify_type2(hls::Program *program);
}

#endif
