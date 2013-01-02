library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;

entity pipeline_interlock is
  port (trigger: in boolean;
        enable : in boolean;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end pipeline_interlock;

architecture default_arch of pipeline_interlock is
  signal symbol_out_sig : BooleanArray(0 downto 0);
  signal enable_place_pred : BooleanArray(0 downto 0);
  signal enable_place : Boolean;
  signal trigger_place_pred : BooleanArray(0 downto 0);
  signal trigger_place : Boolean;
  

begin  -- default_arch
  

  trigger_place_pred(0) <= trigger;
  pTrig: place generic map(capacity => 1, marking => 0)
    port map(trigger_place_pred, symbol_out_sig,trigger_place,clk,reset);

  enable_place_pred(0) <= enable;
  pEnable: place generic map(capacity => 1, marking => 1)
    port map(enable_place_pred, symbol_out_sig,enable_place,clk,reset);
  
  symbol_out_sig(0) <= enable_place and trigger_place;
  symbol_out <= symbol_out_sig(0);

end default_arch;
