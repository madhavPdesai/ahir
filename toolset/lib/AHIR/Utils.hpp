#ifndef __AHIR_UTILS_HPP__
#define __AHIR_UTILS_HPP__

#include <string>
#include <map>

namespace ahir {
  
  class Port;
  typedef std::map<std::string, Port*> PortList;

  class DPElement;
  typedef std::map<unsigned, DPElement*> DPEList;
  
}

#endif
