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
use ahir.BaseComponents.all;

-- Synopsys DC ($^^$@!)  needs you to declare an attribute
-- to infer a synchronous set/reset ... unbelievable.
--##decl_synopsys_attribute_lib##

entity QueueBaseWithEmptyFull is
  generic(name : string; 
		queue_depth: integer := 1; 
		data_width: integer := 32);
  port(clk: in std_logic;
       reset: in std_logic;
       empty, full: out std_logic;
       data_in: in std_logic_vector(data_width-1 downto 0);
       push_req: in std_logic;
       push_ack: out std_logic;
       data_out: out std_logic_vector(data_width-1 downto 0);
       pop_ack : out std_logic;
       pop_req: in std_logic);
end entity QueueBaseWithEmptyFull;

architecture behave of QueueBaseWithEmptyFull is

  type QueueArray is array(natural range <>) of std_logic_vector(data_width-1 downto 0);

  signal base_push_req: std_logic;
  signal base_push_ack: std_logic;

  signal base_pop_req: std_logic;
  signal base_pop_ack: std_logic;

  signal base_empty: boolean;
  signal base_full: boolean;

  signal base_data_out: std_logic_vector(data_width-1 downto 0);
-- see comment above..
--##decl_synopsys_sync_set_reset##

begin  -- SimModel

 pDZero:  if(queue_depth = 0) generate

	empty <= '1';
	full  <= '1';

	data_out <= data_in;

	push_ack <= pop_req;
	pop_ack  <= push_req;

 end generate pDZero;


 oSideQGt0: if (queue_depth > 0)  generate

     base_push_req <= push_req;
     push_ack <= base_push_ack;
     base_pop_req <= pop_req;
     pop_ack <= base_pop_ack;

     data_out <= base_data_out;

 end generate oSideQGt0;

 qD1: if (queue_depth = 1) generate


   RB: block
      signal full_flag: boolean;
      signal data_reg: std_logic_vector(data_width-1 downto 0);
   begin

      base_empty <= not full_flag;
      base_full  <= full_flag;

      process(clk, reset, base_push_req, base_pop_req, full_flag, data_in, data_reg)
	variable next_full_flag_var: boolean;
        variable next_data_reg_var: std_logic_vector(data_width-1 downto 0);
      begin
	next_full_flag_var := full_flag;
        next_data_reg_var := data_reg;

        if (full_flag) then
           if (base_pop_req = '1') then
              next_full_flag_var := false;
           end if;
        else 
           if (base_push_req = '1') then
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
   signal read_pointer, write_pointer, write_pointer_plus_1: unsigned ((Ceil_Log2(queue_depth))-1 downto 0);
   signal next_read_pointer, next_write_pointer: unsigned ((Ceil_Log2(queue_depth))-1 downto 0);

  constant URW0: unsigned ((Ceil_Log2(queue_depth))-1 downto 0):= (others => '0');

  signal incr_read_pointer, incr_write_pointer: boolean;
  signal write_flag : boolean;

  begin
    base_push_ack <= '0' when base_full else '1';
    base_pop_ack  <= '0' when base_empty else '1';

    -- empty/full logic.
    process(clk, reset, incr_read_pointer, incr_write_pointer,
			next_read_pointer, next_write_pointer)
	variable ptrs_equal: boolean;
    begin
	ptrs_equal := (next_write_pointer = next_read_pointer);
 	if(clk'event and clk ='1') then
		if(reset = '1') then
			base_full <= false;
			base_empty <= true;
		else
			base_full <= ((not base_full) and incr_write_pointer and
						(not incr_read_pointer) and ptrs_equal)
						or (base_full and (not incr_read_pointer));
			base_empty <= (base_empty and (not incr_write_pointer))
					or ((not base_empty) and incr_write_pointer and
						(not incr_read_pointer) and ptrs_equal);
		end if;
	end if;
    end process;


    -- next read pointer, write pointer.
    process(incr_read_pointer, read_pointer) 
    begin
	if(incr_read_pointer) then
		if(read_pointer = queue_depth-1) then
			next_read_pointer <= (others => '0');
		else
			next_read_pointer <= read_pointer + 1;
		end if;
	else
		next_read_pointer <= read_pointer;
	end if;
    end process;
    rdpReg: SynchResetRegisterUnsigned generic map (name => name & ":rpreg", data_width => read_pointer'length)
		port map (clk => clk, reset => reset, din => next_read_pointer, dout => read_pointer);

    write_pointer_plus_1 <= (others => '0') when (write_pointer = queue_depth-1) else (write_pointer + 1);
    process(incr_write_pointer, write_pointer) 
    begin
	if(incr_write_pointer) then
		next_write_pointer <= write_pointer_plus_1;
	else
		next_write_pointer <= write_pointer;
	end if;
    end process;
    wrpReg: SynchResetRegisterUnsigned generic map (name => name & ":wrpreg", data_width => write_pointer'length)
		port map (clk => clk, reset => reset, din => next_write_pointer, dout => write_pointer);

    -- bottom pointer gives the data in FIFO mode..
    process (read_pointer, queue_array)
	variable data_out_var : std_logic_vector(data_width-1 downto 0);
    begin
	data_out_var := (others =>  '0');
        for I in 0 to queue_depth-1 loop
	    if(I = To_Integer(read_pointer)) then
    		data_out_var := queue_array(I);
	    end if;
	end loop;
	base_data_out <= data_out_var;
    end process;

    -- write to queue-array.
    Wgen: for W in 0 to queue_depth-1 generate
       process(clk, reset, write_flag, write_pointer, data_in) 
       begin
		if(clk'event and (clk = '1')) then
			if(reset = '1') then
                             queue_array(W) <= (others => '0');
			elsif (write_flag and (W = write_pointer)) then
			     queue_array(W) <= data_in;
			end if;
		end if;
       end process;
    end generate Wgen;
  
    -- single process..  Synopsys mangles the logic... split it into two.
    process(read_pointer, write_pointer, base_empty, base_full, base_push_req, base_pop_req)
      variable push,pop : boolean;
    begin
      push  := false;
      pop   := false;
      
      if((not base_full) and base_push_req = '1') then
          push := true;
      end if;
  
      if((not base_empty) and base_pop_req = '1') then
          pop := true;
      end if;
  
      incr_read_pointer <= pop;
      incr_write_pointer <= push;
  
      write_flag <= push;
    end process;

   end block NTB;
  end generate qDGt1;

end behave;