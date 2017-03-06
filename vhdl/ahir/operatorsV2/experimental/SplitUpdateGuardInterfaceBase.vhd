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


-- A half guard interface which forwards only
-- the update.  (used on input ports).
--  Madhav P. Desai.
entity SplitUpdateGuardInterfaceBase is
	generic (name: string; buffering:integer);
	port (sr_in: in Boolean;
	      sa_out: out Boolean;
	      sr_out: out Boolean;
	      sa_in: in Boolean;
	      cr_in: in Boolean;
	      ca_out: out Boolean;
	      cr_out: out Boolean;
	      ca_in: in Boolean;
	      guard_interface: in std_logic;
	      clk: in std_logic;
	      reset: in std_logic);
end entity;


architecture Behave of SplitUpdateGuardInterfaceBase is
	Type FsmState is (Idle, Busy);
	signal fsm_state: FsmState;
	signal ca_out_u, ca_out_d: Boolean;
	signal sampled_guard_interface: std_logic;
begin
		
	-- sr/sa interface is a dummy... no need to forward to the
	sa_out <= sr_in;

	sr_out <= false;

	-- update guard FSM.
	process(clk, guard_interface, fsm_state, cr_in, ca_in)
		variable next_state : FsmState;
		variable cr_out_var, ca_out_var_d, ca_out_var_u: Boolean;
	begin
		next_state := fsm_state;
		cr_out_var := false;
		ca_out_var_u := false;
		ca_out_var_d := false;
		case fsm_state is
			when Idle =>
				if(cr_in) then
					if(guard_interface  = '1') then
						cr_out_var := true;
						next_state := Busy;
					else
						-- give delayed ack, since guard is 0.
						ca_out_var_d := true;	
					end if;
				end if;
			when Busy => 
				if(ca_in) then
					ca_out_var_u := true;
					if(cr_in) then
						if(guard_interface = '1') then
							cr_out_var := true;
						else
							ca_out_var_d := true;
							next_state := Idle;
						end if;
					else
						next_state := Idle;
					end if;
				end if;
		end case;
		
		cr_out <= cr_out_var;
		ca_out_u <= ca_out_var_u;

		if(clk'event and clk = '1') then
			if(reset = '1') then
				fsm_state <= Idle;
				ca_out_d <= false;
			else 
				fsm_state <= next_state;
				ca_out_d <= ca_out_var_d;
			end if;
		end if;
	end process;	
	ca_out <= ca_out_u or ca_out_d;
end Behave;
