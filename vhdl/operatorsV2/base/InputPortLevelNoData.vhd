library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputPortLevelNoData is
  
  generic (num_reqs: integer; 
	no_arbitration: boolean);
  port (
    -- ready/ready interface with the requesters
    req       : in  std_logic_vector(num_reqs-1 downto 0);
    ack       : out std_logic_vector(num_reqs-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    clk, reset : in  std_logic);
  
end InputPortLevelNoData;

architecture default_arch of InputPortLevelNoData is

  signal req_active, ack_sig  : std_logic_vector(num_reqs-1 downto 0); 
  
begin  -- default_arch

  oreq <= OrReduce(req_active);

  NoArb: if no_arbitration generate
    req_active <= req;
  end generate NoArb;

  Arb: if not no_arbitration generate
    req_active <= PriorityEncode(req);
  end generate Arb;

  gen: for I in num_reqs-1 downto 0 generate

    ack_sig(I) <= req_active(I) and oack; 
    
    ack(I) <= ack_sig(I);
    
  end generate gen;

end default_arch;
