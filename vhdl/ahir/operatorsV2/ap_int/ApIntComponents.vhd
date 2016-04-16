library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ApIntComponents is

 component UnsignedAdderSubtractor_n_n_n is
  
  generic (
    name	       : string;
    tag_width          : integer;
    operand_width      : integer;
    chunk_width        : integer
	);

  port (
    slv_L            : in  std_logic_vector(operand_width-1 downto 0);
    slv_R            : in  std_logic_vector(operand_width-1 downto 0);
    slv_RESULT       : out std_logic_vector(operand_width-1 downto 0);
    slv_carry_out    : out std_logic;
    slv_carry_in     : in std_logic;  
    subtract_op      : in std_logic;
    clk, reset       : in  std_logic;
    in_rdy           : in  std_logic;
    out_rdy          : out std_logic;
    stall            : in std_logic;
    tag_in           : in std_logic_vector(tag_width-1 downto 0);
    tag_out          : out std_logic_vector(tag_width-1 downto 0));

 end component;

 component UnsignedMultiplier_n_n_2n is
  
  generic (
    name: string;
    tag_width     : integer;
    operand_width : integer;
    chunk_width   : integer := 8);

  port (
    slv_L, slv_R   : in  std_logic_vector(operand_width-1 downto 0);
    slv_RESULT     : out std_logic_vector((2*operand_width)-1 downto 0);
    clk, reset : in  std_logic;
    in_rdy     : in  std_logic;
    out_rdy    : out std_logic;
    stall      : in std_logic;
    tag_in     : in std_logic_vector(tag_width-1 downto 0);
    tag_out    : out std_logic_vector(tag_width-1 downto 0));
 end component;

 component UnsignedShifter_n_n_n is
  generic (
    name: string;
    tag_width          : integer;
    operand_width      : integer;
    shift_amount_width : integer);

  port (
    slv_L       : in  std_logic_vector(operand_width-1 downto 0);
    slv_R       : in  std_logic_vector(shift_amount_width-1 downto 0);
    slv_RESULT  : out std_logic_vector(operand_width-1 downto 0);
    clk, reset  : in  std_logic;
    in_rdy      : in  std_logic;
    out_rdy     : out std_logic;
    stall       : in std_logic;
    shift_right_flag   : in std_logic;
    signed_flag        : in std_logic;
    tag_in      : in std_logic_vector(tag_width-1 downto 0);
    tag_out     : out std_logic_vector(tag_width-1 downto 0));
 end component;

 component GenericBinaryApIntArithOperatorPipelined is
  generic (
	    name : string;
	    op_id: string;
	    tag_width : integer := 8;
	    in_operand_width: integer;
	    out_result_width: integer
           );
  port(
    inA, inB: in std_logic_vector(in_operand_width-1 downto 0);
    outR: out std_logic_vector(out_result_width-1 downto 0);
    clk,reset: in std_logic;
    tag_in: in std_logic_vector(tag_width-1 downto 0);
    tag_out: out std_logic_vector(tag_width-1 downto 0);
    pipeline_stall: in std_logic;
    env_rdy: in std_logic;
    op_o_rdy: out std_logic);
 end component;

 component GenericApIntArithOperator is
  generic (
	    name: string;
	    op_id: string;
	    tag_width : integer := 8;
	    in_operand_width: integer;
	    num_non_constant_inputs: integer;
            first_operand_is_constant: boolean;
            second_operand_is_constant: boolean;
	    constant_value: std_logic_vector;
	    out_result_width: integer
           );
  port(
    in_data: in std_logic_vector((num_non_constant_inputs*in_operand_width)-1 downto 0);
    out_data: out std_logic_vector(out_result_width-1 downto 0);
    clk,reset: in std_logic;
    tag_in: in std_logic_vector(tag_width-1 downto 0);
    tag_out: out std_logic_vector(tag_width-1 downto 0);
    env_rdy, accept_rdy: in std_logic;
    op_i_rdy, op_o_rdy: out std_logic);
 end component;
end package;
