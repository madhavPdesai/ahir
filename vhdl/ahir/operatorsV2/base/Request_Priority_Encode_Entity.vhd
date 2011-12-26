library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity Request_Priority_Encode_Entity is
  generic (
    num_reqs : integer := 1;
    pull_mode : boolean := false);
  port (
    clk,reset : in std_logic;
    reqR : in std_logic_vector(num_reqs-1 downto 0);
    forward_enable: out std_logic_vector(num_reqs-1 downto 0);
    ackR: out std_logic_vector(num_reqs-1 downto 0);
    req_s : out std_logic;
    ack_s : in std_logic);
end entity;

architecture Behave of Request_Priority_Encode_Entity is

  signal req_fsm_state : std_logic;
  signal reqR_priority_encoded : std_logic_vector(num_reqs-1 downto 0);
  signal reqR_fresh: std_logic_vector(num_reqs-1 downto 0);
  signal there_is_a_fresh_request  : std_logic;
  
  type RPEState is (idle,busy);
  signal rpe_state : RPEState;
begin  -- Behave

  reqR_fresh <= reqR and (not reqR_priority_encoded);
  there_is_a_fresh_request <= OrReduce(reqR_fresh);
  forward_enable <= reqR_priority_encoded;

  process(clk, rpe_state, there_is_a_fresh_request,ack_s)
	variable nstate: RPEState;
	variable latch_var : std_logic;
  begin
	nstate :=  rpe_state;
	latch_var := '0';
	req_s <= '0';
	if(rpe_state = idle) then
		if(there_is_a_fresh_request = '1') then
			latch_var := '1';
			nstate := busy;
		end if;
	elsif(rpe_state = busy) then
		req_s <= '1';
		if(ack_s = '1') then
			latch_var := '1';
			if(there_is_a_fresh_request = '1') then
				nstate := busy;
			else
				nstate := idle;
			end if;
		end if;
	end if;	

	if(clk'event and clk = '1') then
		if(reset = '1') then
			rpe_state <= idle;
			reqR_priority_encoded <= (others => '0');
		else
			if(latch_var = '1') then
				reqR_priority_encoded <= 
					PriorityEncode(reqR_fresh);
			end if;
			rpe_state <= nstate;
		end if;
	end if;

  end process;
  
  process(ack_s,reqR_priority_encoded)
  begin
    for I in reqR'range loop
      ackR(I) <= reqR_priority_encoded(I) and ack_s;
    end loop;  -- I
  end process;

  
end Behave;
