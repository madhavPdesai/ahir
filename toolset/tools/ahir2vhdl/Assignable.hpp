#ifndef __VHDL_PORT_HPP__
#define __VHDL_PORT_HPP__

#include "typedefs.hpp"
#include <Base/ostream.hpp>
#include <Base/Utils.hpp>

#include <assert.h>

namespace hls {
  class Type;
}

namespace ahir {
  class Port;
}

namespace vhdl {

  struct Range
  {
    RangeType rtype;
    int upper;
    int lower;

    Range(RangeType r, int u, int l)
      : rtype(r), upper(u), lower(l)
    {
      assert(u >= l);
    }

    Range(RangeType r)
      : rtype(r), upper(0), lower(0)
    {}

    Range(RangeType r, int w)
      : rtype(r), upper(w - 1), lower(0)
    {
      if (rtype == INDEX)
        upper++;
      else
        assert(upper >= lower);
    }

    int width() const
    {
      return upper - lower + 1;
    }

    void update(const Range &r)
    {
      assert(r.rtype == rtype);
      if (r.lower < lower)
        lower = r.lower;
      if (r.upper > upper)
        upper = r.upper;
    }
  };

  hls::ostream& operator<< (hls::ostream &out, const Range &r);
  std::ostream& operator<< (std::ostream &out, const Range &r);
  
  hls::ostream& operator<< (hls::ostream &out, const RangeList &ranges);
  std::ostream& operator<< (std::ostream &out, const RangeList &ranges);
  
  struct Type
  {
    std::string name;
    RangeList ranges;

    Type(const std::string &n, const RangeList &r = RangeList())
      : name(n), ranges(r)
    {}
    
    Type(const std::string &n, const Range &r)
      : name(n)
    {
      ranges.push_back(r);
    }
  };

  struct Mapping
  {
    MappingType type;
    std::string name;
    RangeList ranges;

    void operator() (MappingType t, const std::string &n
		     , const RangeList &r = RangeList());
    void operator() (MappingType t, const std::string &n, const Range &r);

    Mapping()
      : type(NONE)
    {} 
  };
  
  hls::ostream& operator<< (hls::ostream &out, const Mapping &p);
  std::ostream& operator<< (std::ostream &out, const Mapping &p);

  struct Assignable 
  {
    std::string id;
    
    // FIXME: Type structures keep getting duplicated. There has to be
    // a better way to do this.
    Type type;

    Mapping mapping;

    Range& get_range(unsigned i);
    void update_range(unsigned i, const Range &r);
    unsigned width(unsigned index);

    Assignable(const std::string &_id, const Type &t)
      : id(_id), type(t)
    {}
  };

  struct Port : public Assignable
  {
    hls::IOType io_type;
    bool is_control;

    Port(const std::string &_id, hls::IOType _io_type
         , const Type &t, bool _isc = false)
      : Assignable(_id, t), io_type(_io_type), is_control(_isc)
    {}
  };

  struct Wire : public Assignable
  {
    Wire(const std::string &_id, const Type &t)
      : Assignable(_id, t)
    {}
  };

  inline bool is_input(Port *port) {return port->io_type == hls::IN;}
  inline bool is_output(Port *port) {return !is_input(port);}

  inline bool is_scalar(Type &type)
  {
    return type.ranges.size() == 0;
  }

  inline bool is_scalar(Port *port)
  {
    return is_scalar(port->type);
  }

  inline hls::ostream& operator<< (hls::ostream &out, const Type &type)
  {
    out << type.name << type.ranges;
    return out;
  }

  inline std::ostream& operator<< (std::ostream &out, const Type &type)
  {
    out << type.name << type.ranges;
    return out;
  }
}

#endif
