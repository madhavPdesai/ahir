#ifndef __CDFG_UTILS_HPP__
#define __CDFG_UTILS_HPP__

#include "CDFG.hpp"

namespace cdfg {
  
  void remove_redundant_nodes(CDFG *cdfg);
  void check_wellformedness(CDFG *cdfg);
  bool is_redundant(CDFGNode *node);
  
  inline bool is_control(CDFGNode *node)
  {
    return hls::CONTROL_BEGIN <= node->ntype && node->ntype <= hls::CONTROL_END;
  }

  inline bool is_data(CDFGNode *node)
  {
    return hls::DATA_BEGIN <= node->ntype && node->ntype <= hls::DATA_END;
  }

  inline bool is_rel(CDFGNode *node)
  {
    return hls::REL_BEGIN <= node->ntype && node->ntype <= hls::REL_END;
  }

  inline bool is_shift(CDFGNode *node)
  {
    return hls::SHIFT_BEGIN <= node->ntype && node->ntype <= hls::SHIFT_END;
  }

  inline bool is_cast(CDFGNode *node)
  {
    return hls::CAST_BEGIN <= node->ntype && node->ntype <= hls::CAST_END;
  }

  inline bool is_binary(CDFGNode *node)
  {
    return hls::BINARY_BEGIN <= node->ntype && node->ntype <= hls::BINARY_END;
  }

  inline bool is_constant(CDFGNode *node)
  {
    return is_constant(node->ntype);
  }

  inline bool has_no_local_control(CDFGNode *node)
  {
    return
      is_constant(node)
      || node->ntype == hls::Multiplexer
      || node->ntype == hls::Accept;
  }
  
}

#endif
