#include "LRG.hpp"

#include <iostream>

using namespace ahir;
using namespace hls;

namespace {
  
  /* ===== Compatibility operations ===== */
  
  // In the first DFS, we traverse from x towards the root. The labels
  // are compatible if we reach y in this traversal. At every vertex
  // encountered, we track the fork indicated by the corresponding
  // label tag. Note the following property:
  //
  // ** If a vertex v is reachable from x along edges e_1,e_2,...,
  // ** then exactly one of the following is true:
  // 
  //    1. If any one edge is labelled with a tag indicating fork f,
  //       then every edge must be labelled with a tag indicating the
  //       same fork f.
  //       
  //    2. If any one edge is unlabelled, then there is in fact only
  //       one edge.
  //
  // Hence we track a single fork identifier (possibly 1, indicating
  // an unlabelled edge), which we store as ``incoming_fork'' at the
  // vertex v.
  bool first_dfs(Label x, Label y, LRG &lrg)
  {
    lrg[x].colour = GRAY;
    
    LRG::in_edge_iterator ei, ee;
    for (tie(ei, ee) = boost::in_edges(x, lrg); ei != ee; ++ei) {
      Edge e = *ei;
      Label z = boost::source(e, lrg);
      unsigned f = lrg[e].f; // fork indicated by the tag on the edge
      
      if (z == y)
        return true;

      assert(lrg[z].colour != GRAY);

      if (lrg[z].colour == WHITE) {
        lrg[z].incoming_fork = f; // don't care if f == 1
        
        if (first_dfs(z, y, lrg))
          return true;
      } else {
        assert(lrg[z].colour == BLACK);
        assert(lrg[z].incoming_fork == f);
      }
    }

    lrg[x].colour = BLACK;
    return false;
  }

  // The second DFS is performed from x towards the root after
  // traversing with first_dfs from label y (the arguments are
  // interchanged when calling the appropriate functions). Let vertex
  // v be a vertex encoutered in the traversal along an edge e. If v
  // is BLACK (reachable from y), let f_v be the fork id stored at v,
  // and let f_e be the fork indicated by the edge along which we
  // reached v.
  //
  // ** The labels are compatible if at least one of the following is
  //    true:
  //
  //    1. v = y
  //
  //    2. f_v = 1 or f_e = 1
  //
  //    3. f_v != f_e
  //
  // If none of the above is true, then labels are possibly
  // incompatible and we continue with the traversal, but we retrace
  // one step instead of going further along the incoming edges on v.
  bool second_dfs(Label x, Label y, LRG &lrg)
  {
    lrg[x].colour = GRAY;

    LRG::in_edge_iterator ei, ee;
    for (tie(ei, ee) = boost::in_edges(x, lrg); ei != ee; ++ei) {
      Edge e = *ei;
      Label z = boost::source(e, lrg);
      unsigned f = lrg[e].f; // fork indicated by the tag on the edge

      switch (lrg[z].colour) {
        case BLACK: {
          if (z == y)
            return true;

          if (f == fin_id)
            return true;

          unsigned inf = lrg[z].incoming_fork;
          
          if (inf == fin_id)
            return true;

          if (inf != f)
            return true;

          break;
        }

        case WHITE:
          if (second_dfs(z, y, lrg))
            return true;
          break;

        default:
          break;
      }
    }

    lrg[x].colour = BLUE;
    return false;
  }

  /* ===== LRG Validation ===== */

  struct LRGValidationException
  {
    std::string message;

    LRGValidationException(const std::string &m)
      : message(m)
    {} 
  };
  
  bool traverse(unsigned i, unsigned j, LRG &lrg)
  {
    assert(i != 0);
    assert(j != 0);
  
    Label x = boost::vertex(i, lrg);
    Label y = boost::vertex(j, lrg);
  
    initialise_dfs(lrg);
  
    if (first_dfs(x, y, lrg))
      return true;

    return (second_dfs(y, x, lrg));
  }

  void check_dfs(Label x, LRG &lrg)
  {
    lrg[x].colour = GRAY;
    
    LRG::adjacency_iterator ai, ae;
    for (tie(ai, ae) = boost::adjacent_vertices(x, lrg);
         ai != ae; ++ai) {
      Label y = *ai;

      switch (lrg[y].colour) {
        case GRAY:
          throw LRGValidationException("discovered a cycle in the LRG");
          break;

        case BLACK:
          break;

        case WHITE:
          check_dfs(y, lrg);
          break;

        default:
          throw LRGValidationException("incorrect DFS state");
          break;
      }
    }

    lrg[x].colour = BLACK;
  }
          
