------------------------------------------------------------------------------------------------
--
-- Copyright (C) 2010-: Madhav P. Desai
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

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
-- an interface which reads 0's from the writer
-- if the writer does not have data to send.
--
entity PipeUnblock is
  generic (name : string; data_width: integer);
  port (
    write_req   : in std_logic;
    write_ack   : out std_logic;
    write_data   : in std_logic_vector(data_width-1 downto 0);
    read_req      : in  std_logic;
    read_ack       : out std_logic;
    read_data     : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end PipeUnblock;

architecture default_arch of PipeUnblock is
begin  -- default_arch
   read_ack <= '1';
   process(write_req, write_data, read_req)
	variable read_data_var : std_logic_vector(data_width-1 downto 0);
   begin

	if(write_req = '1') then
		read_data_var := write_data;
	else
		read_data_var := (others => '0');
	end if;

	read_data <= read_data_var;
	write_ack <= read_req;
   end process;
end default_arch;
