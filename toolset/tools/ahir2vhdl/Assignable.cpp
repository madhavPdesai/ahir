#include "Assignable.hpp"
#include "Utils.hpp"

//FIXME
#include <AHIR/DataPath.hpp>

using namespace vhdl;
using namespace hls;

Range& Assignable::get_range(unsigned i)
{
  assert(i < type.ranges.size());
  return type.ranges[i];
}

void Assignable::update_range(unsigned i, const Range &r)
{
  if (i < type.ranges.size())
    type.ranges[i].update(r);
  else if (i == type.ranges.size())
    type.ranges.push_back(r);
  else
    assert(false);
}

template <class T>
T& dump(T &out, const RangeList &ranges)
{
  unsigned n = ranges.size();
  if (n == 0)
    return out;

  n--;
  out << "(";
  for (unsigned i = 0; i != n; ++i) {
    out << ranges[i];
    out << ", ";
  }
  out << ranges[n];
  out << ")";
  return out;
}

hls::ostream& vhdl::operator<< (hls::ostream &out, const RangeList &ranges)
{
  return dump<hls::ostream>(out, ranges);
}

std::ostream& vhdl::operator<< (std::ostream &out, const RangeList &ranges)
{
  return dump<std::ostream>(out, ranges);
}

template <class T>
T& dump(T &out, const Range &r)
{
  switch (r.rtype) {
    case INDEX:
      out << r.upper;
      break;

    case TO:
      out << r.lower << " to " << r.upper;
      break;

    case DOWNTO:
      out << r.upper << " downto " << r.lower;
      break;
  }
  return out;
}

hls::ostream& vhdl::operator<< (hls::ostream &out, const Range &r)
{
  return dump<hls::ostream>(out, r);
}

std::ostream& vhdl::operator<< (std::ostream &out, const Range &r)
{
  return dump<std::ostream>(out, r);
}


void Mapping::operator() (MappingType t, const std::string &n, const RangeList &r)
{
  assert(type == NONE);
  type = t;
  name = n;
  ranges = r;
}

void Mapping::operator() (MappingType t, const std::string &n, const Range &r)
{
  assert(type == NONE);
  type = t;
  name = n;
  ranges.clear();
  ranges.push_back(r);
}

hls::ostream& vhdl::operator<< (hls::ostream &out, const Mapping &p)
{
  out << p.name << p.ranges;
  return out;
}

std::ostream& vhdl::operator<< (std::ostream &out, const Mapping &p)
{
  out << p.name << p.ranges;
  return out;
}

unsigned Assignable::width(unsigned index)
{
  assert(index <= type.ranges.size());
  
  if (type.ranges.size() == 0)
    return 1;

  Range &r = type.ranges[index - 1];
  return r.upper - r.lower + 1;
}


    
