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
  entity_create_clk_ports(arbiter);

  DPElement *acceptor = dp->acceptor;
  Port *accept_data = acceptor->find_port("odata");
  assert(accept_data);
  
  entity_create_port_with_map_name(arbiter, "call_mreq", hls::OUT
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_call_req");
  entity_create_port_with_map_name(arbiter, "call_mack", hls::IN
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_call_ack");
  entity_create_port_with_map_name(arbiter, "call_mdata", hls::OUT
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_call_data");
  entity_create_port_with_map_name(arbiter, "call_mtag", hls::OUT
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_call_tag");

  entity_create_port_with_map(arbiter, "call_reqs", hls::IN
                              , vhdl::Type("std_logic_vector", all_clients)
                              , WIRE);
  entity_create_port_with_map(arbiter, "call_acks", hls::OUT
                              , vhdl::Type("std_logic_vector", all_clients)
                              , WIRE);
  Port *call_data = entity_create_port_with_map(arbiter, "call_data", hls::IN
                                                , Type("StdLogicArray2D"
                                                       , accept_data->type.ranges)
                                                , WIRE);
  call_data->type.ranges.push_front(all_clients);

  DPElement *retval = dp->retval;
  Port *return_data = retval->find_port("odata");
  assert(return_data);
  
  entity_create_port_with_map_name(arbiter, "return_mreq", hls::IN
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_return_req");
  entity_create_port_with_map_name(arbiter, "return_mack", hls::OUT
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_return_ack");
  entity_create_port_with_map_name(arbiter, "return_mdata", hls::IN
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_return_data");
  entity_create_port_with_map_name(arbiter, "return_mtag", hls::IN
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_return_tag");

  entity_create_port_with_map(arbiter, "return_reqs", hls::IN
                              , vhdl::Type("std_logic_vector", all_clients)
                              , WIRE);
  entity_create_port_with_map(arbiter, "return_acks", hls::OUT
                              , vhdl::Type("std_logic_vector", all_clients)
                              , WIRE);
  Port *response_data = entity_create_port_with_map(arbiter, "return_data", hls::OUT
                                                    , Type("StdLogicArray2D"
                                                           , accept_data->type.ranges)
                                                    , WIRE);
  response_data->type.ranges.push_front(all_clients);
  
  arbiter->clients = arb->clients;

  return arbiter;
}
