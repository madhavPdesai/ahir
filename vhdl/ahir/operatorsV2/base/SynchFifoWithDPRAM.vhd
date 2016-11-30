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
-- copyright: Madhav Desai
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Utilities.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;
use ahir.mem_component_pack.all;

entity SynchFifoWithDPRAM is
  generic(name: string; queue_depth: integer := 3; data_width: integer := 72);
  port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(data_width-1 downto 0);
       push_req: in std_logic;
       push_ack : out std_logic;
       nearly_full: out std_logic;
       data_out: out std_logic_vector(data_width-1 downto 0);
       pop_ack : out std_logic;
       pop_req: in std_logic);
end entity SynchFifoWithDPRAM;

architecture behave of SynchFifoWithDPRAM is

  constant addr_width_of_dpram: integer := Ceil_Log2(queue_depth);
  signal read_pointer, write_pointer : unsigned(addr_width_of_dpram-1 downto 0);
  signal queue_size : integer range 0 to queue_depth;

  signal pop_ack_int, pop_req_int: std_logic;
  signal data_out_int : std_logic_vector(data_width-1 downto 0);

  function Incr(x: unsigned; M: integer) return unsigned is
     variable ret_var: unsigned(1 to x'length);
  begin
    if(x < M) then
      	ret_var := (x + 1);
    else
	ret_var := (others => '0');
    end if;
    return(ret_var);
  end Incr;

  signal incr_read_pointer, incr_write_pointer : unsigned(addr_width_of_dpram-1 downto 0);

  signal write_to_dpram, read_from_dpram: std_logic;
  signal tied_to_low, tied_to_high : std_logic;
  signal data_out_0_unused, data_tied_to_low: std_logic_vector(data_width-1 downto 0);
  
begin  -- SimModel

  tied_to_low <= '0';
  tied_to_high <= '1';
  data_tied_to_low <= (others => '0');

  assert(queue_depth > 2) report "Synch FIFO depth must be greater than 2" severity failure;
  assert (queue_size < queue_depth) report "Queue " & name & " is full." severity note;

  qD1: if (queue_depth = 1) generate
     incr_read_pointer <= read_pointer;
     incr_write_pointer <= write_pointer;
  end generate qD1;

  qDG1: if (queue_depth > 1) generate
     incr_read_pointer <= Incr(read_pointer, queue_depth-1);
     incr_write_pointer <= Incr(write_pointer, queue_depth-1);
  end generate qDG1;
  
  -- single process
  process(clk,reset,queue_size,push_req,pop_req_int,read_pointer, write_pointer, incr_read_pointer, incr_write_pointer)
    variable qsize : integer range 0 to queue_depth;
    variable push_ack_v, pop_ack_v, nearly_full_v: std_logic;
    variable push,pop : boolean;
    variable next_read_ptr,next_write_ptr : unsigned(addr_width_of_dpram-1 downto 0);

  begin

    
    qsize := queue_size;
    push  := false;
    pop   := false;
    next_read_ptr := read_pointer;
    next_write_ptr := write_pointer;
    
    if(queue_size < queue_depth) then
      push_ack_v := '1';
    else
      push_ack_v := '0';
    end if;

    if(queue_size < queue_depth-1) then
      nearly_full_v := '0';
    else
      nearly_full_v := '1';
    end if;

    if(queue_size > 0) then
      pop_ack_v := '1';
    else
      pop_ack_v := '0';
    end if;


    
    if(push_ack_v = '1' and push_req = '1') then
      push := true;
    end if;

    if(pop_ack_v = '1' and pop_req_int = '1') then
      pop := true;
    end if;

    if(push) then
      next_write_ptr := incr_write_pointer;
      write_to_dpram <= '1';
    else
      write_to_dpram <= '0';
    end if;

    if(pop) then
      next_read_ptr := incr_read_pointer;
      read_from_dpram <= '1';
    else
      read_from_dpram <= '0';
    end if;


    if(pop and (not push)) then
      qsize := qsize - 1;
    elsif(push and (not pop)) then
      qsize := qsize + 1;
    end if;
    

    push_ack <= push_ack_v;

    nearly_full <= nearly_full_v;
    
    if(clk'event and clk = '1') then
      if(reset = '1') then
        pop_ack_int  <=  '0';        
	queue_size <= 0;
        read_pointer <= (others => '0');
        write_pointer <= (others => '0');
      else
        pop_ack_int  <=  pop_ack_v and pop_req_int;        
        queue_size <= qsize;
        read_pointer <= next_read_ptr;
        write_pointer <= next_write_ptr;
      end if;
    end if;
    
  end process;

  dpramInst: base_bank_dual_port
		generic map (name => name & "-dpram", 
				g_addr_width => addr_width_of_dpram,
				g_data_width => data_width)
		port map (
				datain_0 =>  data_in,
				dataout_0 => data_out_0_unused,
				addrin_0 =>  std_logic_vector(write_pointer),
				enable_0 => write_to_dpram,
				writebar_0  => tied_to_low,
				datain_1 => data_tied_to_low,
				dataout_1 => data_out_int,
				addrin_1 =>  std_logic_vector(read_pointer),
				enable_1 => read_from_dpram,
				writebar_1  => tied_to_high,
				clk => clk, 
				reset => reset
			 );

  opReg: SynchToAsynchReadInterface 
		generic map(name => name & "-opReg", 
			data_width => data_width)
		port map(clk => clk, reset => reset,
			 synch_req => pop_ack_int,
			 synch_ack => pop_req_int,
			 asynch_req => pop_ack,
			 asynch_ack => pop_req,
			 synch_data => data_out_int,
			 asynch_data => data_out);
end behave;


