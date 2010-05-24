#include "Entity.hpp"
#include "Utils.hpp"
#include "Assignable.hpp"
#include <AHIR/DataPath.hpp>

#include <boost/format.hpp>
#include <assert.h>

using namespace vhdl;
using namespace hls;

vhdl::Port* Entity::find_port(const std::string &id)
{
  if (ports.find(id) != ports.end())
    return ports[id];
  return NULL;
}

void Entity::register_port(Port *port) 
{
  assert(ports.find(port->id) == ports.end());
  ports[port->id] = port;
}

void Entity::remove_port(const std::string &id) 
{
  assert(find_port(id));
  ports.erase(id);
}

vhdl::Wire* Entity::find_wire(const std::string &id)
{
  if (wires.find(id) != wires.end())
    return wires[id];
  return NULL;
}

void Entity::register_wire(Wire *wire) 
{
  assert(!find_wire(wire->id));
  wires[wire->id] = wire;
}

void Entity::print_statements(hls::ostream &out)
{
  for (StatementList::iterator si = statements.begin()
         , se = statements.end(); si != se; ++si) {
    out << indent << *si;
  }
}

void Entity::print_prelude(hls::ostream &out)
{
  for (PreludeLines::iterator pi = prelude.begin()
         , pe = prelude.end(); pi != pe; ++pi) {
    out << indent << *pi;
  }
}

void Entity::declare_wires(hls::ostream &out)
{
  if (wires.size() == 0) {
    std::cerr << "\nno wires in entity " << id;
    return;
  }
  
  for (WireList::const_iterator wi = wires.begin(), we = wires.end();
       wi != we; ++wi) {
    const Wire *wire = (*wi).second;
    out << indent << "signal " << wire->id << " : " << wire->type << ";";
  }
  out << "\n";
}

void Entity::register_generic(Generic *gen)
{
  assert(!find_generic(gen->id));
  generics[gen->id] = gen;
}

Generic* Entity::find_generic(const std::string &id)
{
  if (generics.find(id) != generics.end())
    return generics[id];
  return NULL;
}

void Entity::register_instance(Entity *entity)
{
  assert(!find_instance(entity->id));
  instances[entity->id] = entity;
}

Entity* Entity::find_instance(const std::string &id)
{
  if (instances.find(id) != instances.end())
    return instances[id];

  return NULL;
}
