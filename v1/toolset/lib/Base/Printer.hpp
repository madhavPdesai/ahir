#ifndef __HLS_PRINTER_HPP__
#define __HLS_PRINTER_HPP__

#include "ostream.hpp"

#include <string>
#include <iostream>
#include <assert.h>

namespace hls {
  class Storage;
  class Program;
  class Module;

  class Value;
  class ScalarValue;
  class CompositeValue;
  class AddressValue;

  struct Printer
  {
    Printer()
    {}

    virtual void print(hls::Program *program, const std::string &suffix);
    virtual void print_program(hls::Program *program, hls::ostream &out);
    virtual void print_module(hls::Module *module, hls::ostream &out);
    virtual void print_module_body(hls::Module *module, hls::ostream &out) = 0;
    
    virtual void print_scalar_value(ScalarValue *value, hls::ostream &out);
    virtual void print_composite_value(CompositeValue *value, hls::ostream &out);
    virtual void print_address_value(AddressValue *value, hls::ostream &out);
    virtual void print_value(Value *value, hls::ostream &out);
    virtual void print_types(Program *program, hls::ostream &out);
    virtual void print_storage(Storage *storage, hls::ostream &out);

  };
  
  void dump_address_space(hls::Program *program, const std::string &filename);
}

#endif
