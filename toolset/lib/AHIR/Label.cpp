#include "Label.hpp"
#include "LRG.hpp"
#include "Cover.hpp"
#include "ControlPath.hpp"
#include "CPUtils.hpp"
#include "MuxRegions.hpp"
#include "Module.hpp"
#include "Type2Verify.hpp"
#include <Base/Program.hpp>
#include <Base/Utils.hpp>

#include <assert.h>
#include <deque>

using namespace ahir;
using namespace hls;

namespace {
  
  typedef std::deque<CPElement*> Queue;

  struct LabelGraphImpl : public LabelGraph
  {
    std::string cp;
    LRG lrg;

    bool compatible(CPElement *x, CPElement *y);
    bool compatible(unsigned i, unsigned j);
    
    unsigned& weight(unsigned x)
    {
      Label l = boost::vertex(x, lrg);
      return lrg[l].weight;
    }

    void reset_weights(unsigned w)
    {
      LRG::vertex_iterator vi, ve;
      for (tie(vi, ve) = boost::vertices(lrg); vi != ve; ++vi) {
        Label l = *vi;
        lrg[l].weight = w;
      }
    }

    LabelGraphImpl(const std::string &_cp)
      : cp(_cp)
    { }

    LabelGraphImpl()
    {} 

    virtual ~LabelGraphImpl() {};
  };

  template <class Archive>
  inline void serialize(Archive &ar, LabelGraphImpl &lg, const unsigned version)
  {
    ar & bs::make_nvp("LabelGraph", bs::base_object<LabelGraph>(lg))
      & bs::make_nvp("control_path", lg.cp)
      & bs::make_nvp("lrg", lg.lrg);
  }

  typedef boost::archive::xml_oarchive LRGWriter;
  typedef boost::archive::xml_iarchive LRGReader;

  /* ===== LRG Construction ===== */

  // Can't overload assign_label() unsigned i conflicts with Label l when used as
  // first argument in the overloaded function
  void assign_label_index(unsigned i, CPElement *cpe, LabelGraphImpl *lgraph)
  {
    cpe->label = i;
    assert(lgraph->elements[i].find(cpe->id) == lgraph->elements[i].end());
    lgraph->elements[i].insert(cpe->id);
  }

  void assign_label(CPElement *to, CPElement *from, LabelGraphImpl *lgraph)
  {
    assign_label_index(from->label, to, lgraph);
  }

  void assign_label(Label l, CPElement *cpe, LabelGraphImpl *lgraph)
  {
    assign_label_index(boost::get(boost::vertex_index, lgraph->lrg, l)
                       , cpe, lgraph);
  }

  typedef std::map<unsigned, LabelSet > SubSetCollection;
  typedef std::map<unsigned, unsigned> DegreeMap;
  typedef std::map<unsigned, Label> ForkMap;

  void track_reducible(Label l, SubSetCollection &subsets
                       , DegreeMap &degree, ForkMap &fork
                       , LRG &lrg) 
  {
    assert(boost::in_degree(l, lrg) < 2);
    if (boost::in_degree(l, lrg) == 0)
      return;
    
    Edge e = *boost::in_edges(l, lrg).first;
    Label p = boost::source(e, lrg);
    EdgeProperty &ep = lrg[e];
    subsets[ep.f].insert(l);
      
    if (fork.find(ep.f) != fork.end())
      assert(fork[ep.f] == p);
    else
      fork[ep.f] = p;

    if (degree.find(ep.f) != degree.end())
      assert(degree[ep.f] == ep.k);
    else
      degree[ep.f] = ep.k;

  }

  void insert_root(Label l, LabelSet &roots, LRG &lrg)
  {
    switch (boost::in_degree(l, lrg)) {
      case 0:
      case 1:
        roots.insert(l);
        break;

      default: {
        LRG::in_edge_iterator ei, ee;
        for (tie(ei, ee) = boost::in_edges(l, lrg); ei != ee; ++ei) {
          Edge e = *ei;
          assert(!is_labelled(e, lrg));
          Label p = boost::source(e, lrg);
          insert_root(p, roots, lrg);
        }
        break;
      }
    }

    for (LabelSet::iterator li = roots.begin(), le = roots.end();
         li != le; ++li) {
      assert(boost::in_degree(*li, lrg) < 2);
    }
  }
  
