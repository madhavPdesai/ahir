#ifndef __AHIR_LINKER_HPP__
#define __AHIR_LINKER_HPP__

#include <AHIR/LinkLayer.hpp>

namespace hls {
  class Program;
}

namespace ahir {
  struct Linker 
  {
    LinkLayer::Literal& get_fin(Module *callee);
    LinkLayer::Literal& get_init(Module *callee);
    
    void create_arbiters(hls::Program *program);
    void assign_addresses(hls::Program *program);
    void link(hls::Program *program);
    Linker() {};
  };
}

#endif
