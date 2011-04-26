#ifndef __CDFG_PARSER_HPP__
#define __CDFG_PARSER_HPP__

#include "../Base/Parser.hpp"
#include "CDFGFactory.hpp"

namespace cdfg {

  struct CDFGParser : public hls::ModuleParser 
  {
    CDFGFactory *factory;

    typedef enum {
      INIT, CDFG
      , NODE, PORT, CONSTANT, ADDRESSABLE_BACKREF, CALLEE, COUNTERPART
      , PORTNAME
    } StateType;
    
    StateType state;
    std::vector<StateType> stack;

    hls::Factory* get_factory() { return factory; };
    virtual void on_start_element(const Glib::ustring& name,
				  const xmlpp::SaxParser::AttributeList& properties);
    virtual void on_characters(const Glib::ustring& characters);
    virtual void on_end_element(const Glib::ustring& name);

    CDFGParser(CDFGFactory *fac)
      : factory(fac), state(INIT)
    {};
  };
};

#endif
