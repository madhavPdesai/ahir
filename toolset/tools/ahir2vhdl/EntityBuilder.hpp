#ifndef __VHDL_ENTITYBUILDER_HPP__
#define __VHDL_ENTITYBUILDER_HPP__

#include "Assignable.hpp"
#include "Entity.hpp"

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

  inline Port* entity_create_port_with_map_name(Entity *entity
                                                , const std::string &pid, hls::IOType io_type
                                                , const vhdl::Type &t
                                                , MappingType m
                                                , const std::string &name)
  {
    Port *port = create_port(entity->ports, pid, io_type, t);
    port->mapping(m, name);
    return port;
  }
    
  inline Port* entity_create_port_with_map(Entity *entity
                                           , const std::string &pid, hls::IOType io_type
                                           , const vhdl::Type &t
                                           , MappingType m)
  {
    return entity_create_port_with_map_name(entity, pid, io_type, t, m
                                            , entity->id + "_" + pid);
  }
  
  inline void entity_create_clk_ports(Entity *entity)
  {
    Port *port = entity_create_port_with_map_name(entity, "clk", hls::IN
                                                  , vhdl::Type("std_logic")
                                                  , SLICE, "clk");
    port->is_control = true;
    port = entity_create_port_with_map_name(entity, "reset", hls::IN
                                            , vhdl::Type("std_logic")
                                            , SLICE, "reset");
    port->is_control = true;
  }
}

#endif
