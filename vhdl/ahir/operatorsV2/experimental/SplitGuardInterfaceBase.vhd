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
use ahir.GlobalConstants.all;

-- Synopsys DC ($^^$@!)  needs you to declare an attribute
-- to infer a synchronous set/reset ... unbelievable.
--##decl_synopsys_attribute_lib##


-- a guard-interface to conform with the split protocol.
-- With this interface, the guard at the time of initiation
-- of the operation will be remembered (using a queue) 
-- and the remembered value will be used to generate the
-- completion protocol.
-- 
-- The benefit is that the guard-expression can be reevaluated
-- as soon as the operation starts (instead of waiting
-- for the operation to finish...).  This helps pipelining.
--
-- Assumptions
--   1. sr_in -> sr_in without intervening sa_out is not possible.
--   2. cr_in -> cr_in without intervening ca_out is not possible.
--
entity SplitGuardInterfaceBase is
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


architecture Behave of SplitGuardInterfaceBase is
  signal push, push_ack, pop, pop_ack: std_logic;
  signal qdata_in, qdata : std_logic_vector(0 downto 0);

  type RhsState is (r_Idle, r_Wait_On_Ack_In, r_Wait_On_Queue);
  signal rhs_state: RhsState;

  -- for debug purposes only
  signal s_counter, c_counter: integer;

  signal ca_out_d, ca_out_u: Boolean;


  -- number of stages!  This will cause
  -- the minimum latency of sr -> ca to
  -- increase to this number...  Be careful..
  constant g_queue_number_of_stages : integer := Ceil(buffering, max_single_bit_queue_depth_per_stage);

  -- constant g_queue_number_of_stages : integer := 1;
 
  signal sr_in_q : Boolean;

-- see comment above..
--##decl_synopsys_sync_set_reset##

