library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.BaseComponents.all;
use ahir.ApIntComponents.all;


entity umul32 is -- 
    generic (tag_length : integer);
    port ( -- 
      L : in  std_logic_vector(31 downto 0);
      R : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(63 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
end entity umul32;

architecture Struct of umul32 is
   signal in_data: std_logic_vector(63 downto 0);
begin
   in_data <= L & R; -- concatenate..

   mul_inst: GenericApIntArithOperator
		generic map(op_id => "ApIntMul",
				name => "umul32-mul",
				tag_width => tag_length,
				in_operand_width => 32,
				num_non_constant_inputs => 2,
				first_operand_is_constant => false,
				second_operand_is_constant => false,
				constant_value => "0",
                   		out_result_width => 64)
		port map(in_data => in_data, 
				out_data => ret_val_x_x,
				clk => clk, reset => reset,
				tag_in => tag_in , tag_out => tag_out,
				env_rdy => start_req, accept_rdy => fin_req,
				op_i_rdy => start_ack, op_o_rdy => fin_ack);
			
end Struct;

