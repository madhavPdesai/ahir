#ifndef VHDL_ARBITER_HPP
#define VHDL_ARBITER_HPP

#include "Entity.hpp"
#include <AHIR/Arbiter.hpp>

namespace vhdl {

  struct Arbiter : public Entity
  {
    std::string component_name() { return "CallArbiter"; }
    std::string instance_name() { return id; }

    ahir::ClientList clients;
    
    Arbiter(const std::string _id, const std::string &d)
      : Entity(_id, ARB, d)
    {} 
  };
}

#endif
