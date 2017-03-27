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
  signal output_register_prereg: std_logic_vector(data_width-1 downto 0);
  signal load_reg: boolean;

  type UnloadFsmState is (idle, waiting);
  signal fsm_state : UnloadFsmState;


  signal number_of_elements_in_pipe: integer range 0 to buffer_size+1;
  signal pipe_has_data: boolean;
begin  -- default_arch

  --assert (buffer_size > 0) report "Unload buffer size must be > 0" & ": buffer = " & name  severity error;

  -- count number of elements in pipe.
  process(clk, reset)
  begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			number_of_elements_in_pipe <= 0;
		else
			if((pop_req(0) = '1') and (pop_ack(0) = '1')) then
				if(not ((push_req(0) = '1') and (push_ack(0) = '1'))) then
					number_of_elements_in_pipe <= number_of_elements_in_pipe - 1;
				end if;
			elsif((push_req(0) = '1') and (push_ack(0) = '1')) then
				number_of_elements_in_pipe <= number_of_elements_in_pipe + 1;
			end if;
		end if;
	end if;
  end process;

  pipe_has_data <= (number_of_elements_in_pipe > 0);
  
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
  write_ack <= push_ack(0);


  -- FSM
  --   Two states: Idle, Waiting
  process(clk,fsm_state, unload_req, pipe_has_data, pop_ack, write_req, write_data, pipe_data_out)
     variable nstate: UnloadFsmState;
     variable loadv : boolean;
     variable pop_reqv, push_reqv : std_logic;
     variable datav: std_logic_vector(data_width-1 downto 0);
  begin
     nstate :=  fsm_state;
     pop_reqv := '0';
     push_reqv := write_req;
     loadv := false;
     datav := (others => '0');
  
     case fsm_state is
         when idle => 
               if(unload_req) then
               	 pop_reqv := '1';   
                 if (pop_ack(0) = '1') then
		    -- load output register.
		    	loadv := true;
		    	datav := pipe_data_out;
		 elsif ((not pipe_has_data) and (write_req = '1')) then
			loadv := true;
			datav := write_data;
			-- write-data forwarded to output, don't push into queue.
			push_reqv := '0';
		 elsif (nonblocking_read_flag) then
			loadv := true; -- load zero into output register.
		 else 
		        -- desire to unload, but nothing present.
			nstate := waiting;
		 end if;
               end if;
	 when waiting =>
		pop_reqv := '1';
	        if(pop_ack(0) = '1') then
		    -- ack the unload-req.
		    loadv := true;
		    datav := pipe_data_out;
		    nstate := idle;

		elsif ((not pipe_has_data) and (write_req = '1')) then

		    -- lets not add an in->out combinational
		    -- path which can really bite us later.

		    loadv := true;
		    datav := write_data;
		    push_reqv := '0';
		    nstate := idle;
		end if;
     end case;
 
     pop_req(0) <= pop_reqv;
     push_req(0) <= push_reqv;
     load_reg <= loadv;
     output_register_prereg <= datav;

     -- help XST out..  write the function explicitly below.

     if(clk'event and clk = '1') then
	if(reset = '1') then
		fsm_state <= idle;
		unload_ack <= false;
	else
		fsm_state <= nstate;
		unload_ack <= loadv;
	end if;

	if(loadv) then
           read_data <= datav;
        end if;
     end if;
  end process;

end default_arch;
