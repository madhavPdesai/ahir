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
use ahir.Components.all;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

--
-- a full-rate input port.  The assumption here
-- is that a data item is picked up from the
-- input port for every req pulse.  The production
-- of a new output data-item is indicated by an
-- ack pulse.
--
entity InputPortRevised is
  generic (name : string;
	   num_reqs: integer;
	   data_width: integer;
	   output_buffering: IntegerArray;
	   no_arbitration: boolean := false);
  port (
    -- pulse interface with the data-path
    sample_req        : in  BooleanArray(num_reqs-1 downto 0); -- sacrificial.
    sample_ack        : out BooleanArray(num_reqs-1 downto 0); -- sacrificial.
    update_req        : in  BooleanArray(num_reqs-1 downto 0);
    update_ack        : out BooleanArray(num_reqs-1 downto 0);
    data              : out std_logic_vector((num_reqs*data_width)-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : in  std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;


architecture Base of InputPortRevised is

  --alias outBUFs: IntegerArray(num_reqs-1 downto 0) is output_buffering;
  signal has_room, write_enable : std_logic_vector(num_reqs-1 downto 0);

  type   IPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal write_data, read_data: IPWArray(num_reqs-1 downto 0);

  signal demux_data : std_logic_vector((num_reqs*data_width)-1 downto 0);

  signal ack_raw: BooleanArray(num_reqs-1 downto 0);
  
  type FsmState is (Idle, Waiting);
begin

  -----------------------------------------------------------------------------
  -- data register for every requester.
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate


    --
    -- Note: for correct functioning of this input port
    --   external dependencies on the control-path side
    --   must be correctly setup.
    --     sr->sa->cr->ca chain
    --     ca -o-> sr  (0-delay) dependency.
    --
    sample_ack(I) <= sample_req(I); -- to maintain illusion of split protocol.

    -- FSM.
    fsm: block
	signal fsm_state: FsmState;
	signal data_reg : std_logic_vector(data_width-1 downto 0);
    begin
	process(clk, reset, fsm_state, update_req(I),  write_enable(I))
		variable next_fsm_state: FsmState;
		variable has_room_v : std_logic;
		variable latch_v : boolean;
	begin
		next_fsm_state := fsm_state;
		has_room_v     := '0';
		latch_v        := false;
		case fsm_state is
			when Idle  =>
				if(update_req(I)) then
					has_room_v := '1';
					if(write_enable(I) = '1') then
						latch_v := true;
					else
						next_fsm_state := Waiting;
					end if;
				end if;
			when Waiting =>
				has_room_v := '1';
				if(write_enable(I) = '1') then
					latch_v := true;
					next_fsm_state := Idle;
				end if;
		end case;


		has_room(I) <= has_room_v;
		
		if(clk'event and clk = '1') then
			if(reset = '1') then
				update_ack(I) <= false;
				fsm_state <= Idle;
				data_reg <= (others => '0');
			else
				fsm_state <= next_fsm_state;
				update_ack(I) <= latch_v;
				if(latch_v) then
					data_reg <= write_data(I);
				end if;
			end if;

		end if;
	end process;

	-- read-data I
	read_data(I) <= data_reg;
    end block;

  end generate ProTx;

  demux : InputPortLevel generic map (
    name => name & "-demux",
    num_reqs       => num_reqs,
    data_width     => data_width,
    no_arbitration => no_arbitration)
    port map (
      req => has_room,
      ack => write_enable,
      data => demux_data,
      oreq => oreq,
      odata => odata,
      oack => oack,
      clk => clk,
      reset => reset);

  -----------------------------------------------------------------------------
  -- data handling
  -----------------------------------------------------------------------------
  process(read_data)
    variable ldata: std_logic_vector((num_reqs*data_width)-1 downto 0);
  begin
    for J in num_reqs-1 downto 0 loop
      ldata(((J+1)*data_width)-1 downto J*data_width) := read_data(J);
    end loop;
    data <= ldata;
  end process;

  gen : for I in num_reqs-1 downto 0 generate
    write_data(I) <= demux_data(((I+1)*data_width)-1 downto I*data_width); 
  end generate gen;

end Base;
