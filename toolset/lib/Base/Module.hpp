#ifndef __HLS_MODULE_HPP__
#define __HLS_MODULE_HPP__

#include "Annotable.hpp"
#include "Storage.hpp"
#include <vector>
#include <string>
#include <map>

namespace hls {

  /// \brief Smallest component of a system, it is either a CDFG or an ahir::Module.
  struct Module : public hls::Annotable, public hls::Storage {
    
    std::string id;
    /// Whether CDFG or ahir::Module
    std::string type;

    Module(const std::string &_id, const std::string &t)
      : id(_id), type(t)
    {};
  };

};

#endif
