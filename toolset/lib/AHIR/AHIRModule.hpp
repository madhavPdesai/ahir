#ifndef __AHIRMODULE_HPP__
#define __AHIRMODULE_HPP__

#include <Base/Module.hpp>
#include <AHIR/Storage.hpp>
#include "Symbol.hpp"

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
  
  struct Module : public hls::Module, public Storage
  {
    ControlPath *cp;
    DataPath *dp;
    LinkLayer *ln;
    Arbiter *arbiter;

    Symbol req, ack;

    void register_dp(DataPath *_dp);
    void register_cp(ControlPath *_cp);
    void register_ln(LinkLayer *_ln);
    void register_arbiter(Arbiter *_arbiter);

    void add_input_argument(const std::string &id, hls::Type &type);
    void add_output_argument(const std::string &id, const hls::Type *type);

    Transition& add_transition(const std::string &id, CPEType type);
    Transition& add_place(const std::string &id);

    void set_dependency(Transition &src, Place &snk);
    void set_dependency(Place &src, Transition &snk);
    void set_dependency(Transition &src, Transition &snk);

    DPElement* locate_dpe_from_cpe_id(unsigned id);

    Module(const std::string &_id)
      : hls::Module(_id, "ahir"), Storage(_id)
      , cp(NULL), dp(NULL), ln(NULL), arbiter(NULL)
      , req(0), ack(0)
    {};
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
