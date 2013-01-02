library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity LoadCompleteShared is
    generic
    (
      data_width: integer := 8;
      tag_length:  integer := 1;
      num_reqs : integer := 1;
      no_arbitration: boolean := true
    );
  port (
    -- req/ack follow level protocol
    reqR                     : in BooleanArray(num_reqs-1 downto 0);
    ackR                     : out BooleanArray(num_reqs-1 downto 0);
    dataR                    : out std_logic_vector((data_width*num_reqs)-1 downto 0);
    -- output data consists of concatenated pairs of ops.
    mdata                    : in std_logic_vector(data_width-1 downto 0);
    mreq                     : out  std_logic;
    mack                     : in std_logic;
    mtag                     : in std_logic_vector(tag_length-1 downto 0);
    -- with dataR
    clk, reset              : in std_logic);
end LoadCompleteShared;

architecture Vanilla of LoadCompleteShared is

begin  -- Behave


  odemux: OutputDeMuxBase
    generic map (
      iwidth => data_width,
      owidth =>  data_width*num_reqs,
      twidth =>  tag_length,
      nreqs  => num_reqs,
      no_arbitration => no_arbitration,
      pipeline_flag => true)
    port map (
      reqL   => mack,                   -- cross-over (mack from mem-subsystem)
      ackL   => mreq,                   -- cross-over 
      dataL =>  mdata,
      tagL  =>  mtag,
      reqR  => reqR,
      ackR  => ackR,
      dataR => dataR,
      clk   => clk,
      reset => reset);
  
  
end Vanilla;

