#include "CDFG.hpp"
#include "../Base/Program.hpp"

#include <iostream>
#include <assert.h>

using namespace cdfg;
using namespace hls;

CDFG::CDFG(const std::string& _id)
  : Module(_id, "cdfg"), start(NULL), stop(NULL)
  , acceptor(NULL), retval(NULL)
{
}

CDFG::~CDFG()
{
  for (NodeList::iterator ni = nodes.begin(), ne = nodes.end();
       ni != ne; ++ni) {
    CDFGNode *node = (*ni).second;
    delete node;
  }

  for (EdgeList::iterator ni = edges.begin(), ne = edges.end();
       ni != ne; ++ni) {
    CDFGEdge *edge = (*ni).second;
    delete edge;
  }
}

void CDFG::register_edge(CDFGEdge *edge)
{
  assert(edges.find(edge->id) == edges.end());
  edges[edge->id] = edge;
}

CDFGEdge* CDFG::find_edge(const std::string &eid)
{
  if (edges.find(eid) != edges.end())
    return edges[eid];
  else
    return NULL;
}

void CDFG::register_node(CDFGNode *node)
{
  unsigned id = node->id;
  assert(id > 0 && "node must have a name at this point");
  assert(nodes.find(id) == nodes.end() && "node already exists");
  
  nodes[id] = node;

  // switch (node->ntype) {

  // case Call:
    // register_callsite(node->id);
    // break;

  // default:
    // break;
  // }
}

CDFGNode::~CDFGNode()
{
  for (PortList::iterator di = ports.begin(),
	 de = ports.end();
       di != de; ++di) {
    Port *port = (*di).second;
    delete port;
  }
}

Port::~Port()
{

}

CDFGNode* CDFG::find_node(unsigned id)
{
  if (nodes.find(id) == nodes.end())
    return NULL;
  return nodes[id];
}

void CDFGNode::register_input_data_port(Port *port)
{
  assert(!find_input_data_port(port->id));
  input_data_ports[port->id] = port;
  register_port(port);
}

void CDFGNode::register_output_data_port(Port *port)
{
  assert(!find_output_data_port(port->id));
  output_data_ports[port->id] = port;
  register_port(port);
}

Port* CDFGNode::find_input_data_port(const std::string &id)
{
  if (input_data_ports.find(id) != input_data_ports.end())
    return input_data_ports[id];
  else
    return NULL;
}

Port* CDFGNode::find_output_data_port(const std::string &id)
{
  if (output_data_ports.find(id) != output_data_ports.end())
    return output_data_ports[id];
  else
    return NULL;
}

void CDFGNode::register_port(Port *port)
{
  assert(ports.find(port->id) == ports.end());
  ports[port->id] = port;
  assert(!port->parent);
  port->parent = this;
}

void CDFGNode::register_input_control_port(Port *port)
{
  assert(!find_input_control_port(port->id));
  input_control_ports[port->id] = port;
  register_port(port);
}

void CDFGNode::register_output_control_port(Port *port)
{
  assert(!find_output_control_port(port->id));
  output_control_ports[port->id] = port;
  register_port(port);
}

Port* CDFGNode::find_input_control_port(const std::string &id)
{
  if (input_control_ports.find(id) != input_control_ports.end())
    return input_control_ports[id];
  else
    return NULL;
}

Port* CDFGNode::find_output_control_port(const std::string &id)
{
  if (output_control_ports.find(id) != output_control_ports.end())
    return output_control_ports[id];
  else
    return NULL;
}

CDFG* get_cdfg(hls::Program *program, const std::string &id)
{
  hls::Module *module = program->find_module(id);
  assert(module);
  CDFG *cdfg = to_cdfg(module);
  assert(cdfg);
  return cdfg;
}
