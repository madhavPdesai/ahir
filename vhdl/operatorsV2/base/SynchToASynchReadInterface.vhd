library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Utilities.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;


entity SynchToAsynchReadInterface is
  generic (
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

    if(reset = '1') then
      next_state := idle;
    end if;
    
    synch_ack <= synch_ack_var;
    asynch_req <= asynch_req_var;

    if(clk'event and clk = '1') then
      in_fsm_state <= next_state;
    end if;
  end process;

  -- data is simply forwarded..
  asynch_data <= synch_data;
  
end Behave;
