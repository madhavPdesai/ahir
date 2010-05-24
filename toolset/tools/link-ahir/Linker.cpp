#include "Linker.hpp"

#include <Base/Program.hpp>
#include <Base/Addressable.hpp>

#include <AHIR/LinkLayer.hpp>
#include <AHIR/AHIRModule.hpp>
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

      ahir::Module *callee = get_ahir_module(program, dpe->callee);

      // record this particular function call at a new call-port and
      // assign it to the client
      Client *client = new Client(ahir->id + "_" + boost::lexical_cast<std::string>(dpe->id)
				  , ahir->id, dpe->id);
      callee->arbiter->register_client(client);
    }
  }

  assert(program->start);
  assert(is_ahir(program->start));
  ahir::Module *start = static_cast<ahir::Module*>(program->start);
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

  for (Program::AddressSpace::iterator gi = program->addrs.begin()
	 , ge = program->addrs.end(); gi != ge; gi++) {
    Addressable *glob = (*gi).second;
    glob->set_address(current);
    current += glob->size;
  }

  program->first_free_address = current;
}

void Linker::link(Program *program)
{
  create_arbiters(program);
  assign_addresses(program);
}
