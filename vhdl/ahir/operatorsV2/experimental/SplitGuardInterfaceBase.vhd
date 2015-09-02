library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;


-- a guard-interface to conform with the split protocol.
-- With this interface, the guard at the time of initiation
-- of the operation will be remembered (using a queue) 
-- and the remembered value will be used to generate the
-- completion protocol.
-- 
-- The benefit is that the guard-expression can be reevaluated
-- as soon as the operation starts (instead of waiting
-- for the operation to finish...).  This helps pipelining.
-- TODO: QueueBase can be replaced with a simpler shift-stage?
--       (maybe not.., because this slows down the guard=0 case).
entity SplitGuardInterfaceBase is
	generic (buffering:integer);
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

  type LhsState is (l_Idle, l_Wait_On_Ack_In, l_Wait_On_Queue);
  signal lhs_state : LhsState;

  type RhsState is (r_Idle, r_Wait_On_Ack_In, r_Wait_On_Queue);
  signal rhs_state: RhsState;

  -- for debug purposes only
  signal s_counter, c_counter: integer;

  signal ca_out_d, ca_out_u: Boolean;
begin
	ca_out <= ca_out_d or ca_out_u;

	qdata_in(0) <= guard_interface;

	qI: QueueBase
		generic map(queue_depth => buffering, data_width => 1)
		port map(clk => clk, reset => reset,
				data_in => qdata_in,
				push_req => push,
				push_ack => push_ack,
				data_out => qdata,
				pop_req => pop,
				pop_ack => pop_ack);

	-- LHS state machine.
        -- 
	------------------------------------------------------------------------------------------
        --   Present-state  sr_in  push_ack guard_interface sa_in    Nstate  sr_out  sa_out  push
	------------------------------------------------------------------------------------------
        --     l_Idle        0        _          _            _      l_Idle
 	--     l_Idle        1        1          0            _      l_Idle            1      1
	--     l_Idle        1        1          1            0      W-ack-in  1              1
	--     l_Idle        1        1          1            1      l_Idle    1       1      1
	--     l_Idle        1        0          _            _      W-Queue   
	------------------------------------------------------------------------------------------
        --   Present-state  sr_in  push_ack guard_interface sa_in    Nstate  sr_out  sa_out  push
	------------------------------------------------------------------------------------------
	--     W-Queue       _        0          _            _      W-Queue
	--     W-Queue       _        1          1            1      l_Idle    1       1      1
	--     W-Queue       _        1          1            0      W-ack-in  1              1
	--     W-Queue       _        1          0            _      l_Idle            1      1
	------------------------------------------------------------------------------------------
        --   Present-state  sr_in  push_ack guard_interface sa_in    Nstate  sr_out  sa_out  push
	------------------------------------------------------------------------------------------
	--     W-Ack-In      _        _          _            0      W-ack-in
	--     W-Ack-In      _        _          _            1      l_Idle            1
	------------------------------------------------------------------------------------------
	process(clk, sr_in, push_ack, guard_interface, sa_in, lhs_state, reset)
		variable nstate : LhsState;
		variable next_s_counter: integer;
	begin
		nstate 	:= lhs_state;
		sr_out 	<= false;
		sa_out 	<= false;
		push	<= '0';
 		next_s_counter := s_counter;

		case lhs_state is
			when l_Idle => 
				if sr_in then
					if((push_ack = '1') and (guard_interface = '0')) then
						sa_out <= true;
						push   <= '1';
					elsif ((push_ack = '1') and (guard_interface = '1')) then
						if sa_in then
							sa_out 	<= true;
							sr_out 	<= true;
							next_s_counter := (next_s_counter + 1);
							push 	<= '1';
						else	
							nstate 	:= l_Wait_On_Ack_In;
							sr_out 	<= true;
							next_s_counter := (next_s_counter + 1);
							push 	<= '1';
						end if;
					elsif (push_ack = '0') then
						nstate := l_Wait_On_Queue;
					end if;
				end if;
			when l_Wait_On_Queue => 
				if(push_ack  = '1') then
					if((guard_interface = '1') and sa_in) then
						nstate := l_Idle;
						sa_out <= true;
						sr_out <= true;
						next_s_counter := (next_s_counter + 1);
						push <= '1';
					elsif ((guard_interface = '1') and (not sa_in)) then
						nstate := l_Wait_On_Ack_In;
						sr_out <= true;
						next_s_counter := (next_s_counter + 1);
						push   <= '1';
					elsif (guard_interface = '0') then
						nstate := l_Idle;
						sa_out <= true;
						push <= '1';
					end if;
				end if;
			when l_Wait_On_Ack_In => 
				if sa_in then
					nstate := l_Idle;
					sa_out <= true;
				end if;
		end case;

		if(clk'event and clk = '1') then
			if(reset = '1') then
				lhs_state <= l_Idle;
				s_counter <= 0;
			else
				lhs_state <= nstate;
				s_counter <= next_s_counter;
			end if;
		end if;
	end process;


	-- RHS State machine.
	------------------------------------------------------------------------------------------
        --   Present-state  cr_in  pop_ack      qdata        ca_in    Nstate  cr_out  ca_out  pop
	------------------------------------------------------------------------------------------
	--   r_Idle          0        _           _            _      r_Idle
	--   r_Idle          1        0           _            _      W-Queue
	--   r_Idle          1        1           1            1      r_Idle    1      1       1
	--   r_Idle          1        1           1            0      W-Ack-In  1              1
	--   r_Idle          1        1           0            _      r_Idle           1d      1
	------------------------------------------------------------------------------------------
        --   Present-state  cr_in  pop_ack      qdata        ca_in    Nstate  cr_out  ca_out  pop
	------------------------------------------------------------------------------------------
	--   W-Queue         _        0           _            _      W-Queue
	--   W-Queue         _        1           1            0      W-Ack-In  1              1
	--   W-Queue         _        1           1            1      r_Idle    1      1       1
	--   W-Queue         0        1           0            _      r_Idle           1       1
	--   W-Queue         1        1           0            _      W-Queue          1       1
	------------------------------------------------------------------------------------------
        --   Present-state  cr_in  pop_ack      qdata        ca_in    Nstate  cr_out  ca_out  pop
	------------------------------------------------------------------------------------------
	--   W-Ack-In        _        _           _            0      W-Ack-In  
	--   W-Ack-In        1        1           1            1      W-Ack-In  1       1      1
	--   W-Ack-In        1        1           0            1      r_Idle            1,1d   1
	--   W-Ack-In        1        0           _            1      W-Queue           1
	--   W-Ack-In        0        _           _            1      r_Idle            1  
	------------------------------------------------------------------------------------------
	process(clk,cr_in,pop_ack,qdata,ca_in,rhs_state,reset)
		variable nstate : RhsState;
		variable ca_out_u_var : Boolean;
		variable ca_out_d_var : Boolean;
		variable next_c_counter: integer;
	begin
		nstate := rhs_state;
		pop <= '0';
		cr_out <= false;
		ca_out_u_var := false;
		ca_out_d_var := false;
		next_c_counter := c_counter;

		case rhs_state is
			when r_Idle =>
				if cr_in then
					--
					-- what happens in ca_in appears immediately?
					--	
					if(pop_ack = '0') then
						nstate := r_Wait_On_Queue;			
					else
						pop <= '1';
						if(qdata(0) = '1') then
							cr_out <= true;
							if(ca_in) then	
								ca_out_u_var := true;
							else
								nstate := r_Wait_On_Ack_In;
							end if;
							next_c_counter := (next_c_counter + 1);
						else
							ca_out_d_var := true;
							nstate := r_Idle;
						end if;
					end if;
				end if;
			when r_Wait_On_Queue =>
				if(pop_ack = '1') then
					pop <= '1';
					if(qdata(0) = '1') then
						cr_out <= true;

						if(ca_in) then	
							ca_out_u_var := true;
							nstate := r_Idle;
						else
							nstate := r_Wait_On_Ack_In;
						end if;
					
						nstate := r_Wait_On_Ack_In;
						next_c_counter := (next_c_counter + 1);
					else
						ca_out_u_var := true;
						if(cr_in) then
							nstate := r_Wait_On_Queue;
						else
							nstate := r_Idle;
						end if;
					end if;
				end if;
			when r_Wait_On_Ack_In =>
				if(ca_in) then 
					if(cr_in  and (pop_ack = '1') and (qdata(0) = '1')) then
						ca_out_u_var := true;
						pop <= '1';
						cr_out <= true;
						next_c_counter := (next_c_counter + 1);
					elsif(cr_in and (pop_ack = '1') and (qdata(0) = '0')) then
						nstate := r_Idle;
						ca_out_d_var := true;
						ca_out_u_var := true;
						pop <= '1';
					elsif(cr_in and (pop_ack = '0')) then
						nstate := r_Wait_On_Queue;
						ca_out_u_var := true;	
					elsif(not cr_in) then
						nstate := r_Idle;
						ca_out_u_var := true;
					end if;
				end if;
		end case;

		ca_out_u <= ca_out_u_var;

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

end Behave;
