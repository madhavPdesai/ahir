#ifndef AHIR_TYPEDEFS_HPP
#define AHIR_TYPEDEFS_HPP

#include <set>
#include <map>
#include <string>
#include <vector>

namespace ahir {

  class ControlPath;
  class CPElement;
  typedef std::set<CPElement*> CPEList;

  typedef enum {
    PLACE = 0 
    , REQ 
    , ACK 
    , HIDDEN 
  } CPEType;

  inline bool is_trans(CPEType t) 
  {
    return t != PLACE;
  }

  class Port;
  typedef std::map<std::string, Port*> PortList;

  class DPElement;
  typedef std::map<unsigned, DPElement*> DPEList;
  typedef std::vector<DPElement*> DPEVector;

}

#endif
