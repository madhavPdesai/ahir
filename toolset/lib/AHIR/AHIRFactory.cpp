#include "AHIRFactory.hpp"

#include "Module.hpp"
#include "DataPath.hpp"
#include "ControlPath.hpp"
#include "LinkLayer.hpp"
#include "Arbiter.hpp"
#include <Base/Program.hpp>
#include "CPUtils.hpp"

#include <boost/lexical_cast.hpp>

#include <iostream>

using namespace ahir;
using namespace hls;

AHIRFactory::AHIRFactory()
{
  dp = NULL;
  port = NULL;
  dpe = NULL;
  cp = NULL;
  place = NULL;
  trans = NULL;
  ln = NULL;
  omega = NULL;
}

void AHIRFactory::create_module_hook(const std::string &id
				     , const std::string &type)
{
  assert(type == "ahir");
  ahir_module = new ahir::Module(id);
  module = ahir_module;
}

// /* ----- data-path ----- */

void AHIRFactory::create_dpe(const std::string& _id
			     , const std::string& ntype
			     , const std::string &description)
{
  unsigned id = boost::lexical_cast<unsigned>(_id);
  dpe = new DPElement(id, hls::ntype(ntype), description);
}

void AHIRFactory::commit_dpe()
{
  dp->register_dpe(dpe);
}

void AHIRFactory::dpe_set_req(const std::string &sym)
{
  Symbol s = Symbol(boost::lexical_cast<unsigned>(sym));
  dp->register_req(dpe, dpe_req, s);
}

void AHIRFactory::dpe_set_ack(const std::string &sym)
{
  Symbol s = Symbol(boost::lexical_cast<unsigned>(sym));
  dp->register_ack(dpe, dpe_ack, s);
}

void AHIRFactory::dpe_set_value(const std::string &characters)
{
  assert(dpe->ntype == Constant);
  dpe->value = characters;
}

void AHIRFactory::dpe_set_addressable(const std::string &characters)
{
  assert(dpe->ntype == Address);
  dpe->addressable = program->find_addressable(characters);
  assert(dpe->addressable);
}

void AHIRFactory::dpe_set_counterpart(const std::string &characters)
{
  unsigned id = boost::lexical_cast<unsigned>(characters);
  DPElement *cpart = dp->find_dpe(id);
  if (cpart) {
    assert(!cpart->counterpart);
    cpart->counterpart = dpe;
    dpe->counterpart = cpart;
  }
}

void AHIRFactory::dpe_set_io_portname(const std::string &characters)
{
  assert(dpe->ntype == Input || dpe->ntype == Output);
  assert(characters.size() > 0);
  dpe->portname = characters;
}

void AHIRFactory::dpe_set_callee(const std::string &characters)
{
  assert(dpe->ntype == Call);
  dpe->callee = characters;
}

void AHIRFactory::create_port(const std::string& id
			      , const std::string& iotype
			      , const std::string& type
			      , const std::string& wire)
{
  const hls::Type *t = program->find_type(type);
  assert(t);
  port = new Port(id, (iotype == "out" ? OUT : IN), t);

  Wire *w = dp->find_wire(boost::lexical_cast<unsigned>(wire));
  if (!w)
    w = create_wire(wire);
  port->connect_wire(w);
  dpe->register_port(port);
}

Wire* AHIRFactory::create_wire(const std::string& id)
{
  Wire *wire = new Wire(boost::lexical_cast<unsigned>(id));
  dp->register_wire(wire);
  return wire;
}

void AHIRFactory::commit_dp()
{}

void AHIRFactory::create_wrapper(const std::string &id
				 , const std::string &description)
{
  wrapper = new Wrapper(boost::lexical_cast<unsigned>(id), description);
  dp->register_wrapper(wrapper);
}

void AHIRFactory::wrapper_add_member(const std::string &_id)
{
  unsigned id = boost::lexical_cast<unsigned>(_id);
  wrapper->register_member(id);
}

