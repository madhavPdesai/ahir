#ifndef __VHDL_ENTITY_PRINTER_HPP__
#define __VHDL_ENTITY_PRINTER_HPP__

#include <Base/ostream.hpp>
#include "Utils.hpp"

namespace vhdl {

  class Entity;

  void print_object_declaration(Entity *entity
				, const std::string &type
				, hls::ostream &out);

  void print_instance(Entity *entity, hls::ostream &out);
   
}

#endif
