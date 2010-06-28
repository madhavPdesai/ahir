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

  // Returns true if at least one signal declaration was printed.
  // Useful for inserting blank lines as separators.
  bool entity_declare_mapped_signals(Entity *ent, hls::ostream &out);

  void entity_print_registered_instances(Entity *entity, hls::ostream &out);
  void entity_declare_registered_wires(Entity *entity, hls::ostream &out);
}

#endif
