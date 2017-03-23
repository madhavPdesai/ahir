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

entity UnloadBuffer is
  generic (name: string; buffer_size: integer ; data_width : integer ; 
			bypass_flag : boolean := false; 
			nonblocking_read_flag : boolean := false;
			full_rate: boolean);
  port ( write_req: in std_logic;
        write_ack: out std_logic;
        write_data: in std_logic_vector(data_width-1 downto 0);
        unload_req: in boolean;
        unload_ack: out boolean;
        read_data: out std_logic_vector(data_width-1 downto 0);
        clk : in std_logic;
        reset: in std_logic);
end UnloadBuffer;

architecture default_arch of UnloadBuffer is

  signal pop_req, pop_ack, push_req, push_ack: std_logic_vector(0 downto 0);
  signal pipe_data_out:  std_logic_vector(data_width-1 downto 0);

  -- for waveforms..
  signal output_register: std_logic_vector(data_width-1 downto 0);

  signal unload_ack_reg: boolean;

  type UnloadFsmState is (idle, waiting);
  signal fsm_state : UnloadFsmState;

begin  -- default_arch

  assert (buffer_size > 0) report "Unload buffer size must be > 0" & ": buffer = " & name  severity error;

  -- the input pipe.
  bufPipe : PipeBase generic map (
        name =>  name & "-blocking_read-bufPipe",
        num_reads  => 1,
        num_writes => 1,
        data_width => data_width,
        lifo_mode  => false,
	shift_register_mode => false,
        depth      => buffer_size,
	full_rate  => full_rate)
      port map (
        read_req   => pop_req,
        read_ack   => pop_ack,
        read_data  => pipe_data_out,
        write_req  => push_req,
        write_ack  => push_ack,
        write_data => write_data,
        clk        => clk,
        reset      => reset);

  -- Input protocol.
  write_ack <= push_ack(0);
  push_req(0) <= write_req;


  -- FSM
  --   Two states: Idle, Waiting
  process(clk, reset, fsm_state, unload_req, pop_ack, pipe_data_out, output_register)
     variable nstate: UnloadFsmState;
     variable pop_reqv : std_logic;
     variable next_output_register_var, read_data_var: std_logic_vector(data_width-1 downto 0);
     variable unload_ack_var, next_unload_ack_reg_var : Boolean;
  begin
     nstate :=  fsm_state;
     pop_reqv := '0';

     next_output_register_var := output_register;
     read_data_var := output_register;
     next_unload_ack_reg_var := false;
     unload_ack_var := unload_ack_reg;
  
     case fsm_state is
         when idle => 
               if(unload_req) then
               	 pop_reqv := '1';   
                 if (pop_ack(0) = '1') then
		    	next_output_register_var := pipe_data_out;
			next_unload_ack_reg_var := true;
		 elsif (nonblocking_read_flag) then
		    	next_output_register_var := (others => '0');
			next_unload_ack_reg_var := true;
		 else 
			nstate := waiting;
		 end if;
               end if;
	 when waiting =>
		pop_reqv := '1';
	        if(pop_ack(0) = '1') then
		    unload_ack_var := true;
		    read_data_var := pipe_data_out;
		    next_output_register_var := pipe_data_out;
		    nstate := idle;
		elsif (nonblocking_read_flag) then
		    unload_ack_var := true;
		    next_output_register_var := (others => '0');
		    nstate := idle;
		end if;
		if(unload_req) then
		    nstate := waiting;
		end if;
     end case;
 
     pop_req(0) <= pop_reqv;
     unload_ack <= unload_ack_var;
     read_data <= read_data_var;


     -- help XST out..  write the function explicitly below.

     if(clk'event and clk = '1') then
	if(reset = '1') then
		fsm_state <= idle;
		unload_ack_reg <= false;
		output_register <= (others => '0');
	else
		fsm_state <= nstate;
		unload_ack_reg <= next_unload_ack_reg_var;
		output_register <= next_output_register_var;
	end if;
     end if;
  end process;

end default_arch;
