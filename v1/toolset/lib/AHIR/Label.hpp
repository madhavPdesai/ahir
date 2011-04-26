#ifndef AHIR_LABEL_HPP
#define AHIR_LABEL_HPP

#include "typedefs.hpp"

#include <map>

#include <fstream>

#include <boost/serialization/map.hpp>
#include <boost/serialization/set.hpp>
#include <boost/serialization/assume_abstract.hpp>
namespace bs = boost::serialization;

namespace hls {
  class Program;
}

namespace ahir {

  typedef std::set<unsigned> Clique;
  typedef std::set<Clique> CliqueSet;

  typedef std::map<unsigned, std::set<unsigned> > LabelCPEMap;
  
  struct LabelGraph 
  {
    // Check two labels for compatibility
    virtual bool compatible(unsigned i, unsigned j) = 0;

    // Check two CP elements for compatibility
    virtual bool compatible(CPElement *x, CPElement *y) = 0;

    virtual unsigned& weight(unsigned x) = 0;
    virtual void reset_weights(unsigned w = 0) = 0;

    LabelCPEMap elements;

    CliqueSet cover;

    virtual ~LabelGraph() {};
  };

  template <class Archive>
  inline void serialize(Archive &ar, LabelGraph &lg, const unsigned version)
  {
    ar & bs::make_nvp("elements", lg.elements)
      & bs::make_nvp("cover", lg.cover);
  }

  // Create a label graph for the given CP; store it in the CP, and
  // also return a pointer to it.
  LabelGraph* create_labels(ControlPath *cp);
  void create_labels(hls::Program *program);
  
  LabelGraph* create_empty_lrg();
  bool validate_lrg(LabelGraph *lgraph);
  
  void generate_cover(LabelGraph *lgraph, bool use_weights);
  void generate_cover(LabelGraph *lgraph, CliqueSet &cover, bool use_weights);
  bool verify_cover(LabelGraph *lgraph, CliqueSet &cover, bool use_weights);

  bool save_lrg(LabelGraph *lgraph, std::ostream &out);
  inline bool save_lrg(LabelGraph *lgraph, const std::string &filename)
  {
    std::ofstream ofs(filename.c_str());
    return save_lrg(lgraph, ofs);
  }
  
  bool load_lrg(LabelGraph *lgraph, std::istream &in);
  inline bool load_lrg(LabelGraph *lgraph, const std::string &filename)
  {
    std::ifstream ifs(filename.c_str());
    return load_lrg(lgraph, ifs);
  }
  
  bool save_cover(CliqueSet &cover, std::ostream &out);
  inline bool save_cover(CliqueSet &cover, const std::string &filename)
  {
    std::ofstream ofs(filename.c_str());
    return save_cover(cover, ofs);
  }

  bool load_cover(CliqueSet &cover, std::istream &in);
  inline bool load_cover(CliqueSet &cover, const std::string &filename)
  {
    std::ifstream ifs(filename.c_str());
    return load_cover(cover, ifs);
  }

}

BOOST_SERIALIZATION_ASSUME_ABSTRACT(ahir::LabelGraph);

#endif
