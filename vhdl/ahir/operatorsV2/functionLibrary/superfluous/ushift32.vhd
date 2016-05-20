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

