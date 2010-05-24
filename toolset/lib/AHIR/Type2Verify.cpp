#include "Type2Verify.hpp"
#include "MuxRegions.hpp"
#include "ControlPath.hpp"
#include "CPUtils.hpp"
#include <Base/Program.hpp>
#include "AHIRModule.hpp"
#include <Base/Utils.hpp>

#include <boost/graph/adjacency_list.hpp>
#include <deque>

using namespace ahir;
using namespace hls;

namespace {
  
  typedef boost::adjacency_list<boost::listS, boost::setS
                                , boost::bidirectionalS
                                , bool, boost::no_property
                                , boost::listS> Graph;
  typedef Graph::vertex_descriptor Vertex;
  typedef Graph::edge_descriptor Edge;
  
  typedef std::map<CPElement*, Vertex> NodeMap;
  typedef std::deque<Vertex> Queue;

  struct Type2Exception {
    const std::string msg;
    Type2Exception(const std::string &x)
      : msg(x)
    {}
  };

  std::ostream& operator<< (std::ostream &out, const Type2Exception &ex)
  {
    out << ex.msg;
    return out;
  }

  Vertex register_vertex(CPElement *c, NodeMap &M, Graph &G)
  {
    if (M.find(c) != M.end())
      return M[c];

    // Create a vertex with the colour set to `is_place(c)'.
    Vertex v = boost::add_vertex(is_place(c), G);
    M[c] = v;
    
    return v;
  }

  void dfs_construct_graph(Graph &G, NodeMap &M, CPElement *cpe, Vertex pred)
  {
    Vertex u = register_vertex(cpe, M, G);
    cpe->colour = GRAY;
    boost::add_edge(pred, u, G);
    // Check colours across the edge.
    assert(G[u] != G[pred]);

    for (CPEList::iterator si = cpe->snks.begin(), se = cpe->snks.end();
         si != se; ++si) {
      CPElement *snk = *si;

      switch (snk->colour) {
        case WHITE:
          dfs_construct_graph(G, M, snk, u);
          break;

        case GRAY:
          if (!is_merge(snk))
            // throw Type2Exception("Back-edge of a cycle must land on a merge.");
            assert(false);
        case BLACK: {
          assert(M.find(snk) != M.end());
          Vertex v = M[snk];
          boost::add_edge(u, v, G);
          // Check colours across the edge.
          assert(G[u] != G[v]);
          break;
        }
          
        default:
          break;
      }
    }

    cpe->colour = BLACK;
  }

  void dfs_construct_graph(Graph &G, NodeMap &M, CPElement *cpe)
  {
    Vertex u = register_vertex(cpe, M, G);
    cpe->colour = GRAY;

    // we don't have to check colour here, since we are just beginning.
    for (CPEList::iterator si = cpe->snks.begin(), se = cpe->snks.end();
         si != se; ++si) {
      CPElement *snk = *si;

      dfs_construct_graph(G, M, snk, u);
    }
    cpe->colour = BLACK;
  }

  // Construct a graph G = (V, E) from the control-path `cp', where each
  // vertex `v' in V is an element in the CP and each edge `e' in E is an
  // edge in cp.
  // Edge constraints:
  // 1. The graph is bipartite, where the colour of an element `x' is
  //    the boolean value of `is_place(x)'.
  // 2. There are no parallel edges. Enforced by choosing `setS' for
  //    the OutEdgeList type in the definition of type Graph.
  void construct_graph(Graph &G, ControlPath *cp)
  {
    initialise_dfs(cp);
    disconnect_initial_marking(cp);

    NodeMap M;
    std::deque<Vertex> Q;
    dfs_construct_graph(G, M, cp->init);
    cp->marked_place->colour = BLACK;

    reconnect_initial_marking(cp);
  }

  // Progressively remove simple nodes in the graph. The predecessor
  // `a' is merged with the successor `b' by moving all edges from b
  // to a and then deleting b. The graph is Type-2 if the reduction
  // results in a graph with a single vertex and no edge.
  void reduce_graph(Graph &G)
  {
    bool removed_something = false;
    do {
      removed_something = false;
      for (unsigned i = 0; i < boost::num_vertices(G); ++i) {
        Vertex x = boost::vertex(i, G);

        if (boost::in_degree(x, G) != 1) {
          continue;
        }
        if (boost::out_degree(x, G) != 1) {
          continue;
        }
        removed_something = true;

        // x is simple. Find the predecessor `a' and successor `b'.
        Vertex a = *boost::inv_adjacent_vertices(x, G).first;
        assert(G[x] != G[a]);
        Vertex b = *boost::adjacent_vertices(x, G).first;
        assert(G[x] != G[b]);

        boost::clear_vertex(x, G);
        boost::remove_vertex(x, G);
        
        if (a == b)
          continue;

        // Move the successors of b to a
        Graph::adjacency_iterator si, se;
        for (tie(si, se) = boost::adjacent_vertices(b, G); si != se; ++si) {
          Vertex z = *si;
          // Ensure that the edges are bipartite. Also, a != z.
          assert(G[a] != G[z]);
          boost::add_edge(a, z, G);
        }

        // Move the predecessors of b to a
        Graph::inv_adjacency_iterator pi, pe;
        for (tie(pi, pe) = boost::inv_adjacent_vertices(b, G); pi != pe; ++pi) {
          Vertex z = *pi;
          // Ensure that the edges are bipartite. Also, a != z.
          assert(G[a] != G[z]);
          boost::add_edge(z, a, G);
        }

        // Delete b.
        boost::clear_vertex(b, G);
        boost::remove_vertex(b, G);
      }
    } while (removed_something);

    std::ostringstream str;
    str << "Reduction failed. edges: " << boost::num_edges(G)
        << " vertices: " << boost::num_vertices(G);
    if ((boost::num_edges(G) != 0) ||(boost::num_vertices(G) != 1))
      throw Type2Exception(str.str());
  }

  void verify_type2_helper(ControlPath *cp)
  {
    Graph G;

    construct_graph(G, cp);

    // check that every node has been visited at this point
    for (ControlPath::PList::iterator ii = cp->places.begin(), ie = cp->places.end();
         ii != ie; ++ii) {
      CPElement *cpe = (*ii).second;
      assert(cpe->colour == BLACK);
    }
  
    for (ControlPath::TList::iterator ii = cp->transitions.begin()
           , ie = cp->transitions.end(); ii != ie; ++ii) {
      CPElement *cpe = (*ii).second;
      assert(cpe->colour == BLACK);
    }
  
    reduce_graph(G);
  }

} // end anonymous namespace

bool ahir::verify_type2(ControlPath *cp)
{
  try {
    replace_mux_regions(cp);
    verify_type2_helper(cp);
    restore_mux_regions(cp);
  } catch (const Type2Exception &ex) {
    std::cerr << "\n" << cp->id << ": fail. " << ex;
    return false;
  }
  return true;
}

bool ahir::verify_type2(hls::Program *program)
{
  bool success = true;
  for (Program::ModuleList::iterator mi = program->modules.begin()
         , me = program->modules.end(); mi != me; ++mi) {
    hls::Module *module = (*mi).second;

    ahir::Module *ahir = to_ahir(module);
    success &= verify_type2(ahir->cp);
  }
  return success;
}
