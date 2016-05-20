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

