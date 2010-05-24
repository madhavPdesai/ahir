#ifndef VHDL_ARBITERBUILDER_HPP
#define VHDL_ARBITERBUILDER_HPP

namespace ahir {
  class Arbiter;
}

namespace vhdl {
  class Arbiter;
  class DataPath;
  Arbiter* create_arbiter(ahir::Arbiter *arb, DataPath *dp);
}

#endif
