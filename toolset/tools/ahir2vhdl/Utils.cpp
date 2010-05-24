#include "Utils.hpp"
#include "DataPath.hpp"
#include <AHIR/DataPath.hpp>
#include <Base/Type.hpp>

#include <sstream>
#include <boost/format.hpp>

using namespace vhdl;
using namespace hls;

unsigned memory::data_width = 8;
unsigned memory::address_width = 16;
unsigned memory::tag_width = 8;

namespace {

  std::map<NodeType, std::string> ConfigurationNames, ComponentNames;

  bool has_no_configuration(NodeType ntype) 
  {
    return ConfigurationNames.find(ntype) == ConfigurationNames.end();
  }
}

void vhdl::init_names() 
  {
    if (ConfigurationNames.size() == 0) {
      
      ConfigurationNames[Add] = "Add";
      ConfigurationNames[FAdd] = "Add";
      ConfigurationNames[Sub] = "Sub";
      ConfigurationNames[FSub] = "Sub";
      ConfigurationNames[Mul] = "Mul";
      ConfigurationNames[FMul] = "Mul";
      ConfigurationNames[SDiv] = "DivSigned";
      ConfigurationNames[UDiv] = "DivUnsigned";
      ConfigurationNames[FDiv] = "Div";
      ConfigurationNames[SRem] = "SRem";
      ConfigurationNames[URem] = "URem";
      ConfigurationNames[FRem] = "FRem";
      ConfigurationNames[And] = "And";
      ConfigurationNames[Or] = "Or";
      ConfigurationNames[Xor] = "Xor";
      
      ConfigurationNames[FCMP_OEQ] = "OEQ";
      ConfigurationNames[FCMP_OGT] = "OGT";
      ConfigurationNames[FCMP_OGE] = "OGE";
      ConfigurationNames[FCMP_OLT] = "OLT";
      ConfigurationNames[FCMP_OLE] = "OLE";
      ConfigurationNames[FCMP_ONE] = "ONE";
      ConfigurationNames[FCMP_ORD] = "ORD";
      ConfigurationNames[FCMP_UNO] = "UNO";
      ConfigurationNames[FCMP_UEQ] = "UEQ";
      ConfigurationNames[FCMP_UGT] = "UGT";
      ConfigurationNames[FCMP_UGE] = "UGE";
      ConfigurationNames[FCMP_ULT] = "ULT";
      ConfigurationNames[FCMP_ULE] = "ULE";
      ConfigurationNames[FCMP_UNE] = "UNE";
      
      ConfigurationNames[ICMP_EQ] = "EQ";
      ConfigurationNames[ICMP_NE] = "NE";
      ConfigurationNames[ICMP_UGT] = "UGT";
      ConfigurationNames[ICMP_UGE] = "UGE";
      ConfigurationNames[ICMP_ULT] = "ULT";
      ConfigurationNames[ICMP_ULE] = "ULE";
      ConfigurationNames[ICMP_SGT] = "SGT";
      ConfigurationNames[ICMP_SGE] = "SGE";
      ConfigurationNames[ICMP_SLT] = "SLT";
      ConfigurationNames[ICMP_SLE] = "SLE";
      
      ConfigurationNames[Shl] = "Shl";
      ConfigurationNames[LShr] = "LShr";
      ConfigurationNames[AShr] = "AShr";
      
      ConfigurationNames[FPTrunc] = "APFloatResize";
      ConfigurationNames[FPExt] = "APFloatResize";
      ConfigurationNames[Trunc] = "APIntToAPIntUnsigned";
      ConfigurationNames[ZExt] = "APIntToAPIntUnsigned";
      ConfigurationNames[SExt] = "APIntToAPIntSigned";
      
      ConfigurationNames[FPToUI] = "APFloatToAPIntUnsigned";
      ConfigurationNames[FPToSI] = "APFloatToAPIntSigned";
      ConfigurationNames[UIToFP] = "APIntToAPFloatUnsigned";
      ConfigurationNames[SIToFP] = "APIntToAPFloatSigned";
    }

    if (ComponentNames.size() == 0) {
      ComponentNames[Branch] = "ApIntBranch";
      
      ComponentNames[FPToUI] = "APFloatToAPInt_S_1";
      ComponentNames[FPToSI] = "APFloatToAPInt_S_1";
      ComponentNames[UIToFP] = "APIntToAPFloat_S_1";
      ComponentNames[SIToFP] = "APIntToAPFloat_S_1";
      
      ComponentNames[Multiplexer] = "Phi";
      ComponentNames[Select] = "Select";
      ComponentNames[LoadRequest] = "ApLoadReq";
      ComponentNames[LoadComplete] = "ApLoadComplete";
      ComponentNames[Store] = "ApStoreReq";
      
      ComponentNames[Accept] = "InputPort";
      ComponentNames[Return] = "OutputPort";
      ComponentNames[Call] = "OutputPort";
      ComponentNames[Response] = "InputPort";
    }
  }

