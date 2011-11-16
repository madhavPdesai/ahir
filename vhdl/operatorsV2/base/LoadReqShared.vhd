library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity LoadReqShared is
  generic
    (
	addr_width: integer := 8;
      	num_reqs : integer := 1; -- how many requesters?
	tag_length: integer := 1;
	no_arbitration: Boolean := true;
        min_clock_period: Boolean := false
    );
  port (
    -- req/ack follow pulse protocol
    reqL                     : in BooleanArray(num_reqs-1 downto 0);
    ackL                     : out BooleanArray(num_reqs-1 downto 0);
    -- concatenated address corresponding to access
    dataL                    : in std_logic_vector((addr_width*num_reqs)-1 downto 0);
    -- address to memory
    maddr                   : out std_logic_vector(addr_width-1 downto 0);
    mtag                    : out std_logic_vector(tag_length-1 downto 0);
    mreq                    : out std_logic;
    mack                    : in std_logic;
    -- clock, reset (active high)
    clk, reset              : in std_logic);
end LoadReqShared;

architecture Vanilla of LoadReqShared is

  constant iwidth: integer := addr_width*num_reqs;
  constant owidth: integer := addr_width;

  constant debug_flag : boolean := false;
  
begin  -- Behave
  assert(tag_length >= Ceil_Log2(num_reqs)) report "insufficient tag width" severity error;


  -- xilinx xst does not like this assertion...
  DbgAssert: if debug_flag generate
    assert( (not ((reset = '0') and (clk'event and clk = '1') and no_arbitration)) or Is_At_Most_One_Hot(reqL))
      report "in no-arbitration case, at most one request should be hot on clock edge (in SplitOperatorShared)" severity error;    
  end generate DbgAssert;

  
  imux: InputMuxBase
    generic map(iwidth => iwidth,
                owidth => owidth, 
                twidth => tag_length,
                nreqs => num_reqs,
                no_arbitration => no_arbitration,
                rigid_repeater => true,
                registered_output => min_clock_period)
    port map(
      reqL       => reqL,
      ackL       => ackL,
      dataL      => dataL,
      reqR       => mreq,
      ackR       => mack,
      dataR      => maddr,
      tagR       => mtag,
      clk        => clk,
      reset      => reset);
  
end Vanilla;

