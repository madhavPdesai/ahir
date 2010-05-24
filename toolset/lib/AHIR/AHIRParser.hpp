#ifndef __AHIR_PARSER_H__
#define __AHIR_PARSER_H__

#include <Base/Parser.hpp>
#include "AHIRFactory.hpp"

#include <libxml++/parsers/saxparser.h>

namespace ahir {

  struct AHIRParser : public hls::ModuleParser 
  {
    AHIRFactory *factory;
    
    typedef enum {
      INIT
      , DP, CP, LN
      , DPE, DPE_REQ, DPE_ACK, DPE_PORT
      , DPE_CALLEE, DPE_VALUE, DPE_ADDRESSABLE, DPE_COUNTERPART
      , WRAPPER, MEMBER
      , PLACE, TRANS, TRANS_SRC, TRANS_SNK
      , LN_MAP
      , ARBITER, CLIENT
    } StateType;
    
    StateType state;
    std::vector<StateType> stack;

    hls::Factory* get_factory() { return factory; };
    virtual void on_start_element(const Glib::ustring& name,
				  const xmlpp::SaxParser::AttributeList& properties);
    virtual void on_characters(const Glib::ustring& characters);
    virtual void on_end_element(const Glib::ustring& name);
    
    AHIRParser(AHIRFactory *fac)
      : factory(fac), state(INIT)
    {};
    
  };
}

#endif
