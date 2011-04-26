#ifndef AHIR_COVER_HPP
#define AHIR_COVER_HPP

// The type for CliqueSet is not defined on purpose. This file should
// always be included *after* LRG.hpp
namespace ahir {

  void generate_cover(LRG &lrg, CliqueSet &cover, bool use_weights);
  bool verify_cover(LRG &lrg, CliqueSet &cover, bool use_weights);
  
}

#endif
