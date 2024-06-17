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
use ahir.types.all;
use ahir.utilities.all;

-- Entity to instantiate different available memory cuts based on the 
-- address_width and data_width generics passed.
entity spmem_selector is
	generic(address_width: integer:=8; data_width: integer:=8);
	port (ADDR : in std_logic_vector(address_width-1 downto 0 );
		CLK : in std_logic;
	        RESET: in std_logic;
		WRITE_BAR: in std_logic;
		ENABLE_BAR: in std_logic;
		DATAIN  : in std_logic_vector(data_width-1 downto 0);
		DATAOUT  : out std_logic_vector(data_width-1 downto 0));
end entity spmem_selector;

architecture StructGen of spmem_selector is

  signal TIE_HIGH, TIE_LOW: std_logic;
  signal TIE_LOW_2, TIE_HIGH_2: std_logic_vector(1 downto 0);
  signal TIE_LOW_3: std_logic_vector(2 downto 0);
  signal TIE_LOW_4: std_logic_vector(3 downto 0);

begin
  
  TIE_HIGH <= '1';
  TIE_LOW  <= '0';
  TIE_LOW_2 <= (others => '0');
  TIE_HIGH_2 <= (others => '1');
  TIE_LOW_3 <= (others => '0');
  TIE_LOW_4 <= (others => '0');
  SHKA65_16X30X1CM4_gen: if (address_width = 4) and (data_width = 30) generate
     mc: block 
            signal DATA_TIE_LOW  : std_logic_vector(29 downto 0); 
            signal DATA_TIE_HIGH : std_logic_vector(29 downto 0); 
            signal ADDR_TIE_LOW  : std_logic_vector(3 downto 0); 
            signal ADDR_TIE_HIGH : std_logic_vector(3 downto 0); 
         begin 
              DATA_TIE_LOW <= (others => '0'); 
              DATA_TIE_HIGH <= (others => '1'); 
              ADDR_TIE_LOW <= (others => '0'); 
              ADDR_TIE_HIGH <= (others => '1'); 
               inst: SHKA65_16X30X1CM4
   port map (       A0 => ADDR(0), 
       A1 => ADDR(1), 
       A2 => ADDR(2), 
       A3 => ADDR(3), 
       DI0 => DATAIN(0), 
       DI1 => DATAIN(1), 
       DI2 => DATAIN(2), 
       DI3 => DATAIN(3), 
       DI4 => DATAIN(4), 
       DI5 => DATAIN(5), 
       DI6 => DATAIN(6), 
       DI7 => DATAIN(7), 
       DI8 => DATAIN(8), 
       DI9 => DATAIN(9), 
       DI10 => DATAIN(10), 
       DI11 => DATAIN(11), 
       DI12 => DATAIN(12), 
       DI13 => DATAIN(13), 
       DI14 => DATAIN(14), 
       DI15 => DATAIN(15), 
       DI16 => DATAIN(16), 
       DI17 => DATAIN(17), 
       DI18 => DATAIN(18), 
       DI19 => DATAIN(19), 
       DI20 => DATAIN(20), 
       DI21 => DATAIN(21), 
       DI22 => DATAIN(22), 
       DI23 => DATAIN(23), 
       DI24 => DATAIN(24), 
       DI25 => DATAIN(25), 
       DI26 => DATAIN(26), 
       DI27 => DATAIN(27), 
       DI28 => DATAIN(28), 
       DI29 => DATAIN(29), 
       DO0 => DATAOUT(0), 
       DO1 => DATAOUT(1), 
       DO2 => DATAOUT(2), 
       DO3 => DATAOUT(3), 
       DO4 => DATAOUT(4), 
       DO5 => DATAOUT(5), 
       DO6 => DATAOUT(6), 
       DO7 => DATAOUT(7), 
       DO8 => DATAOUT(8), 
       DO9 => DATAOUT(9), 
       DO10 => DATAOUT(10), 
       DO11 => DATAOUT(11), 
       DO12 => DATAOUT(12), 
       DO13 => DATAOUT(13), 
       DO14 => DATAOUT(14), 
       DO15 => DATAOUT(15), 
       DO16 => DATAOUT(16), 
       DO17 => DATAOUT(17), 
       DO18 => DATAOUT(18), 
       DO19 => DATAOUT(19), 
       DO20 => DATAOUT(20), 
       DO21 => DATAOUT(21), 
       DO22 => DATAOUT(22), 
       DO23 => DATAOUT(23), 
       DO24 => DATAOUT(24), 
       DO25 => DATAOUT(25), 
       DO26 => DATAOUT(26), 
       DO27 => DATAOUT(27), 
       DO28 => DATAOUT(28), 
       DO29 => DATAOUT(29), 
 CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW);
         end block;
  end generate SHKA65_16X30X1CM4_gen;
  SHKA65_32X32X1CM4_gen: if (address_width = 5) and (data_width = 32) generate
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
               inst: SHKA65_32X32X1CM4
   port map (       A0 => ADDR(0), 
       A1 => ADDR(1), 
       A2 => ADDR(2), 
       A3 => ADDR(3), 
       A4 => ADDR(4), 
       DI0 => DATAIN(0), 
       DI1 => DATAIN(1), 
       DI2 => DATAIN(2), 
       DI3 => DATAIN(3), 
       DI4 => DATAIN(4), 
       DI5 => DATAIN(5), 
       DI6 => DATAIN(6), 
       DI7 => DATAIN(7), 
       DI8 => DATAIN(8), 
       DI9 => DATAIN(9), 
       DI10 => DATAIN(10), 
       DI11 => DATAIN(11), 
       DI12 => DATAIN(12), 
       DI13 => DATAIN(13), 
       DI14 => DATAIN(14), 
       DI15 => DATAIN(15), 
       DI16 => DATAIN(16), 
       DI17 => DATAIN(17), 
       DI18 => DATAIN(18), 
       DI19 => DATAIN(19), 
       DI20 => DATAIN(20), 
       DI21 => DATAIN(21), 
       DI22 => DATAIN(22), 
       DI23 => DATAIN(23), 
       DI24 => DATAIN(24), 
       DI25 => DATAIN(25), 
       DI26 => DATAIN(26), 
       DI27 => DATAIN(27), 
       DI28 => DATAIN(28), 
       DI29 => DATAIN(29), 
       DI30 => DATAIN(30), 
       DI31 => DATAIN(31), 
       DO0 => DATAOUT(0), 
       DO1 => DATAOUT(1), 
       DO2 => DATAOUT(2), 
       DO3 => DATAOUT(3), 
       DO4 => DATAOUT(4), 
       DO5 => DATAOUT(5), 
       DO6 => DATAOUT(6), 
       DO7 => DATAOUT(7), 
       DO8 => DATAOUT(8), 
       DO9 => DATAOUT(9), 
       DO10 => DATAOUT(10), 
       DO11 => DATAOUT(11), 
       DO12 => DATAOUT(12), 
       DO13 => DATAOUT(13), 
       DO14 => DATAOUT(14), 
       DO15 => DATAOUT(15), 
       DO16 => DATAOUT(16), 
       DO17 => DATAOUT(17), 
       DO18 => DATAOUT(18), 
       DO19 => DATAOUT(19), 
       DO20 => DATAOUT(20), 
       DO21 => DATAOUT(21), 
       DO22 => DATAOUT(22), 
       DO23 => DATAOUT(23), 
       DO24 => DATAOUT(24), 
       DO25 => DATAOUT(25), 
       DO26 => DATAOUT(26), 
       DO27 => DATAOUT(27), 
       DO28 => DATAOUT(28), 
       DO29 => DATAOUT(29), 
       DO30 => DATAOUT(30), 
       DO31 => DATAOUT(31), 
 CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW);
         end block;
  end generate SHKA65_32X32X1CM4_gen;
  SHKA65_64X23X1CM4_gen: if (address_width = 6) and (data_width = 23) generate
     mc: block 
            signal DATA_TIE_LOW  : std_logic_vector(22 downto 0); 
            signal DATA_TIE_HIGH : std_logic_vector(22 downto 0); 
            signal ADDR_TIE_LOW  : std_logic_vector(5 downto 0); 
            signal ADDR_TIE_HIGH : std_logic_vector(5 downto 0); 
         begin 
              DATA_TIE_LOW <= (others => '0'); 
              DATA_TIE_HIGH <= (others => '1'); 
              ADDR_TIE_LOW <= (others => '0'); 
              ADDR_TIE_HIGH <= (others => '1'); 
               inst: SHKA65_64X23X1CM4
   port map (       A0 => ADDR(0), 
       A1 => ADDR(1), 
       A2 => ADDR(2), 
       A3 => ADDR(3), 
       A4 => ADDR(4), 
       A5 => ADDR(5), 
       DI0 => DATAIN(0), 
       DI1 => DATAIN(1), 
       DI2 => DATAIN(2), 
       DI3 => DATAIN(3), 
       DI4 => DATAIN(4), 
       DI5 => DATAIN(5), 
       DI6 => DATAIN(6), 
       DI7 => DATAIN(7), 
       DI8 => DATAIN(8), 
       DI9 => DATAIN(9), 
       DI10 => DATAIN(10), 
       DI11 => DATAIN(11), 
       DI12 => DATAIN(12), 
       DI13 => DATAIN(13), 
       DI14 => DATAIN(14), 
       DI15 => DATAIN(15), 
       DI16 => DATAIN(16), 
       DI17 => DATAIN(17), 
       DI18 => DATAIN(18), 
       DI19 => DATAIN(19), 
       DI20 => DATAIN(20), 
       DI21 => DATAIN(21), 
       DI22 => DATAIN(22), 
       DO0 => DATAOUT(0), 
       DO1 => DATAOUT(1), 
       DO2 => DATAOUT(2), 
       DO3 => DATAOUT(3), 
       DO4 => DATAOUT(4), 
       DO5 => DATAOUT(5), 
       DO6 => DATAOUT(6), 
       DO7 => DATAOUT(7), 
       DO8 => DATAOUT(8), 
       DO9 => DATAOUT(9), 
       DO10 => DATAOUT(10), 
       DO11 => DATAOUT(11), 
       DO12 => DATAOUT(12), 
       DO13 => DATAOUT(13), 
       DO14 => DATAOUT(14), 
       DO15 => DATAOUT(15), 
       DO16 => DATAOUT(16), 
       DO17 => DATAOUT(17), 
       DO18 => DATAOUT(18), 
       DO19 => DATAOUT(19), 
       DO20 => DATAOUT(20), 
       DO21 => DATAOUT(21), 
       DO22 => DATAOUT(22), 
 CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW);
         end block;
  end generate SHKA65_64X23X1CM4_gen;
  SHKA65_512X8X1CM4_gen: if (address_width = 9) and (data_width = 8) generate
     mc: block 
            signal DATA_TIE_LOW  : std_logic_vector(7 downto 0); 
            signal DATA_TIE_HIGH : std_logic_vector(7 downto 0); 
            signal ADDR_TIE_LOW  : std_logic_vector(8 downto 0); 
            signal ADDR_TIE_HIGH : std_logic_vector(8 downto 0); 
         begin 
              DATA_TIE_LOW <= (others => '0'); 
              DATA_TIE_HIGH <= (others => '1'); 
              ADDR_TIE_LOW <= (others => '0'); 
              ADDR_TIE_HIGH <= (others => '1'); 
               inst: SHKA65_512X8X1CM4
   port map (       A0 => ADDR(0), 
       A1 => ADDR(1), 
       A2 => ADDR(2), 
       A3 => ADDR(3), 
       A4 => ADDR(4), 
       A5 => ADDR(5), 
       A6 => ADDR(6), 
       A7 => ADDR(7), 
       A8 => ADDR(8), 
       DI0 => DATAIN(0), 
       DI1 => DATAIN(1), 
       DI2 => DATAIN(2), 
       DI3 => DATAIN(3), 
       DI4 => DATAIN(4), 
       DI5 => DATAIN(5), 
       DI6 => DATAIN(6), 
       DI7 => DATAIN(7), 
       DO0 => DATAOUT(0), 
       DO1 => DATAOUT(1), 
       DO2 => DATAOUT(2), 
       DO3 => DATAOUT(3), 
       DO4 => DATAOUT(4), 
       DO5 => DATAOUT(5), 
       DO6 => DATAOUT(6), 
       DO7 => DATAOUT(7), 
 CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW);
         end block;
  end generate SHKA65_512X8X1CM4_gen;
  SHKA65_512X64X1CM4_gen: if (address_width = 9) and (data_width = 64) generate
     mc: block 
            signal DATA_TIE_LOW  : std_logic_vector(63 downto 0); 
            signal DATA_TIE_HIGH : std_logic_vector(63 downto 0); 
            signal ADDR_TIE_LOW  : std_logic_vector(8 downto 0); 
            signal ADDR_TIE_HIGH : std_logic_vector(8 downto 0); 
         begin 
              DATA_TIE_LOW <= (others => '0'); 
              DATA_TIE_HIGH <= (others => '1'); 
              ADDR_TIE_LOW <= (others => '0'); 
              ADDR_TIE_HIGH <= (others => '1'); 
               inst: SHKA65_512X64X1CM4
   port map (       A0 => ADDR(0), 
       A1 => ADDR(1), 
       A2 => ADDR(2), 
       A3 => ADDR(3), 
       A4 => ADDR(4), 
       A5 => ADDR(5), 
       A6 => ADDR(6), 
       A7 => ADDR(7), 
       A8 => ADDR(8), 
       DI0 => DATAIN(0), 
       DI1 => DATAIN(1), 
       DI2 => DATAIN(2), 
       DI3 => DATAIN(3), 
       DI4 => DATAIN(4), 
       DI5 => DATAIN(5), 
       DI6 => DATAIN(6), 
       DI7 => DATAIN(7), 
       DI8 => DATAIN(8), 
       DI9 => DATAIN(9), 
       DI10 => DATAIN(10), 
       DI11 => DATAIN(11), 
       DI12 => DATAIN(12), 
       DI13 => DATAIN(13), 
       DI14 => DATAIN(14), 
       DI15 => DATAIN(15), 
       DI16 => DATAIN(16), 
       DI17 => DATAIN(17), 
       DI18 => DATAIN(18), 
       DI19 => DATAIN(19), 
       DI20 => DATAIN(20), 
       DI21 => DATAIN(21), 
       DI22 => DATAIN(22), 
       DI23 => DATAIN(23), 
       DI24 => DATAIN(24), 
       DI25 => DATAIN(25), 
       DI26 => DATAIN(26), 
       DI27 => DATAIN(27), 
       DI28 => DATAIN(28), 
       DI29 => DATAIN(29), 
       DI30 => DATAIN(30), 
       DI31 => DATAIN(31), 
       DI32 => DATAIN(32), 
       DI33 => DATAIN(33), 
       DI34 => DATAIN(34), 
       DI35 => DATAIN(35), 
       DI36 => DATAIN(36), 
       DI37 => DATAIN(37), 
       DI38 => DATAIN(38), 
       DI39 => DATAIN(39), 
       DI40 => DATAIN(40), 
       DI41 => DATAIN(41), 
       DI42 => DATAIN(42), 
       DI43 => DATAIN(43), 
       DI44 => DATAIN(44), 
       DI45 => DATAIN(45), 
       DI46 => DATAIN(46), 
       DI47 => DATAIN(47), 
       DI48 => DATAIN(48), 
       DI49 => DATAIN(49), 
       DI50 => DATAIN(50), 
       DI51 => DATAIN(51), 
       DI52 => DATAIN(52), 
       DI53 => DATAIN(53), 
       DI54 => DATAIN(54), 
       DI55 => DATAIN(55), 
       DI56 => DATAIN(56), 
       DI57 => DATAIN(57), 
       DI58 => DATAIN(58), 
       DI59 => DATAIN(59), 
       DI60 => DATAIN(60), 
       DI61 => DATAIN(61), 
       DI62 => DATAIN(62), 
       DI63 => DATAIN(63), 
       DO0 => DATAOUT(0), 
       DO1 => DATAOUT(1), 
       DO2 => DATAOUT(2), 
       DO3 => DATAOUT(3), 
       DO4 => DATAOUT(4), 
       DO5 => DATAOUT(5), 
       DO6 => DATAOUT(6), 
       DO7 => DATAOUT(7), 
       DO8 => DATAOUT(8), 
       DO9 => DATAOUT(9), 
       DO10 => DATAOUT(10), 
       DO11 => DATAOUT(11), 
       DO12 => DATAOUT(12), 
       DO13 => DATAOUT(13), 
       DO14 => DATAOUT(14), 
       DO15 => DATAOUT(15), 
       DO16 => DATAOUT(16), 
       DO17 => DATAOUT(17), 
       DO18 => DATAOUT(18), 
       DO19 => DATAOUT(19), 
       DO20 => DATAOUT(20), 
       DO21 => DATAOUT(21), 
       DO22 => DATAOUT(22), 
       DO23 => DATAOUT(23), 
       DO24 => DATAOUT(24), 
       DO25 => DATAOUT(25), 
       DO26 => DATAOUT(26), 
       DO27 => DATAOUT(27), 
       DO28 => DATAOUT(28), 
       DO29 => DATAOUT(29), 
       DO30 => DATAOUT(30), 
       DO31 => DATAOUT(31), 
       DO32 => DATAOUT(32), 
       DO33 => DATAOUT(33), 
       DO34 => DATAOUT(34), 
       DO35 => DATAOUT(35), 
       DO36 => DATAOUT(36), 
       DO37 => DATAOUT(37), 
       DO38 => DATAOUT(38), 
       DO39 => DATAOUT(39), 
       DO40 => DATAOUT(40), 
       DO41 => DATAOUT(41), 
       DO42 => DATAOUT(42), 
       DO43 => DATAOUT(43), 
       DO44 => DATAOUT(44), 
       DO45 => DATAOUT(45), 
       DO46 => DATAOUT(46), 
       DO47 => DATAOUT(47), 
       DO48 => DATAOUT(48), 
       DO49 => DATAOUT(49), 
       DO50 => DATAOUT(50), 
       DO51 => DATAOUT(51), 
       DO52 => DATAOUT(52), 
       DO53 => DATAOUT(53), 
       DO54 => DATAOUT(54), 
       DO55 => DATAOUT(55), 
       DO56 => DATAOUT(56), 
       DO57 => DATAOUT(57), 
       DO58 => DATAOUT(58), 
       DO59 => DATAOUT(59), 
       DO60 => DATAOUT(60), 
       DO61 => DATAOUT(61), 
       DO62 => DATAOUT(62), 
       DO63 => DATAOUT(63), 
 CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW);
         end block;
  end generate SHKA65_512X64X1CM4_gen;
  SHKA65_4096X8X1CM4_gen: if (address_width = 12) and (data_width = 8) generate
     mc: block 
            signal DATA_TIE_LOW  : std_logic_vector(7 downto 0); 
            signal DATA_TIE_HIGH : std_logic_vector(7 downto 0); 
            signal ADDR_TIE_LOW  : std_logic_vector(11 downto 0); 
            signal ADDR_TIE_HIGH : std_logic_vector(11 downto 0); 
         begin 
              DATA_TIE_LOW <= (others => '0'); 
              DATA_TIE_HIGH <= (others => '1'); 
              ADDR_TIE_LOW <= (others => '0'); 
              ADDR_TIE_HIGH <= (others => '1'); 
               inst: SHKA65_4096X8X1CM4
   port map (       A0 => ADDR(0), 
       A1 => ADDR(1), 
       A2 => ADDR(2), 
       A3 => ADDR(3), 
       A4 => ADDR(4), 
       A5 => ADDR(5), 
       A6 => ADDR(6), 
       A7 => ADDR(7), 
       A8 => ADDR(8), 
       A9 => ADDR(9), 
       A10 => ADDR(10), 
       A11 => ADDR(11), 
       DI0 => DATAIN(0), 
       DI1 => DATAIN(1), 
       DI2 => DATAIN(2), 
       DI3 => DATAIN(3), 
       DI4 => DATAIN(4), 
       DI5 => DATAIN(5), 
       DI6 => DATAIN(6), 
       DI7 => DATAIN(7), 
       DO0 => DATAOUT(0), 
       DO1 => DATAOUT(1), 
       DO2 => DATAOUT(2), 
       DO3 => DATAOUT(3), 
       DO4 => DATAOUT(4), 
       DO5 => DATAOUT(5), 
       DO6 => DATAOUT(6), 
       DO7 => DATAOUT(7), 
 CK => CLK, WEB => WRITE_BAR, CSB => ENABLE_BAR,  DVSE => TIE_LOW, DVS0 => TIE_LOW, DVS1 => TIE_LOW, DVS2 => TIE_LOW);
         end block;
  end generate SHKA65_4096X8X1CM4_gen;
end StructGen;

