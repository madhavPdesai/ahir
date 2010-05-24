#ifndef __VHDL_TYPEDEFS_HPP__
#define __VHDL_TYPEDEFS_HPP__

#include <vector>
#include <map>
#include <string>
#include <deque>

namespace vhdl {

  typedef enum { DP, DPE, CP, LN, ARB, SYSTEM, MEMORY, SIMPLE } EntityType;
  typedef enum { NONE, WIRE, SLICE } MappingType;
  typedef enum { INDEX, TO, DOWNTO } RangeType;    

  class Generic;
  typedef std::map<std::string, Generic*> GenericList;

  class Range;
  typedef std::deque<Range> RangeList;
  
  class Port;
  typedef std::map<std::string, Port*> PortList;

  class Wire;
  typedef std::map<std::string, Wire*> WireList;

  class Entity;
  typedef std::map<std::string, Entity*> EntityList;
  
  class DPElement;
  typedef std::map<std::string, DPElement*> DPEList;
  
  typedef std::map<std::string, std::string> AssignMap;
  typedef std::vector<std::string> StatementList;
  typedef std::vector<std::string> PreludeLines;
}

#endif
