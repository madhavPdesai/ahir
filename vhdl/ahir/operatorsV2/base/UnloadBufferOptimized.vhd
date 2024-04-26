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
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
-- An optimized version of the unload buffer, to be used when the buffer_size is > 1.
--     Uses a standard queue followed by a state machine..
--
entity UnloadBufferOptimized is
  generic (name: string; buffer_size: integer ; data_width : integer; 
		bypass_flag: boolean; nonblocking_read_flag : boolean := false);
  port ( write_req: in std_logic;
        write_ack: out std_logic;
        write_data: in std_logic_vector(data_width-1 downto 0);
        unload_req: in boolean;
        unload_ack: out boolean;
        read_data: out std_logic_vector(data_width-1 downto 0);
	has_data : out std_logic;
        clk : in std_logic;
        reset: in std_logic);
end UnloadBufferOptimized;

architecture default_arch of UnloadBufferOptimized is

  signal pop_req, pop_ack : std_logic;
  signal unload_ack_sig: boolean; 
  signal empty, full: std_logic;

   type FsmState is (sA, sB, sC, sD);
   signal fsm_state: FsmState;

   signal queue_data_out: std_logic_vector(data_width-1 downto 0);

begin  -- default_arch

  assert (buffer_size /= 1) report "UnloadBufferOptimized must have queue-size != 1" severity failure;

  has_data <= not empty;

  qinst: QueueBaseWithEmptyFull
		generic map (name => name & ":qinst",
				queue_depth => buffer_size,
				data_width => data_width,
				reverse_bypass_flag => bypass_flag
			    )
		port map (
				empty => empty,
				full  => full,
				push_req => write_req,
				push_ack => write_ack,
				pop_req => pop_req,
				pop_ack => pop_ack,
				data_in => write_data,
				data_out => queue_data_out,
				clk => clk,
				reset => reset);	

	-- FSM
        process(clk, reset, pop_ack, fsm_state, unload_req, queue_data_out)
		variable next_fsm_state_var:  FsmState;
		variable unload_ack_var: boolean;
		variable pop_req_var: std_logic;
   		variable read_data_var: std_logic_vector(data_width-1 downto 0);
	begin
		next_fsm_state_var := fsm_state;
		unload_ack_var := false;
		pop_req_var := '0';
		read_data_var := queue_data_out;

		case fsm_state is
			when sA =>
				-- In the beginning, nothing has
				-- been read from the queue.
				if unload_req then
					next_fsm_state_var := sB;
				end if;
			when sB =>
				--
				-- Ack if queue has data 
				--
				-- Careful about the non-blocking
				-- behaviour.
				if (pop_ack = '1') then		     -- p
					unload_ack_var := true;
					if unload_req then
						-- pop from the queue
						-- since the next-req
						-- has arrived.
						pop_req_var := '1';
					else
						next_fsm_state_var := sC;
					end if;
				elsif nonblocking_read_flag then -- (~p).n
					-- non-blocking... as if pop_ack is
					-- asserted except that read data 
					-- will be zero-ed out.
					read_data_var := (others => '0');

					-- ack the zero data..
					unload_ack_var := true;

					if unload_req then
						-- do not pop here
						-- The queue data has not 
						-- been used yet.
						next_fsm_state_var := sB;
					else
						-- wait for update req
						-- but ensure that read_data
						-- is zero-ed out.
						next_fsm_state_var := sD;
					end if;
				end if;
			when sC =>
				--
				-- you will come to this state only
				-- if pop_ack = '1'... you are waiting
				-- for an update-req to start the
				-- next cycle.
				if unload_req then
					-- pop only when signaled by
					-- unload_req
					pop_req_var := '1';

					-- go to sB before reacting
					-- to the update-req.
					next_fsm_state_var := sB;
				end if;

			when SD =>
				--
				-- you got here because pop_ack was false
				-- and non-block was true.  zero out the
				-- read_data until the next unload_req.
				-- 
				-- you are waiting for an update-req to
				-- start the next cycle.
				--
				-- Keep read_data_var = 0 here.  you
				-- do not want the changed queue output
				-- to sneak to the user.
				--
				read_data_var := (others => '0');
				if unload_req then
					--
					-- do not pop!  
					-- 
					-- go to sB before reacting
					-- to the update-req.
					next_fsm_state_var := sB;
				end if;
		end case;

		pop_req <= pop_req_var;
		unload_ack <= unload_ack_var;
		read_data <= read_data_var;

		if(clk'event and (clk = '1')) then
			if (reset = '1') then
				fsm_state <= sA;
			else
				fsm_state <= next_fsm_state_var;
			end if;
		end if;
	end process;

end default_arch;
