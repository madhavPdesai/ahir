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

entity spmem_column is
   generic ( name: string:="SPRAM_16x4"; 
	g_addr_width: natural := 2;
	g_base_bank_addr_width: natural:=4; 
	g_base_bank_data_width : natural := 4);
   port (datain : in std_logic_vector(g_base_bank_data_width-1 downto 0);
         dataout: out std_logic_vector(g_base_bank_data_width-1 downto 0);
         addrin: in std_logic_vector(g_addr_width-1 downto 0);
         enable: in std_logic;
         writebar : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end entity spmem_column;


architecture struct of spmem_column is

--finding the number of row-replications in the column being build
  constant n_rows: integer := 2**(Maximum(0, g_addr_width-g_base_bank_addr_width));

--fixing the size of address to maximum of addr_width, cut_width
  constant resized_addr_width: integer := Maximum(g_addr_width, g_base_bank_addr_width);
  signal resized_addrin: std_logic_vector(resized_addr_width-1 downto 0);  
  type WordArray is array  ( natural range <> ) of std_logic_vector (g_base_bank_addr_width-1 downto 0);
  signal ZZZ_1 : std_logic := '0';

begin
  process (addrin)
	begin 
		resized_addrin <= (others => '0');
		resized_addrin(addrin'length-1 downto 0) <= addrin;
  end process;
	
  -- if only one cut is required to satisfy the address width
  n_rows_1: if (n_rows = 1) generate
	row_1_blk: block
	  signal enb: std_logic := '1';
	begin 
	  process(enable, reset)
	    begin
		enb <= not (enable and not(reset));
 	  end process;
	  mem_inst: spmem_selector generic map (address_width => g_base_bank_addr_width,
				data_width => g_base_bank_data_width )
		port map(A => resized_addrin(g_base_bank_addr_width-1 downto 0),
			CE => clk,
			WEB => writebar,
			OEB => ZZZ_1,
			CSB => enb,
			I => datain,
			O => dataout );
	end block row_1_blk;
  end generate n_rows_1;
	
  --if more than one cuts are required to satisfy the address width
  n_rows_gt_1: if (n_rows > 1) generate
	row_gt_1_blk: block
	  
  	   signal decoded_CS, decoded_CS_d: std_logic_vector(nrows-1 downto 0):= (others=>'1');
  	   signal dataout_array : WordArray(n_rows-1 downto 0);

	  --chipselect is made low only when enable is high and reset is low.
	  --memory will not be read or written when enable is low.
	begin
	  process(addrin, enable, clk, reset)
	     variable decoded_CS_var: std_logic_vector(2**Maximum(0, g_addr_width-g_base_bank_addr_width)-1 downto 0):= (others=>'1');
	    begin
		if (enable = '1' and reset = '0') then
		  decoded_CS_var := MemDecoder(resized_addrin(resized_addr_width-1
		  downto resized_addr_width-Ceil_log2(n_rows)));
		else 
		  decoded_CS_var :=(others=>'1');
		end if;

		decoded_CS <= decoded_CS_var;
		if(clk'event and clk = '1') then
			decoded_CS_d <= decoded_CS_var;
		end if;
	  end process;
	  row_gen: for j in 0 to n_rows-1 generate
		mem_inst: spmem_selector generic map(address_width => g_base_bank_addr_width,
					data_width => g_base_bank_data_width )
			port map(A => resized_addrin(g_base_bank_addr_width-1 downto 0),
				CE => clk,
				WEB => writebar,
				OEB => ZZZ_1,
				CSB => decoded_CS(j),
				I => datain,
				O => dataout_array(j));
	  end generate row_gen;

  	  -- mux.
          process(data_out_array, decoded_CS_d)
		variable sel_data_var: std_logic_vector(g_base_bank_data_width-1 downto 0);
	  begin
		sel_data_var := (others => '0');
		for I in 0 to n_rows-1 loop
			if(decoded_CS_d(I) = '1') then
				sel_data_var := dataout_array(I);
			end if;
		end loop;
		dataout <= sel_data_var;
	  end process;
	end block;
  end generate n_rows_gt_1;
  
end struct;
