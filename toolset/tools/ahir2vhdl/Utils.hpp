#ifndef __VHDL_UTILS_HPP__
#define __VHDL_UTILS_HPP__

#include <Base/NodeType.hpp>

#include <map>
#include <string>

namespace hls {
  class Type;
}

namespace ahir {

  class DPElement;
  class Port;
  class Wire;
  
}

namespace vhdl {

  class Port;
  class Generic;
  class Entity;
  class DPElement;
  
  // std::string vhdl_type_name(ahir::Port *port);
  std::string vhdl_array_type_name(const hls::Type *type);

  std::string vhdl_wire_name(ahir::Wire *wire);

  bool has_no_instance(hls::NodeType ntype);
  const std::string& vhdl_component_name(hls::NodeType ntype);
  
  void init_names();
  std::string vhdl_type_name(ahir::DPElement *dpe);
  std::string vhdl_component_name(ahir::DPElement *dpe);
  std::string vhdl_configuration_name(ahir::DPElement *dpe);
  const std::string& vhdl_configuration_name(hls::NodeType ntype);
  std::string get_conversion_spec(const std::string &value, const hls::Type *type);

  std::string natural_array_all_same(unsigned number, unsigned copies);
}

namespace memory {

  extern unsigned data_width;
  extern unsigned address_width;
  extern unsigned tag_width;

  unsigned get_num_addressable_units(unsigned width);

}

#endif