unsigned memory::get_num_addressable_units(unsigned data_width) 
{
  if (data_width == 0)
    return 0;

  unsigned addressable_units = data_width / memory::data_width;
  if (data_width % memory::data_width > 0)
    addressable_units++;

  return addressable_units;
}

std::string vhdl::vhdl_wire_name(ahir::Wire *wire)
{
  return str(boost::format("wire_%s") % wire->id);
}

std::string vhdl::vhdl_array_type_name(const hls::Type *type)
{
  return str(type->type_id) + "Array";
}

const std::string& vhdl::vhdl_configuration_name(NodeType ntype) 
{
  assert(ConfigurationNames.find(ntype) != ConfigurationNames.end());
  return ConfigurationNames[ntype];
}

bool vhdl::has_no_instance(NodeType ntype)
{
  return is_constant(ntype);
}


std::string vhdl::vhdl_type_name(ahir::DPElement *dpe)
{
  NodeType ntype = dpe->ntype;
    
  assert(is_data(ntype));
  ahir::Port *port = dpe->find_port(get_output_port(ntype));
  
  assert(port);
  return str(port->type->type_id);
}

std::string vhdl::vhdl_component_name(ahir::DPElement *dpe)
{
  NodeType ntype = dpe->ntype;
  
  if (has_no_instance(ntype))
    return "";


  if (ComponentNames.find(ntype) != ComponentNames.end()) {
    const std::string &component = ComponentNames[ntype];
    
    switch (ntype) {
      case Multiplexer:
      case Select:
        return vhdl_type_name(dpe) + component;
        break;

      default:
        break;
    }
    
    return component;
  }

  assert (is_data(ntype));
  std::string name = vhdl_type_name(dpe);

  if (is_fcmp(ntype))
    return name + "_CMP_2";
  
  if (is_binary(ntype))
    return name + "_S_2";
  
  if (is_cast(ntype)) {
    switch (ntype) {
      case Trunc:
      case ZExt:
      case SExt:
      case PtrToInt:
      case IntToPtr:
      case FPTrunc:
      case FPExt:
        return name + "_S_1";
        break;

      default:
        break;
    }
  }
  
  return vhdl_configuration_name(ntype);
}

std::string vhdl::vhdl_configuration_name(ahir::DPElement *dpe)
{
  NodeType ntype = dpe->ntype;
  
  if (has_no_instance(ntype))
    return "";

  if (has_no_configuration(dpe->ntype))
    return "";
  
  const std::string& name = vhdl_configuration_name(ntype);

  if (is_cast(ntype))
    // the full name of the cast component includes type names.
    return name;

  if (ntype == LoadRequest)
    // the load-request does not need a data-type
    return name;

  if (is_io(ntype))
    return name;

  if (is_data(ntype))
    // return type-suffix + component-name
    return vhdl_type_name(dpe) + name;

  return name;
}

std::string vhdl::get_conversion_spec(const std::string &value, const hls::Type *type)
{
  std::ostringstream val;
  std::ostringstream padded_value;

  if (value.size() == type->width())
    padded_value << value;
  else {
    assert(value.size() == 1);
    assert(value == "0");
    for (unsigned count = 0; count < type->width(); count++)
      padded_value << "0";
  }

  switch (type->type_id) {
    case hls::APIntID:
      val << "to_apint";
      break;
      
    case hls::APFloatID:
      val << "to_apfloat";
      break;
      
    default:
      assert(false);
      break;
  }

  // The conversion from bit-string literal to bit_vector to SLV
  // ensures backward compatibility with VHDL'87 and VHDL'93
  val << "(to_stdlogicvector(bit_vector'(B\"" << padded_value.str() << "\")))";
  
  return val.str();
}

std::string vhdl::natural_array_all_same(unsigned number, unsigned copies)
{
  assert(copies > 0);
  
  std::ostringstream str;
  str << "(";
  if (copies == 1) {
    str << "0 => " << number << ")";
    return str.str();
  }

  str << number;
  while (copies-- > 1) {
    str << ", " << number;
  }

  str << ")";
  return str.str();
}