  void reduce_labels_at_join(LabelSet &labels, LRG &lrg)
  {
    SubSetCollection subsets;
    DegreeMap degree;
    ForkMap fork;

    do {
      for (LabelSet::iterator li = labels.begin(), le = labels.end();
           li != le; ++li) {
        Label l = *li;
        track_reducible(l, subsets, degree, fork, lrg);
      }
      
      SubSetCollection::iterator ssi = subsets.begin();
      SubSetCollection::iterator sse = subsets.end();
      
      for (; ssi != sse; ++ssi) {
        unsigned f = (*ssi).first;
        LabelSet &reds = (*ssi).second;
        assert(degree.find(f) != degree.end());
        if (reds.size() == degree[f])
          break;
      }

      if (ssi == sse)
        break;

      unsigned f = (*ssi).first;
      LabelSet &reds = (*ssi).second;
      LabelSet temp;
      std::set_difference(labels.begin(), labels.end()
                          , reds.begin(), reds.end()
                          , inserter(temp, temp.begin()));
      std::swap(temp, labels);
      
      assert(fork.find(f) != fork.end());
      insert_root(fork[f], labels, lrg);
      subsets.erase(ssi);
    } while (true);
  }

  bool label_join(CPElement *x, LabelGraphImpl *lgraph)
  {
    LRG &lrg = lgraph->lrg;
    LabelSet labels;
    
    for (CPEList::iterator si = x->srcs.begin(), se = x->srcs.end();
         si != se; ++si) {
      CPElement *src = *si;
      
      if (src->colour == WHITE)
        return false;
      
      Label l = boost::vertex(src->label, lrg);
      insert_root(l, labels, lgraph->lrg);
    }
    
    reduce_labels_at_join(labels, lrg);

    Label lj = (labels.size() == 1
                ? *labels.begin()
                : boost::add_vertex(lrg));
    assign_label(lj, x, lgraph);

    if (labels.size() > 1)
      for (LabelSet::iterator li = labels.begin(), le = labels.end();
           li != le; ++li) {
        Label s = *li;
        boost::add_edge(s, lj, lrg);
      }

    return true;
  }

  void label_merge(CPElement *cpe, LabelGraphImpl *lgraph) 
  {
    bool label_valid = false;
    unsigned label;
    
    for (CPEList::iterator si = cpe->srcs.begin(), se = cpe->srcs.end();
         si != se; ++si) {
      CPElement *src = *si;
      if (src->colour == WHITE)
        continue;
      
      if (label_valid)
        assert(label == src->label);
      else {
        label = src->label;
        label_valid = true;
      }
    }

    assert(label_valid);
    assign_label(label, cpe, lgraph);
  }

  // mutual recursion. hail!
  void label_dfs(CPElement *cpe, LabelGraphImpl *lgraph);
  
  void snks_dfs(CPElement *cpe, LabelGraphImpl *lgraph)
  {
    cpe->colour = GRAY;
    for (CPEList::iterator si = cpe->snks.begin(), se = cpe->snks.end();
         si != se; ++si) {
      CPElement *snk = *si;
      switch (snk->colour) {
        case GRAY:
        case BLACK:
          assert(is_merge(snk) || snk->id == marked_place_id);
          assert(snk->label == cpe->label);
          break;

        case WHITE:
          label_dfs(snk, lgraph);
          break;

        default:
          assert(false);
          break;
      }
    }
    cpe->colour = BLACK;
  }
  
  void label_dfs(CPElement *cpe, LabelGraphImpl *lgraph)
  {
    bool continue_dfs = true;

    if (cpe->colour == GRAY)
      assert(is_merge(cpe));
    else
      assert(cpe->colour == WHITE);
    
    if (is_fork(cpe)) {
      CPElement *src = *cpe->srcs.begin();
      assign_label(cpe, src, lgraph);
      Label l = boost::vertex(cpe->label, lgraph->lrg);
      
      unsigned f = cpe->id;
      unsigned k = cpe->snks.size();
      unsigned i = 0;

      cpe->colour = GRAY;
      for (CPEList::iterator si = cpe->snks.begin(), se = cpe->snks.end();
           si != se; ++si) {
        CPElement *snk = *si;
        assert(snk->colour == WHITE);
        
        Label snk_label = boost::add_vertex(lgraph->lrg);
        boost::add_edge(l, snk_label, EdgeProperty(f, i, k), lgraph->lrg);
        assign_label(snk_label, snk, lgraph);
        ++i;

        snks_dfs(snk, lgraph);
      }
      cpe->colour = BLACK;
      continue_dfs = false;
    } else if (is_join(cpe))
      continue_dfs = label_join(cpe, lgraph);
    else if (is_merge(cpe)) {
      label_merge(cpe, lgraph);
    } else {
      assert(is_simple(cpe) || is_branch(cpe) || is_fin(cpe));
      CPElement *src = *cpe->srcs.begin();
      assign_label(cpe, src, lgraph);
    }

    if (continue_dfs) {
      snks_dfs(cpe, lgraph);
    }
  }

} // end anonymous namespace

