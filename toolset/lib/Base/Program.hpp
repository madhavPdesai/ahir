#ifndef __PROGRAM_HPP__
#define __PROGRAM_HPP__

#include <string>
#include <map>

namespace hls {

  class Type;
  class Module;
  class Addressable;

  struct Program {
    std::string id;
    Module *start;
    unsigned first_free_address;

    typedef std::map<std::string, Module*> ModuleList;
    ModuleList modules;
    Module* find_module(const std::string &id);
    void register_module(Module *func);

    typedef std::map<std::string, const Type *> TypeList;
    TypeList types;
    const Type* find_type(const std::string &id);
    void register_type(const std::string &id, const Type *type);

    typedef std::map<std::string, Addressable*> AddressSpace;
    AddressSpace addrs;
    void register_addressable(Addressable *addr);
    Addressable* find_addressable(const std::string &id);

    Program(const std::string& _id);
  };

};

#endif
