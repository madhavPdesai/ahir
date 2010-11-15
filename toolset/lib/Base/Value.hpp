#ifndef __AHIR_VALUES_HPP__
#define __AHIR_VALUES_HPP__

#include "Type.hpp"

#include <string>
#include <map>
#include <vector>
#include <ostream>

namespace hls {
  
  class Type;
  
  /*! \brief Base class to represent values in AHIR.
   */
  struct Value {
    typedef enum {Scalar, Composite, Address} ValueType;
    ValueType vtype;
    unsigned size;
    std::string type;
    
    Value(ValueType _vt, unsigned _s, const std::string &_t)
      : vtype(_vt), size(_s), type(_t)
    {} 
    virtual ~Value() {} 
  };

  //! \brief Derived class for scalar values.
  struct ScalarValue : public Value {
    //! String encoded value, to be interpreted by the user.
    std::string value;
    const Type *hls_type;

    ScalarValue(const hls::Type *_type)
      : Value(Scalar, _type->width()/8, str(_type)), hls_type(_type)
    {} 
  };

  /*! \brief Derived class for a composite value, i.e., array or
      struct in C.
    
    A CompositeValue contains references to instances of any subclass
    of hls::Value. The size of this value must be the sum of the sizes
    of all elements in it.
   */
  struct CompositeValue : public Value {
    typedef std::vector<Value*> ElementVector;
    ElementVector elements;

    CompositeValue(const std::string &_type)
      : Value(Composite, 0, _type)
    {}
  };

  /*! Derived class to represent a pointer value.

    An instance of AddressValue indicates a MemoryLocation by it's
    fully qualified name.
  */
  struct AddressValue : public Value {
  std::string addressable;

    AddressValue(const std::string &addr, unsigned _s)
      : Value(Address, _s, "address"), addressable(addr)
    {}
  };

  inline bool is_scalar(Value *value) { return value->vtype == Value::Scalar; };
  inline bool is_composite(Value *value) { return value->vtype == Value::Composite; };
  inline bool is_address(Value *value) { return value->vtype == Value::Address; };
}

#endif
