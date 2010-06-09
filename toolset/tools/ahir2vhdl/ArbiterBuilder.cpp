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

  DPElement *response = dp->retval;
  Port *response_data = response->find_port("odata");
  assert(response_data);

  /* ===== Tag ports on the DP ===== */

  Port *call_tag_port = dp->find_port("call_tag");
  assert(call_tag_port);
  call_tag_port->mapping.ranges.push_front(all_tags);

  Port *return_tag_port = dp->find_port("return_tag");
  assert(return_tag_port);
  return_tag_port->mapping.ranges.push_front(all_tags);

  /* ===== Call mports on the arbiter ===== */
  entity_create_port_with_map_name(arbiter, "call_mreq", hls::OUT
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_call_req");
  entity_create_port_with_map_name(arbiter, "call_mack", hls::IN
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_call_ack");
  entity_create_port_with_map_name(arbiter, "call_mdata", hls::OUT
                                   , vhdl::Type("std_logic_vector"
                                                , accept_data->get_range(0))
                                   , SLICE, dp->id + "_call_data");
  entity_create_port_with_map_name(arbiter, "call_mtag", hls::OUT
                                   , vhdl::Type("std_logic_vector", all_tags)
                                   , SLICE, dp->id + "_call_tag");

  /* ===== Call ports on the arbiter ===== */
  entity_create_port_with_map(arbiter, "call_reqs", hls::IN
                              , vhdl::Type("std_logic_vector", all_clients)
                              , WIRE);
  entity_create_port_with_map(arbiter, "call_acks", hls::OUT
                              , vhdl::Type("std_logic_vector", all_clients)
                              , WIRE);
  Port *call_data = entity_create_port_with_map(arbiter, "call_data", hls::IN
                                                , Type("StdLogicArray2D"
                                                       , accept_data->get_range(0))
                                                , WIRE);
  call_data->type.ranges.push_front(all_clients);

  /* ===== Return mports on the arbiter ===== */
  
  entity_create_port_with_map_name(arbiter, "return_mreq", hls::IN
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_return_req");
  entity_create_port_with_map_name(arbiter, "return_mack", hls::OUT
                                   , vhdl::Type("std_logic")
                                   , SLICE, dp->id + "_return_ack");
  entity_create_port_with_map_name(arbiter, "return_mdata", hls::IN
                                   , vhdl::Type("std_logic_vector"
                                                , response_data->get_range(0))
                                   , SLICE, dp->id + "_return_data");
  entity_create_port_with_map_name(arbiter, "return_mtag", hls::IN
                                   , vhdl::Type("std_logic_vector", all_tags)
                                   , SLICE, dp->id + "_return_tag");

  /* ===== Return ports on the arbiter ===== */
  
  entity_create_port_with_map(arbiter, "return_reqs", hls::IN
                              , vhdl::Type("std_logic_vector", all_clients)
                              , WIRE);
  entity_create_port_with_map(arbiter, "return_acks", hls::OUT
                              , vhdl::Type("std_logic_vector", all_clients)
                              , WIRE);
  Port *return_data = entity_create_port_with_map(arbiter, "return_data", hls::OUT
                                                    , Type("StdLogicArray2D"
                                                           , response_data->get_range(0))
                                                    , WIRE);
  return_data->type.ranges.push_front(all_clients);
  
  arbiter->clients = arb->clients;

  return arbiter;
}
