#include "Addressable.hpp"
#include "Value.hpp"

#include <assert.h>

using namespace hls;

Addressable::Addressable(const std::string &_id
			 , const std::string &_type
			 , size_t _size)
{
  id = _id;
  size = _size;
  address = 0;
  value = NULL;
  type = _type;
}

Addressable::~Addressable()
{
}

void Addressable::register_address(const std::string &module
				   , unsigned addr)
{
  addresses[module].insert(addr);
}

void Addressable::set_address(size_t addr)
{
  address = addr;
}
