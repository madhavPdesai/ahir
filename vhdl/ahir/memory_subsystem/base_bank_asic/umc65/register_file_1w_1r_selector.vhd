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
use ahir.mem_ASIC_components.all;

-- Entity to instantiate different available memory cuts based on the 
-- address_width and data_width generics passed.
entity register_file_1w_1r_selector is
	generic(address_width: integer:=8; data_width: integer:=8);
	port (ADDR_0 : in std_logic_vector(address_width-1 downto 0 );
		ADDR_1 : in std_logic_vector(address_width-1 downto 0 );
		ENABLE_0_BAR : in std_logic;
		ENABLE_1_BAR : in std_logic;
		DATAIN_0  : in std_logic_vector(data_width-1 downto 0);
		DATAOUT_1  : out std_logic_vector(data_width-1 downto 0);
		CLK, RESET: in std_logic);
end entity register_file_1w_1r_selector;

architecture StructGen of register_file_1w_1r_selector is
	signal TIE_HIGH, TIE_LOW: std_logic;
        signal TIE_LOW_2, TIE_HIGH_2: std_logic_vector(1 downto 0);
        signal TIE_LOW_3: std_logic_vector(2 downto 0);
        signal TIE_LOW_4: std_logic_vector(3 downto 0);
begin
	TIE_HIGH <= '1';
	TIE_LOW <= '0';
        TIE_LOW_2 <= (others => '0');
        TIE_HIGH_2 <= (others => '1');
	TIE_LOW_3 <= (others => '0');
	TIE_LOW_4 <= (others => '0');
  SZKA65_32X32X1CM2_gen: if (address_width = 5) and (data_width = 32) generate
     mc: block 
            signal DATA_TIE_LOW  : std_logic_vector(31 downto 0); 
            signal DATA_TIE_HIGH : std_logic_vector(31 downto 0); 
            signal ADDR_TIE_LOW  : std_logic_vector(4 downto 0); 
            signal ADDR_TIE_HIGH : std_logic_vector(4 downto 0); 
         begin 
              DATA_TIE_LOW <= (others => '0'); 
              DATA_TIE_HIGH <= (others => '1'); 
              ADDR_TIE_LOW <= (others => '0'); 
              ADDR_TIE_HIGH <= (others => '1'); 
               inst: SZKA65_32X32X1CM2
   port map (       A0 => ADDR_1(0), 
       A1 => ADDR_1(1), 
       A2 => ADDR_1(2), 
       A3 => ADDR_1(3), 
       A4 => ADDR_1(4), 
       B0 => ADDR_0(0), 
       B1 => ADDR_0(1), 
       B2 => ADDR_0(2), 
       B3 => ADDR_0(3), 
       B4 => ADDR_0(4), 
       DI0 => DATAIN_0(0), 
       DI1 => DATAIN_0(1), 
       DI2 => DATAIN_0(2), 
       DI3 => DATAIN_0(3), 
       DI4 => DATAIN_0(4), 
       DI5 => DATAIN_0(5), 
       DI6 => DATAIN_0(6), 
       DI7 => DATAIN_0(7), 
       DI8 => DATAIN_0(8), 
       DI9 => DATAIN_0(9), 
       DI10 => DATAIN_0(10), 
       DI11 => DATAIN_0(11), 
       DI12 => DATAIN_0(12), 
       DI13 => DATAIN_0(13), 
       DI14 => DATAIN_0(14), 
       DI15 => DATAIN_0(15), 
       DI16 => DATAIN_0(16), 
       DI17 => DATAIN_0(17), 
       DI18 => DATAIN_0(18), 
       DI19 => DATAIN_0(19), 
       DI20 => DATAIN_0(20), 
       DI21 => DATAIN_0(21), 
       DI22 => DATAIN_0(22), 
       DI23 => DATAIN_0(23), 
       DI24 => DATAIN_0(24), 
       DI25 => DATAIN_0(25), 
       DI26 => DATAIN_0(26), 
       DI27 => DATAIN_0(27), 
       DI28 => DATAIN_0(28), 
       DI29 => DATAIN_0(29), 
       DI30 => DATAIN_0(30), 
       DI31 => DATAIN_0(31), 
       DO0 => DATAOUT_1(0), 
       DO1 => DATAOUT_1(1), 
       DO2 => DATAOUT_1(2), 
       DO3 => DATAOUT_1(3), 
       DO4 => DATAOUT_1(4), 
       DO5 => DATAOUT_1(5), 
       DO6 => DATAOUT_1(6), 
       DO7 => DATAOUT_1(7), 
       DO8 => DATAOUT_1(8), 
       DO9 => DATAOUT_1(9), 
       DO10 => DATAOUT_1(10), 
       DO11 => DATAOUT_1(11), 
       DO12 => DATAOUT_1(12), 
       DO13 => DATAOUT_1(13), 
       DO14 => DATAOUT_1(14), 
       DO15 => DATAOUT_1(15), 
       DO16 => DATAOUT_1(16), 
       DO17 => DATAOUT_1(17), 
       DO18 => DATAOUT_1(18), 
       DO19 => DATAOUT_1(19), 
       DO20 => DATAOUT_1(20), 
       DO21 => DATAOUT_1(21), 
       DO22 => DATAOUT_1(22), 
       DO23 => DATAOUT_1(23), 
       DO24 => DATAOUT_1(24), 
       DO25 => DATAOUT_1(25), 
       DO26 => DATAOUT_1(26), 
       DO27 => DATAOUT_1(27), 
       DO28 => DATAOUT_1(28), 
       DO29 => DATAOUT_1(29), 
       DO30 => DATAOUT_1(30), 
       DO31 => DATAOUT_1(31), 
 CKA => CLK, CKB => CLK,  WEB => ENABLE_0_BAR, CSAN => ENABLE_1_BAR, CSBN => ENABLE_0_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW);
         end block;
  end generate SZKA65_32X32X1CM2_gen;
  SZKA65_64X32X1CM2_gen: if (address_width = 6) and (data_width = 32) generate
     mc: block 
            signal DATA_TIE_LOW  : std_logic_vector(31 downto 0); 
            signal DATA_TIE_HIGH : std_logic_vector(31 downto 0); 
            signal ADDR_TIE_LOW  : std_logic_vector(5 downto 0); 
            signal ADDR_TIE_HIGH : std_logic_vector(5 downto 0); 
         begin 
              DATA_TIE_LOW <= (others => '0'); 
              DATA_TIE_HIGH <= (others => '1'); 
              ADDR_TIE_LOW <= (others => '0'); 
              ADDR_TIE_HIGH <= (others => '1'); 
               inst: SZKA65_64X32X1CM2
   port map (       A0 => ADDR_1(0), 
       A1 => ADDR_1(1), 
       A2 => ADDR_1(2), 
       A3 => ADDR_1(3), 
       A4 => ADDR_1(4), 
       A5 => ADDR_1(5), 
       B0 => ADDR_0(0), 
       B1 => ADDR_0(1), 
       B2 => ADDR_0(2), 
       B3 => ADDR_0(3), 
       B4 => ADDR_0(4), 
       B5 => ADDR_0(5), 
       DI0 => DATAIN_0(0), 
       DI1 => DATAIN_0(1), 
       DI2 => DATAIN_0(2), 
       DI3 => DATAIN_0(3), 
       DI4 => DATAIN_0(4), 
       DI5 => DATAIN_0(5), 
       DI6 => DATAIN_0(6), 
       DI7 => DATAIN_0(7), 
       DI8 => DATAIN_0(8), 
       DI9 => DATAIN_0(9), 
       DI10 => DATAIN_0(10), 
       DI11 => DATAIN_0(11), 
       DI12 => DATAIN_0(12), 
       DI13 => DATAIN_0(13), 
       DI14 => DATAIN_0(14), 
       DI15 => DATAIN_0(15), 
       DI16 => DATAIN_0(16), 
       DI17 => DATAIN_0(17), 
       DI18 => DATAIN_0(18), 
       DI19 => DATAIN_0(19), 
       DI20 => DATAIN_0(20), 
       DI21 => DATAIN_0(21), 
       DI22 => DATAIN_0(22), 
       DI23 => DATAIN_0(23), 
       DI24 => DATAIN_0(24), 
       DI25 => DATAIN_0(25), 
       DI26 => DATAIN_0(26), 
       DI27 => DATAIN_0(27), 
       DI28 => DATAIN_0(28), 
       DI29 => DATAIN_0(29), 
       DI30 => DATAIN_0(30), 
       DI31 => DATAIN_0(31), 
       DO0 => DATAOUT_1(0), 
       DO1 => DATAOUT_1(1), 
       DO2 => DATAOUT_1(2), 
       DO3 => DATAOUT_1(3), 
       DO4 => DATAOUT_1(4), 
       DO5 => DATAOUT_1(5), 
       DO6 => DATAOUT_1(6), 
       DO7 => DATAOUT_1(7), 
       DO8 => DATAOUT_1(8), 
       DO9 => DATAOUT_1(9), 
       DO10 => DATAOUT_1(10), 
       DO11 => DATAOUT_1(11), 
       DO12 => DATAOUT_1(12), 
       DO13 => DATAOUT_1(13), 
       DO14 => DATAOUT_1(14), 
       DO15 => DATAOUT_1(15), 
       DO16 => DATAOUT_1(16), 
       DO17 => DATAOUT_1(17), 
       DO18 => DATAOUT_1(18), 
       DO19 => DATAOUT_1(19), 
       DO20 => DATAOUT_1(20), 
       DO21 => DATAOUT_1(21), 
       DO22 => DATAOUT_1(22), 
       DO23 => DATAOUT_1(23), 
       DO24 => DATAOUT_1(24), 
       DO25 => DATAOUT_1(25), 
       DO26 => DATAOUT_1(26), 
       DO27 => DATAOUT_1(27), 
       DO28 => DATAOUT_1(28), 
       DO29 => DATAOUT_1(29), 
       DO30 => DATAOUT_1(30), 
       DO31 => DATAOUT_1(31), 
 CKA => CLK, CKB => CLK,  WEB => ENABLE_0_BAR, CSAN => ENABLE_1_BAR, CSBN => ENABLE_0_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW);
         end block;
  end generate SZKA65_64X32X1CM2_gen;
end StructGen;

