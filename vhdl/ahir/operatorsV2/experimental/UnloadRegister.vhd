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

entity UnloadRegister is
  generic (name: string; 
		data_width : integer ; 
		nonblocking_read_flag : boolean := false);
  port ( write_req: in std_logic;
        write_ack: out std_logic;
        write_data: in std_logic_vector(data_width-1 downto 0);
        unload_req: in boolean;
        unload_ack: out boolean;
        read_data: out std_logic_vector(data_width-1 downto 0);
        clk : in std_logic;
        reset: in std_logic);
end UnloadRegister;

architecture default_arch of UnloadRegister is
	signal unload_ack_sig : boolean;
	signal write_req_nonblockified : std_logic;
	signal write_data_nonblockified: std_logic_vector(data_width-1 downto 0);
	type FsmState is (Idle, Waiting);
	signal fsm_state : FsmState;
begin  -- default_arch
	-- FSM
  	--   Two states: Idle, Waiting
  	process(clk, reset, fsm_state, unload_req, write_req, write_data)
     		variable nstate: FsmState;
     		variable load_v : boolean;
		variable write_ack_v : std_logic;
		variable data_v : std_logic_vector(data_width-1 downto 0);
        begin
     		nstate :=  fsm_state;
		write_ack_v := '0';
     		load_v := false;
		data_v := write_data;
  		
     		case fsm_state is
         		when Idle => 
               			if(unload_req) then
					write_ack_v := '1';
					if (write_req = '1') then
						load_v := true;
					elsif nonblocking_read_flag then
						load_v := true;
						data_v := (others => '0'); -- non-blocking!
					else
						nstate := Waiting;
					end if;
				end if;
	 		when Waiting =>
				write_ack_v := '1';
				if(write_req = '1') then
					load_v := true;
					nstate := Idle;
				end if;
     		end case;
 
		write_ack <= write_ack_v;
		
     		if(clk'event and clk = '1') then
			if(reset = '1') then
				fsm_state <= idle;
				unload_ack <= false;
           			read_data <= (others => '0');
			else
				fsm_state <= nstate;
				unload_ack <= load_v;
				if(load_v) then
           				read_data <= data_v;
        			end if;
			end if;
		
     		end if;
  	end process;

end default_arch;
