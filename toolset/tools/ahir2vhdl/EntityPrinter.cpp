#include "EntityPrinter.hpp"
#include "Entity.hpp"
#include "Assignable.hpp"

#include <boost/format.hpp>
#include <fstream>

using namespace vhdl;
using namespace hls;

namespace {
  
  void print_type_declaration(Port *port, hls::ostream &out)
  {
    out << port->type;
  }

  void print_generic_list_declaration(GenericList &glist, hls::ostream &out)
  {
    if (glist.size() == 0)
      return;
    
    out << indent << "generic(";

    out << indent_in;
    // We iterate upto but NOT including the last element in the list,
    // given by --end(). This is valid because std::map is a Reversible
    // Container (and so are other containers in the STL.)
    GenericList::iterator pe = --glist.end();
    for (GenericList::iterator pi = glist.begin(); pi != pe; ++pi) {
      Generic *generic = (*pi).second;

      out << indent << generic->id << " : " << generic->type << ";";    
    }
    // print the last generic
    Generic *generic = (*pe).second;
    out << indent << generic->id << " : " << generic->type << ");";
    out << indent_out;
  }

  void print_port_list_declaration(PortList &plist, hls::ostream &out)
  {
    assert(plist.size() != 0);
    
    out << indent << "port(";

    out << indent_in;
    // We iterate upto but NOT including the last element in the list,
    // given by --end(). This is valid because std::map is a Reversible
    // Container (and so are other containers in the STL.)
    PortList::iterator pe = --plist.end();
    for (PortList::iterator pi = plist.begin(); pi != pe; ++pi) {
      Port *port = (*pi).second;

      out << indent << port->id
	  << " : " << (port->io_type == IN ? "in " : "out ");
      print_type_declaration(port, out);
      out << ";";    
    }
    // print the last port
    Port *port = (*pe).second;
    out << indent << port->id << " : "
	<< (port->io_type == IN ? "in " : "out ");
    print_type_declaration(port, out);
    out << ");";
    out << indent_out;
  }

  void print_generic_map(Entity *entity, hls::ostream &out)
  {
    GenericList &plist = entity->generics;
    if (plist.size() == 0)
      return;
  
    out << indent << "generic map(";
    out << indent_in;
  
    GenericList::iterator pe = --plist.end();
    for (GenericList::iterator pi = plist.begin(); pi != pe; ++pi) {
      Generic *generic = (*pi).second;
      out << indent << generic->id << " => " << generic->value << ",";
    }
    Generic *generic = (*pe).second;
    out << indent << generic->id << " => " << generic->value << ")";

    out << indent_out;
  }

  void print_port_map(Entity *entity, hls::ostream &out)
  {
    PortList &plist = entity->ports;
  
    out << indent << "port map(";
    out << indent_in;
  
    PortList::iterator pe = --plist.end();
    for (PortList::iterator pi = plist.begin(); pi != pe; ++pi) {
      Port *port = (*pi).second;
      out << indent << port->id << " => " << port->mapping << ",";
    }
    Port *port = (*pe).second;
    out << indent << port->id << " => " << port->mapping << ")";

    out << indent_out;
  }

} // end anonymous namespace

void vhdl::print_object_declaration(Entity *entity
				    , const std::string &type
				    , hls::ostream &out)
{
  out << indent << type << " " << entity->id << " is";
  out << indent_in;
  print_generic_list_declaration(entity->generics, out);
  print_port_list_declaration(entity->ports, out);
  out << indent_out;
  if (type == "component")
    out << indent << "end component;";
  else
    out << indent << "end " << entity->id << ";";
  out <<"\n";
}

void vhdl::print_instance(Entity *entity, hls::ostream &out)
{
  entity->print_prelude(out);
  
  out << indent << entity->instance_name() << " : "
      << entity->component_name()
      << " -- " << entity->description
      << indent << "-- configuration: " << entity->configuration;
  entity->print_instance_hook(out);
  out << indent_in;

  print_generic_map(entity, out);
  print_port_map(entity, out);
  
  out << ";"
      << "\n";
  out << indent_out;
}
