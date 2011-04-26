#ifndef AHIR_LRG_HPP
#define AHIR_LRG_HPP

#include "ControlPath.hpp"
#include <Base/Utils.hpp>
#include <boost/archive/xml_iarchive.hpp>
#include <boost/archive/xml_oarchive.hpp>
#include <boost/graph/adjacency_list.hpp>
#include <boost/graph/adj_list_serialize.hpp>
#include <boost/serialization/base_object.hpp>
#include <boost/serialization/type_info_implementation.hpp>

namespace bs = boost::serialization;

namespace ahir {

  // The class EdgeProperty represents the tag on an edge in the LRG.
  // A valid tag satisfies the following conditions:
  // 1. f > fin_id ... fin_id == 1 and marked_place_id == 0
  // 2. 0 <= i < k
  // 3. k > 1 ... Else element f is not a fork!
  //
  // The default constructor ensures that a new tag is always invalid,
  // while the parameterised constructor checks for validity.
  
  struct EdgeProperty           // "label element"
  {
    unsigned f;                 // identifies a fork
    unsigned i;                 // index range 0..k-1
    unsigned k;                 // out-degree of the fork

    const bool is_valid() const
    {
      return f > fin_id || k > 1 || i < k;
    }

    EdgeProperty()
      : f(fin_id), i(1), k(0)
    {}

    EdgeProperty(unsigned _f, unsigned _i, unsigned _k)
      : f(_f), i(_i), k(_k)
    {
      assert(is_valid());
    }
  };

  template <class Archive>
  inline void serialize(Archive &ar, EdgeProperty &ep, const unsigned version)
  {
    ar & bs::make_nvp("f", ep.f)
      & bs::make_nvp("i", ep.i)
      & bs::make_nvp("k", ep.k);
  }
  
  struct VertexProperty 
  {
    hls::Colour colour;
    unsigned incoming_fork;
    unsigned weight;
  };

  template <class Archive>
  inline void serialize(Archive &ar, VertexProperty &vp, const unsigned version)
  {
    ar & bs::make_nvp("colour", vp.colour)
      & bs::make_nvp("incoming_fork", vp.incoming_fork);
  }

  typedef boost::adjacency_list<boost::setS, boost::vecS
                                , boost::bidirectionalS
                                , VertexProperty
                                , EdgeProperty
                                , boost::no_property
                                , boost::vecS> LRG;
  typedef LRG::vertex_descriptor Label;
  typedef LRG::edge_descriptor Edge;
  typedef std::set<Label> LabelSet;

  // A label with an invalid tag is assumed to be unlabelled.
  inline bool is_labelled(const Edge &e, const LRG &lrg)
  {
    return lrg[e].is_valid();
  }

  void initialise_dfs(LRG &lrg);
  
  bool validate_lrg(LRG &lrg);

  bool compatible(unsigned i, unsigned j, LRG &lrg);
}

#endif
