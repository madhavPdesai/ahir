library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.OperatorPackage.all;
use ahir.BaseComponents.all;
use ahir.FloatOperatorPackage.all;

entity UnsharedOperatorBase is
  generic
    (
      operator_id   : string;          -- operator id
      input1_is_int : Boolean := true; -- false means float
      input1_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input1_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      iwidth_1      : integer;    -- width of input1
      input2_is_int : Boolean := true; -- false means float
      input2_characteristic_width : integer := 0; -- characteristic width if input2 is float
      input2_mantissa_width       : integer := 0; -- mantissa width if input2 is float
      iwidth_2      : integer;    -- width of input2
      num_inputs    : integer := 2;    -- can be 1 or 2.
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      owidth        : integer;          -- width of output.
      constant_operand : std_logic_vector; -- constant operand.. (it is always the second operand)
      use_constant  : boolean := false;
      zero_delay    : boolean := false;
      flow_through  : boolean := false
      );
  port (
    -- req -> ack follow pulse protocol
    reqL:  in Boolean;
    ackL : out Boolean;
    reqR : in Boolean;
    ackR:  out Boolean;
    -- operands.
    dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
    dataR      : out std_logic_vector(owidth-1 downto 0);
    clk, reset : in  std_logic);
end UnsharedOperatorBase;


architecture Vanilla of UnsharedOperatorBase is
  signal   result: std_logic_vector(owidth-1 downto 0);
  signal   state_sig : std_logic;
  constant iwidth : integer := iwidth_1  + iwidth_2;
  signal   enable_data_reg : std_logic;
  
begin  -- Behave


  assert((num_inputs = 1) or (num_inputs = 2)) report "either 1 or 2 inputs" severity failure;

  ackR <= reqR;                         -- all action on reqL->ackL

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
      use_constant                => use_constant)
    port map (
      data_in => dataL,
      result  => result);

  FlowThrough: if flow_through generate
    ackL <= reqL;
    dataR <= result;
  end generate FlowThrough;

  ZeroDelay: if ((not flow_through) and zero_delay) generate

    ackL <= reqL;
    enable_data_reg <= '1' when reqL  else '0';

    dreg : BypassRegister generic map (
      data_width    => owidth,
      enable_bypass => true)
      port map (
        clk      => clk,
        reset    => reset,
        enable   => enable_data_reg,
        data_in  => result,
        data_out => dataR);
    
  end generate ZeroDelay;

  NonZeroDelay: if ((not flow_through) and (not zero_delay)) generate

    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(reset = '1') then
          ackL <= false;
        else
          ackL <= reqL;
        end if;
      end if;
    end process;

    enable_data_reg <= '1' when reqL  else '0';

    dreg : BypassRegister generic map (
      data_width    => owidth,
      enable_bypass => false)
      port map (
        clk      => clk,
        reset    => reset,
        enable   => enable_data_reg,
        data_in  => result,
        data_out => dataR);
  
  end generate NonZeroDelay;
  
end Vanilla;

