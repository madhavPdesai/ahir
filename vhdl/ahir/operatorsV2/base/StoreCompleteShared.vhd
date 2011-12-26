library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity StoreCompleteShared is
  generic (num_reqs: integer := 3;
	   tag_length: integer :=  3);
  port (
    -- in requester array, pulse protocol
    -- more than one requester can be active
    -- at any time
    reqR : in BooleanArray(num_reqs-1 downto 0);
    -- out ack array, pulse protocol
    -- more than one ack can be sent back
    -- at any time.
    --
    -- Note: req -> ack delay can be 0
    ackR : out BooleanArray(num_reqs-1 downto 0);
    -- mreq goes out to memory as 
    -- a response to mack.
    mreq : out std_logic;
    mack : in  std_logic;
    -- mtag to distinguish the 
    -- requesters.
    mtag : in std_logic_vector(tag_length-1 downto 0);
    -- rising edge of clock is used
    clk : in std_logic;
    -- synchronous reset, active high
    reset : in std_logic);
end StoreCompleteShared;

architecture Behave of StoreCompleteShared is
begin  -- Behave


  odemux: OutputDemuxBaseNoData
    generic map (
      twidth =>  tag_length,
      nreqs  => num_reqs,
      no_arbitration => true)
    port map (
      reqL   => mack,                   -- cross-over (mack from mem-subsystem)
      ackL   => mreq,                   -- cross-over 
      tagL  =>  mtag,
      reqR  => reqR,
      ackR  => ackR,
      clk   => clk,
      reset => reset);

end Behave;
