#ifndef __VHDL_LINKLAYER_HPP__
#define __VHDL_LINKLAYER_HPP__

#include "Entity.hpp"

namespace ahir {
  class LinkLayer;
}

namespace vhdl {
  
  struct LinkLayer : public Entity
  {
    std::string instance_name();
    std::string component_name();
    ahir::LinkLayer *aln;
    
    LinkLayer(const std::string _id, ahir::LinkLayer *_aln);
  };

  LinkLayer* create_ln(ahir::LinkLayer *aln);

  void print_ln(LinkLayer *ln, bool clocked);
}

#endif
