#include "Printer.hpp"
#include "Program.hpp"
#include "Module.hpp"
#include "Value.hpp"
#include "Type.hpp"
#include "Addressable.hpp"
#include "Utils.hpp"

#include <fstream>

using namespace hls;

void Printer::print(Program *program, const std::string &suffix)
{
  std::string filename = program->id + suffix;
  std::ofstream file(filename.c_str());
  hls::ostream out(file);
  print_program(program, out);
}

void Printer::print_program(Program *program, hls::ostream &out)
{
  assert(program->start);
  out << indent << "<program id=\"" << program->id
      << "\" start=\"" << program->start->id
      << "\">";

  out << indent_in;
  print_types(program, out);
  print_addressables(program, out);

  for (Program::ModuleList::iterator fi = program->modules.begin()
  	 , fe = program->modules.end(); fi != fe; ++fi) {
    Module *myf = (*fi).second;
    print_module(myf, out);
  }

  out << indent_out;
    
  out << "\n" << indent << "</program>";
}


void Printer::print_module(hls::Module *myf, hls::ostream &out)
{
  out << "\n" << indent << "<module id=\"" << myf->id
      << "\" type=\"" << myf->type
      << "\">";
  out << indent_in;

  // print_call_interface(myf, out);
  print_module_body(myf, out);
    
  out << indent_out;
  out << indent << "</module>";
}

void Printer::print_scalar_value(ScalarValue *value, hls::ostream &out)
{
  out << indent << "<scalar type=\"" << value->type
      << "\" size=\"" << value->size
      << "\">"
      << value->value << "</scalar>";
}

void Printer::print_composite_value(CompositeValue *value, hls::ostream &out)
{
  out << indent << "<composite type=\"" << value->type
      << "\" size=\"" << value->size
      << "\">";
  out << indent_in;

  for (CompositeValue::ElementVector::iterator ei = value->elements.begin()
	 , ee = value->elements.end();
       ei != ee; ++ei) {
    print_value(*ei, out);
  }

  out << indent_out;
  out << indent << "</composite>";
}

void Printer::print_address_value(AddressValue *value, hls::ostream &out)
{
  out << indent << "<address addressable=\"" << value->addressable
      << "\" size=\"" << value->size
      << "\"/>";
}

void Printer::print_value(Value *value, hls::ostream &out)
{
  switch (value->vtype) {
    case Value::Scalar:
      print_scalar_value(static_cast<ScalarValue*>(value), out);
      break;
    case Value::Composite:
      print_composite_value(static_cast<CompositeValue*>(value), out);
      break;
    case Value::Address:
      print_address_value(static_cast<AddressValue*>(value), out);
      break;
    default:
      assert(false && "unsupported value");
      break;
  }
}

void Printer::print_types(Program *program, hls::ostream &out)
{
  out << "\n" << indent << "<types>";
  out << indent_in;

  for (Program::TypeList::iterator ti = program->types.begin()
         , te = program->types.end(); ti != te; ++ti) {
    const hls::Type *type = (*ti).second;

    out << indent << "<type id=\"" << str(type)
        << "\" type=\"" << str(type->type_id);

    switch (type->type_id) {
      case APIntID:
        out << "\" int_width=\"" << type->int_width;
        break;

      case APFloatID:
        out << "\" exp_width=\"" << type->exp_width;
        out << "\" frc_width=\"" << type->frc_width;
        break;

      default:
        assert(false);
        break;
    }

    out << "\"/>";
  }
  
  out << indent_out;
  out << indent << "</types>";
}
  
void Printer::print_addressables(Program *program, hls::ostream &out)
{
  out << "\n" << indent << "<address_space>";
  out << indent_in;
    
  for (Program::AddressSpace::iterator ai = program->addrs.begin()
	 , ae = program->addrs.end();
       ai != ae; ++ai) {
    Addressable *addr = (*ai).second;
      
    out << indent << "<addressable id=\"" << addr->id
	<< "\" type=\"" << addr->type
	<< "\" size=\"" << addr->size;
    if (addr->address != 0)
      out << "\" address=\"" << addr->address;
    out << "\">";

    out << indent_in;

    if (addr->value)
      print_value(addr->value, out);

    out << indent_out;
    out << indent << "</addressable>";
  }
    
  out << indent_out;
  out << indent << "</address_space>";
}

void dump_value(Program *program, unsigned address, Value *value, std::ostream &out);

void dump_value_in_bytes(unsigned address, const std::string &value,
                         unsigned size, std::ostream &out)
{
  for (unsigned count = 0; count < size; ++count) {
    unsigned pos = (size - 1 - count) * 8;
    unsigned actual = address + count;
    out << "\n" << actual << " " << value.substr(pos, 8);
  }
}

void dump_scalar_value(unsigned address, ScalarValue *value, std::ostream &out)
{
  dump_value_in_bytes(address, value->value, value->size, out);
}

void dump_composite_value(Program *program, unsigned address
                          , CompositeValue *value, std::ostream &out)
{
  unsigned base = address;
  for (CompositeValue::ElementVector::iterator ei = value->elements.begin()
         , ee = value->elements.end(); ei != ee; ++ei) {
    Value *eval = *ei;
    dump_value(program, base, eval, out);
    base += eval->size;
  }
}

void dump_address_value(unsigned address, unsigned value
                        , unsigned size, std::ostream &out) 
{
  std::string str = create_bitstring(value, size * 8);

  dump_value_in_bytes(address, str, size, out);
}

void dump_value(Program *program, unsigned address, Value *value, std::ostream &out)
{
  switch (value->vtype) {
    default:
      assert(false);
      break;
      
    case Value::Scalar:
      dump_scalar_value(address, static_cast<ScalarValue*>(value), out);
      break;

    case Value::Composite:
      dump_composite_value(program, address, static_cast<CompositeValue*>(value), out);
      break;

    case Value::Address:
      AddressValue *adval = static_cast<AddressValue*>(value);
      Addressable *target = program->find_addressable(adval->addressable);
      assert(target);
      assert(target->address != 0);
      dump_address_value(address, target->address, value->size, out);
      break;
  }
}

void dump_addressable(Program *program, Addressable *adr, std::ostream &out)
{
  assert(adr->address != 0);
  
  if (!adr->value)
    return;

  dump_value(program, adr->address, adr->value, out);
}

void hls::dump_address_space(hls::Program *program, const std::string &filename)
{
  if (program->addrs.size() == 0) {
    std::cerr << "\nAddress space empty. Nothing printed.";
    return;
  }
  
  std::ofstream out(filename.c_str());

  for (hls::Program::AddressSpace::iterator ai = program->addrs.begin(),
         ae = program->addrs.end(); ai != ae; ai++) {
    Addressable *adr = (*ai).second;

    dump_addressable(program, adr, out);
  }
}
