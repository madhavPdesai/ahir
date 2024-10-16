------------------------------------------------------------------------------------------------
--
-- Copyright (C) 2010-: Madhav P. Desai
-- All Rights Reserved.
--  
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal with the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
-- 
--  * Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimers.
--  * Redistributions in binary form must reproduce the above
--    copyright notice, this list of conditions and the following
--    disclaimers in the documentation and/or other materials provided
--    with the distribution.
--  * Neither the names of the AHIR Team, the Indian Institute of
--    Technology Bombay, nor the names of its contributors may be used
--    to endorse or promote products derived from this Software
--    without specific prior written permission.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
-- ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library ahir;

use ahir.Types.all;
use ahir.subprograms.all;
use ahir.BaseComponents.all;
use ahir.utilities.all;

entity generic_join is
  generic(number_of_predecessors: integer; name: string; place_capacities: IntegerArray; place_markings: IntegerArray; place_delays: IntegerArray);
  port ( preds      : in   BooleanArray(number_of_predecessors-1 downto 0);
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
  
  placegen: for I in 1 to number_of_predecessors generate
    placeBlock: block
	signal place_pred: BooleanArray(0 downto 0);
    begin
      dly: control_delay_element generic map(name => name & "-placegen-dly-" & Convert_To_String(I), delay_value => pdelays(I))
                   port map(req => ppreds(I), ack => place_pred(0), clk => clk, reset => reset);
      pI: place_with_bypass
        generic map(capacity => pcapacities(I),
                    marking => pmarkings(I),
                    name => name & "-placegen-pI-" & Convert_To_String(I) )
		port map(place_pred,symbol_out_sig,place_sigs(I),clk,reset);
    end block;
  end generate placegen;

  -- The transition is enabled only when all preds are true.
  symbol_out_sig(0) <= AndReduce(place_sigs);
  symbol_out <= symbol_out_sig(0);

end default_arch;
