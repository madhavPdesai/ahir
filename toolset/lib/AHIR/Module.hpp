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

    Symbol req, ack;

    Transition* add_transition(unsigned id, ahir::CPEType type
                               , const std::string &description = "");
    Place* add_place(unsigned id
                     , const std::string &description = "");

    void add_input_argument(const std::string &id, hls::Type &type);
    void add_output_argument(const std::string &id, const hls::Type *type);
    void control_flow(Transition *src, Place *snk);
    void control_flow(Place *src, Transition *snk);
    void control_flow(Transition *src, Transition *snk);



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
