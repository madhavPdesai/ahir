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
use ahir.Types.all;	
use ahir.Subprograms.all;	
use ahir.mem_function_pack.all;
use ahir.memory_subsystem_package.all;

use ahir.MemCutsPackage.all;
use ahir.mem_ASIC_components.all;

library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;

entity dpmem_column is
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
end entity dpmem_column;


architecture struct of dpmem_column is

  --finding the number of row-replications in the column being build
  constant n_rows: integer := 2**(Maximum(0, g_addr_width - g_base_bank_addr_width));
  type WordArray is array  ( natural range <> ) of std_logic_vector (g_base_bank_addr_width-1 downto 0);

  --fixing the size of address to maximum of addr_width, cut_width
  constant resized_addr_width: integer := Maximum (g_addr_width, g_base_bank_addr_width);
  
  signal resized_addrin_0: std_logic_vector(resized_addr_width-1 downto 0);  
  signal resized_addrin_1: std_logic_vector(resized_addr_width-1 downto 0);  

  signal ZZZ_1 : std_logic;

begin

  ZZZ_1 <= '0';
  
  process (addrin_0, addrin_1)
	begin 
		resized_addrin_0 <= (others => '0');
		resized_addrin_1 <= (others => '0');
		resized_addrin_0(addrin_0'length-1 downto 0) <= addrin_0;
		resized_addrin_1(addrin_1'length-1 downto 0) <= addrin_1;
  end process;
	
  -- if only one cut is required to satisfy the address width
  n_rows_1: if (n_rows = 1) generate
	row_1_blk: block
	  signal enb_0 : std_logic;
	  signal enb_1: std_logic;
	begin 
	  process (enable_0, reset, clk)
	    begin
		enb_0 <= not (enable_0 and not(reset));
 	  end process;
	  process (enable_1, reset, clk)
	    begin 
		enb_1 <= not (enable_1 and not(reset));
	  end process;
 
	  mem_inst: dpmem_selector generic map (address_width => g_base_bank_addr_width,
				data_width => g_base_bank_data_width )
		port map(A1 => resized_addrin_0 (g_base_bank_addr_width-1 downto 0),
			A2 => resized_addrin_1 (g_base_bank_addr_width-1 downto 0),
			CE1 => clk,
			CE2 => clk,
			WEB1 => writebar_0,
			WEB2 => writebar_1,
			OEB1 => ZZZ_1,
			OEB2 => ZZZ_1,
			CSB1 => enb_0,
			CSB2 => enb_1,
			I1 => datain_0,
			I2 => datain_1,
			O1 => dataout_0,
			O2 => dataout_1 );
	end block row_1_blk;
  end generate n_rows_1;
	
  --if more than one cuts are required to satisfy the address width
  n_rows_gt_1: if (n_rows > 1) generate
	row_gt_1_blk: block
	  signal decoded_CS_0, decoded_CS_0_d: std_logic_vector(n_rows-1 downto 0):= (others=>'1');
	  signal decoded_CS_1, decoded_CS_1_d: std_logic_vector(n_rows-1 downto 0):= (others=>'1');
	  
  	   signal dataout_array_0 : WordArray(n_rows-1 downto 0);
  	   signal dataout_array_1 : WordArray(n_rows-1 downto 0);
	  --chipselect is made low only when enable is high and reset is low.
	  --memory will not be read or written when enable is low.
	begin
	  process(addrin_0, enable_0, clk, reset)
	  	variable decoded_CS_0_var: std_logic_vector(2**Maximum(0, g_addr_width-g_base_bank_addr_width)-1 downto 0):= (others=>'1');
	    begin
		if (enable_0 = '1' and reset = '0') then
		  decoded_CS_0_var := MemDecoder(resized_addrin_0(resized_addr_width-1
		  downto resized_addr_width - Ceil_log2(n_rows)));
		else 
		  decoded_CS_0_var := (others=>'1');
		end if;
		
		decoded_CS_0 <= decoded_CS_0_var;
		if(clk'event and clk = '1') then
			decoded_CS_0_d <= decoded_CS_0_var;
	 	end if;

	  end process;
	  
	  process(addrin_1, enable_1, clk, reset)
	  	variable decoded_CS_1_var: std_logic_vector(2**Maximum(0, g_addr_width-g_base_bank_addr_width)-1 downto 0):= (others=>'1');
	    begin
		if (enable_1 = '1' and reset = '0') then
		  decoded_CS_1_var := MemDecoder(resized_addrin_1(resized_addr_width-1
		  downto resized_addr_width - Ceil_log2(n_rows)));
		else 
		  decoded_CS_1_var := (others=>'1');
		end if;
		decoded_CS_1 <= decoded_CS_1_var;
		if(clk'event and clk = '1') then
			decoded_CS_1_d <= decoded_CS_1_var;
	 	end if;
	  end process;

	  row_gen: for j in 0 to n_rows-1 generate
		mem_inst: dpmem_selector generic map(address_width => g_base_bank_addr_width,
					data_width => g_base_bank_data_width )
			port map(A1 => resized_addrin_0 (g_base_bank_addr_width-1 downto 0),
			A2 => resized_addrin_1 (g_base_bank_addr_width-1 downto 0),
			CE1 => clk,
			CE2 => clk,
			WEB1 => writebar_0,
			WEB2 => writebar_1,
			OEB1 => ZZZ_1,
			OEB2 => ZZZ_1,
			CSB1 => decoded_CS_0(j),
			CSB2 => decoded_CS_1(j),
			I1 => datain_0,
			I2 => datain_1,
			O1 => dataout_array_0(j),
			O2 => dataout_array_1(j) );
	  end generate row_gen;

	-- muxes.
          process(dataout_array_0, decoded_CS_0_d)
		variable sel_data_var: std_logic_vector(g_base_bank_data_width-1 downto 0);
	  begin
		sel_data_var := (others => '0');
		for I in 0 to n_rows-1 loop
			if(decoded_CS_0_d(I) = '1') then
				sel_data_var := dataout_array_0(I);
			end if;
		end loop;
		dataout_0 <= sel_data_var;
	  end process;
          process(dataout_array_1, decoded_CS_1_d)
		variable sel_data_var: std_logic_vector(g_base_bank_data_width-1 downto 0);
	  begin
		sel_data_var := (others => '0');
		for I in 0 to n_rows-1 loop
			if(decoded_CS_1_d(I) = '1') then
				sel_data_var := dataout_array_1(I);
			end if;
		end loop;
		dataout_1 <= sel_data_var;
	  end process;
	end block;
  end generate n_rows_gt_1;
end struct;
