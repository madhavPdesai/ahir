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
-- modified base-bank dual-port implementation by Kalyani
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
use ahir.MemCutsPackage.all;
use ahir.mem_ASIC_components.all;

entity base_bank_dual_port is
   generic ( name: string; g_addr_width: natural := 10; g_data_width : natural := 16);
   port (
	 datain_0 : in std_logic_vector(g_data_width-1 downto 0);
         dataout_0: out std_logic_vector(g_data_width-1 downto 0);
         addrin_0: in std_logic_vector(g_addr_width-1 downto 0);
         enable_0: in std_logic;
         writebar_0 : in std_logic;
	 datain_1 : in std_logic_vector(g_data_width-1 downto 0);
         dataout_1: out std_logic_vector(g_data_width-1 downto 0);
         addrin_1: in std_logic_vector(g_addr_width-1 downto 0);
         enable_1: in std_logic;
         writebar_1 : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end entity base_bank_dual_port;

architecture struct of base_bank_dual_port is 

  -- n_cols contains the required number of columns of available memory cuts
  -- to build the given memory 
  constant n_cols: IntegerArray(1 to 3) := find_n_cols(dpmem_cut_address_widths, dpmem_cut_data_widths, dpmem_cut_row_heights, g_addr_width, g_data_width);

  --total_data_width is the size of the resized data 
  constant total_data_width: integer := find_data_width(dpmem_cut_data_widths, n_cols);

  --resized data and addresses
  signal resized_datain_0: std_logic_vector(total_data_width-1 downto 0);
  signal resized_dataout_0: std_logic_vector(total_data_width-1 downto 0);
  signal resized_datain_1: std_logic_vector(total_data_width-1 downto 0);
  signal resized_dataout_1: std_logic_vector(total_data_width-1 downto 0);

  signal latch_dataout_0, latch_dataout_1: std_logic;
  signal dataout_reg_0, dataout_reg_1: std_logic_vector(g_data_width-1 downto 0);

begin

  process(clk, reset)
  begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			latch_dataout_0 <= '0';
			latch_dataout_1 <= '0';
		else
			latch_dataout_0 <= enable_0 and writebar_0;
			latch_dataout_1 <= enable_1 and writebar_1;
		end if;
	end if;
  end process;

  process (datain_0)
  begin
	resized_datain_0 <= (others=>'0');
	resized_datain_0(datain_0'length-1 downto 0) <= datain_0;
  end process;
  
  process (datain_1)
  begin
	resized_datain_1 <= (others=>'0');
	resized_datain_1(datain_1'length-1 downto 0) <= datain_1;
  end process;

  mem_gen: for i in 1 to dpmem_cut_address_widths'length generate -- loop to cover all the cuts
	gen_cols: for j in 0 to n_cols(i)-1 generate -- generate if it's no.of columns 								     -- to be used >=1
		inst: dpmem_column generic map ( name => "col_gen",
				g_addr_width => g_addr_width,
				g_base_bank_addr_width => dpmem_cut_address_widths(i), 
				g_base_bank_data_width => dpmem_cut_data_widths(i))
			
			port map ( datain_0 => resized_datain_0((j+1)*dpmem_cut_data_widths(i)
				+ col_index(dpmem_cut_data_widths, n_cols, i-1)-1 downto j*dpmem_cut_data_widths(i)
				+ col_index(dpmem_cut_data_widths, n_cols, i-1)), 
				
				dataout_0 => resized_dataout_0((j+1)*dpmem_cut_data_widths(i)
				+ col_index(dpmem_cut_data_widths, n_cols, i-1)-1 downto j*dpmem_cut_data_widths(i)
				+ col_index(dpmem_cut_data_widths, n_cols, i-1)),
				
				addrin_0 => addrin_0,
       				enable_0 => enable_0,
         			writebar_0 => writebar_0,
			
				datain_1 => resized_datain_1((j+1)*dpmem_cut_data_widths(i)
				+ col_index(dpmem_cut_data_widths, n_cols, i-1)-1 downto j*dpmem_cut_data_widths(i)
				+ col_index(dpmem_cut_data_widths, n_cols, i-1)), 
				
				dataout_1 => resized_dataout_1((j+1)*dpmem_cut_data_widths(i)
				+ col_index(dpmem_cut_data_widths, n_cols,i-1)-1 downto j*dpmem_cut_data_widths(i)
				+ col_index(dpmem_cut_data_widths, n_cols, i-1)),
       				
				addrin_1 => addrin_1,
       				enable_1 => enable_1,
         			writebar_1 => writebar_1,
       				clk => clk,
         			reset => reset);

	end generate gen_cols;
  end generate mem_gen;		

  process (clk, latch_dataout_0, resized_dataout_0, latch_dataout_1, resized_dataout_1)
  begin
	if(clk'event and clk = '1') then
		if(latch_dataout_0 = '1') then
			dataout_reg_0 <= resized_dataout_0(dataout_0'length-1 downto 0);
		end if;
		if(latch_dataout_1 = '1') then
			dataout_reg_1 <= resized_dataout_1(dataout_1'length-1 downto 0);
		end if;
	end if;
  end process;
  dataout_0 <= dataout_reg_0 when (latch_dataout_0 = '0') else resized_dataout_0(dataout_0'length-1 downto 0);
  dataout_1 <= dataout_reg_1 when (latch_dataout_1 = '0') else resized_dataout_1(dataout_1'length-1 downto 0);


end struct;
