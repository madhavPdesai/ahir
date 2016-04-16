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

   p2l: Pulse_To_Level_Translate_Entity
		port map (rL => sample_req, rR => start_req,
				aL => sample_ack, aR => start_ack,
					clk => clk, reset => reset);
   l2p: Level_To_Pulse_Translate_Entity
		port map (rL => fin_req, rR => update_req,
				aL => fin_ack, aR => update_ack);
				

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

