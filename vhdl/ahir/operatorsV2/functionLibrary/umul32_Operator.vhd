library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.BaseComponents.all;
use ahir.ApIntComponents.all;


entity umul32_Operator is -- 
    port ( -- 
      L : in  std_logic_vector(31 downto 0);
      R : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(63 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      sample_req : in Boolean;
      sample_ack : out Boolean;
      update_req : in Boolean;
      update_ack   : out Boolean
    );
end entity umul32_Operator;

architecture Struct of umul32_Operator is
   signal in_data: std_logic_vector(63 downto 0);
   signal start_req, start_ack, fin_req, fin_ack: std_logic;
   signal tag_in, tag_out: std_logic_vector(0 downto 0);
begin
   tag_in(0) <= '0';

   p2l: Pulse_To_Level_Translate_Entity
		port map (rL => sample_req, rR => start_req,
				aL => sample_ack, aR => start_ack,
					clk => clk, reset => reset);
   l2p: Level_To_Pulse_Translate_Entity
		port map (rL => fin_req, rR => update_req,
				aL => fin_ack, aR => update_ack);
				
   in_data <= L & R; -- concatenate..

   mul_inst: GenericApIntArithOperator
		generic map(op_id => "ApIntMul",
				name => "umul32-mul",
				tag_width => 1,
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

