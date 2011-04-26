#ifndef VHDL_MODULE_HPP
#define VHDL_MODULE_HPP

#include <Base/Module.hpp>

namespace hls {
  class Program;
}

namespace vhdl {

  class ControlPath;
  class DataPath;
  class LinkLayer;
  class Arbiter;
  
  struct Module : public hls::Module
  {
    ControlPath *cp;
    DataPath *dp;
    LinkLayer *ln;
    Arbiter *arbiter;
    
    Module(const std::string &id)
      : hls::Module(id, "vhdl")
      , cp(NULL), dp(NULL), ln(NULL), arbiter(NULL)
    {}
  };
}

vhdl::Module* get_vhdl_module(hls::Program *program, const std::string &id);

inline bool is_vhdl(hls::Module *f) { return f->type == "vhdl"; }

inline vhdl::Module* to_vhdl(hls::Module *m) 
{
  if (is_vhdl(m))
    return static_cast<vhdl::Module*>(m);
  return NULL;
}


#endif
