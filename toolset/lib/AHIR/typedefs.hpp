#ifndef AHIR_TYPEDEFS_HPP
#define AHIR_TYPEDEFS_HPP

#include <set>
#include <map>
#include <string>
#include <vector>

namespace ahir {

  class ControlPath;
  class CPElement;
  class Port;
  
  typedef std::map<std::string, Port*> PortList;

  class DPElement;
  typedef std::map<unsigned, DPElement*> DPEList;
  typedef std::vector<DPElement*> DPEVector;

}

#endif
