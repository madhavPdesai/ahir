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

------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SPRAM_GENERIC is
	generic (address_width: integer := 4; data_width: integer := 4);
	port(A : in std_logic_vector(address_width-1 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(data_width-1 downto 0);
	O  : out std_logic_vector(data_width-1 downto 0));
end entity;

architecture XilinxBramInfer of SPRAM_GENERIC is
  type MemArray is array (natural range <>) of std_logic_vector(data_width-1 downto 0);
  signal mem_array : MemArray((2**address_width)-1 downto 0) := (others => (others => '0'));
  signal address_reg : std_logic_vector(address_width-1 downto 0);
  signal rd_enable_reg : std_logic;
  signal dataout : std_logic_vector(data_width-1 downto 0);
begin  -- XilinxBramInfer

  -- read/write process
  process(CE, A, CSB, WEB)
  begin

    -- synch read-write memory
    if(CE'event and CE ='1') then

     	-- register the address
	-- and use it in a separate assignment
	-- for the delayed read.
      address_reg <= A;

      rd_enable_reg <= not(CSB) and WEB;

      if(CSB = '0' and WEB = '0') then
        mem_array(To_Integer(unsigned(A))) <= I;
      end if;
    end if;
  end process;
      	
	-- use the registered read enable with the registered address to 
	-- describe the read
  dataout <= mem_array(To_Integer(unsigned(address_reg))) when (rd_enable_reg = '1');

  O <= dataout when (OEB = '0') else (others => 'Z');
end XilinxBramInfer;




