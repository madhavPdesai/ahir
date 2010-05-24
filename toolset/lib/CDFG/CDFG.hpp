#ifndef __CDFG_HPP__
#define __CDFG_HPP__

#include "../Base/NodeType.hpp"
#include "../Base/Module.hpp"
#include "../Base/Utils.hpp"
#include "../Base/Type.hpp"

#include <map>
#include <string>
#include <vector>
#include <set>

namespace hls {
  class Addressable;
  class CallSite;
  class Program;
};

namespace cdfg {

  class CDFGNode;
  class CDFGEdge;

  struct Port {
    std::string id;
    CDFGNode *parent;
    CDFGEdge *edge;

    hls::IOType dir;
    
    typedef enum {Control, Data} PortType;
    PortType port_type;

    const hls::Type *type;

    Port(const std::string &_id, hls::IOType _io, PortType _pt)
      : id(_id), parent(NULL), edge(NULL)
      , dir(_io), port_type(_pt), type(NULL)
    {};

    ~Port();
  };

  inline bool is_input(Port *port) { return port->dir == hls::IN; }
  inline bool is_output(Port *port) { return port->dir == hls::OUT; }

  inline bool is_control(Port *port) { return port->port_type == Port::Control; };
  inline bool is_data(Port *port) { return port->port_type == Port::Data; };

  struct CDFGEdge {
    std::string id;

    typedef std::set<Port*> UserList;
    UserList users;
    Port *driver;

    CDFGEdge(const std::string &_id)
    {
      id = _id;
      driver = NULL;
    }
  };

  struct CDFGNode {
    unsigned id;
    hls::NodeType ntype;
    std::string description;

    typedef std::map<std::string, Port*> PortList;
    PortList input_data_ports;
    PortList output_data_ports;
    PortList input_control_ports;
    PortList output_control_ports;
    PortList ports;
    
    void register_port(Port *port);
    
    void register_input_data_port(Port *port);
    void register_output_data_port(Port *port);
    Port* find_input_data_port(const std::string &id);
    Port* find_output_data_port(const std::string &id);
    
    void register_input_control_port(Port *port);
    void register_output_control_port(Port *port);
    Port* find_input_control_port(const std::string &id);
    Port* find_output_control_port(const std::string &id);
    
    // big fat fingers in the eye of OOP
    std::string callee;
    std::string value; // used by Constant
    hls::Addressable *addressable; // used by Address
    CDFGNode *counterpart;	   // LC <-> LR mapping
    
    // typedef std::map<unsigned, std::string> CaseMap;
    // CaseMap switch_cases; // used by SwitchInst
    // void register_case(unsigned value, const std::string &port_id);

    hls::Colour colour;

    CDFGNode(unsigned _id, hls::NodeType _type, const std::string &_d)
      : id(_id), ntype(_type), description(_d), addressable(NULL), counterpart(NULL)
    {}

    ~CDFGNode();
  };

  struct CDFG : public hls::Module
  {
    typedef std::map<unsigned, CDFGNode*> NodeList;
    NodeList nodes;
    void register_node(CDFGNode *node);
    CDFGNode* find_node(unsigned id);

    typedef std::map<std::string, CDFGEdge*> EdgeList;
    EdgeList edges;
    void register_edge(CDFGEdge *edge);
    CDFGEdge* find_edge(const std::string &id);

    CDFGNode *start;
    CDFGNode *stop;
    CDFGNode *acceptor;
    CDFGNode *retval;

    CDFG(const std::string& _id);
    ~CDFG();
  };


};

inline bool is_cdfg(hls::Module *f) { return f->type == "cdfg"; }

cdfg::CDFG* get_cdfg(hls::Program *program, const std::string &id);

inline cdfg::CDFG* to_cdfg(hls::Module *module)
{
  if (is_cdfg(module))
    return static_cast<cdfg::CDFG*>(module);
  return NULL;
}

#endif
