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

--
-- The unload buffer is used all over the place.  We will use
-- three forms
--     depth <= 1
--         fast cut through with buffering provided by a single register
--     depth = 2
--         1 + 1 split with bypass in the first part.
--     depth > 2
--         (n-1) + 1 split with no bypass provided in the
--         second part.
--
--  Using shallow buffers (<=2) will result in fast in->out 
--  performance but combinational through paths.  Using deeper
--  buffers will result in at least one unit of delay from in->out
--
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
  signal pipe_data_out, data_to_unload_register:  std_logic_vector(data_width-1 downto 0);

  signal number_of_elements_in_pipe: unsigned ((Ceil_Log2(buffer_size+2))-1 downto 0); 
  signal pipe_has_data: boolean;

  signal unload_register_ready: boolean;

  signal pop_req_from_unload_register : std_logic;
  signal pop_ack_to_unload_register   : std_logic;

  signal write_to_pipe: boolean;
  signal unload_from_pipe : boolean;

  --
  -- try to save a slot if buffer size is 1... this
  -- tries to prevent a 100% wastage of resources
  -- and allows us to use 2-depth buffers to cut long
  -- combinational paths.
  --
  constant save_slot_flag : boolean := ((not bypass_flag) and (buffer_size = 1));
  constant bypass_flag_to_ureg : boolean := (bypass_flag or (buffer_size = 0));

  constant shallow_flag : boolean :=    (buffer_size < global_pipe_shallowness_threshold);

-- see comment above..
--##decl_synopsys_sync_set_reset##
begin  -- default_arch

  DeepCase: if not shallow_flag generate
	ulb_deep: UnloadBufferDeep
			generic map (name => name & "-deep",
					buffer_size => buffer_size, data_width => data_width,
						nonblocking_read_flag => nonblocking_read_flag)
			port map (
				write_req => write_req,
				write_ack => write_ack,
				unload_req => unload_req,
				unload_ack => unload_ack,
				write_data => write_data,
				read_data => read_data, 
				clk => clk, reset => reset);
  end generate DeepCase;

  ShallowCase: if shallow_flag generate
    bufGt0: if buffer_size > 0 generate

		-- count number of elements in pipe.
	process(clk, reset)
  	begin
		if(clk'event and clk = '1') then
			if(reset = '1') then
				number_of_elements_in_pipe <= (others => '0');
			else
				if((pop_req(0) = '1') and (pop_ack(0) = '1')) then
					if(not ((push_req(0) = '1') and (push_ack(0) = '1'))) then
				          number_of_elements_in_pipe <= (number_of_elements_in_pipe -1);
					end if;
				elsif((push_req(0) = '1') and (push_ack(0) = '1')) then
					number_of_elements_in_pipe <= (number_of_elements_in_pipe + 1);
				end if;
			end if;
		end if;
  	end process;
	
  	pipe_has_data <= (number_of_elements_in_pipe > 0);
	write_to_pipe <= (pipe_has_data or (not unload_register_ready));
	unload_from_pipe <= pipe_has_data;

	unload_register_ready <= (pop_req_from_unload_register = '1');
 
	-- if pipe does not have data, then we will be bypassing write-data straight
	-- to the unload-register, if it is ready to accept stuff.
	push_req(0) <= write_req when write_to_pipe else '0';
	write_ack   <= push_ack(0);

	pop_ack_to_unload_register <= pop_ack(0) when unload_from_pipe else write_req;
	pop_req(0)  <= pop_req_from_unload_register;
	data_to_unload_register <= pipe_data_out when unload_from_pipe else write_data;

  	-- the input pipe.
  	bufPipe : PipeBase generic map (
        	name =>  name & "-blocking_read-bufPipe",
        	num_reads  => 1,
        	num_writes => 1,
        	data_width => data_width,
        	lifo_mode  => false,
		shift_register_mode => false,
        	depth      => buffer_size,
		save_slot  => save_slot_flag,
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

   end generate bufGt0;
	

   -- unload-register will provide bypassed buffering.
   bufEq0: if (buffer_size = 0) generate
	data_to_unload_register <= write_data;
	pop_ack_to_unload_register <= write_req;
	write_ack  <= pop_req_from_unload_register;
   end generate bufEq0;

   ulReg: UnloadRegister 
			generic map (name => name & "-unload-register",
					data_width => data_width,
						bypass_flag => bypass_flag_to_ureg,
						   nonblocking_read_flag => nonblocking_read_flag)
			port map (
					write_data => data_to_unload_register,
					write_req => pop_ack_to_unload_register,
					write_ack => pop_req_from_unload_register,
					unload_req => unload_req,
					unload_ack => unload_ack,
					read_data => read_data,
					clk => clk,  reset => reset
				);
							
 end generate ShallowCase;

end default_arch;
