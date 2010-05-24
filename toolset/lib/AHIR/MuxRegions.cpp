#include "MuxRegions.hpp"

#include "../AHIR/ControlPath.hpp"
#include "../AHIR/CPUtils.hpp"

#include <iostream>
#include <assert.h>
#include <set>

using namespace ahir;

namespace ahir {
  
  // The parallel-merge region. This structure records the entry forks
  // and the exit join that demarcate the parallel-merge. These are
  // replaced by proxies connected to a single merge place.
  struct MuxRegion {
    unsigned id;

    // elements within the region, not including the end points
    std::set<CPElement*> elements;

    typedef std::map<Transition*, Transition*> ProxyMap;
    ProxyMap proxies, reverse_proxies;
    void register_proxy(Transition* orig, Transition *proxy);
    Transition* find_proxy(Transition *orig);
    Transition* find_reverse_proxy(Transition *proxy);

    // this merge replaces the entire region
    Place *merge;

    MuxRegion(unsigned _id)
      : id(_id), merge(NULL)
    {}

    ~MuxRegion();
  };

  // List of MuxRegion identified by the id of their exit joins (the
  // proxy exit has the same id when the MuxRegion is replaced).
  typedef std::map<unsigned, MuxRegion*> MuxRegionMap;
  
}

MuxRegion::~MuxRegion()
{
  // member of the elements vector are not destroyed since they are
  // owned by the control-path.

  // destroy all the proxy forks
  for (ProxyMap::iterator fi = proxies.begin(), fe = proxies.end();
       fi != fe; ++fi) {
    delete (*fi).second;
  }

  delete merge;
}

void MuxRegion::register_proxy(Transition *orig, Transition *proxy)
{
  assert(!find_proxy(orig));
  proxies[orig] = proxy;
  reverse_proxies[proxy] = orig;
}

Transition* MuxRegion::find_proxy(Transition *orig)
{
  if (proxies.find(orig) != proxies.end())
    return proxies[orig];
  return NULL;
}

Transition* MuxRegion::find_reverse_proxy(Transition *proxy)
{
  if (reverse_proxies.find(proxy) != reverse_proxies.end())
    return reverse_proxies[proxy];
  return NULL;
}

namespace {

  // This function reconnects x->snks to y, where CPE y replaces CPE x
  // in the ControlPath.
  void replace_snk_edges(CPElement *x, CPElement *y)
  {
    for (CPEList::iterator si = x->snks.begin()
           , se = x->snks.end(); si != se; ++si) {
      CPElement *snk = *si;
      assert(snk->srcs.count(x) == 1);
      snk->srcs.erase(x);
      snk->srcs.insert(y);
    }
    y->snks = x->snks;
  }

  // This function reconnects x->srcs to y, where CPE y replaces CPE x
  // in the ControlPath.
  void replace_src_edges(CPElement *x, CPElement *y)
  {
    for (CPEList::iterator si = x->srcs.begin()
           , se = x->srcs.end(); si != se; ++si) {
      CPElement *src = *si;
      assert(src->snks.count(x) == 1);
      src->snks.erase(x);
      src->snks.insert(y);
    }
    y->srcs = x->srcs;
  }

  // A function that recursively builds one n-way merge tree in the
  // MuxRegion. Return true if we did not encounter an element that
  // violates the construction rules. The parameter merge_found is
  // updated to indicate whether we encountered a merge during the
  // traversal.
  bool create_merge_tree(std::set<Transition*>&forks
                         , std::set<CPElement*>&bag
                         , bool &merge_found
                         , unsigned &merge_id
                         , CPElement *ele)
  {
    // If we encounter an element that is already in the bag, then
    // this is not a merge tree.
    if (bag.count(ele) != 0)
      return false;

    if (is_fork(ele)) {
      // We seem to have reached an exit.
      forks.insert(static_cast<Transition*>(ele));
      return true;
    } else if (is_simple(ele) || is_merge(ele)) {
      if (is_merge(ele)) {
        merge_found = true;
        merge_id = ele->id;
      }
      
      bag.insert(ele);
      for (CPEList::iterator sri = ele->srcs.begin(), sre = ele->srcs.end();
           sri != sre; sri++) {
        CPElement *src = *sri;
        // We don't check for a merge here, only at the topmost call.
        if (!create_merge_tree(forks, bag, merge_found, merge_id, src))
          return false;
      }
      return true;
    } else
      return false;
  }

