#ifndef __HLS_CDFG_VISITOR_HPP__
#define __HLS_CDFG_VISITOR_HPP__

#include "CDFG.hpp"

#include <assert.h>
#include <stdlib.h>

namespace cdfg {

  // Curiously Recursive Template Parameter (CRTP) used as a visitor
  // on the nodes in the CDFG. Refer Wikipedia for the advantage of
  // static casts made possible by the CRTP.
  //
  // To use this visitor, create a derived class by instantiating this
  // template, while passing the derived class itself as the template
  // parameter (hence the name). For example:
  //
  // struct MyCDFGVisitor : public CDFGVisitor<MyCDFGVisitor>
  // {
  //   ...
  // };

  template<typename SubClass>
  struct CDFGVisitor {

    // The main visitor function.
    void visit(CDFG *cdfg)
    {
      for (CDFG::NodeList::iterator ni = cdfg->nodes.begin(), ne = cdfg->nodes.end();
           ni != ne; ++ni) {
        CDFGNode *node = (*ni).second;
        
        visit_node_base(node);
      }
      
      for (CDFG::EdgeList::iterator ni = cdfg->edges.begin(), ne = cdfg->edges.end();
           ni != ne; ++ni) {
        CDFGEdge *edge = (*ni).second;
        
        visit_edge_base(edge);
      }
    }

    // The central switch that is called by the visitor on each node.
    void visit_node_base(CDFGNode *node)
    {
      switch (node->ntype) {
      default:
	assert(0 && "Unknown node type");
	abort();
	break;
	
#define HANDLE_OP(OPCODE)						\
	case hls::OPCODE:                                               \
	  static_cast<SubClass*>(this)->visit_##OPCODE(node);		\
	  break;
#include <Base/NodeType.inc>
      }
    }

    // Special visitors, generated for each type of node. Note that
    // they are not virtual functions, instead they are overriden by
    // the derived class. The whole point of the CRTP is to eliminate
    // the cost of declaring these functions as virtual.
#define HANDLE_OP(OPCODE)					\
    void visit_##OPCODE(CDFGNode *node)                         \
    {								\
      static_cast<SubClass*>(this)->visit_node(node);		\
    }
#include <Base/NodeType.inc>

    // Default visitor node.
    void visit_node(CDFGNode *node) {};

    // The central switch called on each edge.
    void visit_edge_base(CDFGEdge *edge)
    {
      assert(edge->driver);
      switch (edge->driver->port_type) {
        case Port::Control:
          static_cast<SubClass*>(this)->visit_control_edge(edge);
          break;
          
        case Port::Data:
          static_cast<SubClass*>(this)->visit_data_edge(edge);
          break;
          
        default:
          assert(false);
      }
    }

    // Special visitors.
    void visit_control_edge(CDFGEdge *edge)
    {
      static_cast<SubClass*>(this)->visit_edge(edge);
    };
    
    void visit_data_edge(CDFGEdge *edge)
    {
      static_cast<SubClass*>(this)->visit_edge(edge);
    };

    // Default visitor.
    void visit_edge(CDFGEdge *edge) {};
  };
}

#endif
