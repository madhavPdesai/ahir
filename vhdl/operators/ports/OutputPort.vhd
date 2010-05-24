library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity OutputPort is
  generic(colouring: NaturalArray);
  port (
    req       : in  BooleanArray;
    ack       : out BooleanArray;
    data      : in  StdLogicArray2D;
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector;
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPort is
  signal odata_array : StdLogicArray2D(0 downto 0, data'length(2)-1 downto 0);
  alias lodata : std_logic_vector(odata'length-1 downto 0) is odata;
  signal ftag: std_logic_vector(0 downto 0);
  constant allow_imm_ack : BooleanArray(req'length-1 downto 0)  := (others => true);
begin  -- Base

  -----------------------------------------------------------------------------
  -- base input mux provides the functionality
  -----------------------------------------------------------------------------
  imux: InputMuxBase
    generic map (
      colouring  => colouring,
      suppress_immediate_ack => allow_imm_ack)
    port map (
      reqL  => req,
      ackL  => ack,
      dataL  => data,
      reqR  => oreq,
      ackR  => oack,
      dataR => odata_array,
      tagR  => ftag, -- this will be ignored
      clk   => clk,
      reset => reset);

  -----------------------------------------------------------------------------
  -- reformat
  -----------------------------------------------------------------------------
  process(odata_array)
  begin
    for I in lodata'range loop
      lodata(I) <= odata_array(0,I);
    end loop;  -- I
  end process;
  
end Base;
