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

package mem_ASIC_components is

component SPRAM_GENERIC
	generic (address_width: integer := 4; data_width: integer := 4);
	port(A : in std_logic_vector(address_width-1 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(data_width-1 downto 0);
	O  : out std_logic_vector(data_width-1 downto 0));
end component;

component SPRAM_16x4
	port(A : in std_logic_vector(3 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(3 downto 0);
	O  : out std_logic_vector(3 downto 0));
end component;

component SPRAM_32_16
	port(A : in std_logic_vector(4 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;	
	CSB: in std_logic;
	I  : in std_logic_vector(15 downto 0);
	O  : out std_logic_vector(15 downto 0));
end component;

component obc11_256x8
	port(A : in std_logic_vector(7 downto 0 );
	CEB : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(7 downto 0);
	O  : out std_logic_vector(7 downto 0));
end component;

component SPRAM_512x24
port(A : in std_logic_vector(8 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(23 downto 0);
	O  : out std_logic_vector(23 downto 0));
end component;

component DPRAM_GENERIC
	generic (address_width: integer := 4; data_width: integer := 4);
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
end component;

component DPRAM_16x4
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
end component;

component obc11_dpram_16x8
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
end component;

component DPRAM_32x8
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
end component;

component spmem_selector is
	generic(address_width: integer:=8; data_width: integer:=8);
	port (A : in std_logic_vector(address_width-1 downto 0 );
	CE : in std_logic;
	WEB: in std_logic;
	OEB: in std_logic;
	CSB: in std_logic;
	I  : in std_logic_vector(data_width-1 downto 0);
	O  : out std_logic_vector(data_width-1 downto 0));
end component spmem_selector;

component dpmem_selector is
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
end component dpmem_selector;

component spmem_column is
	generic ( name: string:= "mem"; 
		g_addr_width: natural := 4;
		g_base_bank_addr_width:natural := 4; 
		g_base_bank_data_width : natural := 4);

	port (datain : in std_logic_vector(g_base_bank_data_width-1 downto 0);
		dataout: out std_logic_vector(g_base_bank_data_width-1 downto 0);
		addrin: in std_logic_vector(g_addr_width-1 downto 0);
		enable: in std_logic;
		writebar : in std_logic;
		clk: in std_logic;
		reset : in std_logic);
end component spmem_column;

component dpmem_column is
   generic ( name: string:="DPRAM_16x4"; 
	g_addr_width: natural := 2;
	g_base_bank_addr_width: natural:=4; 
	g_base_bank_data_width : natural := 4);
   port (datain_0 : in std_logic_vector(g_base_bank_data_width-1 downto 0);
         dataout_0: out std_logic_vector(g_base_bank_data_width-1 downto 0);
         addrin_0: in std_logic_vector(g_addr_width-1 downto 0);
         enable_0: in std_logic;
         writebar_0 : in std_logic;
	 datain_1 : in std_logic_vector(g_base_bank_data_width-1 downto 0);
         dataout_1: out std_logic_vector(g_base_bank_data_width-1 downto 0);
         addrin_1: in std_logic_vector(g_addr_width-1 downto 0);
         enable_1: in std_logic;
         writebar_1 : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end component dpmem_column;

end package;
