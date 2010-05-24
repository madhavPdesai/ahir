#include "Memory.hpp"

#include <assert.h>

using namespace ahir;

Memory::Memory(const std::string& _id, unsigned _size)
{
  id = _id;
  size = _size;
};


void Memory::set_input_value(size_t address, std::string value)
{
  assert(inputs.find(address) == inputs.end()
	 && "this location has already been assigned");
  inputs[address] = value;
}

void Memory::set_output_value(size_t address, std::string value)
{
  assert(outputs.find(address) == outputs.end()
	 && "this location has already been assigned");
  outputs[address] = value;
}
