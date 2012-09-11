library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPortLevelNoData is
  generic(num_reqs: integer;
	no_arbitration: boolean);
  port (
    req       : in  std_logic_vector(num_reqs-1 downto 0);
    ack       : out std_logic_vector(num_reqs-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPortLevelNoData is
  signal req_active, ack_sig , fair_reqs, fair_acks : std_logic_vector(num_reqs-1 downto 0);
begin
  
  fairify: NobodyLeftBehind generic map(num_reqs => num_reqs)
		port map(clk => clk, reset => reset,
				reqIn => req,
				ackOut => ack,
				reqOut => fair_reqs,
				ackIn => fair_acks);
  
  oreq <= OrReduce(req_active);

  NoArb: if no_arbitration generate
     req_active <= fair_reqs;
  end generate NoArb;

  Arb: if not no_arbitration generate
     req_active <= PriorityEncode(fair_reqs);
  end generate Arb;

  gen: for I in num_reqs-1 downto 0 generate
       ack_sig(I) <= req_active(I) and oack; 
       fair_acks(I) <= ack_sig(I);
  end generate gen;

end Base;
