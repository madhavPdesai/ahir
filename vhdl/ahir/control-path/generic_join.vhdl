library ieee;
use ieee.std_logic_1164.all;
library ahir;

use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;
use ahir.utilities.all;

entity generic_join is
  generic(name: string; place_capacities: IntegerArray; place_markings: IntegerArray; place_delays: IntegerArray);
  port ( preds      : in   BooleanArray;
    	symbol_out : out  boolean;
	clk: in std_logic;
	reset: in std_logic);
end generic_join;

architecture default_arch of generic_join is
  signal symbol_out_sig : BooleanArray(0 downto 0);
  signal place_sigs: BooleanArray(1 to preds'length);
  constant pmarkings : IntegerArray(1 to preds'length) := place_markings;
  constant pcapacities: IntegerArray(1 to preds'length) := place_capacities;
  constant pdelays: IntegerArray(1 to preds'length) := place_delays;
  alias ppreds : BooleanArray(1 to preds'length) is preds;
begin  -- default_arch

  assert ((preds'length = place_capacities'length) and (place_capacities'length = place_delays'length)
		and (place_delays'length = place_markings'length) )
	report "Mismatch in lengths of marking/capacity arrays." severity failure;
  
  placegen: for I in 1 to pmarkings'length generate
    placeBlock: block
	signal place_pred: BooleanArray(0 downto 0);
    begin
      dly: control_delay_element generic map(delay_value => pdelays(I))
                   port map(req => ppreds(I), ack => place_pred(0), clk => clk, reset => reset);
      pI: place_with_bypass
        generic map(capacity => pcapacities(I),
                    marking => pmarkings(I),
                    name => name & ":(bypass):" & Convert_To_String(I) )
		port map(place_pred,symbol_out_sig,place_sigs(I),clk,reset);
    end block;
  end generate placegen;

  -- The transition is enabled only when all preds are true.
  symbol_out_sig(0) <= AndReduce(place_sigs);
  symbol_out <= symbol_out_sig(0);

end default_arch;
