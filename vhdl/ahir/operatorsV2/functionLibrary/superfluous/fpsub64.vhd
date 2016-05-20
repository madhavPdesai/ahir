library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.BaseComponents.all;

library aHiR_ieee_proposed;
use aHiR_ieee_proposed.float_pkg.all;
use aHiR_ieee_proposed.math_utility_pkg.all;


entity fpsub64 is -- 
    generic (tag_length : integer);
    port ( -- 
      L : in  std_logic_vector(63 downto 0);
      R : in  std_logic_vector(63 downto 0);
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
end entity fpsub64;

architecture Struct of fpsub64 is
begin

   mul: GenericFloatingPointAdderSubtractor
		generic map(tag_width => tag_length,
				exponent_width => 11,
				fraction_width => 52,
                   		round_style => round_nearest,
                   		addguard => 3,
                   		check_error => true,
                   		denormalize => true,
				use_as_subtractor => true)
		port map(INA => L, INB => R,
				OUTADD => ret_val_x_x,
				clk => clk, reset => reset,
				tag_in => tag_in , tag_out => tag_out,
				env_rdy => start_req, accept_rdy => fin_req,
				addi_rdy => start_ack, addo_rdy => fin_ack);
			
end Struct;

