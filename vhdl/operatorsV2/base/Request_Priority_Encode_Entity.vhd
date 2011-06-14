library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity Request_Priority_Encode_Entity is
  generic (
    num_reqs : integer := 1);
  port (
    clk,reset : in std_logic;
    reqR : in std_logic_vector(num_reqs-1 downto 0);
    forward_Enable: out std_logic_vector(num_reqs-1 downto 0);
    ackR: out std_logic_vector(num_reqs-1 downto 0);
    req_s : out std_logic;
    ack_s : in std_logic);
end entity;

architecture Behave of Request_Priority_Encode_Entity is

  signal req_fsm_state : std_logic;
  signal reqR_priority_encoded : std_logic_vector(num_reqs-1 downto 0);
  signal there_is_a_request  : std_logic;
  signal assert_ackR : std_logic;
  signal assert_eN : std_logic;
  
begin  -- Behave

  reqR_priority_encoded <= PriorityEncode(reqR);
  forward_enable <= reqR_priority_encoded;
  
  there_is_a_request <= OrReduce(reqR);
  req_s <= there_is_a_request;

  process(ack_s,reqR_priority_encoded)
  begin
    for I in reqR'range loop
      ackR(I) <= reqR_priority_encoded(I) and ack_s;
    end loop;  -- I
  end process;
  
end Behave;
