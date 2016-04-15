-------------------------------------------------------------------------------
-- generic ap-int (signed/unsigned operator)
-- modified by Madhav Desai.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;


entity GenericBinaryApIntArithOperatorPipelined is
  generic (op_id: string;
	    tag_width : integer := 8;
	    in_operand_width: integer;
	    out_result_width: integer;
           );
  port(
    in_data: in std_logic_vector((2*in_operand_width)-1 downto 0);
    out_data: out std_logic_vector(out_result_width-1 downto 0);
    clk,reset: in std_logic;
    tag_in: in std_logic_vector(tag_width-1 downto 0);
    tag_out: out std_logic_vector(tag_width-1 downto 0);
    pipeline_stall: in std_logic;
    env_rdy: in std_logic;
    op_o_rdy: out std_logic);
end entity;

architecture rtl of GenericBinaryApIntArithOperatorPipelined is
  signal pipeline_stall : std_logic;
begin


  -- binary operator.

  mulOp: if (op_id = "ApIntMul") generate
	op: UnsignedMultiplier
		generic map (tag_width => tag_width,
				operand_width => in_operand_width,
					chunk_width => 8)
		port map (
    				L => in_data((2*in_operand_width)-1 downto in_operand_width), 
				R => in_data(in_operand_width-1 downto 0),
    				RESULT     : out_data,
				clk => clk, reset => reset,
    				in_rdy   => env_rdy,
    				out_rdy  => op_o_rdy,
    				stall    => pipeline_stall,
    				tag_in   => tag_in,
    				tag_out  => tag_out
			 );
  end generate mulOp;

  lshlOp: if (op_id = "ApIntSHL") generate
  end generate lshlOp;
		
  lshrOp: if (op_id = "ApIntLSHR") generate
  end generate lshrOp;

  ashrOp: if (op_id = "ApIntASHR") generate
  end generate ashrOp;

  rolOp: if (op_id = "ApIntROL") generate
  end generate rolOp;

  rorOp: if(op_id = "ApIntROR"))  generate
  end generate rorOp;

end rtl;
