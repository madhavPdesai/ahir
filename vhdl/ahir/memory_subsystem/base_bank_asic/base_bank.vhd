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
-- modified base-bank implementation by Kalyani
-------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;	
use ahir.Types.all;	
use ahir.Subprograms.all;	
use ahir.mem_function_pack.all;
use ahir.memory_subsystem_package.all;

library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;

library ahir;
use work.MemCutsPackage.all;
use work.mem_ASIC_components.all;

entity base_bank is
   generic ( name: string:="mem"; g_addr_width: natural := 5; 
	     g_data_width : natural := 20);
   port (datain : in std_logic_vector(g_data_width-1 downto 0);
         dataout: out std_logic_vector(g_data_width-1 downto 0);
         addrin: in std_logic_vector(g_addr_width-1 downto 0);
         enable: in std_logic;
         writebar : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end entity base_bank;


architecture struct of base_bank is

  -- n_cols contains the required number of columns of available memory cuts
  -- to build the given memory 
  constant n_cols: IntegerArray(1 to 4) := find_n_cols(spmem_cut_address_widths, spmem_cut_data_widths, spmem_cut_row_heights, g_addr_width, g_data_width);

  --total_data_width is the size of the resized data 
  constant total_data_width: integer := find_data_width(spmem_cut_data_widths, n_cols);

  --resized data and addresses
  signal resized_datain: std_logic_vector(total_data_width-1 downto 0);
  signal resized_dataout: std_logic_vector(total_data_width-1 downto 0);

begin

  process (datain)
  begin
	resized_datain <= (others=>'0');
	resized_datain(datain'length-1 downto 0) <= datain;
  end process;

  mem_gen: for i in 1 to spmem_cut_address_widths'length generate -- loop to cover all the cuts
	gen_cols: for j in 0 to n_cols(i)-1 generate -- generate if it's no.of columns 								     -- to be used >=1
		inst: spmem_column generic map ( name => "row_gen",
			g_addr_width => g_addr_width,
			g_base_bank_addr_width => spmem_cut_address_widths(i), 
			g_base_bank_data_width => spmem_cut_data_widths(i))
			port map ( datain => resized_datain((j+1)*spmem_cut_data_widths(i)
				+ col_index(spmem_cut_data_widths, n_cols, i-1)-1 downto j*spmem_cut_data_widths(i)
				+ col_index(spmem_cut_data_widths, n_cols, i-1)), 
				
				dataout => resized_dataout((j+1)*spmem_cut_data_widths(i)
				+ col_index(spmem_cut_data_widths, n_cols,i-1)-1 downto j*spmem_cut_data_widths(i) 
				+ col_index(spmem_cut_data_widths, n_cols, i-1)),
       				
				addrin => addrin,
       				enable => enable,
         			writebar => writebar,
       				clk => clk,
         			reset => reset);

	end generate gen_cols;
  end generate mem_gen;		

  process (resized_dataout)
  begin
	dataout <= resized_dataout(dataout'length-1 downto 0);
  end process;
end struct;
