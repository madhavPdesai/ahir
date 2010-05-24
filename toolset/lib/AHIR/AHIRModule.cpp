#include "AHIRModule.hpp"
#include <Base/Program.hpp>
#include "DataPath.hpp"
#include "ControlPath.hpp"
#include "CPUtils.hpp"
#include "LinkLayer.hpp"
#include "Arbiter.hpp"

#include <assert.h>

using namespace ahir;
using namespace hls;
  
ahir::Module* get_ahir_module(Program *program, const std::string &id) 
{
  hls::Module *module = program->find_module(id);
  assert(module);
  assert(is_ahir(module));

  ahir::Module *ahir = static_cast<ahir::Module*>(module);
  return ahir;
}

void ahir::Module::register_dp(DataPath *_dp)
{
  assert(!dp);
  dp = _dp;
  assert(!dp->parent);
  dp->parent = this;
}

void ahir::Module::register_cp(ControlPath *_cp)
{
  assert(!cp);
  cp = _cp;
  assert(!cp->parent);
  cp->parent = this;
}

void ahir::Module::register_ln(LinkLayer *_ln)
{
  assert(!ln);
  ln = _ln;
  assert(!ln->parent);
  ln->parent = this;
}

void ahir::Module::register_arbiter(Arbiter *_arbiter)
{
  assert(!arbiter);
  arbiter = _arbiter;
}

DPElement* ahir::Module::locate_dpe_from_cpe_id(unsigned id)
{
  CPElement *cpe = cp->find_element(id);
  assert(cpe);

  if (!is_req(cpe))
    return NULL;
  Transition *trans = static_cast<Transition*>(cpe);

  LinkLayer::Literal &lit = ln->forward_map(cp->id + "_LambdaOut", trans->symbol);
  assert(lit.iface == dp->id + "_SigmaIn");

  DPElement *dpe = dp->req_to_dpe(lit.sym);
  assert(dpe);

  return dpe;
}
