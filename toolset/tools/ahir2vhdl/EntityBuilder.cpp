#include "EntityBuilder.hpp"
#include "Entity.hpp"

#include <AHIR/DataPath.hpp>
#include <Base/Type.hpp>

#include <iostream>

using namespace vhdl;
using namespace hls;

Port* record_port(PortList &plist, Port *port)
{
  assert(plist.find(port->id) == plist.end());
  plist[port->id] = port;
  return port;
}

Port* vhdl::create_port(const std::string &id
                        , IOType io_type, const Type &t
                        , bool is_control)
{
  return new Port(id, io_type, t, is_control);
}

Port* vhdl::create_port(PortList &plist, const std::string &id
                        , IOType io_type, const Type &t
                        , bool is_control) 
{
  return record_port(plist, create_port(id, io_type, t, is_control));
}
    
Port* vhdl::create_port(PortList &plist
                        , const std::string &id
                        , IOType io_type
                        , const std::string &type
                        , const Range &r)
{
  return create_port(plist, id, io_type, Type(type, r));
}

Range vhdl::create_range(const hls::Type *type)
{
  Range r(TO, 0, 0);

  switch (type->type_id) {
    case APIntID:
      r = Range(DOWNTO, type->int_width);
      break;

    case APFloatID:
      r = Range(DOWNTO, type->exp_width, - (type->frc_width));
      break;

    default:
      assert(false);
      break;
  }

  return r;
}

Port* vhdl::create_port(PortList &plist
                        , const std::string &id
                        , hls::IOType io_type
                        , const std::string &type
                        , bool is_control)
{
  return create_port(plist, id, io_type, Type(type), is_control);
}

void vhdl::port_map(Entity *entity, const std::string &port_name
                    , MappingType mtype, const std::string &mapping_name
                    , RangeType rtype, int upper, int lower)
{
  Port *port = entity->find_port(port_name);
  assert(port);
  port->mapping(mtype, mapping_name
                , Range(rtype, upper, lower));
}

void vhdl::port_map_wire(Entity *entity, const std::string &port_name
                         , const std::string &mapping_name)
{
  Port *port = entity->find_port(port_name);
  assert(port);
  port->mapping(WIRE, mapping_name);
}

