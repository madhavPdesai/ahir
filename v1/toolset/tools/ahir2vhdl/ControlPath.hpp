#ifndef __VHDL_CONTROLPATH_HPP__
#define __VHDL_CONTROLPATH_HPP__

#include "Entity.hpp"

namespace ahir {
  class ControlPath;
}

namespace vhdl {
  
  struct ControlPath : public Entity
  {
    std::string instance_name();
    std::string component_name();
    ahir::ControlPath *acp;
    
    ControlPath(const std::string _id, ahir::ControlPath *_acp);
  };

  ControlPath* create_cp(ahir::ControlPath *acp);

  void print_cp(ControlPath *cp);

}

#endif
