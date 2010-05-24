#include "Module.hpp"
#include <Base/Program.hpp>

#include <assert.h>

using namespace vhdl;

Module* get_vhdl_module(hls::Program *program, const std::string &id)
{
  hls::Module *module = program->find_module(id);
  assert(module);
  return to_vhdl(module);
}