  // Starting from the given element, work backwards looking for a
  // merge tree. Any fork encountered must be a member of "forks".
  // Each fork must be encountered exactly once, which we track using
  // "worklist". If we encounter an element which is already in the
  // bag, then this is not a merge tree.
  bool compare_merge_tree(const std::set<Transition*> &forks
                          , std::set<Transition*> &worklist
                          , std::set<CPElement*>&bag
                          , CPElement *ele)
  {
    if (bag.count(ele) != 0)
      return false;
    
    if (is_fork(ele)) {
      Transition *f = static_cast<Transition*>(ele);
      if (forks.count(f) == 0)
        return false;
      if (worklist.count(f) != 0)
        return false;
      worklist.insert(f);
      return true;
    } else if (is_merge(ele) || is_simple(ele)) {
      bag.insert(ele);
      for (CPEList::iterator sri = ele->srcs.begin(), sre = ele->srcs.end();
           sri != sre; sri++) {
        CPElement *src = *sri;
        if (!compare_merge_tree(forks, worklist, bag, src))
          return false;
      }
      return true;
    } else
      return false;
  }

  // We have a MuxRegion consisting of elements in the bag, along with
  // a set of entry forks and one exit join. Remove this from the CP
  // and replace it with a set of proxies. Return the proxy join.
  Transition* record_mux_region(ControlPath *cp
                                , std::set<CPElement*> &bag
                                , std::set<Transition*> &forks
                                , Transition *join
                                , unsigned merge_id)
  {
    unsigned id = join->id;
    MuxRegion *mux_region = new MuxRegion(id);
    assert(cp->mux_regions.find(mux_region->id) == cp->mux_regions.end());
    cp->mux_regions[mux_region->id] = mux_region;

    mux_region->elements = bag;

    for (std::set<CPElement*>::iterator bi = bag.begin()
           , be = bag.end(); bi != be; ++bi) {
      CPElement *ele = *bi;

      cp->elements.erase(ele->id);
      if (is_place(ele)) {
        cp->places.erase(ele->id);
      } else if (is_trans(ele)) {
        assert(forks.count(static_cast<Transition*>(ele)) == 0
               && "forks should not be in the bag");
        cp->transitions.erase(ele->id);
      } else
        assert(false);
    }

    // Create the replacement merge, with a suitable id derived from
    // the existing number of places in the CP.
    std::ostringstream dscr;
    dscr << "merge replacement at join " << id;
    Place *new_place = new Place(merge_id, dscr.str());
    mux_region->merge = new_place;
    cp->register_place(new_place);
  
    Transition *proxy_join = new Transition(*join);
    mux_region->register_proxy(join, proxy_join);
    cp->transitions.erase(join->id);
    cp->elements.erase(join->id);
    cp->register_transition(proxy_join);

    control_flow(mux_region->merge, proxy_join);
    // We do not disconnect the join from its snks here, since that
    // invalidates the iterators in the DFS.
    // replace_snk_edges(join, proxy_join);

    for (std::set<Transition*>::iterator fi = forks.begin()
           , fe = forks.end(); fi != fe; ++fi) {
      Transition *f = *fi;
      
      Transition *tfork = new Transition(*f);
      mux_region->register_proxy(f, tfork);
      cp->transitions.erase(f->id);
      cp->elements.erase(f->id);
      cp->register_transition(tfork);
      
      replace_src_edges(f, tfork);
      control_flow(tfork, mux_region->merge);
    }

     // std::cerr << "\nmerge region replaced."
     //   	    << "\n  join: " << join->id
     //        << "\n  forks:";
     // for (MuxRegion::ProxyMap::iterator fi = mux_region->proxies.begin()
     //        , fe = mux_region->proxies.end();
     //      fi != fe; fi++) {
     //   CPElement *f = (*fi).first;
     //   CPElement *nf = (*fi).second;
     //   std::cerr << "\n    " << f->id << " -> " << nf->id;
     // }

     // std::cerr << "\n  elements:";
     // for (std::set<CPElement*>::iterator bi = bag.begin(), be = bag.end();
     //      bi != be; ++bi) {
     //   CPElement *ele = *bi;
     //   std::cerr << "\n    " << ele->id;
     // }

     // std::cerr << "\n  new merge: " << mux_region->merge->id;
     // std::cerr << "\n";

    return proxy_join;
  }

