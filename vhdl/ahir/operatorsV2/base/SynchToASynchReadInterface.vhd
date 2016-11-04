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
use ahir.Utilities.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;


entity SynchToAsynchReadInterface is
  generic (
    name: string;
    data_width : integer);
  port (
    clk : in std_logic;
    reset  : in std_logic;
    synch_req : in std_logic;
    synch_ack : out std_logic;
    asynch_req : out std_logic;
    asynch_ack: in std_logic;
    synch_data: in std_logic_vector(data_width-1 downto 0);
    asynch_data : out std_logic_vector(data_width-1 downto 0));
end SynchToAsynchReadInterface;


architecture Behave of SynchToAsynchReadInterface is

  type InMatchingFSMState is (idle,waiting);
  signal in_fsm_state : InMatchingFSMState;
  
begin

  process(clk,reset, in_fsm_state, synch_req, asynch_ack)
    variable next_state: InMatchingFSMState;
    variable synch_ack_var, asynch_req_var: std_logic;
    
  begin
    next_state := in_fsm_state;

    synch_ack_var := '0';
    asynch_req_var := '0';
    
    case in_fsm_state is
      when idle =>
        synch_ack_var := '1';          -- this is the only state where we req..
        
        if(synch_req = '1') then
          asynch_req_var := '1';

          -- synch-ack is withdrawn immediately
          -- unless asynch acks.
          synch_ack_var := '0';          
          if(asynch_ack = '1')  then
            -- if asynch-ack, continue ack to synch
            synch_ack_var := '1';
          else
            -- neither acked
            next_state := waiting;
          end if;
	end if;
      when waiting =>
        -- keep requesting to the asynch-pipe
        asynch_req_var := '1';
        if(asynch_ack = '1')  then
          -- asynch ack, continue synch-ack.
            synch_ack_var := '1';
            next_state := idle;
        else
          -- neither acked
          next_state := waiting;
        end if;
      when others => null;
    end case;

    
    synch_ack <= synch_ack_var;
    asynch_req <= asynch_req_var;

    if(clk'event and clk = '1') then
       if(reset = '1') then
         in_fsm_state <= idle;
       else 
         in_fsm_state <= next_state;
      end if;
    end if;
  end process;

  -- data is simply forwarded..
  asynch_data <= synch_data;
  
end Behave;