bool LabelGraphImpl::compatible(unsigned x, unsigned y)
{
  return ahir::compatible(x, y, lrg);
}

bool LabelGraphImpl::compatible(CPElement *x, CPElement *y)
{
  // We assume that the elements are labelled, since there is no
  // elegant way to check whether the labels are valid.
  return compatible(x->label, y->label);
}

LabelGraph* ahir::create_labels(ControlPath *cp)
{
  LabelGraphImpl *lgraph = new LabelGraphImpl(cp->id);
  cp->labels = lgraph;
  
  LRG &lrg = lgraph->lrg;
  Label zero = boost::add_vertex(lrg);
  assert(zero == boost::vertex(0, lrg));
  assert(boost::get(boost::vertex_index, lrg, zero) == 0);

  disconnect_initial_marking(cp);
  // #warning fix me.
  cp->init->srcs.insert(cp->marked_place);
  replace_mux_regions(cp);
  initialise_dfs(cp);
  // #warning fix me.
  cp->init->colour = WHITE;
  assign_label(zero, cp->marked_place, lgraph);
  cp->marked_place->colour = BLACK;
  label_dfs(cp->init, lgraph);
    
  restore_mux_regions(cp);
  reconnect_initial_marking(cp);

  // FIXME: very important opportunity to remove spurious elements
  // from the control-path.
  // 
  // for (LabelCPEMap::iterator ci = lgraph->elements.begin()
         // , ce = lgraph->elements.end(); ci != ce; ++ci) {
    // assert((*ci).second.size() > 0);
    // if ((*ci).second.size() > 1)
      // continue;
    // unsigned eid = *(*ci).second.begin();
    // CPElement *cpe = cp->find_element(eid);
    // assert(cpe);
    // std::cerr << "\nSingle CPE at label "
              // << (*ci).first << ": " << eid << "(" << cpe->description << ")";
  // }
  
  return lgraph;
}

bool ahir::validate_lrg(LabelGraph *lgraph)
{
  LabelGraphImpl *actual = static_cast<LabelGraphImpl*>(lgraph);
  return validate_lrg(actual->lrg);
}

bool ahir::save_lrg(LabelGraph *lgraph, std::ostream &out)
{
  LabelGraphImpl *actual = static_cast<LabelGraphImpl*>(lgraph);
  LRGWriter w(out);

  w << bs::make_nvp("LabelGraphImpl", actual);
  return true;
}

bool ahir::load_lrg(LabelGraph *lgraph, std::istream &in)
{
  LabelGraphImpl *actual = static_cast<LabelGraphImpl*>(lgraph);
  LRGReader r(in);

  r >> bs::make_nvp("LabelGraphImpl", *actual);
  return true;
}

bool ahir::save_cover(CliqueSet &cover, std::ostream &out)
{
  LRGWriter w(out);
  w << bs::make_nvp("LRGCover", cover);
  
  return true;
}

bool load_cover(CliqueSet &cover, std::istream &in)
{
  LRGReader r(in);
  r >> bs::make_nvp("LRGCover", cover);
  return true;
}

void ahir::generate_cover(LabelGraph *lgraph, bool use_weights)
{
  generate_cover(lgraph, lgraph->cover, use_weights);
}

void ahir::generate_cover(LabelGraph *lgraph, CliqueSet &cover, bool use_weights)
{
  LabelGraphImpl *actual = static_cast<LabelGraphImpl*>(lgraph);
  generate_cover(actual->lrg, cover, use_weights);
}

bool ahir::verify_cover(LabelGraph *lgraph, CliqueSet &cover, bool use_weights) 
{
  LabelGraphImpl *actual = static_cast<LabelGraphImpl*>(lgraph);
  return verify_cover(actual->lrg, cover, use_weights);
}

LabelGraph* ahir::create_empty_lrg()
{
  LabelGraphImpl *lrg = new LabelGraphImpl();
  return lrg;
}

void ahir::create_labels(Program *program)
{
  for (Program::ModuleList::iterator mi = program->modules.begin()
         , me = program->modules.end(); mi != me; ++mi) {
    hls::Module *module = (*mi).second;
    ahir::Module *ahir = to_ahir(module);

    ControlPath *cp = ahir->cp;
    
    create_labels(cp);
    save_lrg(cp->labels, cp->id + ".labels.xml");
  }
}
