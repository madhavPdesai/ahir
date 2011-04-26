#ifndef __HLS_INDENT_HPP__
#define __HLS_INDENT_HPP__

#include <boost/format.hpp>

#include <ostream>
#include <string>
#include <assert.h>

namespace hls {

  typedef enum { indent, indent_in, indent_out } flag;
  
  struct ostream 
  {
    std::ostream &out;

    std::string indent_str;
    std::string increment;

    
    void indent_plus() { indent_str += increment; }
    void indent_minus()
    {
      assert(indent_str.length() >= increment.size() && "invalid indent");
      indent_str.resize(indent_str.size() - increment.size());
    }
    void insert_indent() { out << indent_str; } 

    ostream(std::ostream &o)
      : out(o), indent_str("\n"), increment("  ")
    {}
  };

  inline ostream& operator<< (ostream &out, const std::string &str)
  {
    out.out << str;
    return out;
  }

  inline ostream& operator<< (ostream &out, const int i)
  {
    out.out << i;
    return out;
  }

  inline ostream& operator<< (ostream &out, const boost::format &f)
  {
    out.out << f;
    return out;
  }

  inline ostream& operator<< (ostream &out, const flag f)
  {
    switch (f) {
      case indent:
	out.insert_indent();
	break;

      case indent_in:
	out.indent_plus();
	break;

      case indent_out:
	out.indent_minus();
	break;
    }
	  
    return out;
  }
}

#endif
