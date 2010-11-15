#include "Factory.hpp"

#include "Addressable.hpp"
#include "Value.hpp"
#include "Program.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <boost/lexical_cast.hpp>

#include <iostream>
#include <assert.h>

using namespace hls;

Factory::Factory()
{
  program = NULL;
  module = NULL;
  omega = NULL;
  mspace = NULL;
  mloc = NULL;
  svalue = NULL;
  cvalue = NULL;
}

std::string Factory::format(const std::string &input)
{
  return input;
}

void Factory::create_program(const std::string &id)
{
  program = new Program(id);
  storage = program;
}

void Factory::commit_program()
{
  for (Program::RootList::iterator ri = program->roots.begin()
         , re = program->roots.end(); ri != re; ++ri) {
    const std::string &root_id = *ri;
    assert(program->find_module(root_id));
  }
}

void Factory::register_root(const std::string &root)
{
  program->roots.push_back(root);
}

void Factory::create_module(const std::string &id, const std::string &type)
{
  create_module_hook(id, type);
  program->register_module(module);
  storage = module;
}

void Factory::begin_iface()
{}

// void Factory::module_set_retval(const std::string &characters)
// {
  // assert(module->retval_id == 0);
  // module->retval_id = boost::lexical_cast<unsigned>(characters);
// }

// void Factory::module_append_arg(const std::string &characters)
// {
  // module->args.push_back(boost::lexical_cast<unsigned>(characters));
// }

void Factory::create_integer_type(const std::string &id
                                  , const std::string &int_width)
{
  unsigned w = boost::lexical_cast<unsigned>(int_width);
  const hls::Type *type = program->find_type(id);
  assert(!type);

  type = new Type(w);
  program->register_type(id, type);
}

void Factory::create_float_type(const std::string &id
                                , const std::string &exp_width
                                , const std::string &frc_width)
{
  unsigned e = boost::lexical_cast<unsigned>(exp_width);
  unsigned f = boost::lexical_cast<unsigned>(frc_width);

  const hls::Type *type = program->find_type(id);
  assert(!type);

  type = new Type(e, f);
  program->register_type(id, type);
}

void Factory::create_memory_space(const std::string &id)
{
  mspace = storage->add_memory_space(id);
}

void Factory::create_memory_location(const std::string &id
                                     , const std::string &type_id
                                     , const std::string &_size
                                     , const std::string &address
                                     , const std::string &description)
{
  unsigned size = boost::lexical_cast<unsigned>(size);
  mloc = mspace->add_memory_location(id, type_id, size);
  if (address.size() > 0) {
    unsigned addr = boost::lexical_cast<unsigned>(address);
    mloc->address = addr;
  }
  assert(!svalue);
  assert(!cvalue);
}

void Factory::dispatch_value(Value *value)
{
  if (cvalue) {
    if (mloc)
      assert(mloc->value);
    cvalue->elements.push_back(value);
  } else {
    assert(mloc);
    assert (!mloc->value);
    mloc->value = value;
  }
}

void Factory::register_scalar(const std::string &type)
{
  svalue = new ScalarValue(program->find_type(type));
  assert(svalue->hls_type);
  dispatch_value(svalue);
}

void Factory::register_composite(const std::string &type)
{
  CompositeValue *cval = new CompositeValue(type);
  dispatch_value(cval); // should be called before push_cvalue
  push_cvalue(cval);
}

void Factory::register_address_value(const std::string &mloc_name
                                     , const std::string &size)
{
  AddressValue *av = new AddressValue(mloc_name
                                      , boost::lexical_cast<unsigned>(size));
  dispatch_value(av);
}

void Factory::commit_value_composite()
{
  assert(cvalue);
  pop_cvalue();
  assert(!svalue);
}

void Factory::commit_value_scalar()
{
  assert(svalue);
  svalue = NULL;
}

void Factory::commit_memory_location()
{
  assert(mloc);
  mloc = NULL;
  assert(value_stack.size() == 0);
  assert(!svalue);
  assert(!cvalue);
}

void Factory::push_cvalue(CompositeValue *cval)
{
  if (value_stack.empty())
    assert(cvalue == NULL);
  value_stack.push_back(cvalue);
  cvalue = cval;
}

void Factory::pop_cvalue()
{
  assert(value_stack.size() > 0);
  cvalue = value_stack.back();
  value_stack.pop_back();

  if (value_stack.empty())
    assert(cvalue == NULL);
}

void Factory::set_value_scalar(const std::string &characters)
{
  assert(svalue);
  assert(svalue->value.size() == 0);
  svalue->value = characters;
}

