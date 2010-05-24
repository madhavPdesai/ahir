#ifndef __HLS_MODULE_HPP__
#define __HLS_MODULE_HPP__

#include <vector>
#include <string>
#include <map>

namespace hls {

  class Addressable;
  typedef std::vector<unsigned> ArgumentList;
  typedef std::map<std::string, Addressable*> LocalAllocs;
  
  struct Module {
    std::string id;
    std::string type;

    typedef LocalAllocs::iterator alloc_iterator;
    LocalAllocs allocs;

    Module(const std::string &_id, const std::string &t)
      : id(_id), type(t)
    {};
  };

};

#endif
