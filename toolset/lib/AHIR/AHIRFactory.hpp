#ifndef __AHIR_FACTORY_H__
#define __AHIR_FACTORY_H__

#include <Base/Factory.hpp>
#include "Symbol.hpp"

#include <map>

namespace ahir
{
  class Module;
  class DataPath;
  class ControlPath;
  class LinkLayer;
  class Arbiter;

  class DPElement;
  class Port;
  class Wire;
  class Wrapper;
  class Place;
  class Transition;
  
  struct AHIRFactory : public hls::Factory
  {
    ahir::Module *ahir_module;
    
    DataPath *dp;
    Port *port;
    DPElement *dpe;
    std::string dpe_req, dpe_ack;
    Wrapper *wrapper;
    
    ControlPath *cp;
    Place *place;
    Transition *trans;
    // unsigned pending_init;
    // unsigned pending_fin;

    // snk Transitions waiting for missing src Places.
    std::map<std::string, std::vector<Transition*> > pending_src;

    // src Transitions waiting for missing snk Places.
    std::map<std::string, std::vector<Transition*> > pending_snk;
    
    LinkLayer *ln;
    Arbiter *arbiter;

    void create_module_hook(const std::string &id, const std::string &type);
    
    void create_dp(const std::string& id);
    void commit_dp();
    void create_dpe(const std::string &id
		    , const std::string& ntype
		    , const std::string &description);
    void commit_dpe();
    void dpe_new_req(const std::string &id) { dpe_req = id; };
    void dpe_new_ack(const std::string &id) { dpe_ack = id; };
    void dpe_set_req(const std::string &sym);
    void dpe_set_ack(const std::string &sym);
    
    void create_port(const std::string& id
    			     , const std::string& iotype
    			     , const std::string& type
    			     , const std::string& wire);

    void dpe_set_value(const std::string &characters);
    void dpe_set_memory_location(const std::string &characters);
    void dpe_set_counterpart(const std::string &characters);
    void dpe_set_io_portname(const std::string &characters);

    void dpe_set_callee(const std::string &characters);
    
    Wire* create_wire(const std::string& id);

    void create_wrapper(const std::string &id
			, const std::string &description);
    void wrapper_add_member(const std::string &id);
    
    void create_cp(const std::string &id);
			   // const std::string &init,
			   // const std::string &fin);
    void commit_cp();
    
    void create_place(const std::string &id, const std::string &marking
		      , const std::string &description);
    
    void create_transition(const std::string &id
			   , const std::string &type
			   , const std::string &sym
			   , const std::string &description);
    void transition_add_src(const std::string &id);
    void transition_add_snk(const std::string &id);
    
    void create_ln(const std::string& id);
    void map_symbols(const std::string &src
		     , const std::string &src_sym
		     , const std::string &snk
		     , const std::string &snk_sym);

    void create_arbiter(const std::string &id);
    void create_client(const std::string &id
		       , const std::string &module_name
		       , const std::string &callsite);
    
    AHIRFactory();
  };
}

#endif
