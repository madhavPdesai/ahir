#include "Linker.hpp"

#include <Base/Program.hpp>
#include <Base/Addressable.hpp>

#include <AHIR/LinkLayer.hpp>
#include <AHIR/Module.hpp>
#include <AHIR/ControlPath.hpp>
#include <AHIR/DataPath.hpp>
#include <AHIR/Arbiter.hpp>

#include <boost/lexical_cast.hpp>
#include <iostream>
#include <assert.h>

using namespace hls;
using namespace ahir;

void Linker::create_arbiters(Program *program)
{
  for (Program::ModuleList::iterator mi = program->modules.begin()
	 , me = program->modules.end(); mi != me; ++mi) {

    ahir::Module *ahir = get_ahir_module(program, (*mi).first);

    assert(!ahir->arbiter);
    ahir->arbiter = new Arbiter(ahir->id + "_arbiter");
  }

  for (Program::ModuleList::iterator mi = program->modules.begin()
	 , me = program->modules.end(); mi != me; ++mi) {

    ahir::Module *ahir = get_ahir_module(program, (*mi).first);
  
    assert(ahir->dp);
    for (DPEList::iterator di = ahir->dp->calls.begin()
	   , de = ahir->dp->calls.end(); di != de; ++di) {
      DPElement *dpe = (*di).second;

      ahir::Module *callee = get_ahir_module(program, program->id + "_" + dpe->callee);

      // record this particular function call at a new call-port and
      // assign it to the client
      Client *client = new Client(ahir->id + "_" + boost::lexical_cast<std::string>(dpe->id)
				  , ahir->id, dpe->id);
      callee->arbiter->register_client(client);
    }
  }

  assert(program->roots.size() == 1);
  const std::string &root_id = *program->roots.begin();
  ahir::Module *start = get_ahir_module(program, root_id);
  Arbiter *arbiter = start->arbiter;
  
  // the environment is the only client of the "start" function, and
  // vice versa. we create a new call-port for the "env" client, that
  // records thehandshake with which "start" will be called.

  Client *client = new Client("env_call_start", "env", 1);
  arbiter->register_client(client);
}

void Linker::assign_addresses(Program *program)
{
  size_t current = 1;

  for (Storage::memory_iterator si = program->memory_begin()
	 , se = program->memory_end(); si != se; si++) {
    MemorySpace *ms = (*si).second;

    for (MemorySpace::iterator mi = ms->begin(), me = ms->end();
         mi != me; ++mi) {
      MemoryLocation *mloc = (*mi).second;
      mloc->address = current;
      current += mloc->size;
    }

    ms->first_free_address = current;
  }
}

void Linker::link(Program *program)
{
  create_arbiters(program);
  assign_addresses(program);
}
