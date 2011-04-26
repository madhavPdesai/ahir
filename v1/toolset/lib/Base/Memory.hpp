#ifndef __AHIR_MEMORY_HPP__
#define __AHIR_MEMORY_HPP__

#include <map>
#include <string>

namespace ahir {
  class ScalarValue;

  /*!
    A description of the linear memory address space.
   */
  struct Memory {
    std::string id;

    size_t size;

    /*! @name Memory Locations
      Values are stored as strings whose interpretation is left to the
      client.
     */
    //@{
    typedef std::map<size_t, std::string> MemoryMap;
    typedef MemoryMap::iterator iterator;
    //! The initial and final states of memory.
    MemoryMap inputs, outputs;
    //@}

    void set_input_value(size_t address, std::string value);
    void set_output_value(size_t address, std::string value);

    Memory(const std::string& _id, unsigned _size);
  };

}

#endif
