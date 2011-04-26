#ifndef __CDFG_FACTORY_HPP__
#define __CDFG_FACTORY_HPP__

#include "../Base/Factory.hpp"

namespace hls
{
  class Program;
};

namespace cdfg {

  class CDFG;
  class CDFGNode;
  class Port;
  
  struct CDFGFactory : public hls::Factory
  {
    CDFG *cdfg;
    CDFGNode *node;

    CDFGFactory();

    void create_module_hook(const std::string &id, const std::string &type);

    void create_node(const std::string &id
		     , const std::string &ntype
		     , const std::string &description);
    void create_input_data_port(const std::string &id
				, const std::string &type
				, const std::string &edge);
    void create_output_data_port(const std::string &id
				 , const std::string &type
				 , const std::string &edge);
    void create_input_control_port(const std::string &id
				   , const std::string &edge);
    void create_output_control_port(const std::string &id
				    , const std::string &edge);
    void connect_edge(Port *port, const std::string &eid);

    void node_register_addressable(const std::string &id);
    void node_register_callee(const std::string &callee);
    void node_register_counterpart(const std::string &id);
    void node_register_io_portname(const std::string &id);

    void node_set_constant(const std::string &characters);
  };
  
};

#endif
