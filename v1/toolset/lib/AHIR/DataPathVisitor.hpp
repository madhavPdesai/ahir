#ifndef __AHIR_DATAPATH_VISITOR_HPP__
#define __AHIR_DATAPATH_VISITOR_HPP__

#include "DataPath.hpp"

#include <assert.h>
#include <stdlib.h>

namespace ahir {

  // Curiously Recursive Template Parameter (CRTP) used as a visitor
  // on the elements in the DP. Refer Wikipedia for the advantage of
  // static casts made possible by the CRTP.
  //
  // To use this visitor, create a derived class by instantiating this
  // template, while passing the derived class itself as the template
  // parameter (hence the name). For example:
  //
  // struct MyDPVisitor : public CDFGVisitor<MyDPVisitor>
  // {
  //   ...
  // };

  template<typename SubClass>
  struct DPVisitor {

    // The main visitor function.
    void visit(DataPath *dp)
    {
      for (DPEList::iterator ni = dp->elements.begin(), ne = dp->elements.end();
           ni != ne; ++ni) {
        DPElement *ele = (*ni).second;
        
        visit_element_base(ele);
      }
    }

    // The central switch that is called by the visitor on each DPE.
    void visit_element_base(DPElement *ele)
    {
      switch (ele->ntype) {
      default:
	assert(0 && "Unknown element type");
	abort();
	break;
	
#define HANDLE_OP(OPCODE)						\
	case hls::OPCODE:                                               \
	  static_cast<SubClass*>(this)->visit_##OPCODE(ele);		\
	  break;
#include "../NodeType.inc"
      }
    }

    // Special visitors, generated for each type of element. Note that
    // they are not virtual functions, instead they are overriden by
    // the derived class. The whole point of the CRTP is to eliminate
    // the cost of declaring these functions as virtual.
#define HANDLE_OP(OPCODE)					\
    void visit_##OPCODE(DPElement *ele)                         \
    {								\
      static_cast<SubClass*>(this)->visit_element(ele);		\
    }
#include "../NodeType.inc"

    // Default visitor element.
    void visit_element(DPElement *ele) {};
  };
}

#endif
