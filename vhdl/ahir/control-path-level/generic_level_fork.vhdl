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
use ahir.subprograms.all;
use ahir.BaseComponents.all;
use ahir.utilities.all;


--
-- A control fork which triggers
-- multiple actions from a single
-- source.  A ready-ready level protocol
-- is used.
--
-- There is 0-delay path from 
--    req_in -> req_out.
--    req_in -> ack_out.
--    ack_in -> ack_out.
--
-- Because of these paths, the level-fork is
-- to be used only in constructing level protocol
-- based pipelines.
--
--
entity generic_level_fork is
  generic(name: string; num_reqs: integer)
  port ( req_out      : out   std_logic_vector(num_reqs-1 downto 0);
         ack_in     : in  std_logic_vector(num_reqs-1 downto 0);
    	 req_in : in  std_logic;
	 ack_out  : out   std_logic;
	 clk: in std_logic;
	 reset: in std_logic);
end generic_level_fork;

architecture default_arch of generic_level_fork is
  signal   req_in_repeated: std_logic;

  signal   ack_join_vector: std_logic_vector(num_reqs-1 downto 0);
  signal   ack_joined: std_logic;

  constant const_one: std_logic_vector((num_reqs-1) downto 0) := (others => '1');
  constant const_zero: std_logic_vector((num_reqs-1) downto 0) := (others => '0');

  signal repeater_state: std_logic;
begin  -- default_arch

  ack_joined <= AndReduce (ack_join_vector);

  -- repeater fsm..
  process(clk, reset, repeater_state, req_in, ack_joined)
 	variable next_repeater_state: std_logic;
	variable ack_out_var: std_logic;
	variable req_in_repeated_var: std_logic;
  begin
	next_repeater_state := repeater_state;

	ack_out_var := '0';
	req_in_repeated_var := '0';

	case repeater_state is
		when '0' =>
			if (req_in = '1') then
				req_in_repeated_var := '1';
				if(ack_joined = '1') then
					ack_out_var := '1';
				else
					next_repeater_state := '1';
				end if;
			end if;
		when '1' =>
			if(ack_joined = '1') then
				ack_out_var := '1';
			end if;
	end case;

	ack_out <= ack_out_var;
	req_in_repeated <= req_in_repeated_var;

	if (clk'event and clk = '1') then
		repeater_state <= (not reset) and next_repeater_state;
	end if;
				
  end process;
 
  RepGen for I in 0 to num_reqs-1 generate
     blk: block
	signal fsm_state: std_logic;
     begin

  	process(clk, reset, fsm_state, req_in_repeated(I), ack_in(I))
		variable next_fsm_state_var: std_logic;
		variable ack_var: std_logic;
		variable req_var: std_logic;
	begin
		next_fsm_state_var := fsm_state;
		ack_var := '0';
		req_var := '0';

		case fsm_state is
			when '0' =>
				if(req_in_repeated(I) = '1') then
					req_var := '1';
					if (ack_in(I) = '1') then
						ack_var := '1';
					else
						next_fsm_state_var := '1';
					end if;
				end if;
			when '1' =>
				req_var := '1';
				if (ack_in(I) = '1') then
					ack_var := '1';
					next_fsm_state_var := '0';
				end if;
		end case;

		req_out(I) <= req_var;
		ack_join_vector(I) <= ack_var;

		if (clk'event and (clk = '1')) then
			fsm_state <= (not reset) and next_fsm_state_var;
		end if;
	end process;
     end block;
  end generate RepGen;

end default_arch;
