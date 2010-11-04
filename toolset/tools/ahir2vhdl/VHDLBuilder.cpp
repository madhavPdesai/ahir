#include "VHDLBuilder.hpp"
#include "Utils.hpp"

#include "DataPathBuilder.hpp"
#include "DataPathPrinter.hpp"

#include "Entity.hpp"
#include "Module.hpp"
#include "ControlPath.hpp"
#include "LinkLayer.hpp"

#include "ArbiterBuilder.hpp"

#include <Base/Program.hpp>
#include <AHIR/Module.hpp>
#include <Base/Printer.hpp>

#include <assert.h>

using namespace hls;
using namespace vhdl;

namespace vhdl {
  
  void generate_system(Program *program);

}

namespace {

  vhdl::Module* generate_vhdl_module(ahir::Module *ahir)
  {
    vhdl::Module *module = new vhdl::Module(ahir->id);
    module->dp = create_dp(ahir->dp);
    module->cp = create_cp(ahir->cp);
    module->ln = create_ln(ahir->ln);
    if (ahir->arbiter)
      module->arbiter = create_arbiter(ahir->arbiter, module->dp);
    return module;
  }

  void print_vhdl(Program *program, bool clocked_ln)
  {
    for (Program::ModuleList::iterator mi = program->modules.begin()
           , me = program->modules.end(); mi != me; ++mi) {
      vhdl::Module *module = get_vhdl_module(program, (*mi).first);

      print_cp(module->cp);
      print_dp(module->dp);
      print_ln(module->ln, clocked_ln);
    }
  }

} // end anonymous namespace

void vhdl::ahir2vhdl(Program *program, bool clocked_ln)
{
  init_names();
  assert(program->start);
  std::string start_id = program->start->id;
  
  for (Program::ModuleList::iterator mi = program->modules.begin()
	 , me = program->modules.end(); mi != me; ++mi) {
    ahir::Module *ahir = get_ahir_module(program, (*mi).first);
    vhdl::Module *vhdl = generate_vhdl_module(ahir);
    (*mi).second = vhdl;
    delete ahir;
  }

  program->start = program->find_module(start_id);
  assert(program->start);

  print_vhdl(program, clocked_ln);

  dump_address_space(program, program->id + "_memory_init.txt");
  
  generate_system(program);
}

