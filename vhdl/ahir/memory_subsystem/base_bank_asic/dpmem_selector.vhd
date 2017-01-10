------------------------------------------------------------------------------------------------
--
-- Copyright (C) 2010-: Madhav P. Desai, Ch. V. Kalyani
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
--------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use work.mem_ASIC_components.all;

-- Entity to instantiate different available memory cuts based on the 
-- address_width and data_width generics passed.
entity dpmem_selector is
	generic(address_width: integer:=8; data_width: integer:=8);
	port (A1 : in std_logic_vector(address_width-1 downto 0 );
	A2 : in std_logic_vector(address_width-1 downto 0 );
	CE1 : in std_logic;
	CE2 : in std_logic;
	WEB1: in std_logic;
	WEB2: in std_logic;
	OEB1: in std_logic;
	OEB2: in std_logic;
	CSB1: in std_logic;
	CSB2: in std_logic;
	I1  : in std_logic_vector(data_width-1 downto 0);
	I2  : in std_logic_vector(data_width-1 downto 0);
	O1  : out std_logic_vector(data_width-1 downto 0);
	O2  : out std_logic_vector(data_width-1 downto 0));
end entity dpmem_selector;

architecture behave of dpmem_selector is

begin

  c1: if (address_width = 4 and data_width = 4) generate 
	u1: DPRAM_16x4 port map(A1, A2, CE1, CE2, WEB1, WEB2, OEB1, OEB2, CSB1, CSB2, I1, I2, O1, O2);
	end generate;

  c2: if (address_width = 4 and data_width = 8) generate 
	u1: obc11_dpram_16x8 port map(A1, A2, CE1, CE2, WEB1, WEB2, OEB1, OEB2, CSB1, CSB2, I1, I2, O1, O2);
	end generate;

  c3: if (address_width = 5 and data_width = 8) generate
	u1: DPRAM_32x8 port map(A1, A2, CE1, CE2, WEB1, WEB2, OEB1, OEB2, CSB1, CSB2, I1, I2, O1, O2);
	end generate;

end behave;
