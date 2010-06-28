#include "DataPath.hpp"

#include <assert.h>

using namespace ahir;
using namespace hls;

void DataPath::register_dpe(DPElement *dpe)
{
  assert(elements.find(dpe->id) == elements.end());
  elements[dpe->id] = dpe;
  assert(!dpe->parent);
  dpe->parent = this;

  switch (dpe->ntype) {
    case LoadRequest:
      lrs[dpe->id] = dpe;
      break;

    case LoadComplete:
      lcs[dpe->id] = dpe;
      break;

    case Store:
      stores[dpe->id] = dpe;
      break;

    case Call:
      calls[dpe->id] = dpe;
      break;

    case Return:
      assert(!retval);
      retval = dpe;
      break;

    case Accept:
      assert(!acceptor);
      acceptor = dpe;
      break;

    case Input:
    case Output:
      assert(dpe->portname.size() > 0);
      io_ports[dpe->portname].push_back(dpe);
      break;

    default:
      break;
  }
}

DPElement* DataPath::req_to_dpe(Symbol req)
{
  if (reqs.find(req) != reqs.end())
    return reqs[req];
  else
    return NULL;
}

DPElement* DataPath::ack_to_dpe(Symbol ack)
{
  if (acks.find(ack) != acks.end())
    return acks[ack];
  else
    return NULL;
}

void DataPath::register_req(DPElement *dpe, const std::string &name, Symbol req)
{
  assert(reqs.find(req) == reqs.end());
  reqs[req] = dpe;
  dpe->register_req(name, req);
  // max_req = max_req < req ? req : max_req;
}

void DataPath::register_ack(DPElement *dpe, const std::string &name, Symbol ack)
{
  assert(acks.find(ack) == acks.end());
  acks[ack] = dpe;
  dpe->register_ack(name, ack);
  // max_ack = max_ack < ack ? ack : max_ack;
}

DPElement* DataPath::find_dpe(unsigned id)
{
  if (elements.find(id) != elements.end())
    return elements[id];
  else
    return NULL;
}

void DPElement::register_port(Port *port)
{
  assert(ports.find(port->id) == ports.end());
  ports[port->id] = port;
  assert(!port->parent);
  port->parent = this;
}

Port* DPElement::find_port(const std::string &id)
{
  if (ports.find(id) != ports.end())
    return ports[id];
  else
    return NULL;
}

void Port::connect_wire(Wire *w)
{
  assert(!wire);
  wire = w;
  
  switch (io_type) {
    case OUT:
      assert(!wire->driver);
      wire->driver = this;
      break;

    case IN:
      assert(wire->users.find(this) == wire->users.end());
      wire->users.insert(this);
      break;
  }
}

void Wire::add_user(Port *u)
{
  assert(!u->wire);
  assert(users.find(u) == users.end());
  users.insert(u);
  u->wire = this;
}

void DPElement::register_req(const std::string &id, Symbol sym)
{
  assert(reqs.find(id) == reqs.end());
  reqs[id] = sym;
}

void DPElement::register_ack(const std::string &id, Symbol sym)
{
  assert(acks.find(id) == acks.end());
  acks[id] = sym;
}

void DataPath::register_wire(Wire *wire)
{
  assert(wires.find(wire->id) == wires.end());
  wires[wire->id] = wire;
}

Wire* DataPath::find_wire(unsigned id)
{
  if (wires.find(id) != wires.end())
    return wires[id];
  else
    return NULL;
}

void Wrapper::register_member(unsigned m)
{
  assert(members.count(m) == 0);
  members.insert(m);
}

void DataPath::register_wrapper(Wrapper *w)
{
  assert(wrappers.find(w->id) == wrappers.end());
  wrappers[w->id] = w;
}
