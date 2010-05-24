#include "CDFGFactory.hpp"

#include "../Base/Program.hpp"
#include "../Base/Addressable.hpp"
#include "CDFG.hpp"

#include <boost/lexical_cast.hpp>

#include <iostream>
#include <assert.h>

using namespace cdfg;
using namespace hls;

CDFGFactory::CDFGFactory()
  : hls::Factory()
{
  cdfg = NULL;
  node = NULL;
}

void CDFGFactory::create_module_hook(const std::string &id, const std::string &type)
{
  assert(type == "cdfg");
  cdfg = new CDFG(id);
  module = cdfg;
}

void CDFGFactory::create_node(const std::string &id
			      , const std::string &ntype
			      , const std::string &description)
{
  node = new CDFGNode(boost::lexical_cast<unsigned>(id)
		      , hls::ntype(ntype), description);
  assert(cdfg);
  cdfg->register_node(node);
}

void CDFGFactory::create_input_data_port(const std::string &id
					 , const std::string &type
					 , const std::string &edge)
{
  Port *port = new Port(id, IN, Port::Data);
  port->type = program->find_type(type);
  assert(port->type);

  node->register_input_data_port(port);
  connect_edge(port, edge);
}

void CDFGFactory::create_output_data_port(const std::string &id
					  , const std::string &type
					  , const std::string &edge)
{
  Port *port = new Port(id, OUT, Port::Data);
  port->type = program->find_type(type);
  assert(port->type);

  node->register_output_data_port(port);
  connect_edge(port, edge);
}

void CDFGFactory::create_input_control_port(const std::string &id
					    , const std::string &edge)
{
  Port *port = new Port(id, IN, Port::Control);
  node->register_input_control_port(port);
  connect_edge(port, edge);
}

void CDFGFactory::create_output_control_port(const std::string &id
					    , const std::string &edge)
{
  Port *port = new Port(id, OUT, Port::Control);
  node->register_output_control_port(port);
  connect_edge(port, edge);
}

void CDFGFactory::connect_edge(Port *port, const std::string &eid)
{
  assert(port);
  CDFGEdge *edge = cdfg->find_edge(eid);
  if (!edge) {
    edge = new CDFGEdge(eid);
    cdfg->register_edge(edge);
  }

  if (port->dir == IN) {
    edge->users.insert(port);
  } else {
    assert(!edge->driver);
    edge->driver = port;
  }

  assert(!port->edge);
  port->edge = edge;
}

void CDFGFactory::node_register_counterpart(const std::string &id)
{
  CDFGNode *cpart = cdfg->find_node(boost::lexical_cast<unsigned>(id));
  if (cpart) {
    assert(!cpart->counterpart);
    cpart->counterpart = node;
    node->counterpart = cpart;
  }
}

void CDFGFactory::node_register_addressable(const std::string &id)
{
  Addressable *addr = program->find_addressable(id);
  assert(addr);
  node->addressable = addr;
  addr->register_address(module->id, node->id);
}
  
void CDFGFactory::node_set_constant(const std::string &characters)
{
  assert(node->value.size() == 0);
  node->value = characters;
}

void CDFGFactory::node_register_callee(const std::string &callee)
{
  assert(node->ntype == Call);
  node->callee = callee;
}
