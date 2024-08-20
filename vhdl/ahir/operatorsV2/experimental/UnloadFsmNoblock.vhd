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

-- Synopsys DC ($^^$@!)  needs you to declare an attribute
-- to infer a synchronous set/reset ... unbelievable.
--##decl_synopsys_attribute_lib##

--  A non-blocking version of the state machine for
--  handling the revised case of the unload-buffer.
--
-- BUG ALERT:  there is something wrong about this 
--             which causes incorrect behaviour. 
--             Am stymied for the moment (MPD)
--
entity UnloadFsmNoBlock is
  generic (name: string; data_width: integer);
  port ( 
	 write_req: in std_logic;
         write_ack: out std_logic;
         unload_req: in boolean;
         unload_ack: out boolean;
	 data_in :  in std_logic_vector(data_width-1 downto 0);
	 data_out :  out std_logic_vector(data_width-1 downto 0);
         clk : in std_logic;
         reset: in std_logic
	);
end UnloadFsmNoBlock;

architecture default_arch of UnloadFsmNoBlock is

	signal unload_ack_sig : boolean;
	signal write_ack_sig: std_logic;

	type FsmState is (Idle, UnloadAck, DataValid, ZeroData);
	signal fsm_state : FsmState;
-- see comment above..
--##decl_synopsys_sync_set_reset##
begin  -- default_arch

	process(fsm_state, write_req, data_in,  unload_req, clk, reset)
		variable next_fsm_state_var : FsmState;
		variable unload_ack_var: boolean;
		variable write_ack_var : std_logic;

		variable data_out_var: std_logic_vector(data_width-1 downto 0);

	begin
		unload_ack_var := false;
		write_ack_var  := '0';
		next_fsm_state_var := fsm_state;

		data_out_var := data_in;

		case fsm_state is 
			-- reset state, nothing seen so far.
			when Idle =>
				if(unload_req) then
					next_fsm_state_var := UnloadAck;
				end if;
			when UnloadAck =>
			-- have received an unload-req, unload-ack true.
				unload_ack_var := true;

				if(write_req = '0') then
				-- noblock 0 data.
					data_out_var := (others => '0');
				end if;
					
				if(unload_req) then
					if(write_req = '1') then
						-- new unload-req, ack
						-- the last write data.
						write_ack_var := '1';
					end if;
				else
					-- go to a holding state..
					if(write_req = '1') then
						-- valid data
						next_fsm_state_var := DataValid;
					else
						-- zero data.
						next_fsm_state_var := ZeroData;
					end if;
				end if;

			when ZeroData => 
				-- Acked state, hold until next unload-req
				-- hold 0 data until next unload-req.
				data_out_var := (others => '0');
				if(unload_req) then
					next_fsm_state_var := UnloadAck;
				end if;
			when DataValid =>
				-- Acked state, hold until next unload-req
				-- write_req is '1' here... 
				if(unload_req) then
					-- write-data is no longer needed.
					write_ack_var := '1';
					next_fsm_state_var := UnloadAck;
				end if;
		end case;

		unload_ack_sig <= unload_ack_var;
		write_ack_sig <= write_ack_var;
		data_out <= data_out_var;

		if(clk'event and clk='1') then
			if(reset = '1') then
				fsm_state <= Idle;
			else
				fsm_state <= next_fsm_state_var;
			end if;
		end if;
	end process;

	unload_ack <= unload_ack_sig;
	write_ack  <= write_ack_sig;

end default_arch;
