#ifndef __VHDL_ENTITYBUILDER_HPP__
#define __VHDL_ENTITYBUILDER_HPP__

#include "Assignable.hpp"

namespace vhdl {

  Range create_range(const hls::Type *type);
  
  Port* create_port(const std::string &id
                    , hls::IOType io_type
                    , const Type &t, bool is_control = false);
  Port* create_port(PortList &plist
		    , const std::string &id
  		    , hls::IOType io_type
		    , const Type &t, bool is_control = false);
    
  Port* create_port(PortList &plist
		    , const std::string &id
		    , hls::IOType io_type
		    , const std::string &type
		    , const Range &r);

  Port* create_port(PortList &plist
                    , const std::string &id
                    , hls::IOType io_type
                    , const std::string &type
                    , bool is_control = false);

  Port* create_port_with_existing_wire(Entity *component
                                       , const std::string &port_id, hls::IOType dir
                                       , Entity *container, const std::string &wire_id);
  
  void port_map(Entity *entity, const std::string &port_name
                , MappingType mtype, const std::string &mapping_name
                , RangeType rtype, int upper, int lower);
  
  void port_map_slice(Entity *entity, const std::string &port_name
                      , const std::string &mapping_name);
  void port_map_wire(Entity *entity, const std::string &port_name
                      , const std::string &mapping_name);
}

#endif
