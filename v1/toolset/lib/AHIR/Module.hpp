#ifndef __AHIRMODULE_HPP__
#define __AHIRMODULE_HPP__

#include <Base/Module.hpp>
#include <Base/Storage.hpp>
#include "Symbol.hpp"
#include "ControlPath.hpp"
#include "DataPath.hpp"
#include "LinkLayer.hpp"

namespace hls
{
  class Program;
}
  

namespace ahir
{
  class ControlPath;
  class DataPath;
  class LinkLayer;
  class Arbiter;
  class DPElement;
  
  struct Module : public hls::Module
  {
    ControlPath *cp;
    DataPath *dp;
    LinkLayer *ln;
    Arbiter *arbiter;

    void add_input_argument(const std::string &id, const hls::Type *type);
    void add_output_argument(const std::string &id, const hls::Type *type);

    /*! Convenience function.
    
      \todo This function is used by the AHIR Parser to introduce a known
      transition in the module. It is required only because the
      current XML format explicitly stores symbols in the link-layer.
      As a result, the numerical value of the symbol associated with a
      particular transition HAS to be preserved. This is a bug which
      should be fixed by removing numerical symbol values from the
      link layer.
    */
    // id must be >= 3
    Transition* add_transition_with_symbol(unsigned id, ahir::CPEType type
                                           , Symbol s
                                           , const std::string &d = "");
    // id must be >= 3
    Transition* add_transition(unsigned id, ahir::CPEType type
                               , const std::string &d = "");
    // id must be >= 3
    Place* add_place(unsigned id
                     , const std::string &description = "");


    void control_flow(unsigned int src, unsigned int dest); // todo

    void control_flow(Transition *src, Place *snk);
    void control_flow(Place *src, Transition *snk);
    void control_flow(Transition *src, Transition *snk);
    void control_flow(CPElement *src, CPElement *snk);

    DPElement* add_dpe(unsigned id, hls::NodeType ntype
                       , const std::string &d = "");
    DPElement* find_dpe(unsigned id);

    Port *add_port(DPElement *dpe, const std::string &port_id
                   , hls::IOType in_or_out, const hls::Type *data_type);

    Wire* add_wire(unsigned id);
    Wire* find_wire(unsigned id);
    void connect_wire(Wire *wire, DPElement *dpe, const std::string &port_id);

    void link_symbols(Transition *t, DPElement *dpe, const std::string &name);

    DPElement* locate_dpe_from_cpe_id(unsigned id);

    Module(const std::string &_id);
  };
}

ahir::Module* get_ahir_module(hls::Program *program, const std::string &id);

inline bool is_ahir(hls::Module *f) { return f && f->type == "ahir"; }

inline ahir::Module* to_ahir(hls::Module *m) 
{
  if (is_ahir(m))
    return static_cast<ahir::Module*>(m);
  return NULL;
}

#endif
