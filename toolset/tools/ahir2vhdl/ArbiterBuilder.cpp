#include "ArbiterBuilder.hpp"
#include "EntityBuilder.hpp"
#include "Arbiter.hpp"
#include "DataPath.hpp"

#include <AHIR/Arbiter.hpp>

using namespace vhdl;

namespace {

  unsigned number_of_bits(unsigned x)
  {
    assert(x != 0);

    unsigned count = 0;
    while (x > 0) {
      x >>= 1;
      count++;
    }

    return count;
  }
}

Arbiter* vhdl::create_arbiter(ahir::Arbiter *arb, vhdl::DataPath *dp)
{
  const unsigned num_clients = arb->clients.size();
  assert(num_clients > 0);
  const Range all_clients =  Range(DOWNTO, num_clients);
  
  const unsigned call_tag_width = number_of_bits(num_clients);
  const Range all_tags = Range(DOWNTO, call_tag_width);
  
  Arbiter *arbiter = new Arbiter(arb->id, "");

  create_port(arbiter->ports, "clk", hls::IN, "std_logic");
  create_port(arbiter->ports, "reset", hls::IN, "std_logic");

  DPElement *acceptor = dp->acceptor;
  Port *accept_data = acceptor->find_port("odata");
  assert(accept_data);
  create_port(arbiter->ports, "call_mreq", hls::OUT, "std_logic");
  create_port(arbiter->ports, "call_mack", hls::IN, "std_logic");
  create_port(arbiter->ports, "call_mdata", hls::OUT, accept_data->type);
  create_port(arbiter->ports, "call_mtag", hls::OUT, "std_logic_vector", all_tags);

  create_port(arbiter->ports, "call_reqs", hls::IN, "std_logic_vector", all_clients);
  create_port(arbiter->ports, "call_acks", hls::OUT, "std_logic_vector", all_clients);
  Port *call_data = create_port(arbiter->ports, "call_data", hls::IN
                                , Type("StdLogicArray2D", accept_data->type.ranges));
  call_data->type.ranges.push_front(all_clients);

  DPElement *retval = dp->retval;
  Port *return_data = retval->find_port("odata");
  assert(return_data);
  create_port(arbiter->ports, "return_mreq", hls::IN, "std_logic");
  create_port(arbiter->ports, "return_mack", hls::OUT, "std_logic");
  create_port(arbiter->ports, "return_mdata", hls::IN, return_data->type);
  create_port(arbiter->ports, "return_mtag", hls::IN, "std_logic_vector", all_tags);

  create_port(arbiter->ports, "return_reqs", hls::IN, "std_logic_vector", all_clients);
  create_port(arbiter->ports, "return_acks", hls::OUT, "std_logic_vector", all_clients);
  Port *port = create_port(arbiter->ports, "return_data", hls::OUT
                           , Type("StdLogicArray2D", return_data->type.ranges));
  port->type.ranges.push_front(all_clients);

  std::swap(arb->clients, arbiter->clients);

  return arbiter;
}
