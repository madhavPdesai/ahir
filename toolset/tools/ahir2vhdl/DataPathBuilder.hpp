#ifndef __VHDL_DATAPATH_BUILDER_HPP__
#define __VHDL_DATAPATH_BUILDER_HPP__

#include "DataPath.hpp"
#include <AHIR/DataPath.hpp>

namespace vhdl {
  vhdl::DataPath* create_dp(ahir::DataPath *dp);
}

#endif
