#include "NodeType.hpp"

#include <boost/algorithm/string/predicate.hpp>
#include <assert.h>

using namespace hls;

#define HANDLE_OP(op) const std::string op##_str = #op;
#include "NodeType.inc"

std::string hls::str(NodeType ntype)
{
  switch (ntype) {
#define HANDLE_OP(op) case op: return op##_str; break;
#include "NodeType.inc"
  default:
    assert(false && "unknown node type");
  }
  return "DUMMY";
}

NodeType hls::ntype(const std::string &str)
{
#define HANDLE_OP(op) if (boost::iequals(str, op##_str)) return op; else
#include "NodeType.inc"
  // assert(false && "unknown node type");
  return DUMMY;
}

bool hls::is_cast(NodeType ntype) 
{
  return ntype >= CAST_BEGIN && ntype <= CAST_END;
}
  
bool hls::is_rel(NodeType ntype) 
{
  return ntype >= REL_BEGIN && ntype <= REL_END;
}

bool hls::is_fcmp(NodeType ntype) 
{
  return ntype >= FCMP_BEGIN && ntype <= FCMP_END;
}

bool hls::is_data(NodeType ntype) 
{
  return ntype >= DATA_BEGIN && ntype <= DATA_END;
}

bool hls::is_control(NodeType ntype) 
{
  return ntype >= CONTROL_BEGIN && ntype <= CONTROL_END;
}

bool hls::is_constant(NodeType ntype)
{
  switch (ntype) {
    case Constant:
    case Address:
      return true;
      break;

    default:
      return false;
      break;
  }
}

bool hls::is_binary(NodeType ntype)
{
  return ntype >= BINARY_BEGIN && ntype <= BINARY_END;
}

bool hls::has_one_operand(NodeType ntype)
{
  assert(is_data(ntype));
  assert(!is_constant(ntype));

  if (is_cast(ntype))
    return true;

  if (is_binary(ntype))
    return false;

  assert(false);
  return false;
}

bool hls::has_two_operands(NodeType ntype)
{
  return !has_one_operand(ntype);
}

bool hls::is_shared(NodeType ntype)
{
  if (is_constant(ntype))
    return false;

  if (is_io(ntype))
    return false;

  if (is_mem(ntype))
    return true;

  if (is_data(ntype))
    switch (ntype) {
      case Multiplexer:
      case Select:
      case Call:
      case Response:
      case Accept:
      case Return:
        return false;
        break;

      default:
        return true;
        break;
    }
  
  return false;
}

bool hls::is_pipelined(NodeType ntype)
{
  if (!is_data(ntype))
    return false;

  if (is_constant(ntype))
    return false;

  switch (ntype) {
    // case ZExt:
    // case SExt:
    // case Trunc:
    case Multiplexer:
    case Select:
    case LoadRequest:
    case LoadComplete:
    case Store:
    case Call:
    case Response:
    case Accept:
    case Return:
    case Input:
    case Output:
      return false;
      break;

    default:
      return true;
      break;
  }

  return true;
}

bool hls::is_io(NodeType ntype)
{
  return ntype == Input || ntype == Output;
}

bool hls::is_mapped_to_io(NodeType ntype)
{
  switch (ntype) {
    case Call:
    case Response:
    case Accept:
    case Return:
    case Input:
    case Output:
      return true;
      break;

    default:
      break;
  }

  return false;
}

std::string hls::get_output_port(NodeType ntype)
{
  assert(is_data(ntype));
  
  if (is_rel(ntype))
    // the output port of a relational operator is always APInt<0>.
    // Hence we use an input port to guess the type.
    return "x";
  else if (ntype == Store || ntype == LoadComplete)
    // The Store element has no output. Hence we use its "data" input
    // to determine the type.
    return "data";
  else
    // Else we use the port that most operators have! 
    return "z";
}

bool hls::is_mem(NodeType ntype)
{
  switch (ntype) {
    case LoadRequest:
    case Store:
    case LoadComplete:
      return true;
      break;

    default:
      break;
  }

  return false;
}

bool hls::has_2D_ports(NodeType ntype)
{
  switch (ntype) {
    case Branch:
    case Select:
    case Multiplexer:
      return false;
      break;

    default:
      break;
  }

  return true;
}
