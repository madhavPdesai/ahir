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

entity QueueBase is
  generic(name : string; queue_depth: integer := 1; data_width: integer := 32;
		save_one_slot: boolean := false);
  port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(data_width-1 downto 0);
       push_req: in std_logic;
       push_ack: out std_logic;
       data_out: out std_logic_vector(data_width-1 downto 0);
       pop_ack : out std_logic;
       pop_req: in std_logic);
end entity QueueBase;

architecture behave of QueueBase is

  type QueueArray is array(natural range <>) of std_logic_vector(data_width-1 downto 0);

begin  -- SimModel

 --
 -- 0-depth queue is just a set of wires.
 --
 triv: if queue_depth = 0 generate
	push_ack <= pop_req;
	pop_ack  <= push_req;
	data_out <= data_in;
 end generate triv;

 qD1: if (queue_depth = 1) generate
   RB: block
      signal full_flag: boolean;
      signal data_reg: std_logic_vector(data_width-1 downto 0);

   begin

      push_ack <= '1' when (not full_flag) else '0';
      pop_ack  <= '1' when full_flag else '0';
      data_out <= data_reg;

      process(clk, reset, push_req, pop_req, full_flag, data_in, data_reg)
	variable next_full_flag_var: boolean;
        variable next_data_reg_var: std_logic_vector(data_width-1 downto 0);
      begin
	next_full_flag_var := full_flag;
        next_data_reg_var := data_reg;

        if (full_flag) then
           if (pop_req = '1') then
              next_full_flag_var := false;
           end if;
        else 
           if (push_req = '1') then
               next_full_flag_var := true;
               next_data_reg_var :=  data_in;
	   end if;
         end if;
  
       if (clk'event and clk='1') then
         if(reset  = '1') then
            full_flag <= false;
            data_reg <= (others => '0');
         else
             full_flag <= next_full_flag_var;
	     data_reg  <= next_data_reg_var;
         end if;
      end if;
     end process;
   end block;
 end generate qD1;


 qDGt1: if queue_depth > 1 generate 
  NTB: block 
  	signal queue_array : QueueArray(queue_depth-1 downto 0);
  	signal read_pointer, write_pointer, incr_write_pointer, incr_read_pointer : 
			unsigned ((Ceil_Log2(queue_depth))-1 downto 0);

  	constant URW0: unsigned ((Ceil_Log2(queue_depth))-1 downto 0):= (others => '0');

  	signal queue_size : unsigned ((Ceil_Log2(queue_depth+1))-1 downto 0);
  begin
 
    assert (queue_size < queue_depth) report "Queue " & name & " is full." severity note;
    assert (queue_size < (3*queue_depth/4)) report "Queue " & name & " is three-quarters-full." severity note;
    assert (queue_size < (queue_depth/2)) report "Queue " & name & " is half-full." severity note;
    assert (queue_size < (queue_depth/4)) report "Queue " & name & " is quarter-full." severity note;


    incr_read_pointer <= (read_pointer + 1) when (read_pointer < (queue_depth - 1)) else URW0;
    incr_write_pointer <= (write_pointer + 1) when (write_pointer < (queue_depth-1)) else URW0;

    push_ack <= '1' when (queue_size < queue_depth) else '0';
    pop_ack  <= '1' when (queue_size > 0) else '0';

    -- bottom pointer gives the data in FIFO mode..
    -- write it this way to remove warning due to
    -- synopsys dc synthesis.
    process(read_pointer, queue_array) 
       variable data_out_var: std_logic_vector(data_width-1 downto 0);
    begin
       data_out_var := (others => '0');
       for I in queue_array'low to queue_array'high loop
         if (I = To_Integer(read_pointer)) then
       	 	data_out_var := queue_array(I);
         end if;
       end loop;
       data_out <= data_out_var;
    end process;
  
    -- single process
    process(clk, reset, read_pointer, write_pointer, incr_read_pointer, incr_write_pointer, queue_size, push_req, pop_req)
      variable qsize : unsigned (queue_size'high downto queue_size'low);
      variable push,pop : boolean;
      variable next_read_ptr,next_write_ptr : unsigned (read_pointer'high downto read_pointer'low);
    begin

      qsize := queue_size;
      push  := false;
      pop   := false;
      next_read_ptr := read_pointer;
      next_write_ptr := write_pointer;
      
      if((qsize < queue_depth) and push_req = '1') then
          push := true;
      end if;
  
      if((qsize > 0) and pop_req = '1') then
          pop := true;
      end if;
  
  
      if(push) then
          next_write_ptr := incr_write_pointer;
      end if;
  
      if(pop) then
          next_read_ptr := incr_read_pointer;
      end if;
  
  
      if(pop and (not push)) then
          qsize := (qsize  - 1);
      elsif(push and (not pop)) then
          qsize := (qsize + 1);
      end if;
        
  
      if(clk'event and clk = '1') then
        
	if(reset = '1') then
           queue_size <= (others => '0');
           read_pointer <= (others => '0');
           write_pointer <= (others => '0');
           queue_array(0) <= (others => '0'); -- initially 0.
	else
           if(push) then
		for I in queue_array'low to queue_array'high loop
                    if(I = To_Integer(write_pointer)) then
          		queue_array(I) <= data_in;
		    end if;
		end loop;
           end if;
        
           queue_size <= qsize;
           read_pointer <= next_read_ptr;
           write_pointer <= next_write_ptr;

        end if;
      end if;

    end process;

   end block NTB;
  end generate qDGt1;
  

end behave;
