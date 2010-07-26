#ifndef __CONTROLPATH_HPP__
#define __CONTROLPATH_HPP__

#include <Base/Utils.hpp>
#include "Symbol.hpp"
#include "typedefs.hpp"

#include <vector>
#include <string>
#include <map>
#include <set>
#include <assert.h>

namespace ahir {

  class Transition;
  class Module;
  class LabelGraph;

  struct CPElement {
    unsigned id;
    CPEType type;
    std::string description;

    CPEList srcs;
    CPEList snks;

    hls::Colour colour;
    unsigned label;

    CPElement(unsigned _id, CPEType t, const std::string &d)
      : id(_id), type(t), description(d), colour(hls::WHITE), label(0)
    {}

    CPElement(const CPElement &other)
      : id(other.id), type(other.type), description(other.description)
      , colour(other.colour), label(other.label)
    {} 
  };

  struct Place : public CPElement {
    unsigned marking;

    // The initial marking is zero iff the id is zero. Consequently,
    // the marked place must be the first place created in the
    // petri-net.
    Place(unsigned _id, const std::string &d
          ,  unsigned m = 0)
      : CPElement(_id, PLACE, d), marking(m)
    { assert((m == 0) ^ (id == marked_place_id)); } // No logical XOR! Hail!

    Place(const Place &other)
      : CPElement(other), marking(other.marking)
    {} 
  };

  struct Transition : public CPElement {
    Symbol symbol;
    
    Transition(unsigned _id, CPEType t, const std::string &d = "")
      : CPElement(_id, t, d), symbol(0)
    { }

    Transition(const Transition &other)
      : CPElement(other), symbol(other.symbol)
    {} 
  };

  class MuxRegion;
  // List of MuxRegion identified by the id of their exit joins (the
  // proxy exit has the same id when the MuxRegion is replaced).
  typedef std::map<unsigned, MuxRegion*> MuxRegionMap;

  struct ControlPath
  {
    std::string id;

    Module *parent;
    Transition *init;           // (init_id, type ACK, symbol 1)
    Transition *fin;            // (fin_id, type REQ, symbol 1)
    // Store the marked place purely for convenience. It can be
    // reached from both init and fin.
    Place *marked_place;

    typedef std::map<unsigned, Place*> PList;
    PList places;
    typedef std::map<unsigned, Transition*> TList;
    TList transitions;
    typedef std::map<unsigned, CPElement*> EList;
    EList elements;

    MuxRegionMap mux_regions;
    LabelGraph *labels;

    void register_element(CPElement *cpe);
    CPElement* find_element(unsigned id);
    void register_transition(Transition *t);
    Transition* find_transition(unsigned id);
    void register_place(Place *p);
    Place* find_place(unsigned id);

    std::map<Symbol, Transition*> acks;
    std::map<Symbol, Transition*> reqs;
    
    ControlPath(const std::string& _id);
    ~ControlPath();
  };

};



#endif