begin
	ca_out <= ca_out_d or ca_out_u;

	qdata_in(0) <= guard_interface;

	qI: ShiftRegisterSingleBitQueue  -- dont bypass.. combinational cycle alert!
		generic map(name => name & "-qI", queue_depth => buffering, number_of_stages => g_queue_number_of_stages)
		port map(clk => clk, reset => reset,
				data_in => qdata_in,
				push_req => push,
				push_ack => push_ack,
				data_out => qdata,
				pop_req => pop,
				pop_ack => pop_ack);

	-----------------------------------------------------------------------------------------------
	-- sample side logic.
	-----------------------------------------------------------------------------------------------
	sampleFsm: SgiSampleFsm
			generic map (name => name & "-sample-fsm")
			port map (clk => clk, reset => reset,
					sr_in => sr_in, sr_in_q => sr_in_q,
					push_req => push, push_ack => push_ack);

	-- sr_out
	sr_out <= sr_in_q when (guard_interface = '1') else false;
	
	-- sa_out
	sa_out <= sr_in_q when (guard_interface = '0') else sa_in;


	-- RHS State machine.
	------------------------------------------------------------------------------------------
        --   Present-state  cr_in  pop_ack      qdata        ca_in    Nstate  cr_out  ca_out  pop
	------------------------------------------------------------------------------------------
	--   r_Idle          0        _           _            _      r_Idle
	--   r_Idle          1        0           _            _      W-Queue                  1
	--   r_Idle          1        1           1            _      W-Ack-In  1              1
	--   r_Idle          1        1           0            _      r_Idle           1d      1
	--      Note: ca_in is never expected to be asserted in the idle state.
	------------------------------------------------------------------------------------------
        --   Present-state  cr_in  pop_ack      qdata        ca_in    Nstate  cr_out  ca_out  pop
	------------------------------------------------------------------------------------------
	--   W-Queue         _        0           _            _      W-Queue                  1
	--   W-Queue         1        1           0            _      W-Queue          1       1
	--   W-Queue         0        1           0            _      r-Idle           1       1
	--   W-Queue         0        1           1            1      r_Idle    1      1       1
	--   W-Queue         1        1           1            1      W_Queue   1      1       1
	--   W-Queue         _        1           1            0      W-Ack-In  1              1
	--      Note: cr_in will be asserted only if ca_out is asserted.
	------------------------------------------------------------------------------------------
        --   Present-state  cr_in  pop_ack      qdata        ca_in    Nstate  cr_out  ca_out  pop
	------------------------------------------------------------------------------------------
	--   W-Ack-In        _        _           _            0      W-Ack-In  
	--   W-Ack-In        1        1           1            1      W-Ack-In  1       1      1
	--   W-Ack-In        1        1           0            1      r_Idle            1,1d   1
	--   W-Ack-In        1        0           _            1      W-Queue           1      1
	--   W-Ack-In        0        _           _            1      r_Idle            1  
	--	Note: cr_in will be asserted only if ca_out is asserted.
	--            ca_out-u will be asserted only on ca_in.
	--            ca-out-d can depend on cr_in.
	------------------------------------------------------------------------------------------
	process(clk,cr_in,pop_ack,qdata,ca_in,rhs_state,reset, c_counter)
		variable nstate : RhsState;
		variable ca_out_u_var : Boolean;
		variable ca_out_d_var : Boolean;
		variable cr_out_var : Boolean;
		variable next_c_counter: integer;
	begin
		nstate := rhs_state;
		pop <= '0';
		cr_out_var := false;
		ca_out_u_var := false;
		ca_out_d_var := false;
		next_c_counter := c_counter;

		case rhs_state is
			when r_Idle =>
				if cr_in then
					pop <= '1';
					--
					-- what happens if ca_in appears immediately?
					-- not permitted in this state.
					--	
					if(pop_ack = '0') then
						nstate := r_Wait_On_Queue;			
					else
						if(qdata(0) = '1') then
							cr_out_var := true;
							nstate := r_Wait_On_Ack_In;
							next_c_counter := (next_c_counter + 1);
						else
							ca_out_d_var := true;
							nstate := r_Idle;
						end if;
					end if;
				end if;
			when r_Wait_On_Queue =>
				pop <= '1';
				if(pop_ack = '1') then
					if(qdata(0) = '0') then
						ca_out_u_var := true;
						if(cr_in) then
							nstate := r_Wait_On_Queue;
						else
							nstate := r_Idle;
						end if;
					else 
						cr_out_var := true;
						if(ca_in) then	
							ca_out_u_var := true;
						end if;

						if(cr_in and ca_in) then
							nstate := r_Wait_On_Queue;
						elsif ((not cr_in) and ca_in)  then
							nstate := r_Idle;
						elsif (not ca_in) then
							nstate := r_Wait_On_Ack_In;
						end if;
					
						next_c_counter := (next_c_counter + 1);
					end if;
				end if;
			when r_Wait_On_Ack_In =>
				-- assumption: there is at least a unit delay from cr_out -> ca_in.
				if(ca_in) then 
					ca_out_u_var := true;
					if(cr_in  and (pop_ack = '1') and (qdata(0) = '1')) then
						pop <= '1';
						cr_out_var := true;
						next_c_counter := (next_c_counter + 1);
					elsif(cr_in and (pop_ack = '1') and (qdata(0) = '0')) then
						nstate := r_Idle;
						ca_out_d_var := true;
						pop <= '1';
					elsif(cr_in and (pop_ack = '0')) then
						pop <= '1';
						nstate := r_Wait_On_Queue;
					elsif(not cr_in) then
						nstate := r_Idle;
					end if;
				end if;
		end case;

		-- done separately below.
		--   Xilinx xst optimization seems to be imperfect
		--   and we need to help it out.
		--
		-- ca_out_u <= ca_out_u_var;
		-- cr_out <= cr_out_var;

		if(clk'event and clk = '1') then
			if(reset = '1') then
				rhs_state <= r_Idle;
				ca_out_d <= false;
				c_counter <= 0;
			else
				ca_out_d <= ca_out_d_var;
				rhs_state <= nstate;
				c_counter <= next_c_counter;
			end if;
		end if;
	end process;


	-- Mealy outputs (to ensure that xst doesn't screw up.)
	cr_out <=  (((rhs_state = r_Idle) and cr_in and (pop_ack = '1') and (qdata(0) = '1')) 
				or
			 ((rhs_state = r_Wait_On_Queue) and (pop_ack = '1') and (qdata(0) = '1'))
				or
			  ((rhs_state = r_Wait_On_Ack_In) and ca_in and 
						cr_in and (pop_ack = '1') and (qdata(0) = '1')));

	ca_out_u <= (((rhs_state = r_Wait_On_Queue) and (pop_ack = '1') and (qdata(0) = '0'))
				or
			 ((rhs_state = r_Wait_On_Queue) and (pop_ack = '1') and (qdata(0) = '1') and ca_in)
				or
			 ((rhs_state = r_Wait_On_Ack_In) and ca_in));


end Behave;
