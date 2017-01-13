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
library ahir;
use ahir.mem_ASIC_components.all;
 
entity SPRAM_16x4 is
	port(A : in std_logic_vector(3 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(3 downto 0);
	O  : out std_logic_vector(3 downto 0));
end entity;

architecture struct of SPRAM_16x4 is
begin 
  
  inst: SPRAM_GENERIC generic map(address_width => 4, data_width => 4)
			port map(A, CE, WEB, OEB, CSB, I, O);
end struct;

library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.mem_ASIC_components.all;

entity SPRAM_32_16 is
	port(A : in std_logic_vector(4 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;	
	CSB: in std_logic;
	I  : in std_logic_vector(15 downto 0);
	O  : out std_logic_vector(15 downto 0));
end entity;

architecture struct of SPRAM_32_16 is
begin 
  
  inst: SPRAM_GENERIC generic map(address_width => 5, data_width => 16)
			port map(A, CE, WEB, OEB, CSB, I, O);
end struct;

library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.mem_ASIC_components.all;

entity SPRAM_512x24 is
	port(A : in std_logic_vector(8 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(23 downto 0);
	O  : out std_logic_vector(23 downto 0));
end entity;

architecture struct of SPRAM_512x24 is
begin 
  
  inst: SPRAM_GENERIC generic map(address_width => 9, data_width => 24)
			port map(A, CE, WEB, OEB, CSB, I, O);
end struct;

library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.mem_ASIC_components.all;

entity obc11_256x81 is
	port(A : in std_logic_vector(7 downto 0 );
	CEB : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(7 downto 0);
	O  : out std_logic_vector(7 downto 0));
end entity;

architecture struct of obc11_256x81 is
  signal CE: std_logic;
begin 
  
  CE <= not(CEB);
  inst: SPRAM_GENERIC generic map(address_width => 8, data_width => 8)
			port map(A, CE, WEB, OEB, CSB, I, O);
end struct;

library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.mem_ASIC_components.all;

entity DPRAM_16x4 is
	port (A1 : in std_logic_vector(3 downto 0 );
	A2 : in std_logic_vector(3 downto 0 );
	CE1 : in std_logic;
	CE2 : in std_logic;
	WEB1: in std_logic;
	WEB2: in std_logic;
	OEB1: in std_logic;
	OEB2: in std_logic;
	CSB1: in std_logic;
	CSB2: in std_logic;
	I1  : in std_logic_vector(3 downto 0);
	I2  : in std_logic_vector(3 downto 0);
	O1  : out std_logic_vector(3 downto 0);
	O2  : out std_logic_vector(3 downto 0));
end entity;

architecture struct of DPRAM_16x4 is
begin 
  
  inst: DPRAM_GENERIC generic map(address_width => 4, data_width => 4)
		port map(A1, A2, CE1, CE2, WEB1, WEB2, OEB1, OEB2, CSB1, CSB2, I1, I2, O1, O2);
end struct;

library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.mem_ASIC_components.all;

entity DPRAM_32x8 is
	port (A1 : in std_logic_vector(4 downto 0 );
	A2 : in std_logic_vector(4 downto 0 );
	CE1 : in std_logic;
	CE2 : in std_logic;
	WEB1: in std_logic;
	WEB2: in std_logic;
	OEB1: in std_logic;
	OEB2: in std_logic;
	CSB1: in std_logic;
	CSB2: in std_logic;
	I1  : in std_logic_vector(7 downto 0);
	I2  : in std_logic_vector(7 downto 0);
	O1  : out std_logic_vector(7 downto 0);
	O2  : out std_logic_vector(7 downto 0));
end entity;

architecture struct of DPRAM_32x8 is
begin 
  
  inst: DPRAM_GENERIC generic map(address_width => 5, data_width => 8)
		port map(A1, A2, CE1, CE2, WEB1, WEB2, OEB1, OEB2, CSB1, CSB2, I1, I2, O1, O2);
end struct;

library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.mem_ASIC_components.all;

entity obc11_dpram_16x8 is
	port (A1 : in std_logic_vector(3 downto 0 );
	A2 : in std_logic_vector(3 downto 0 );
	CE1 : in std_logic;
	CE2 : in std_logic;
	WEB1: in std_logic;
	WEB2: in std_logic;
	OEB1: in std_logic;
	OEB2: in std_logic;
	CSB1: in std_logic;
	CSB2: in std_logic;
	I1  : in std_logic_vector(7 downto 0);
	I2  : in std_logic_vector(7 downto 0);
	O1  : out std_logic_vector(7 downto 0);
	O2  : out std_logic_vector(7 downto 0));
end entity;

architecture struct of obc11_dpram_16x8 is
begin 
  
  inst: DPRAM_GENERIC generic map(address_width => 4, data_width => 8)
		port map(A1, A2, CE1, CE2, WEB1, WEB2, OEB1, OEB2, CSB1, CSB2, I1, I2, O1, O2);
end struct;

