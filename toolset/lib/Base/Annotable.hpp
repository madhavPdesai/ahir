#ifndef Annotable_HPP
#define Annotable_HPP

#include <map>
#include <string>
#include <assert.h>

namespace hls {

  class Annotable {

  private:

    typedef std::map<std::string, std::string> AttributeMap;
    AttributeMap attributes;

  public:

    void set_attribute(const std::string &key, const std::string &value)
    {
      attributes[key] = value;
    }
    
    bool has_attribute(const std::string &key) const
    {
      return attributes.find(key) != attributes.end();
    }
    
    const std::string& get_attribute(const std::string &key) const
    {
      assert(has_attribute(key));
      return (*attributes.find(key)).second;
    }

    typedef AttributeMap::iterator attribute_iterator;

    attribute_iterator attributes_begin() 
    {
      return attributes.begin();
    }

    attribute_iterator attributes_end() 
    {
      return attributes.end();
    }

    void clear_attributes()
    {
      attributes.clear();
    }
  };
  
}

#endif
