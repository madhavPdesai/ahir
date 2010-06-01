#include "CDFGParser.hpp"

#include <boost/lexical_cast.hpp>
#include <assert.h>

using namespace cdfg;
using namespace hls;

void CDFGParser::on_start_element(const Glib::ustring& name
				  , const xmlpp::SaxParser::AttributeList& properties)
{
  std::string id;
  stack.push_back(state);

  if (find_attribute(properties, "id"))
    id = get_attribute(properties, "id");
  
  switch (state) {
    case INIT:
      if (name == "cdfg") {
	state = CDFG;
      } else
	assert(false && "unexpected element");
      break;
      
    case CDFG:
      if (name == "node") {
	state = NODE;
	factory->create_node(id, get_attribute(properties, "ntype")
			     , maybe_get_attribute(properties, "description"));
      } else
	assert(false && "unexpected element");
      break;

    case NODE:
      if (name == "port") {
	state = PORT;
	std::string ptype = get_attribute(properties, "ptype");
	std::string iotype = get_attribute(properties, "iotype");
	if (ptype == "data") {
	  if (iotype == "in")
	    factory->create_input_data_port(id, get_attribute(properties, "type")
					    , get_attribute(properties, "edge"));
	  else if (iotype == "out")
	    factory->create_output_data_port(id, get_attribute(properties, "type")
					     , get_attribute(properties, "edge"));
	  else
	    assert(false && "unexpected value for iotype");
	} else if (ptype == "control") {
	  if (iotype == "in")
	    factory->create_input_control_port(id, get_attribute(properties, "edge"));
	  else if (iotype == "out")
	    factory->create_output_control_port(id, get_attribute(properties, "edge"));
	  else
	    assert(false && "unexpected value for iotype");
	}
      } else if (name == "value") {
	state = CONSTANT;
      } else if (name == "addressable") {
	state = ADDRESSABLE_BACKREF;
	factory->node_register_addressable(id);
      } else if (name == "callee") {
	state = CALLEE;
      } else if (name == "counterpart") {
	state = COUNTERPART;
	factory->node_register_counterpart(id);
      } else if (name == "portname") {
        state = PORTNAME;
      } else 
	assert(false && "unexpected element");
      break;

    default:
      assert(false && "unexpected state");
      break;
  }
}

void CDFGParser::on_characters(const Glib::ustring &characters)
{
  switch (state) {
    case CONSTANT:
      factory->node_set_constant(characters);
      break;
      
    case CALLEE:
      factory->node_register_callee(characters);
      break;

    case PORTNAME:
      factory->node_register_io_portname(characters);
      break;
      
    default:
      break;
  }
}

void CDFGParser::on_end_element(const Glib::ustring& name)
{
  assert(stack.size() > 0);
  state = stack.back();
  stack.pop_back();

  if (state == INIT) {
    assert(name == "cdfg");
  }
}
