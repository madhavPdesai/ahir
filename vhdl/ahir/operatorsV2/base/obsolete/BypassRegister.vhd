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

entity BypassRegister is
  generic(data_width: integer; enable_bypass: boolean := false); 
  port (
    clk, reset : in  std_logic;
    enable     : in  std_logic;
    data_in     : in  std_logic_vector(data_width-1 downto 0);
    data_out    : out std_logic_vector(data_width-1 downto 0));
end BypassRegister;

architecture behave of BypassRegister is
  constant datazero : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal data_reg: std_logic_vector(data_width-1 downto 0);
begin  -- behave

  process (clk, reset)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      if reset = '1' then
	data_reg <= datazero;
      elsif enable = '1' then
        data_reg <= data_in;
      end if;
    end if;
  end process;

  Bypass: if enable_bypass generate
    data_out <= data_in when enable = '1' else data_reg;    
  end generate Bypass;

  NoBypass: if not enable_bypass generate
    data_out <= data_reg;
  end generate NoBypass;

end behave;
