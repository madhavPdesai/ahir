#ifndef __CDFG_PRINTER_HPP__
#define __CDFG_PRINTER_HPP__

#include "../Base/Printer.hpp"

namespace cdfg {

  class CDFGNode;

  struct Printer : public hls::Printer 
  {
    void print_ports(CDFGNode *node, hls::ostream &out);
    void print_node_details(CDFGNode *node, hls::ostream &out);
    void print_node(CDFGNode *node, hls::ostream &out);
    void print_module_body(hls::Module *myf, hls::ostream &out);
    Printer() : hls::Printer() {};
  };
}

#endif
