#include "Module.hpp"
#include <Base/Program.hpp>
#include "DataPath.hpp"
#include "ControlPath.hpp"
#include "CPUtils.hpp"
#include "LinkLayer.hpp"
#include "Arbiter.hpp"

#include <assert.h>

using namespace ahir;
using namespace hls;
  
ahir::Module::Module(const std::string &_id)
  : hls::Module(_id, "ahir")
{
  cp = new ControlPath(id + "_cp");
  dp = new DataPath(id + "_dp");
  ln = new LinkLayer(id + "_ln");
  arbiter = new Arbiter(id + "_arbiter");
}

ahir::Module* get_ahir_module(Program *program, const std::string &id) 
{
  hls::Module *module = program->find_module(id);
  assert(module);
  assert(is_ahir(module));

  ahir::Module *ahir = static_cast<ahir::Module*>(module);
  return ahir;
}

// The current AHIR implementation represents input arguments as
// output data ports on an "Accept" DPE. This function is currently a
// wrapper around that scheme.
void ahir::Module::add_input_argument(const std::string &id, const hls::Type *type)
{
  assert(dp);
  DPElement *acc = dp->acceptor;
  assert(acc);
  
  ahir::Port *aport = new ahir::Port(id, OUT, type);
  acc->register_port(aport);
}

// Similarly, a wrapper for output arguments that are currecntly
// represented as input data ports on a "Return" DPE.
void ahir::Module::add_output_argument(const std::string &id, const hls::Type *type)
{
  assert(dp);
  DPElement *ret = dp->retval;
  assert(ret);

  ahir::Port *aport = new ahir::Port(id, IN, type);
  ret->register_port(aport);
}

Transition* ahir::Module::add_transition_with_symbol(unsigned id
                                                     , CPEType type
                                                     , Symbol s
                                                     , const std::string &d)
{
  assert(cp);
  assert(is_trans(type));
  Transition *t = new Transition(id, type, d);
  t->symbol = s;
  cp->register_transition(t);
  return t;
}

Transition* ahir::Module::add_transition(unsigned id
                                         , CPEType type
                                         , const std::string &d)
{
  Symbol s = 0;
  
  switch (type) {
    case REQ:
      s = cp->reqs.size() + 1;
      break;
    case ACK:
      s = cp->acks.size() + 1;
      break;
    default:
      break;
  }
  
  return add_transition_with_symbol(id, type, s, d);
}

Place* ahir::Module::add_place(unsigned id
                               , const std::string &description)
{
  assert(cp);
  Place *p = new Place(id, description);
  cp->register_place(p);
  return p;
}

void ahir::Module::control_flow(unsigned int src, unsigned int dest)
{
  CPElement* src_e = cp->find_element(src);
  CPElement* dest_e = cp->find_element(dest);

  if(src_e != NULL && dest_e != NULL)
    ahir::control_flow(src_e, dest_e);
}

void ahir::Module::control_flow(Transition *t, Place *p)
{
  ahir::control_flow(t, p);
}

void ahir::Module::control_flow(Place *p, Transition *t)
{
  ahir::control_flow(p, t);
}

void ahir::Module::control_flow(Transition *u, Transition *v)
{
  std::ostringstream d;
  d << u->id << "_to_" << v->id;
  Place *p = new Place(cp->elements.size(), d.str());
  cp->register_place(p);
  ahir::control_flow(u, p);
  ahir::control_flow(p, v);
}

void ahir::Module::control_flow(CPElement *src, CPElement *snk) 
{
  if (is_trans(src) && is_trans(snk))
    control_flow(static_cast<Transition*>(src)
                 , static_cast<Transition*>(snk));
  else
    ahir::control_flow(src, snk);
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

DPElement* ahir::Module::add_dpe(unsigned id, NodeType ntype
                                 , const std::string &d)
{
  assert(!dp->find_dpe(id));
  DPElement *dpe = new DPElement(id, ntype, d);
  dp->register_dpe(dpe);
  return dpe;
}

DPElement* ahir::Module::find_dpe(unsigned id)
{
  return dp->find_dpe(id);
}

Port* ahir::Module::add_port(DPElement *dpe, const std::string &port_id
                             , hls::IOType in_or_out
                             , const hls::Type *data_type) 
{
  Port *port = new Port(port_id, in_or_out, data_type);
  dpe->register_port(port);
  return port;
}

Wire* ahir::Module::add_wire(unsigned id)
{
  assert(!dp->find_wire(id));
  Wire *wire = new Wire(id);
  dp->register_wire(wire);
  return wire;
}

Wire* ahir::Module::find_wire(unsigned id)
{
  return dp->find_wire(id);
}

void ahir::Module::connect_wire(Wire *wire, DPElement *dpe
                                , const std::string &port_id)
{
  Port *port = dpe->find_port(port_id);
  assert(port);
  port->connect_wire(wire);
}

void ahir::Module::link_symbols(Transition *t, DPElement *dpe
                                , const std::string &name)
{
  Symbol &ts = t->symbol;

  if (is_req(t)) {
    assert(dpe->find_req(name) == 0);
    Symbol s = dp->reqs.size() + 1;
    dp->register_req(dpe, name, s);
    ln->map(cp->id + "_LambdaOut", ts, dp->id + "_SigmaIn", s);
  } else {
    assert(dpe->find_ack(name) == 0);
    Symbol s = dp->acks.size() + 1;
    dp->register_ack(dpe, name, s);
    ln->map(dp->id + "_SigmaOut", s, cp->id + "_LambdaIn", ts);
  }
}
