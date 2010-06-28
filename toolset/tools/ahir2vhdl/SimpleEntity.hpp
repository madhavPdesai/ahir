#ifndef SIMPLEENTITY_HPP
#define SIMPLEENTITY_HPP

#include "Entity.hpp"

namespace vhdl {

  struct SimpleEntity : Entity 
  {
    SimpleEntity(const std::string &instance, const std::string &component)
      : Entity(instance, SIMPLE, component)
    {}

    std::string instance_name() { return id; }
    std::string component_name() { return description; } 
  };
  
}

#endif
