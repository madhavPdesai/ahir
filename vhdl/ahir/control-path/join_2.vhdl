library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;

entity join2 is
  generic(bypass : boolean := false);
  port ( pred0, pred1      : in   Boolean;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end join2;

architecture default_arch of join2 is
  signal preds: BooleanArray(1 downto 0);
begin  -- default_arch

  preds <= pred0 & pred1;
  baseJoin : join
    generic map(bypass => bypass)
    port map (preds => preds,
              symbol_out => symbol_out,
              clk => clk,
              reset => reset);

end default_arch;
