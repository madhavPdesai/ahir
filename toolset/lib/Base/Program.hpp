#ifndef __PROGRAM_HPP__
#define __PROGRAM_HPP__

#include "Annotable.hpp"
#include "Storage.hpp"

#include <string>
#include <map>

namespace hls {

  class Type;
  class Module;
  class Addressable;

  struct Program : public Annotable, public Storage {
    std::string id;
    
    Module *start;

    typedef std::map<std::string, Module*> ModuleList;
    ModuleList modules;
    Module* find_module(const std::string &id);
    void register_module(Module *func);

    typedef std::map<std::string, const Type *> TypeList;
    TypeList types;
    const Type* find_type(const std::string &id);
    void register_type(const std::string &id, const Type *type);

    Program(const std::string& _id);
  };

};

#endif