  void validate_lrg_helper(LRG &lrg)
  {
    
    initialise_dfs(lrg);
    check_dfs(boost::vertex(0, lrg), lrg);

    LRG::vertex_iterator vi, ve;
    for (boost::tie(vi, ve) = boost::vertices(lrg); vi != ve; ++vi) {
      if (lrg[*vi].colour != BLACK)
        throw LRGValidationException("the lrg is not connected");
    }
    
    // Check conditions at each label
    LRG::vertex_iterator li, le;
    for (boost::tie(li, le) = boost::vertices(lrg); li != le; ++li) {
      Label l = *li;

      switch (in_degree(l, lrg)) {
        case 0:
          break;

        case 1: {
          // A single in-edge must be labelled, since only a join has
          // unlabelled in-edges.
          Edge e = *boost::in_edges(l, lrg).first;
          if (!is_labelled(e, lrg))
            throw LRGValidationException("single unlabelled in-edge");
          break;
        }
          
        default: {
          // Current label is a join.
          LRG::in_edge_iterator ei, ee;
          for (tie(ei, ee) = boost::in_edges(l, lrg); ei != ee; ++ei) {
            Edge e = *ei;
            if (is_labelled(e, lrg))
              throw LRGValidationException("labelled in-edge at a join");
            // Check the predecessor at the in-edge. It cannot be the
            // null label, and it can't be another join, since the LRG
            // disallows two or more consecutive unlabelled edges.
            Label t = boost::source(e, lrg);
            switch (boost::in_degree(t, lrg)) {
              case 0:
                throw LRGValidationException("unlabelled edge at the null label");
                break;

              case 1:
                break;

              default:
                throw LRGValidationException("consecutive unlabelled edges");
                break;
            }
          } // end check for in-edges at join
          break;
        }
      } // end check for in-degree

      switch (boost::out_degree(l, lrg)) {
        case 0:
          break;
          
        case 1: {
          // A single out-edge must be unlabelled, since a fork must
          // have at least two out-edges.
          Edge e = *boost::out_edges(l, lrg).first;
          if (is_labelled(e, lrg))
            throw LRGValidationException("single labelled out-edge");
          break;
        }

        default: {
          // Access the tag (f, i, k) at each labelled out-edge and
          // ignore unlabelled out-edges. For each f, there must be
          // exactly k out-edges and they must have 0 <= i < k
          std::map<unsigned, unsigned> degree;
          std::map<unsigned, std::set<unsigned> > indices;

          LRG::out_edge_iterator ei, ee;
          for (tie(ei, ee) = boost::out_edges(l, lrg); ei != ee; ++ei) {
            Edge e = *ei;
            if (!is_labelled(e, lrg))
              continue;

            EdgeProperty &ep = lrg[e];
            if (!ep.is_valid())
              throw LRGValidationException("invalid tag at labelled edge");
            
            if (degree.find(ep.f) != degree.end()) {
              if (degree[ep.f] != ep.k)
                throw LRGValidationException("mis-matching degree at labelled edges");
              else
                degree[ep.f] = ep.k;
            }

            std::set<unsigned> &inx = indices[ep.f];
            if (inx.find(ep.i) != inx.end())
              throw LRGValidationException("multiple fork edges with same label");
            else 
              inx.insert(ep.i);
          }

          for (std::map<unsigned, unsigned>::iterator di = degree.begin()
                 , de = degree.end(); di != de; ++di) {
            unsigned f = (*di).first;
            unsigned d = (*di).second;

            if (indices[f].size() != d)
              throw LRGValidationException("missing indices at fork labels");
          }
        }
      } // end vertex out-edge check
    } // end LRG vertex check
  }
  
} // end anonymous namespace

void ahir::initialise_dfs(LRG &lrg)
{
  LRG::vertex_iterator vi, ve;
  for (boost::tie(vi, ve) = boost::vertices(lrg); vi != ve; ++vi) {
    lrg[*vi].colour = WHITE;
    lrg[*vi].incoming_fork = 1;
  }
}
  
bool ahir::compatible(unsigned i, unsigned j, LRG &lrg)
{
  if (i == j)
    return true;

  if (i == 0 || j == 0)
    return true;

  return traverse(i, j, lrg);
}

bool ahir::validate_lrg(LRG &lrg)
{
  try {
    validate_lrg_helper(lrg);
  } catch (LRGValidationException &ex) {
    std::cerr << ex.message;
    return false;
  }

  return true;
}