  // Start at the given join and traverse backwards to check whether
  // this is the exit of a MuxRegion. If it is, then remove the
  // MuxRegion, replace it with proxies and return the proxy join;
  // else return the original join.
  Transition* reduce_merge_region(ControlPath *cp, Transition *join)
  {
    // The strategy: Locate one merge tree (consisting of merges
    // connected by simple transitions, and terminating at distinct
    // forks). If we find one, then we look for others such that they
    // terminate on the same set of forks. We put everything that we
    // find in a bag, which will be recorded in the CP as a MuxRegion.
    std::set<CPElement*> bag;
    std::set<Transition*> forks;

    // Use the first src to look for the first merge tree. We have
    // found the first merge tree in the MuxRegion if and only if we
    // find a merge (indicated by merge_found), and we don't encounter
    // anything that should not be in a MuxRegion (indicated by the
    // return value).
    CPEList::iterator jsi = join->srcs.begin();
    CPElement *src = *jsi++;
    bool merge_found = false;
    unsigned merge_id = 0;
    
    if (!create_merge_tree(forks, bag, merge_found, merge_id, src))
      // Something that should not be in a MuxRegion.
      return join;
    if (!merge_found)
      // No merge found, so it can't be a MuxRegion.
      return join;

    // For each subsequent src, create a different merge tree, that
    // reaches the same set of forks. Use a scratchpad to keep track
    // of the forks encounter.
    for (CPEList::iterator jse = join->srcs.end(); jsi != jse; ++jsi) {
      CPElement *src = *jsi;

      std::set<Transition*> worklist;
      if (!compare_merge_tree(forks, worklist, bag, src))
        // No merge tree found at this src.
        return join;

      if (worklist.size() != forks.size())
        // The merge tree didn't end on the same set of forks.
        return join;
    }

    return record_mux_region(cp, bag, forks, join, merge_id);
  }

  CPElement* mux_dfs(ControlPath *cp, CPElement *ele)
  {
    if (is_join(ele))
      // We attempt to detect a MuxRegion at every join.
      ele = reduce_merge_region(cp, static_cast<Transition*>(ele));

    ele->colour = hls::GRAY;

    typedef std::map<Transition*, Transition*> ReplacementMap;
    ReplacementMap replacements;
    
    for (CPEList::iterator sri = ele->srcs.begin(), sre = ele->srcs.end();
         sri != sre; sri++) {
      CPElement *src = *sri;
      
      if (src->colour != hls::WHITE)
        continue;
      
      CPElement *rep = mux_dfs(cp, src);
      if (rep != src) {
        assert(is_trans(src));
        assert(is_trans(rep));
        replacements[static_cast<Transition*>(src)]
          = static_cast<Transition*>(rep);
      }
    }

    for (ReplacementMap::iterator ri = replacements.begin()
           , re = replacements.end(); ri != re; ++ri) {
      Transition *x = (*ri).first;
      Transition *y = (*ri).second;
      replace_snk_edges(x, y);
    }

    ele->colour = hls::BLACK;
    return ele;
  }
} // end anonymous namespace


void ahir::replace_mux_regions(ControlPath *cp)
{
  initialise_dfs(cp);
  mux_dfs(cp, cp->fin);
}

void ahir::restore_mux_regions(ControlPath *cp)
{
  MuxRegionMap& regions = cp->mux_regions;

  for (MuxRegionMap::iterator rmi = regions.begin()
	 , rme = regions.end();
       rmi != rme; ++rmi) {
    MuxRegion *reg = (*rmi).second;
    
    for (MuxRegion::ProxyMap::iterator fi = reg->proxies.begin()
	   , fe = reg->proxies.end(); fi != fe; ++fi) {
      Transition *actual = (*fi).first;
      Transition *proxy = (*fi).second;

      if (is_fork(actual))
        replace_src_edges(proxy, actual);
      else
        replace_snk_edges(proxy, actual);
      
      cp->transitions.erase(proxy->id);
      cp->elements.erase(proxy->id);
      cp->register_transition(actual);
    }
    
    cp->places.erase(reg->merge->id);
    cp->elements.erase(reg->merge->id);
    
    for (std::set<CPElement*>::iterator ei = reg->elements.begin()
	   , ee = reg->elements.end();
	 ei != ee; ++ei) {
      CPElement *ele = *ei;
      
      if (is_place(ele)) {
        Place *p = static_cast<Place*>(ele);
        assert(!cp->find_place(p->id));
        cp->register_place(p);
      } else {
        Transition *p = static_cast<Transition*>(ele);
        assert(!cp->find_transition(p->id));
        // #warning Fix this. register_transition_with_sym() and unregister_*()
        // cant use cp->register_transition here since it also checks
        // the req-to-transition mapping in the control-path.
        cp->transitions[p->id] = p;
        cp->register_element(p);
      }
    }

    delete reg;
  }

  regions.clear();
}

