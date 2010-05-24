#ifndef __VHDL_ENTITY_HPP__
#define __VHDL_ENTITY_HPP__

#include <Base/ostream.hpp>
#include "typedefs.hpp"
#include <Base/Utils.hpp>
#include <Base/NodeType.hpp>

#include <string>
#include <map>
#include <vector>
#include <iostream>

#include <assert.h>

namespace vhdl {

  struct Generic
  {
    std::string id;
    std::string type;
    std::string value;

    Generic(const std::string &_id
	    , const std::string &_type
	    , const std::string &_value)
      : id(_id), type(_type), value(_value)
    {}
  };

  struct Entity 
  {
    std::string id;

    EntityType type;

    std::string description;
    std::string configuration;

    PortList ports;
    void register_port(Port *port);
    Port* find_port(const std::string &id);
    void remove_port(const std::string &id);
    
    WireList wires;
    void register_wire(Wire *wire);
    Wire* find_wire(const std::string &id);
    void declare_wires(hls::ostream &out);
    
    GenericList generics;
    void register_generic(Generic *gen);
    Generic* find_generic(const std::string &id);

    StatementList statements;
    void register_statement(const std::string &st)
    {
      statements.push_back(st);
    }
    void print_statements(hls::ostream &out);

    PreludeLines prelude;
    void append_to_prelude(const std::string &st)
    {
      prelude.push_back(st);
    }
    void print_prelude(hls::ostream &out);

    EntityList instances;
    void register_instance(Entity *entity);
    Entity* find_instance(const std::string &id);

    virtual std::string instance_name() = 0;
    virtual std::string component_name() = 0;
    virtual void print_instance_hook(hls::ostream &out) {};

    Entity(const std::string _id, EntityType _t, const std::string &d)
      : id(_id), type(_t), description(d)
    {}

    virtual ~Entity() {};
  };
}

#endif
