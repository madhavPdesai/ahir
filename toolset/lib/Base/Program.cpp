#include "Program.hpp"
#include "Module.hpp"
#include "Addressable.hpp"

#include <assert.h>

using namespace hls;

Program::Program(const std::string& _id)
  : id(_id), start(NULL), first_free_address(0)
{}

const Type* Program::find_type(const std::string &id)
{
  if (types.find(id) != types.end())
    return types[id];
  return NULL;
}

void Program::register_type(const std::string &id, const Type *type)
{
  assert(!find_type(id));
  types[id] = type;
}

Module* Program::find_module(const std::string &id)
{
  if (modules.find(id) != modules.end())
    return modules[id];
  else
    return NULL;
}

void Program::register_module(Module *func)
{
  assert(!find_module(func->id));
  modules[func->id] = func;
}

void Program::register_addressable(Addressable *addr)
{
  assert(addrs.find(addr->id) == addrs.end()
	 && "addressable already exists");
  addrs[addr->id] = addr;
}

Addressable* Program::find_addressable(const std::string &id)
{
  if (addrs.find(id) != addrs.end())
    return addrs[id];
  return NULL;
}

