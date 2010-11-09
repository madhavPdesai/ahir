#include "Parser.hpp"

#include <iostream>
#include <assert.h>

using namespace hls;

namespace {
  const Glib::ustring empty_string = "";
}

const Glib::ustring& hls::get_attribute(const xmlpp::SaxParser::AttributeList& list
					, const Glib::ustring& name)
{
  assert(list.size() != 0 && "no attributes present in the list");
  for (xmlpp::SaxParser::AttributeList::const_iterator i = list.begin(), e = list.end();
       i != e; ++i) {
    if ((*i).name == name)
      return (*i).value;
  }

  assert(false && "requested attribute does not exist");
}

bool hls::find_attribute(const xmlpp::SaxParser::AttributeList& list
			 , const Glib::ustring& name)
{
  for (xmlpp::SaxParser::AttributeList::const_iterator i = list.begin(), e = list.end();
       i != e; ++i) {
    if ((*i).name == name)
      return true;
  }
  return false;
}

const Glib::ustring& hls::maybe_get_attribute(const xmlpp::SaxParser::AttributeList& list
					      , const Glib::ustring& name)
{
  if (!find_attribute(list, name)) {
    return empty_string;
  } else {
    return get_attribute(list, name);
  }
}

void Parser::on_start_element(const Glib::ustring& name
			      , const xmlpp::SaxParser::AttributeList& properties)
{
  std::string id;
  stack.push_back(state);

  if (find_attribute(properties, "id"))
    id = get_attribute(properties, "id");
  
  switch (state) {
    case INIT:
      if (name == "program") {
	state = PROGRAM;
	factory->create_program(id);
      } else
	assert(false && "unexpected element");
      break;

    case PROGRAM:
      if (name == "module") {
	state = MODULE;
	std::string type = get_attribute(properties, "type");
	factory->create_module(id, type);
      } else if (name == "roots") {
        state = ROOTS;
      } else if (name == "mspace") {
	state = MSPACE;
      } else if (name == "types") {
        state = TYPES;
      } else
	assert(false && "unexpected element");
      break;

    case ROOTS:
      if (name == "root") {
        state = ROOT;
      } else
        assert(false && "unexpected element");
      break;
      
    case MSPACE:
      if (name == "mloc") {
	state = MLOC;
	factory->create_memory_location(id, get_attribute(properties, "type")
                                        , get_attribute(properties, "size")
                                        , maybe_get_attribute(properties, "address")
                                        , maybe_get_attribute(properties, "description"));
      } else
	assert(false && "unexpected element");
      break;

    case TYPES:
      if (name == "type") {
        state = TYPE;
        std::string type_id = get_attribute(properties, "type");
        std::string int_width = maybe_get_attribute(properties, "int_width");
        std::string exp_width = maybe_get_attribute(properties, "exp_width");
        std::string frc_width = maybe_get_attribute(properties, "frc_width");

        if (type_id == "APInt") {
          factory->create_integer_type(id, int_width);
        } else if (type_id == "APFloat") {
          factory->create_float_type(id, exp_width, frc_width);
        } else
          assert(false);
      } else
        assert(false && "unexpected element");
      break;

    case MLOC:
    case COMPOSITE:
      if (name == "scalar") {
	state = SCALAR;
	factory->register_scalar(get_attribute(properties, "type"));
      } else if (name == "composite") {
	state = COMPOSITE;
	factory->register_composite(get_attribute(properties, "type"));
      } else if (name == "address") {
	state = ADDRESS_VALUE;
	factory->register_address_value(get_attribute(properties, "addressable")
                                        , get_attribute(properties, "size"));
      } else
	assert(false && "unexpected element");
      break;

    case MODULE:
      // if (name == "iface") {
	// state = MODULE_IFACE;
	// factory->begin_iface();
      // } else {
	state = PARSE_MODULE;
	module_parser->on_start_element(name, properties);
      // }
      break;
    
    // case MODULE_IFACE:
      // if (name == "retval") {
	// state = MODULE_RETVAL;
      // } else if (name == "arg") {
	// state = MODULE_ARG;
      // } else
	// assert(false && "unexpected element");
      // break;

    case PARSE_MODULE:
      module_parser->on_start_element(name, properties);
      break;
    
    default:
      assert(false && "unexpected state");
      break;
  }
}

void Parser::on_end_element(const Glib::ustring& name)
{
  switch (state) {
    case PROGRAM:
      factory->commit_program();
      break;
      
    case COMPOSITE:
      factory->commit_value_composite();
      break;

    case SCALAR:
      factory->commit_value_scalar();
      break;

    case PARSE_MODULE:
      module_parser->on_end_element(name);
      break;

    case MLOC:
      factory->commit_memory_location();
      break;

    default:
      break;
  }
  
  assert(stack.size() > 0);
  state = stack.back();
  stack.pop_back();
}

void Parser::on_characters(const Glib::ustring& characters)
{
  switch (state) {
    case SCALAR:
      factory->set_value_scalar(characters);
      break;
      
    case PARSE_MODULE:
      module_parser->on_characters(characters);
      break;

    case ROOT:
      factory->register_root(characters);
      break;
      
    default:
      break;
  }
}

void Parser::on_error(const Glib::ustring &text) 
{
  std::cerr << "\n" << text << "\n";
}
