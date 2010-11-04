#ifndef BASE_HPP
#define BASE_HPP

#include <map>
#include <string>

namespace hls {

  class Root {

  private:

    typedef std::map<std::string, std::string> AttributeMap;
    AttributeMap attributes;

  public:

    const std::string id;

    Root(const std::string &_id)
      : id(_id)
    {} 
    
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
      return attributes[key];
    }

    typedef AttributeMap::iterator attribute_iterator;

    attribute_iterator attributes_begin() const
    {
      return attributes.begin();
    }

    attribute_iterator attributes_end() const
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
