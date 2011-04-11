library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Components.all;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputPortNoData is
  generic (num_reqs: integer;
	   no_arbitration: boolean);
  port (
    -- pulse interface with the data-path
    req        : in  BooleanArray(num_reqs-1 downto 0);
    ack        : out BooleanArray(num_reqs-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    clk, reset : in  std_logic);
end entity;


architecture Base of InputPortNoData is

  signal reqR, ackR, eN : std_logic_vector(num_reqs-1 downto 0);
  signal reqF, reqFreg  : std_logic_vector(num_reqs-1 downto 0);
  signal req_fsm_state  : std_logic;

begin

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate

    P2L : block
      signal state : P2LState;
    begin  -- block P2L
      Pulse_To_Level_Translate(suppr_imm_ack => true,
                               rL            => req(I),
                               rR            => reqR(I),
                               aL            => ack(I),
                               aR            => ackR(I),
                               en            => eN(I),
                               state         => state,
                               clk           => clk,
                               reset         => reset);

    end block P2L;
    
  end generate ProTx;

  -----------------------------------------------------------------------------
  -- request handling
  -----------------------------------------------------------------------------
  RequestPriorityEncode(req_fsm_state => req_fsm_state,
                        clk           => clk,
                        reset         => reset,
                        reqR          => reqR,
                        ackR          => ackR,
                        reqF          => reqF,
                        req_s         => oreq,
                        ack_s         => oack,
                        reqFreg       => reqFreg);


  gen : for I in num_reqs-1 downto 0 generate
    ackR(I) <= reqF(I) and oack;
  end generate gen;

end Base;
