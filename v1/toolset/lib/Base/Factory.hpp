#ifndef __HLS_FACTORY_HPP__
#define __HLS_FACTORY_HPP__

#include <string>
#include <vector>

namespace hls {

  class Program;
  class Module;
  class Storage;
  class MemorySpace;
  class MemoryLocation;
  class Value;
  class ScalarValue;
  class CompositeValue;
  class Omega;

  struct Factory 
  {
    Program *program;
    Module *module;
    Storage *storage;
    MemorySpace *mspace;
    MemoryLocation *mloc;
    ScalarValue *svalue;
    CompositeValue *cvalue;
    Omega *omega;
    
    Factory();

    std::string format(const std::string& input);

    void create_program(const std::string &id);
    void commit_program();

    void register_root(const std::string &id);
    
    void create_module(const std::string &id, const std::string &type);
    virtual void create_module_hook(const std::string &id, const std::string &type) = 0;
    void begin_iface();

    void create_memory_space(const std::string &id);
    void create_memory_location(const std::string &id
                                , const std::string &type
                                , const std::string &size
                                , const std::string &address
                                , const std::string &description);
    void dispatch_value(Value *value);
    void register_scalar(const std::string &type);
    void register_composite(const std::string &type);
    void register_address_value(const std::string &mloc_name
                                , const std::string &size);

    void create_integer_type(const std::string &id
                             , const std::string &int_width);
    void create_float_type(const std::string &id
                           , const std::string &exp_width
                           , const std::string &frc_width);


    std::vector<CompositeValue*> value_stack;
    void push_cvalue(CompositeValue *cval);
    void pop_cvalue();
    void commit_value_composite();
    void commit_memory_location();
    void commit_value_scalar();
    void set_value_scalar(const std::string &characters);
    
    // void module_set_retval(const std::string &characters);
    // void module_append_arg(const std::string &characters);

    void register_omega(Omega *omega);
  };
}

#endif
