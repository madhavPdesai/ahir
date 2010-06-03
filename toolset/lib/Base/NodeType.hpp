#ifndef __NODETYPES_HPP__
#define __NODETYPES_HPP__

#include <string>

namespace hls {

  typedef enum {
    DUMMY = 0
#define FIRST_CONTROL(num) , CONTROL_BEGIN = num
#define LAST_CONTROL(num) , CONTROL_END = num
#define FIRST_DATA(num) , DATA_BEGIN = num
#define LAST_DATA(num) , DATA_END = num
#define FIRST_BINARY(num) , BINARY_BEGIN = num
#define LAST_BINARY(num) , BINARY_END = num
#define FIRST_REL(num) , REL_BEGIN = num
#define LAST_REL(num) , REL_END = num
#define FIRST_FCMP(num) , FCMP_BEGIN = num
#define LAST_FCMP(num) , FCMP_END = num
#define FIRST_SHIFT(num) , SHIFT_BEGIN = num
#define LAST_SHIFT(num) , SHIFT_END = num
#define FIRST_CAST(num) , CAST_BEGIN = num
#define LAST_CAST(num) , CAST_END = num
#define HANDLE_OP(op) , op
#include "NodeType.inc"
  } NodeType;
  
  std::string str(NodeType ntype);
  NodeType ntype(const std::string &str);

  bool is_binary(NodeType ntype);
  bool has_one_operand(NodeType ntype);
  bool has_two_operands(NodeType ntype);
  bool is_shared(NodeType ntype);
  bool is_cast(NodeType ntype);
  bool is_rel(NodeType ntype);
  bool is_fcmp(NodeType ntype);
  bool is_data(NodeType ntype);
  bool is_control(NodeType ntype);
  bool is_constant(NodeType ntype);
  bool is_pipelined(NodeType ntype);
  bool is_io(NodeType ntype);
  bool is_mapped_to_io(NodeType ntype);
  bool is_mem(NodeType ntype);
  bool has_array_ports(NodeType ntype);

  std::string get_output_port(NodeType ntype);
}
  
#endif
