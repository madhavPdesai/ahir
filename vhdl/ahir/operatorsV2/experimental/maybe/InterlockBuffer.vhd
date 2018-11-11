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
use ahir.GlobalConstants.all;

-- Synopsys DC ($^^$@!)  needs you to declare an attribute
-- to infer a synchronous set/reset ... unbelievable.
--##decl_synopsys_attribute_lib##

entity InterlockBuffer is
  generic (name: string; buffer_size: integer := 2; 
  in_data_width : integer := 32;
  out_data_width : integer := 32;
  flow_through: boolean := false;
  bypass_flag : boolean := false;
  full_rate : boolean);
  port (write_req: in boolean;
        write_ack: out boolean;
        write_data: in std_logic_vector(in_data_width-1 downto 0);
        read_req: in boolean;
        read_ack: out boolean;
        read_data: out std_logic_vector(out_data_width-1 downto 0);
        clk : in std_logic;
        reset: in std_logic);
end InterlockBuffer;

architecture default_arch of InterlockBuffer is

  constant data_width: integer := Minimum(in_data_width,out_data_width);
  constant shallow_flag : boolean :=    (buffer_size = 1);
  constant simplified_flag : boolean := full_rate and shallow_flag and (not flow_through);

  signal buf_write_req, buf_write_ack: std_logic;
  signal buf_write_data, buf_read_data:  std_logic_vector(data_width-1 downto 0);

  type LoadFsmState is (l_idle, l_busy);
  signal l_fsm_state : LoadFsmState;
  
-- see comment above..
--##decl_synopsys_sync_set_reset##

begin  -- default_arch

  -- interlock buffer must have buffer-size > 0
  assert buffer_size > 0 report " interlock buffer size must be > 0 " severity failure;

  flowThrough: if flow_through generate

    write_ack <= write_req;
    read_ack <= read_req;

    inSmaller: if in_data_width <= out_data_width generate
      process(write_data)
        variable rvar : std_logic_vector(out_data_width-1 downto 0);
      begin
        rvar := (others => '0');
        rvar(in_data_width-1 downto 0) := write_data;
        read_data <= rvar;
      end process;
    end generate inSmaller;

    outSmaller: if out_data_width < in_data_width generate
      read_data <= write_data(out_data_width-1 downto 0);
    end generate outSmaller;

  end generate flowThrough;


  simpleGen: if simplified_flag generate
	ilbSimplified: InterlockBufferSimplified
			generic map (name => name & ":Simplified",
					buffer_size => buffer_size,
  					data_width  => data_width)
  			port map (
					write_req => write_req,
        				write_ack => write_ack,
        				write_data => write_data,
        				read_req => read_req,
        				read_ack => read_ack,
        				read_data => read_data,
        				clk  => clk,
        				reset => reset
				);
  end generate simpleGen;

  notSimpleGen: if (not simplified_flag) and (not flow_through) generate

      inSmaller: if in_data_width <= out_data_width generate
        buf_write_data <= write_data;
  
        process(buf_read_data)
          begin
          read_data <= (others => '0');
          read_data(data_width-1 downto 0)  <= buf_read_data;
        end process;
      end generate inSmaller;
  
      outSmaller: if out_data_width < in_data_width generate
        buf_write_data <= write_data(data_width-1 downto 0);
        read_data  <= buf_read_data;
      end generate outSmaller;
  
      -- write FSM to pipe.
      p2l: Sample_Pulse_To_Level_Translate_Entity
		generic map (name => name & ":p2l")
		port map (rL => write_req, rR => buf_write_req,
				aL => write_ack, aR => buf_write_ack,
					clk => clk, reset => reset);


      -- the unload buffer.
      buf : UnloadBuffer generic map (
        name =>  name & " buffer ",
        data_width => data_width,
        buffer_size => buffer_size, 
        bypass_flag => false,
        full_rate => full_rate)
        port map (
          write_req   => buf_write_req,
          write_ack   => buf_write_ack,
          write_data  => buf_write_data,
          unload_req  => read_req,
          unload_ack  => read_ack,
          read_data   => buf_read_data,
          clk         => clk,
          reset       => reset);
  end generate notSimpleGen;

end default_arch;
