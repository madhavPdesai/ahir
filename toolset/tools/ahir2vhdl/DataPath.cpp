#include "DataPath.hpp"
#include "Assignable.hpp"
#include "Utils.hpp"

#include <boost/format.hpp>
#include <boost/lexical_cast.hpp>

using namespace vhdl;
using namespace hls;

namespace {
  
  const boost::format wid("wrapper_%s");
    
} // end anonymous namespace

void DataPath::register_wrapper(DPElement *wrapper)
{
  assert(wrappers.find(wrapper->id) == wrappers.end());
  wrappers[wrapper->id] = wrapper;
}

void DataPath::register_dpe(DPElement *dpe)
{
  assert(elements.find(dpe->id) == elements.end());
  elements[dpe->id] = dpe;

  if (is_io(dpe->ntype)) {
    io_ports[dpe->portname].push_back(dpe);
  }
}

void DataPath::remove_dpe(DPElement *dpe)
{
  assert(elements.find(dpe->id) != elements.end());
  elements.erase(dpe->id);
}

DataPath::DataPath(const std::string _id, const std::string &d)
  : Entity(_id, DP, d), store_lines(0), load_lines(0)
{
  configuration = id + "_config";
}

void DPElement::register_member(DPElement *dpe)
{
  assert(ntype == dpe->ntype);
    
  assert(members.find(dpe->id) == members.end());
  members[dpe->id] = dpe;

  for (PortList::iterator pi = dpe->ports.begin(), pe = dpe->ports.end();
       pi != pe; ++pi) {
    Port *port = (*pi).second;
    if (is_scalar(port))
      continue;
    Port *wport = find_port(port->id);
    assert(wport);
    wport->update_range(1, port->get_range(1));
  }

  if (is_io(ntype))
    assert(portname == dpe->portname);
}

void DataPath::register_assign(const std::string &lhs, const std::string &rhs)
{
  assert(assign.find(lhs) == assign.end());
  assign[lhs] = rhs;
}

void DataPath::register_dpe_ahir_id(unsigned id, DPElement *dpe)
{
  assert(!find_dpe_from_ahir_id(id));
  dpe_map[id] = dpe;
  register_dpe(dpe);
}

DPElement* DataPath::find_dpe_from_ahir_id(unsigned id)
{
  if (dpe_map.find(id) != dpe_map.end())
    return dpe_map[id];
  return NULL;
}

