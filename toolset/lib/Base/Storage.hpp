#ifndef STORAGE_HPP
#define STORAGE_HPP

#include "Type.hpp"
#include "Value.hpp"

#include <map>
#include <string>
#include <set>
#include <deque>

#include <boost/algorithm/string/split.hpp>
#include <boost/algorithm/string/classification.hpp>

namespace ba = boost::algorithm;

namespace hls {

  struct MemoryLocation
  {
    std::string id;
    const std::string type;     // the type can never be changed.
    hls::Value *value;
    unsigned address;
    unsigned size;

    /*! @name Indirect Address
      List of Address objects in the data-path that indirectly refer
      to this Addressable location.
     */
    //@{
    typedef std::map<std::string, std::set<unsigned> > AddressList;
    AddressList addresses;
    void register_address(const std::string &module, unsigned addr)
    {
      addresses[module].insert(addr);
    }
    
  private:
    // A MemoryLocation can only be created by a MemorySpace
    friend class MemorySpace;
    MemoryLocation(const std::string &_id
                   , const std::string &_type
                   , unsigned _size)
      : id(_id), type(_type), value(NULL), address(0), size(_size)
    {};
  };

  class MemorySpace 
  {
    typedef std::map<std::string, MemoryLocation*> _mapType;
    _mapType space_map;

    // A memory space can only be created by a Storage object
    friend class Storage;
    MemorySpace(const std::string _id)
      : id(_id) 
    {}

    void clear()
    {
      space_map.clear();
    }

    // TODO: Define set-like operations on memory spaces.

  public:

    std::string id;
    
    MemoryLocation* add_location(const std::string &id
                                 , const std::string &type
                                 , unsigned size)
    {
      assert(!find_location(id));
      MemoryLocation *m = new MemoryLocation(id, type, size);
      space_map[m->id] = m;
      return m;
    }
    
    MemoryLocation* find_location(const std::string &id)
    {
      if (space_map.find(id) != space_map.end())
        return space_map[id];
      return NULL;
    }

    // FIXME: Replace this with the boost::map_values
    typedef _mapType::iterator iterator;

    iterator begin()
    {
      return space_map.begin();
    }

    iterator end()
    {
      return space_map.end();
    }

    ~MemorySpace()
    {
      for (iterator ii = begin(), ie = end(); ii != ie; ++ii)
        delete (*ii).second;
      clear();
    }
  };
    
  // Classes derived from this shall have storage facilities. (e.g.,
  // Program and Module).
  
  class Storage
  {
    typedef std::map<std::string, MemorySpace*> _mapType;
    _mapType storage_map;

    void memory_clear()
    {
      storage_map.clear();
    }

    // TOOD: Allow memory spaces and memory locations to migrate
    // between different Storage instances.

    typedef std::deque<std::string> TokenList;
    void split_name(TokenList &tokens, const std::string &name) 
    {
      ba::split(tokens, name, ba::is_any_of(":"));
      
      assert(tokens.size() < 3);

      if (tokens.size() == 1)
        tokens.push_front("default");

      assert(tokens.size() == 2);
    }
    
  public:

    // Add a location to the default memory space.
    MemoryLocation* add_memory_location(const std::string &var_id
                                        , const std::string &type
                                        , unsigned size)
    {
      TokenList tokens;
      split_name(tokens, var_id);
      add_memory_location(tokens[0], tokens[1], type, size);
    }

    // Add a location to an arbitrary memory space, creating the space
    // if necessary.
    MemoryLocation* add_memory_location(const std::string &space_id
                                        , const std::string &var_id
                                        , const std::string &type
                                        , unsigned size)
    {
      MemorySpace *ms = find_memory_space(space_id);
      if (!ms)
        ms = add_memory_space(space_id);
      return ms->add_location(var_id, type, size);
    }

    MemoryLocation* find_memory_location(const std::string &id) 
    {
      TokenList tokens;
      split_name(tokens, id);

      const std::string &ms_id = tokens[0];
      MemorySpace *ms = find_memory_space(ms_id);
      if (!ms)
        return NULL;

      return ms->find_location(tokens[1]);
    }
          
    MemorySpace* add_memory_space(const std::string &id)
    {
      assert(!find_memory_space(id));
      MemorySpace *m = new MemorySpace(id);
      storage_map[m->id] = m;
      return m;
    }

    MemorySpace* find_memory_space(const std::string &id) 
    {
      if (storage_map.find(id) != storage_map.end())
        return storage_map[id];
      return NULL;
    }

    // Prefix "memory_" to avoid confusion in derived classes.
    typedef _mapType::iterator memory_iterator;
    
    memory_iterator memory_begin()
    {
      return storage_map.begin();
    }

    memory_iterator memory_end() 
    {
      return storage_map.end();
    }

    ~Storage()
    {
      for (memory_iterator ii = memory_begin(), ie = memory_end();
           ii != ie; ++ii)
        delete (*ii).second;
      memory_clear();
    }
  };
}

#endif
