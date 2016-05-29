library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.BaseComponents.all;
use ahir.ApIntComponents.all;

entity uaddsub32_Operator is -- 
    port ( -- 
      L : in  std_logic_vector(31 downto 0);
      R : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      carry_in: in std_logic_vector(0 downto 0);
      carry_out: out std_logic_vector(0 downto 0);
      subtract_flag: in std_logic_vector(0 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      sample_req : in Boolean;
      sample_ack : out Boolean;
      update_req : in Boolean;
      update_ack   : out Boolean
    );
end entity uaddsub32_Operator;

architecture Struct of uaddsub32_Operator is
   signal pipeline_stall: std_logic;
   signal out_rdy_sig: std_logic;
   signal start_req, start_ack, fin_req, fin_ack: std_logic;
   signal tag_in, tag_out: std_logic_vector(0 downto 0);

begin
   tag_in(0) <= '0';

   p2l: Sample_Pulse_To_Level_Translate_Entity
		generic map(name => "uaddsub32-Operator-p2l")
		port map (rL => sample_req, rR => start_req,
				aL => sample_ack, aR => start_ack,
					clk => clk, reset => reset);
   l2p: Level_To_Pulse_Translate_Entity
		generic map(name => "uaddsub32-Operator-l2p")
		port map (rL => fin_req, rR => update_req,
				aL => fin_ack, aR => update_ack, clk => clk, reset => reset);
				

   pipeline_stall <= fin_ack and (not fin_req);
   start_ack <= not pipeline_stall;

   shift_inst: UnsignedAdderSubtractor_n_n_n
		generic map( name => "uaddsub32-adder",
				tag_width => 1,
				operand_width => 32,
				chunk_width => 8)
		port map(slv_L => L,  slv_R => R, 
				slv_RESULT => ret_val_x_x,
				slv_carry_in => carry_in(0),
				slv_carry_out => carry_out(0),
				subtract_op => subtract_flag(0),
				clk => clk, reset => reset,
				tag_in => tag_in , tag_out => tag_out,
				stall => pipeline_stall,
				in_rdy => start_req, out_rdy => fin_ack);
			
end Struct;

library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.BaseComponents.all;
use ahir.ApIntComponents.all;

entity uaddsub32 is -- 
    generic (tag_length : integer);
    port ( -- 
      L : in  std_logic_vector(31 downto 0);
      R : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      carry_in: in std_logic_vector(0 downto 0);
      carry_out: out std_logic_vector(0 downto 0);
      subtract_flag: in std_logic_vector(0 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
end entity uaddsub32;

architecture Struct of uaddsub32 is
   signal pipeline_stall: std_logic;
   signal out_rdy_sig: std_logic;
begin
   pipeline_stall <= out_rdy_sig and (not fin_req);
   start_ack <= not pipeline_stall;
   fin_ack <= out_rdy_sig;

   shift_inst: UnsignedAdderSubtractor_n_n_n
		generic map( name => "uaddsub32-adder",
				tag_width => tag_length,
				operand_width => 32,
				chunk_width => 8)
		port map(slv_L => L,  slv_R => R, 
				slv_RESULT => ret_val_x_x,
				slv_carry_in => carry_in(0),
				slv_carry_out => carry_out(0),
				subtract_op => subtract_flag(0),
				clk => clk, reset => reset,
				tag_in => tag_in , tag_out => tag_out,
				stall => pipeline_stall,
				in_rdy => start_req, out_rdy => out_rdy_sig);
			
end Struct;

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

   p2l: Sample_Pulse_To_Level_Translate_Entity
		generic map(name => "umul32_Operator_p2l")
		port map (rL => sample_req, rR => start_req,
				aL => sample_ack, aR => start_ack,
					clk => clk, reset => reset);
   l2p: Level_To_Pulse_Translate_Entity
		generic map(name => "umul32_Operator_l2p")
		port map (rL => fin_req, rR => update_req,
				aL => fin_ack, aR => update_ack, clk => clk, reset => reset);
				
   in_data <= L & R; -- concatenate..

   mul_inst: GenericApIntArithOperator
		generic map(op_id => "ApIntMul",
				name => "umul32-Operator-mul",
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

library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.BaseComponents.all;
use ahir.ApIntComponents.all;


entity ushift32_Operator is -- 
    port ( -- 
      L : in  std_logic_vector(31 downto 0);
      R : in  std_logic_vector(31 downto 0);
      shift_right_flag: in std_logic_vector(0 downto 0);
      signed_flag: in std_logic_vector(0 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      sample_req : in Boolean;
      sample_ack : out Boolean;
      update_req : in Boolean;
      update_ack   : out Boolean
    );
end entity ushift32_Operator;

architecture Struct of ushift32_Operator is
   signal pipeline_stall: std_logic;
   signal out_rdy_sig: std_logic;

   signal start_req, start_ack, fin_req, fin_ack: std_logic;
   signal tag_in, tag_out: std_logic_vector(0 downto 0);
begin

   tag_in(0) <= '0';

   p2l: Sample_Pulse_To_Level_Translate_Entity
		generic map (name => "ushift32_Operator_p2l")
		port map (rL => sample_req, rR => start_req,
				aL => sample_ack, aR => start_ack,
					clk => clk, reset => reset);
   l2p: Level_To_Pulse_Translate_Entity
		generic map (name => "ushift32_Operator_l2p")
		port map (rL => fin_req, rR => update_req,
				aL => fin_ack, aR => update_ack, clk => clk, reset => reset);
				
   pipeline_stall <= fin_ack and (not fin_req);
   start_ack <= not pipeline_stall;

   shift_inst: UnsignedShifter_n_n_n
		generic map( name => "ushift32-shifter",
				tag_width => 1,
				operand_width => 32,
				shift_amount_width => 32)
		port map(slv_L => L,  slv_R => R, 
				slv_RESULT => ret_val_x_x,
				clk => clk, reset => reset,
				shift_right_flag => shift_right_flag(0),
				signed_flag => signed_flag(0),		
				tag_in => tag_in , tag_out => tag_out,
				stall => pipeline_stall,
				in_rdy => start_req, out_rdy => fin_ack);
			
end Struct;

library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.BaseComponents.all;
use ahir.ApIntComponents.all;


entity ushift32 is -- 
    generic (tag_length : integer);
    port ( -- 
      L : in  std_logic_vector(31 downto 0);
      R : in  std_logic_vector(31 downto 0);
      shift_right_flag: in std_logic_vector(0 downto 0);
      signed_flag: in std_logic_vector(0 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
end entity ushift32;

architecture Struct of ushift32 is
   signal pipeline_stall: std_logic;
   signal out_rdy_sig: std_logic;
begin
   pipeline_stall <= out_rdy_sig and (not fin_req);
   start_ack <= not pipeline_stall;
   fin_ack <= out_rdy_sig;

   shift_inst: UnsignedShifter_n_n_n
		generic map( name => "ushift32-shifter",
				tag_width => tag_length,
				operand_width => 32,
				shift_amount_width => 32)
		port map(slv_L => L,  slv_R => R, 
				slv_RESULT => ret_val_x_x,
				clk => clk, reset => reset,
				shift_right_flag => shift_right_flag(0),
				signed_flag => signed_flag(0),		
				tag_in => tag_in , tag_out => tag_out,
				stall => pipeline_stall,
				in_rdy => start_req, out_rdy => out_rdy_sig);
			
end Struct;

