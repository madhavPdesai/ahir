#ifndef __HLS_PARSER_HPP__
#define __HLS_PARSER_HPP__

#include "Factory.hpp"

#include <libxml++/parsers/saxparser.h>

namespace hls {

  bool find_attribute(const xmlpp::SaxParser::AttributeList& list
		      , const Glib::ustring& name);
  const Glib::ustring& get_attribute(const xmlpp::SaxParser::AttributeList& list
				   , const Glib::ustring& name);
  const Glib::ustring& maybe_get_attribute(const xmlpp::SaxParser::AttributeList& list
					 , const Glib::ustring& name);

  struct ModuleParser
  {
    virtual Factory* get_factory() = 0;
    
    virtual void on_start_element(const Glib::ustring& name
				  , const xmlpp::SaxParser::AttributeList& properties) = 0;
    virtual void on_characters(const Glib::ustring& characters) = 0;
    virtual void on_end_element(const Glib::ustring& name) = 0;
  };

  struct Parser : public xmlpp::SaxParser
  {
    ModuleParser *module_parser;
    Factory *factory;

    typedef enum {
      INIT
      , PROGRAM
      , ADDRESS_SPACE, ADDRESSABLE
      , TYPES, TYPE
      , MODULE
      // , MODULE_IFACE, MODULE_RETVAL, MODULE_ARG
      , SCALAR, COMPOSITE, ADDRESS_VALUE
      , PARSE_MODULE
    } StateType;
      
    StateType state;
    std::vector<StateType> stack;
    
    Parser(ModuleParser *mp)
      : module_parser(mp), factory(mp->get_factory()), state(INIT)
    {}

    //  virtual void on_start_document();
    //  virtual void on_end_document();
    void on_start_element(const Glib::ustring& name,
				  const AttributeList& properties);
    void on_end_element(const Glib::ustring& name);
    void on_characters(const Glib::ustring& characters);
    //  virtual void on_comment(const Glib::ustring& text);
    //  virtual void on_warning(const Glib::ustring& text);
    virtual void on_error(const Glib::ustring& text);
    //  virtual void on_fatal_error(const Glib::ustring& text);
  };
}

#endif