// /* ----- control-path ----- */

void AHIRFactory::create_cp(const std::string &id)
{
  cp = new ControlPath(id);
  assert(!ahir_module->cp);
  ahir_module->cp = cp;
}

void AHIRFactory::commit_cp()
{}

// /* ----- place ----- */

void AHIRFactory::create_place(const std::string &id
			       , const std::string &marking
			       , const std::string &description)
{
  unsigned m = boost::lexical_cast<unsigned>(marking);

  if (m != 0) {
    assert(m == 1);
    place = cp->marked_place;
  } else {
    place = new Place(boost::lexical_cast<unsigned>(id), description);
    place->marking = m;
    cp->register_place(place);
  }

  // src Place needed by snk Transitions in pending_src.
  if (pending_src.find(id) != pending_src.end()) {
    for (std::vector<Transition*>::iterator i = pending_src[id].begin()
	   , e = pending_src[id].end(); i != e; ++i) {
      Transition *snk = *i;
      control_flow(place, snk);
    }
    pending_src.erase(id);
  }

  // snk Place needed by src Transitions in pending_snk.
  if (pending_snk.find(id) != pending_snk.end()) {
    for (std::vector<Transition*>::iterator i = pending_snk[id].begin()
	   , e = pending_snk[id].end(); i != e; ++i) {
      Transition *src = *i;
      control_flow(src, place);
    }
    pending_snk.erase(id);
  }
}

// /* ----- transition ----- */

void AHIRFactory::create_transition(const std::string &id
				    , const std::string &type
				    , const std::string &sym
				    , const std::string &description)
{
  unsigned i = boost::lexical_cast<unsigned>(id);
  
  CPEType t;
  if (type == "req")
    t = REQ;
  else if (type == "ack")
    t = ACK;
  else
    t = HIDDEN;
  
  Symbol s = boost::lexical_cast<unsigned>(sym);

  if (i == init_id) {
    // assert(t == ACK);
    // assert(s == 1);
    trans = cp->init;
    return;
  }

  if (i == fin_id) {
    // assert(t == REQ);
    // assert(s == 1);
    trans = cp->fin;
    return;
  }

  // assert(s != 1);
  
  trans = new Transition(i, t, description);

  switch (t) {
    case REQ:
    case ACK:
      trans->symbol = s;
      break;
    default:
      break;
  }

  cp->register_transition(trans);
}

void AHIRFactory::transition_add_snk(const std::string &id)
{
  Place *snk = cp->find_place(boost::lexical_cast<unsigned>(id));
  assert(snk);
  if (!snk) {
    pending_snk[id].push_back(trans);
    return;
  }

  control_flow(trans, snk);
}

void AHIRFactory::transition_add_src(const std::string &id)
{
  Place *src = cp->find_place(boost::lexical_cast<unsigned>(id));
  if (!src) {
    pending_src[id].push_back(trans);
    return; 
  }

  control_flow(src, trans);
}

// /* ----- link layer ----- */

void AHIRFactory::create_ln(const std::string& id)
{
  ln = new LinkLayer(id);
  assert(!ahir_module->ln);
  ahir_module->ln = ln;
}

void AHIRFactory::map_symbols(const std::string &src
		     , const std::string &src_sym
		     , const std::string &snk
		     , const std::string &snk_sym)
{
  Symbol src_s = boost::lexical_cast<unsigned>(src_sym);
  Symbol snk_s = boost::lexical_cast<unsigned>(snk_sym);
  ln->map(src, src_s, snk, snk_s);
}

/* ----- Inter-module Link Layer ----- */

void AHIRFactory::create_client(const std::string &id
				, const std::string &module_name
				, const std::string &callsite)
{
  Client *client = new Client(id, module_name, boost::lexical_cast<unsigned>(callsite));
  arbiter->register_client(client);
}
