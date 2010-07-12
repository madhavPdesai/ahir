#ifndef Aa_Bgl_Wrap__
#define Aa_Bgl_Wrap__

#include <AaIncludes.h>
#include <AaRoot.h>
#include <utility>                   // for std::pair
#include <algorithm>                 // for std::for_each
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/adjacency_list.hpp>
#include <boost/tuple/tuple.hpp>
#include <boost/graph/depth_first_search.hpp>


using namespace boost;
using namespace std;

struct AaBglVertexProperties
{
  AaRoot* _aa_rep;
  std::string _aa_rep_name;
};

typedef adjacency_list<vecS, vecS, bidirectionalS,AaBglVertexProperties> Graph;
typedef boost::graph_traits<Graph>::vertex_descriptor  Vertex;
typedef boost::graph_traits<Graph>::vertex_iterator  VertexIterator;
typedef boost::graph_traits<Graph>::edge_iterator EdgeIterator;
typedef boost::graph_traits<Graph>::edge_descriptor Edge;
typedef property_map<Graph, vertex_index_t>::type IndexMap;

/* struct TypePropagationVisitor : public dfs_visitor<> */
/* { */
/*  TypePropagationVisitor()  : { } */
 
/*   // need to define these... */
/*   template <class Vertex, class Graph> void discover_vertex(Vertex,Graph&) {} // todo */
/*   template <class Vertex, class Graph> void finish_vertex(Vertex,Graph&) {} // todo */
/*   template <class Edge, class Graph> void examine_edge(Vertex,Graph&) {} // todo */
/* }; */


// In progress
struct CycleDetectionVisitor : public dfs_visitor<>
{

  CycleDetectionVisitor( bool& cycle_found,
			 std::map<Vertex,Vertex>& predecessor_map)
    : 
    _cycle_found(cycle_found),
    _predecessor_map(predecessor_map)
  {}

  template <class Vertex, class Graph> void initialize_vertex(Vertex u, Graph& g)
  {
    _predecessor_map[u] = u;
  }
  template <class Edge, class Graph> void tree_edge(Edge e, Graph& g)
  {
    _predecessor_map[target(e,g)] = source(e,g);
  }
  template <class Edge, class Graph>  void back_edge(Edge e, Graph& g) 
  {
    _cycle_found = true;
    std::cerr << "Info: found cycle " << std::endl;
    
    Vertex endv = target(e,g);
    Vertex startv = source(e,g);
    std::cerr << g[endv]._aa_rep_name << " <- " << g[startv]._aa_rep_name << std::endl;
    
    while(1)
      { 
	Vertex predv = _predecessor_map[startv];
	std::cerr << g[startv]._aa_rep_name << " <- " << g[predv]._aa_rep_name << std::endl;
	
	
	if((predv == endv) || (predv == startv))
	  break;
	else
	  startv = predv;
      }
    std::cerr << std::endl;
  }

 protected:
  bool& _cycle_found;
  std::map<Vertex,Vertex>& _predecessor_map;
};


class AaGraphBase
{
  Graph _bgl_graph;
	
  // from root to vertex
  map<AaRoot*, Vertex> _aa_link_map;
 public:
  AaGraphBase() {}
  ~AaGraphBase() {}
  
  Vertex Add_Vertex(AaRoot* u) 
  {
    Vertex uv;
    if(_aa_link_map.find(u) == _aa_link_map.end())
      {
	uv = add_vertex(this->_bgl_graph);
	this->_bgl_graph[uv]._aa_rep = u;
	this->_aa_link_map[u] = uv;
      }
    else
      uv = this->_aa_link_map[u];

    return(uv);
  }
  
  void Set_Rep_Name(Vertex v, string& repname)
  {
    this->_bgl_graph[v]._aa_rep_name = repname;
  }

  Vertex Add_Vertex(AaRoot* u, string& repname)
  {
    Vertex uv = this->Add_Vertex(u);
    this->Set_Rep_Name(uv,repname);
    return(uv);
  }

  
  Edge Add_Edge(AaRoot* u, AaRoot* v)
  {
    std::pair<Edge,bool> e_b = add_edge(this->Add_Vertex(u), this->Add_Vertex(v), this->_bgl_graph);
    return(e_b.first);
  }

  AaRoot* To_Aa(Vertex v)
  {
    return(this->_bgl_graph[v]._aa_rep);
  }

  // type propagation dfs: fill list of
  // vertices whose type cannot be determined
  // return true if all ok false otherwise.
  bool Type_Propagate_Dfs(AaRoot* start_point,vector<AaRoot*>& undetermined_type_vector);

  // cycle detection dfs: return number of back-edges and
  // report elementary cycles detected during traversal
  bool Cycle_Detect_Dfs()
  {
    bool cycle_found = false;
    map<Vertex,Vertex> predecessor_map;

    CycleDetectionVisitor vis(cycle_found, predecessor_map);
    boost::depth_first_search(this->_bgl_graph, visitor(vis));

    return(cycle_found);
  }

};
#endif
