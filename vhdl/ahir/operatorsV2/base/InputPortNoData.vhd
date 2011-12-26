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

  signal reqR, ackR : std_logic_vector(num_reqs-1 downto 0);
  signal fEN: std_logic_vector(num_reqs-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate
    P2L : block
    begin  -- block P2L
      p2LInst: Pulse_To_Level_Translate_Entity
        port map (rL            => req(I),
                  rR            => reqR(I),
                  aL            => ack(I),
                  aR            => ackR(I),
                  clk           => clk,
                  reset         => reset);
    end block P2L;
  end generate ProTx;

  demux : InputPortLevelNoData generic map (
    num_reqs       => num_reqs,
    no_arbitration => no_arbitration)
    port map (
      req => reqR,
      ack => ackR,
      oreq => oreq,
      oack => oack,
      clk => clk,
      reset => reset);

end Base;
