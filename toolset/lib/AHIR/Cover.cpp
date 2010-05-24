#include "Label.hpp"
#include "LRG.hpp"
#include "Cover.hpp"

using namespace ahir;
using namespace hls;

namespace {

  typedef std::map<Label, CliqueSet> CoverMap;

  struct LRGCoverException
  {
    std::string message;
    LRGCoverException(const std::string &m)
      : message(m)
    {}
  };

  void verify_clique(const Clique &cl, LRG &lrg)
  {
    for (Clique::iterator ii = cl.begin(), ie = cl.end(); ii != ie; ++ii) {
      unsigned i = *ii;
      Label x = boost::vertex(i, lrg);
      Clique::iterator ji = ii;
      ++ji;
      for (; ji != ie; ++ji) {
        unsigned j = *ji;
        Label y = boost::vertex(j, lrg);
        if (!compatible(x, y, lrg))
          throw LRGCoverException("incompatible labels in one clique");
      }
    }
  }

  void cover_dfs(Label x, LRG &lrg, CoverMap &cmap, bool use_weights) 
  {
    lrg[x].colour = GRAY;
    unsigned x_index = boost::get(boost::vertex_index, lrg, x);

    // If x is a leaf add it to a clique of its own.
    if (boost::out_degree(x, lrg) == 0) {
      lrg[x].colour = BLACK;
      if (use_weights && lrg[x].weight == 0)
        return;
      
      Clique cl;
      assert(cmap.find(x) == cmap.end());
      cl.insert(x_index);
      cmap[x].insert(cl);
      return;
    }

    // Since x is an internal node, descend along its successors.
    LRG::adjacency_iterator ai, ae;
    for (tie(ai, ae) = boost::adjacent_vertices(x, lrg);
         ai != ae; ++ai) {
      Label a = *ai;

      switch (lrg[a].colour) {
        case WHITE:
          cover_dfs(a, lrg, cmap, use_weights);
          break;

        case BLACK:
          break;

        default:
          assert(false);
          break;
      }
    }

    // Collect cliques from the successors and sort them by the
    // fork-id along which the respetive successors are reachable.
    // Cliques are compatible if and only if they are reachable along
    // different forks, and hence belong to different sets.
    LRG::out_edge_iterator ei, ee;
    typedef std::map<unsigned, CliqueSet> ForkMap;
    ForkMap fork_map;
    for (tie(ei, ee) = boost::out_edges(x, lrg);
         ei != ee; ++ei) {
      Edge e = *ei;
      Label y = boost::target(e, lrg);
      assert(lrg[y].colour == BLACK);
      if (cmap.find(y) == cmap.end()) // no cliques here
        continue;
      CliqueSet &lset = cmap[y];
      assert(!lset.empty());
      // Add the cliques to the set for the corresponding fork
      // indicated by the label on edge e.
      CliqueSet &cset = fork_map[lrg[e].f];
      cset.insert(lset.begin(), lset.end());
      cmap.erase(y);            // y is out of the game now.
    }

    // While there are sets available, merge together one clique from
    // each set.
    if (!fork_map.empty()) {
      assert(cmap.find(x) == cmap.end());
      CliqueSet &lset = cmap[x];
      while (!fork_map.empty()) {
        Clique cl;              // the new union clique
        for (ForkMap::iterator fi = fork_map.begin(); fi != fork_map.end();) {
          CliqueSet &cset = (*fi).second;
          assert(!cset.empty());
          const Clique &one = *cset.begin();
          assert(!one.empty());
          cl.insert(one.begin(), one.end());
          cset.erase(one);
          if (cset.empty()) {   // this fork is out of the game
            fork_map.erase(fi++);
          } else {
            ++fi;
          }
        }
        assert(!cl.empty());
        lset.insert(cl);
      }
      assert(!lset.empty());
    }

    // If x has no relevant weight, we don't add it to any clique.
    lrg[x].colour = BLACK;
    if (use_weights && lrg[x].weight == 0)
      return;

    // If x has a set of cliques, select one, else create a new one.
    CliqueSet &lset = cmap[x];
    Clique nl;
    if (lset.size() > 0) {
      CliqueSet::iterator lsi = lset.begin();
      // crazy roundabout way to throw away the implicit const
      // reference returned by lset.begin()
      const Clique &cl = *lsi;
      nl = cl;
      lset.erase(cl);
    }

    // Add x to the new clique and insert it into 
    nl.insert(x_index);
    lset.insert(nl);
  }
}

void ahir::generate_cover(LRG &lrg, CliqueSet &cover, bool use_weights)
{
  Label zero = boost::vertex(0, lrg);
  initialise_dfs(lrg);

  CoverMap cmap;
  cover_dfs(zero, lrg, cmap, use_weights);

  LRG::vertex_iterator vi, ve;
  for (tie(vi, ve) = boost::vertices(lrg); vi != ve; ++vi) {
    Label x = *vi;
    if (cmap.find(x) == cmap.end())
      continue;
    
    assert(cmap[x].size() > 0);
    assert(x == zero);
  }

  std::swap(cover, cmap[zero]);
  assert(verify_cover(lrg, cover, use_weights));
}

bool ahir::verify_cover(LRG &lrg, CliqueSet &cover, bool use_weights) 
{
  std::set<unsigned> tally;

  try {
    
    for (CliqueSet::iterator ci = cover.begin(), ce = cover.end(); ci != ce; ++ci) {
      const Clique &cl = *ci;

      verify_clique(cl, lrg);

      for (Clique::iterator ii = cl.begin(), ie = cl.end(); ii != ie; ++ii) {
        unsigned i = *ii;
        if (tally.count(i) != 0)
          // throw LRGCoverException("label encountered twice in the over");
          assert(false);
        tally.insert(i);
      }
    }

    if (!use_weights) {
      if (tally.size() != boost::num_vertices(lrg))
        // throw LRGCoverException("missing labels");
        assert(false);
    } else {
      LRG::vertex_iterator vi, ve;
      for (tie(vi, ve) = boost::vertices(lrg); vi != ve; ++vi) {
        Label v = *vi;
        unsigned v_index = boost::get(boost::vertex_index, lrg, v);

        if (tally.count(v_index) == 0)
          assert(lrg[v].weight == 0);
      }
    }
  } catch (LRGCoverException& ex) {
    std::cerr << ex.message;
    return false;
  }
  
  return true;
}
