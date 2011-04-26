#ifndef __AHIR_LINK_LAYER_HPP__
#define __AHIR_LINK_LAYER_HPP__

#include "Symbol.hpp"

#include <string>
#include <map>

#include <assert.h>

namespace ahir {

  class Module;

  struct LinkLayer {
    std::string id;

    struct Literal {
      std::string iface;
      Symbol sym;
      
      void operator() (const std::string& i, int s) {iface = i; sym = s;};
    };

    typedef std::map<Symbol, Literal> Interface;

    typedef std::map<std::string, Interface> IfaceMap;
    IfaceMap maps, rmaps;

    Module *parent;

    inline void map(const std::string& from_iface
	     , Symbol from_sym
	     , const std::string& to_iface
	     , Symbol to_sym)
    {
      maps[from_iface][from_sym](to_iface, to_sym);
      rmaps[to_iface][to_sym](from_iface, from_sym);
    }

    inline Literal& forward_map(const std::string& iface, Symbol sym)
    {
      assert(maps.find(iface) != maps.end() && "uh oh!");
      Interface& i = maps[iface];
      assert(i.find(sym) != i.end() && "uh oh!");
      return i[sym];
    }

    inline Literal& reverse_map(const std::string& iface, Symbol sym)
    {
      assert(rmaps.find(iface) != rmaps.end() && "uh oh!");
      Interface& i = rmaps[iface];
      assert(i.find(sym) != i.end() && "uh oh!");
      return i[sym];
    }

    LinkLayer(const std::string& _id) {id = _id; parent = NULL; };
    LinkLayer() {parent = NULL;};
  };

};

#endif
