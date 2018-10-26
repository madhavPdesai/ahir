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
use ieee.numeric_std.all;

library ahir;
use ahir.BaseComponents.all;

-- effectively a delay stage, which
-- has just one combinational path from ack_in -> ack_out.
-- Works at full speed.
entity LevelRepeater is
    generic(name: string; g_data_width: integer := 32);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(g_data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(g_data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
end entity LevelRepeater;

architecture behave of LevelRepeater is
	Type FsmState is (Empty, Full);
	signal fsm_state: FsmState;
begin  -- SimModel

	process(clk, reset, fsm_state, req_in, ack_in)
		variable next_fsm_state_var: FsmState;
		variable ack_out_var, req_out_var, latch_var: std_logic;
	begin
		next_fsm_state_var := fsm_state;
		ack_out_var := '0';
		req_out_var := '0';
		latch_var   := '0';
		case fsm_state is
			when Empty =>
				ack_out_var := '1';
				if (req_in = '1') then
					latch_var := '1';
					next_fsm_state_var := Full;
				end if;
			when Full =>
				req_out_var := '1';
				if(ack_in = '1') then
					ack_out_var := '1';
					if(req_in = '1') then
						latch_var := '1';
					else
						next_fsm_state_var := Empty;
					end if;
				end if;
		end case;
		
		ack_out <= ack_out_var;
		req_out <= req_out_var;

		if(clk'event and clk = '1') then
			if(reset = '1') then
				fsm_state <= Empty;
			else
				fsm_state <= next_fsm_state_var;
			end if;
			if(latch_var = '1') then
				data_out <= data_in;
			end if;
		end if;
	end process;
end behave;
