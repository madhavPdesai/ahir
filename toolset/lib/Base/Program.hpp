#ifndef __PROGRAM_HPP__
#define __PROGRAM_HPP__

#include "Annotable.hpp"
#include "Storage.hpp"

#include <string>
#include <map>

namespace hls {

  class Type;
  class Module;
  class Addressable;

  /** \brief An AHIR program is a collection of \link Module Modules\endlink. */
  
  struct Program : public Annotable, public Storage {
    std::string id;

    typedef std::vector<std::string> RootList;
    /// \brief The list of names for the "root" \link Module Modules\endlink.
    ///
    /// Each root is the starting point of a call-graph. The named
    /// \link Module Modules\endlink most exist in this program.
    RootList roots;
    
    typedef std::map<std::string, Module*> ModuleList;
    /// The list of \link Module Modules\endlink present in this program.
    ModuleList modules;
    Module* find_module(const std::string &id);
    void register_module(Module *module);

    typedef std::map<std::string, const Type *> TypeList;
    // List of data-types used in this program.
    TypeList types;
    const Type* find_type(const std::string &id);
    void register_type(const std::string &id, const Type *type);

    Program(const std::string& _id);
  };

};

#endif
