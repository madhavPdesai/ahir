#ifndef __ADDRESSABLE_HPP__
#define __ADDRESSABLE_HPP__

#include <string>
#include <set>
#include <map>

namespace hls {

  class Address;
  class Value;

  /*! Base class for any value that is mapped into a known memory location.
   */
  struct Addressable {
    std::string id;
    unsigned size;
    std::string type;
    std::string description;

    //! Value assigned to the current object.
    Value *value;
    /*! @name Indirect Address
      List of Address objects in the data-path that indirectly refer
      to this Addressable location.
     */
    //@{
    typedef std::map<std::string, std::set<unsigned> > AddressList;
    AddressList addresses;
    void register_address(const std::string& module, unsigned addr);
    //@}

    virtual void set_address(unsigned addr);
    unsigned get_address() {return address;};

    Addressable(const std::string &_id
		, const std::string& _type
		, unsigned _size);
    virtual ~Addressable();

    //! This is assigned by the linker, and used by the Address objects.
    unsigned address;
  };
}

#endif
