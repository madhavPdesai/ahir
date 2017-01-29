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

entity DPRAM_GENERIC is
	generic (address_width: integer := 5; data_width: integer := 3);
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
end entity;


architecture XilinxBramInfer of DPRAM_GENERIC is
  type MemArray is array (natural range <>) of std_logic_vector(data_width-1 downto 0);
  signal mem_array : MemArray((2**address_width)-1 downto 0) := (others => (others => '0'));
  signal addr_reg_0 : std_logic_vector(address_width-1 downto 0);
  signal rd_enable_reg_0 : std_logic;
  signal addr_reg_1 : std_logic_vector(address_width-1 downto 0);
  signal rd_enable_reg_1 : std_logic;
  signal dataout_0, dataout_1 : std_logic_vector(data_width-1 downto 0);
begin  -- XilinxBramInfer

  -- read/write process
  process(CE1, A1, CSB1, WEB1, A2, CSB2, WEB2)
  begin

    -- synch read-write memory
    if(CE1'event and CE1 ='1') then

      -- register the address
      -- and use it in a separate assignment
      -- for the delayed read.
      addr_reg_0 <= A1;
      addr_reg_1 <= A2;

	-- generate a registered read enable
	rd_enable_reg_0 <= not(CSB1) and WEB1;
	rd_enable_reg_1 <= not(CSB2) and WEB2;

      -- both ports write.. second one wins if writes
      -- are to the same address.
      if(CSB1 = '0' and WEB1 = '0') then
        mem_array(To_Integer(unsigned(A1))) <= I1;
      end if;
      if(CSB2 = '0' and WEB2 = '0') then
        mem_array(To_Integer(unsigned(A2))) <= I2;
      end if;
    end if;
  end process;
      	
  -- use the registered read enable with the registered address to 
  -- describe the read
  dataout_0 <= mem_array(To_Integer(unsigned(addr_reg_0)));
  dataout_1 <= mem_array(To_Integer(unsigned(addr_reg_1)));

  O1 <= dataout_0 when (OEB1 = '0') else (others => 'Z');
  O2 <= dataout_1 when (OEB2 = '0') else (others => 'Z');
  
end XilinxBramInfer;
