#ifndef STORAGE_HPP
#define STORAGE_HPP

namespace ahir {

  struct MemoryLocation 
  {
    const std::string id;
    const Type* const type;     // the type can never be changed.
    Value *value;

  private:
    // A MemoryLocation can only be created by a MemorySpace
    friend class MemorySpace;
    MemoryLocation(const std::string &_id, const Type *_type)
      : id(_id), type(_type), value(NULL)
    {};
  };

  class MemorySpace 
  {
    // Use a vector for iteration, and a map for searching by id. The
    // two are always in sync.
    //
    // FIXME: Deletion is O(n) in this arrangement. We need a custom
    // iterator class that encapsulates the map::iterator to behave
    // like the vector::iterator!
    typedef std::map<std::string, MemoryLocation*> _mapType;
    _mapType space_map;

    typedef std::vector<MemoryLocation*> _vecType;
    _vecType space;

    // A memory space can only be created by a Storage object
    friend class Storage;
    MemorySpace(const std::string _id)
      : id(_id) 
    {}

    void clear()
    {
      space.clear();
      space_map.clear();
    }

    // TODO: Define set-like operations on memory spaces.

  public:
    const std::string id;
    
    MemoryLocation* add_location(const std::string &id
                                 , const Type *type
                                 , Value *value = NULL)
    {
      assert(!find_location(id));
      MemoryLocation *m = new MemoryLocation(id, type, value);
      space_map[m->id] = m;
      space.push_back(m);
      return m;
    }
    
    MemoryLocation* find_location(const std::string &id)
    {
      if (space_map.find(id) != space_map.end())
        return space_map[id];
      return NULL;
    }

    typedef _vecType::iterator iterator;

    iterator begin()
    {
      return space.begin();
    }

    iterator end()
    {
      return space.end();
    }

    ~MemorySpace()
    {
      for (iterator ii = space.begin(), ie = space.end(); ii != ie; ++ii)
        delete *ii;
      clear();
    }
  };
    
  // Classes derived from this shall have storage facilities. (e.g.,
  // Program and Module).
  
  class Storage : public Base 
  {
    typedef std::map<std::string, MemorySpace*> _mapType;
    _mapType storage_map;

    typedef std::vector<MemorySpace*> _vecType;
    _vecType storage;

    void memory_clear()
    {
      storage_map.clear();
      storage.clear();
    }

    // TOOD: Allow memory spaces and memory locations to migrate
    // between different Storage instances.
    
  public:

    Storage(const std::string &_id)
      : Base(_id)
    {} 
    
    // Add a location to a new memory space where it lives all by itself.
    MemoryLocation* add_location(const std::string &var_id
                                 , const Type *type
                                 , Value *value = NULL)
    {
      MemorySpace *ms = add_memory_space(var_id);
      return ms->add_location(var_id, type, value);
    }

    // Add a location to an arbitrary memory space, creating the space
    // if necessary.
    MemoryLocation* add_location(const std::string &var_id
                                 , const Type *type
                                 , Value *value
                                 , const std::string &space_id)
    {
      MemorySpace *ms = find_memory_space(space_id);
      if (!ms)
        ms = add_memory_space(space_id);
      return ms->add_location(var_id, type, value);
    }

    MemroySpace* add_memory_space(const std::string &id)
    {
      assert(!find_memory_space(id));
      MemorySpace *m = new MemorySpace(id);
      storage_map[m->id] = m;
      storage.push_back(m);
      return m;
    }

    MemorySpace* find_memory_space(const std::string &id) 
    {
      if (storage_map.find(id) != storage_map.end())
        return storage_map[id];
      return NULL;
    }

    // Prefix "memory_" to avoid confusion in derived classes.
    typedef _vecType::iterator memory_iterator;
    
    memory_iterator memory_begin()
    {
      return storage.begin();
    }

    memory_iterator memory_end() 
    {
      return storage.end();
    }

    ~Storage()
    {
      for (memory_iterator ii = storage.begin(), ie = storage.end();
           ii != ie; ++ii)
        delete *ii;
      memory_clear();
    }
  }
}

#endif
