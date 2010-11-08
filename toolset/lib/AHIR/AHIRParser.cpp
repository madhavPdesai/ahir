#include "AHIRParser.hpp"

#include <boost/lexical_cast.hpp>
#include <assert.h>

using namespace ahir;
using namespace hls;

void AHIRParser::on_start_element(const Glib::ustring& name,
				  const xmlpp::SaxParser::AttributeList& properties)
{
  std::string id;
  stack.push_back(state);

  if (find_attribute(properties, "id"))
    id = get_attribute(properties, "id");
  
  switch (state) {
    case INIT:
      if (name == "dp") {
	state = DP;
      } else if (name == "cp") {
	state = CP;
      } else if (name == "ln") {
	state = LN;
      } else if (name == "arbiter") {
	state = ARBITER;
      } else
	assert(false && "unexpected element");
      break;

    case DP:
      if (name == "dpe") {
	state = DPE;
	factory->create_dpe(id, get_attribute(properties, "ntype")
			    , maybe_get_attribute(properties, "description"));
      } else if (name == "wrapper") {
	state = WRAPPER;
	factory->create_wrapper(id, maybe_get_attribute(properties, "description"));
      } else
	assert(false && "unexpected element");
      break;

    case WRAPPER:
      if (name == "member") {
	state = MEMBER;
	factory->wrapper_add_member(id);
      } else
	assert(false && "unexpected element");
      break;

    case DPE:
      if (name == "req") {
	state = DPE_REQ;
	factory->dpe_new_req(id);
      } else if (name == "ack") {
	state = DPE_ACK;
	factory->dpe_new_ack(id);
      } else if (name == "port") {
	state = DPE_PORT;
	factory->create_port(id, get_attribute(properties, "iotype")
			     , get_attribute(properties, "type")
			     , get_attribute(properties, "wire"));
      } else if (name == "callee") {
	state = DPE_CALLEE;
      } else if (name == "value") {
	state = DPE_VALUE;
      } else if (name == "addressable") {
	state = DPE_ADDRESSABLE;
      } else if (name == "counterpart") {
	state = DPE_COUNTERPART;
      } else if (name == "portname") {
        state = DPE_PORTNAME;
      } else
	assert(false && "unexpected element");
      break;

    case CP:
      if (name == "place") {
	state = PLACE;
	factory->create_place(id, get_attribute(properties, "marking")
			      , maybe_get_attribute(properties, "description"));
      } else if (name == "transition") {
	state = TRANS;
	factory->create_transition(id, get_attribute(properties, "type")
				   , get_attribute(properties, "symbol")
				   , maybe_get_attribute(properties, "description"));
      } else
	assert(false && "unexpected element");
      break;

    case TRANS:
      if (name == "src") {
	state = TRANS_SRC;
	factory->transition_add_src(id);
      } else if (name == "snk") {
	state = TRANS_SNK;
	factory->transition_add_snk(id);
      } else
	assert(false && "unexpected element");
      break;
    
    case LN:
      if (name == "map") {
	state = LN_MAP;
	factory->map_symbols(get_attribute(properties, "src")
			     , get_attribute(properties, "src_sym")
			     , get_attribute(properties, "snk")
			     , get_attribute(properties, "snk_sym"));
      } else
	assert(false && "unexpected element");
      break;

    case ARBITER:
      if (name == "client") {
	state = CLIENT;
	factory->create_client(id, get_attribute(properties, "module")
			       , get_attribute(properties, "callsite"));
      } else
	assert(false && "unexpected element");
      break;

    default:
      assert(false && "unexpected state");
  }
}

void AHIRParser::on_characters(const Glib::ustring& characters)
{
  switch (state) {
    case DPE_REQ:
      factory->dpe_set_req(characters);
      break;

    case DPE_ACK:
      factory->dpe_set_ack(characters);
      break;

    case DPE_VALUE:
      factory->dpe_set_value(characters);
      break;

    case DPE_ADDRESSABLE:
      factory->dpe_set_addressable(characters);
      break;

    case DPE_CALLEE:
      factory->dpe_set_callee(characters);
      break;

    case DPE_COUNTERPART:
      factory->dpe_set_counterpart(characters);
      break;

    case DPE_PORTNAME:
      factory->dpe_set_io_portname(characters);
      break;

    default:
      break;
  }
}

void AHIRParser::on_end_element(const Glib::ustring& name)
{
  switch (state) {
    case CP:
      assert(name == "cp");
      factory->commit_cp();
      break;

    case DP:
      assert(name == "dp");
      factory->commit_dp();
      break;

    case DPE:
      assert(name == "dpe");
      factory->commit_dpe();
      break;

    default:
      break;
  }
  
  assert(stack.size() > 0 && "invalid stack");
  state = stack.back();
  stack.pop_back();
}
