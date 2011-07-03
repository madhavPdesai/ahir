library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPort is
  generic(num_reqs: integer;
	  data_width: integer;
	  no_arbitration: boolean);
  port (
    req        : in  BooleanArray(num_reqs-1 downto 0);
    ack        : out BooleanArray(num_reqs-1 downto 0);
    data       : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPort is

  signal reqR, ackR : std_logic_vector(num_reqs-1 downto 0);
  signal fEN: std_logic_vector(num_reqs-1 downto 0);

  type   OPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal data_array : OPWArray(num_reqs-1 downto 0);

  
begin

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate

    P2L : block
    begin  -- block P2L
      p2LInst: Pulse_To_Level_Translate_Entity
        port map(rL            => req(I),
                 rR            => reqR(I),
                 aL            => ack(I),
                 aR            => ackR(I),
                 clk           => clk,
                 reset         => reset);

    end block P2L;
    
  end generate ProTx;

  mux : OutputPortLevel generic map (
    num_reqs       => num_reqs,
    data_width     => data_width,
    no_arbitration => no_arbitration)
    port map (
      req   => reqR,
      ack   => ackR,
      data  => data,
      oreq  => oreq,
      oack  => oack,
      odata => odata,
      clk   => clk,
      reset => reset);
    

end Base;
