library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.BaseComponents.all;

entity ShiftRepeaterBase is
   generic(data_width: integer := 32; number_of_stages: natural := 1);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
end entity ShiftRepeaterBase;

architecture behave of ShiftRepeaterBase is

  type DataArray is array (natural range <>) of std_logic_vector(data_width-1 downto 0);
  signal idata : DataArray(0 to number_of_stages);
  signal ireq,iack : std_logic_vector(0 to number_of_stages);

begin  -- SimModel

  idata(0) <= data_in;
  ireq(0)  <= req_in;
  ack_out <= iack(0);

  data_out <= idata(number_of_stages);
  req_out <= ireq(number_of_stages);
  iack(number_of_stages) <= ack_in;

  ifGen: if number_of_stages > 0 generate

    RepGen: for I in 0 to number_of_stages-1 generate
      rptr : RepeaterBase generic map (
        data_width => data_width)
        port map (
          clk      => clk,
          reset    => reset,
          data_in  => idata(I),
          req_in   => ireq(I),
          ack_out  => iack(I),
          data_out => idata(I+1),
          req_out  => ireq(I+1),
          ack_in   => iack(I+1));
    end generate RepGen;
  end generate ifGen; 

end behave;
