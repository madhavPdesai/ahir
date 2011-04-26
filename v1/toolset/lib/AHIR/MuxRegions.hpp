#ifndef __MUXREGIONS_HPP__
#define __MUXREGIONS_HPP__

namespace ahir {
  class ControlPath;

  void replace_mux_regions(ControlPath *cp);
  void restore_mux_regions(ControlPath *cp);
};

#endif
