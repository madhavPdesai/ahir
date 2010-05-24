#ifndef __AHIR_PRINTER_HPP__
#define __AHIR_PRINTER_HPP__

#include <Base/Printer.hpp>

namespace ahir {

  class LinkLayer;
  class DPElement;
  class DataPath;
  class Place;
  class Transition;
  class ControlPath;
  class Module;
  class Arbiter;

  struct Printer : public hls::Printer 
  {
    void print_ln(LinkLayer *ln, hls::ostream &out);
    void print_dpe(DPElement *dpe, hls::ostream &out);
    void print_dp(DataPath *dp, hls::ostream &out);
    
    void print_place(Place *p, hls::ostream &out);
    void print_transition(Transition *t, hls::ostream &out);
    void print_cp(ControlPath *cp, hls::ostream &out);
    void print_cp(ControlPath *cp);
    
    
    void print_ahir(Module *ahir, hls::ostream &out);
    void print_module_body(hls::Module *myf, hls::ostream &out);
    void print_arbiter(Arbiter *arbiter, hls::ostream &out);
    
    Printer() : hls::Printer() {};
  };
}

#endif
