library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.OperatorPackage.all;
use ahir.FloatOperatorPackage.all;
use ahir.BaseComponents.all;

entity SplitOperatorBase is
  generic
    (
      operator_id   : string := "ApIntAdd";          -- operator id
      input1_is_int : Boolean := true; -- false means float
      input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      iwidth_1      : integer := 4;    -- width of input1
      input2_is_int : Boolean := true; -- false means float
      input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
      input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
      iwidth_2      : integer := 0;    -- width of input2
      num_inputs    : integer := 1;    -- can be 1 or 2.
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      owidth        : integer := 4;          -- width of output.
      constant_operand : std_logic_vector := "0001"; -- constant operand.. (it is always the second operand)
      constant_width: integer := 4;
      twidth        : integer := 1;          -- tag width
      use_constant  : boolean := true
      );
  port (
    -- req/ack follow level protocol
    reqR: out std_logic;
    ackR: in std_logic;
    reqL: in std_logic;
    ackL : out  std_logic;
    -- tagL is passed out to tagR
    tagL       : in  std_logic_vector(twidth-1 downto 0);
    -- input array consists of m sets of 1 or 2 possibly concatenated
    -- operands.
    dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
    dataR      : out std_logic_vector(owidth-1 downto 0);
    -- tagR is received from tagL, concurrent
    -- with dataR
    tagR       : out std_logic_vector(twidth-1 downto 0);
    clk, reset : in  std_logic);
end SplitOperatorBase;


architecture Vanilla of SplitOperatorBase is
  signal   result    : std_logic_vector(owidth-1 downto 0);
  signal   state_sig : std_logic;
  constant tag0      : std_logic_vector(tagR'length-1 downto 0) := (others => '0');
  constant iwidth : integer := iwidth_1  + iwidth_2;

begin  -- Behave

  assert((num_inputs = 1) or (num_inputs = 2)) report "either 1 or 2 inputs" severity failure;

  reqR <= reqL;
  ackL <= ackR;
  tagR <= tagL;
  
  comb_block: GenericCombinationalOperator
    generic map (
      operator_id                 => operator_id,
      input1_is_int               => input1_is_int,
      input1_characteristic_width => input1_characteristic_width,
      input1_mantissa_width       => input1_mantissa_width,
      iwidth_1                    => iwidth_1,
      input2_is_int               => input2_is_int,
      input2_characteristic_width => input2_characteristic_width,
      input2_mantissa_width       => input2_mantissa_width,
      iwidth_2                    => iwidth_2,
      num_inputs                  => num_inputs,
      output_is_int               => output_is_int,
      output_characteristic_width => output_characteristic_width,
      output_mantissa_width       => output_mantissa_width,
      owidth                      => owidth,
      constant_operand            => constant_operand,
      constant_width		  => constant_width,
      use_constant                => use_constant)
    port map (
      data_in => dataL,
      result  => dataR);


end Vanilla;

