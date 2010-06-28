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
  assert(!find_wrapper(wrapper->id));
  wrappers[wrapper->id] = wrapper;
}

DPElement* DataPath::find_wrapper(const std::string &id)
{
  if (wrappers.find(id) == wrappers.end())
    return NULL;
  return wrappers[id];
}

void DataPath::register_dpe(DPElement *dpe)
{
  assert(!find_dpe(dpe->id));
  elements[dpe->id] = dpe;
}

DPElement* DataPath::find_dpe(const std::string &id)
{
  if (elements.find(id) == elements.end())
    return NULL;
  return elements[id];
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
    
  assert(memberset.find(dpe) == memberset.end());
  members.push_back(dpe);

  for (PortList::iterator pi = dpe->ports.begin(), pe = dpe->ports.end();
       pi != pe; ++pi) {
    Port *port = (*pi).second;
    if (is_scalar(port))
      continue;
    Port *wport = find_port(port->id);
    assert(wport);
    if (is_io(dpe->ntype) && wport->type.ranges.size() > 1) 
      assert(wport->get_range(1) == port->get_range(1)
             && "All requesters on an I/O port should have the same width.");
    else
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

DPElement* DataPath::find_dpe_from_ahir_id(unsigned id)
{
  return find_dpe("dpe_" + boost::lexical_cast<std::string>(id));
}
