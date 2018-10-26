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

-- Synopsys DC ($^^$@!)  needs you to declare an attribute
-- to infer a synchronous set/reset ... unbelievable.
--##decl_synopsys_attribute_lib##

--
-- Will run at full speed...
--
entity InterlockBufferLevel is
  generic (name: string; buffer_size: integer := 2; 
  		in_data_width : integer := 32;
  		out_data_width : integer := 32;
  		flow_through: boolean := false;
  		non_blocking_read_flag: boolean ;= false);
  port (write_req: in std_logic;
        write_ack: out std_logic;
        write_data: in std_logic_vector(in_data_width-1 downto 0);
        read_req: in std_logic;
        read_ack: out std_logic;
        read_data: out std_logic_vector(out_data_width-1 downto 0);
        clk : in std_logic;
        reset: in std_logic);
end InterlockBufferLevel;

architecture default_arch of InterlockBufferLevel is

  constant data_width: integer := Minimum(in_data_width,out_data_width);

  signal read_data_sig: std_logic_vector(out_data_width-1 downto 0);
  signal buf_write_req, buf_write_ack: std_logic_vector(0 downto 0);
  signal buf_read_req,  buf_red_ack:   std_logic_vector(0 downto 0);
  signal buf_write_data, buf_read_data:  std_logic_vector(data_width-1 downto 0);
  
-- see comment above..
--##decl_synopsys_sync_set_reset##

begin  -- default_arch

  -- interlock buffer must have buffer-size > 0
  assert (flow_through or (buffer_size > 0)) 
			report " interlock buffer size in non-flow-through case  must be > 0 " 
			severity failure;
  
  flowThrough: if (flow_through or (buffer_size = 0)) generate

    write_ack <= write_req;
    read_ack <= read_req;

    inSmaller: if in_data_width <= out_data_width generate
      process(write_data)
        variable rvar : std_logic_vector(out_data_width-1 downto 0);
      begin
        rvar := (others => '0');
        rvar(in_data_width-1 downto 0) := write_data;
        read_data_sig <= rvar;
      end process;
    end generate inSmaller;

    outSmaller: if out_data_width < in_data_width generate
      read_data_sig <= write_data(out_data_width-1 downto 0);
    end generate outSmaller;

  end generate flowThrough;

  NoFlowThrough: if (not flow_through) generate


    interlockBuf: if (buffer_size > 0) generate
      inSmaller: if in_data_width <= out_data_width generate
        buf_write_data <= write_data;
  
        process(buf_read_data, buf_read_ack)
          begin
          	read_data_sig <= (others => '0');
          	read_data_sig(data_width-1 downto 0)  <= buf_read_data;
        end process;
      end generate inSmaller;
  
      outSmaller: if out_data_width < in_data_width generate
        buf_write_data <= write_data(data_width-1 downto 0);
        read_data_sig  <= buf_read_data;
      end generate outSmaller;
  
      buf_write_req(0) <= write_req;
      write_ack <= buf_write_ack(0);

      buf_read_req(0) <= read_req;

      noblockGen: if non_blocking_read_flag generate
      	read_data <= read_data_sig when (buf_read_ack(0) = '1') else (others => '0');
	read_ack  <= '1';
      end generate noblockGen;

      blockGen: if (not non_blocking_read_flag) generate
      	 read_ack <= buf_read_ack(0);
	 read_data <= read_data_sig;
      end generate blockGen;

      pipeGen: if (buffer_size > 1) generate
        buf : PipeBase generic map (
          name =>  name & " buffer ",
	  num_reads => 1,
	  num_writes => 1,
          data_width => data_width,
          buffer_size => buffer_size, 
          full_rate => full_rate)
        port map (
          write_req   => buf_write_req,
          write_ack   => buf_write_ack,
          write_data  => buf_write_data,
          read_req    => buf_read_req,
          read_ack    => buf_read_ack,
          read_data   => buf_read_data,
          clk         => clk,
          reset       => reset);
        end generate pipeGen;

        rptrGen: if (buffer_size = 1) generate
          lrptr: LevelRepeater
			generic map (name => name & "-repeater", g_data_width => data_width)
			port map (clk=>clk, reset=>reset, 
						data_in => buf_write_data,
						req_in  => buf_write_req(0),
						ack_out => buf_write_ack(0),
						data_out => buf_read_data,
						req_out => buf_read_ack(0),
						ack_in => buf_read_req(0));
        end generate rptrGen;

    end generate interlockBuf;
  end generate NoFlowThrough;

end default_arch;
