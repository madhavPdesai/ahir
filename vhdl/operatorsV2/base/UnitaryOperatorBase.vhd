library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.OperatorPackage.all;
use ahir.BaseComponents.all;
use ahir.FloatOperatorPackage.all;

entity UnitaryOperatorBase is
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
      twidth        : integer;          -- tag width
      use_constant  : boolean := false;
      zero_delay    : boolean := false;
      flow_through  : boolean := false
      );
  port (
    -- req -> ack follow pulse protocol
    req:  in Boolean;
    ack:  out Boolean;
    -- operands.
    dataL      : in  std_logic_vector(iwidth_1 + iwidth_2 - 1 downto 0);
    dataR      : out std_logic_vector(owidth-1 downto 0);
    clk, reset : in  std_logic);
end UnitaryOperatorBase;


architecture Vanilla of UnitaryOperatorBase is
  signal   result: std_logic_vector(owidth-1 downto 0);
  signal   state_sig : std_logic;
  constant iwidth : integer := iwidth_1  + iwidth_2;
  signal   enable_data_reg : std_logic;
  
begin  -- Behave

  assert((num_inputs = 1) or (num_inputs = 2)) report "either 1 or 2 inputs" severity failure;

  TwoOperand : if num_inputs = 2 generate

    -- int x int -> int
    TwoOpIntIntInt: if input1_is_int and input2_is_int and output_is_int generate
      process(dataL)
        
        variable   result_var   : IStdLogicVector(owidth-1 downto 0);
        variable op1: IStdLogicVector(iwidth_1-1 downto 0);
        variable op2: IStdLogicVector(iwidth_2-1 downto 0);
      begin
        op1 := To_ISLV(dataL(iwidth-1 downto iwidth_2));
        op2 := To_ISLV(dataL(iwidth_2-1 downto 0));
        TwoInputOperation(operator_id, op1, op2,result_var);
        result <= To_SLV(result_var);
      end process;
    end generate TwoOpIntIntInt;

    -- float x float -> float
    TwoOpFloatFloatFloat: if (not input1_is_int) and (not input2_is_int) and (not output_is_int) generate
      process(dataL)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        variable op2: IStdLogicVector(input2_characteristic_width downto (- input2_mantissa_width));
        variable   result_var: IStdLogicVector(output_characteristic_width downto (-output_mantissa_width));
      begin
        op1 := To_ISLV(dataL(iwidth-1 downto iwidth_2));
        op2 := To_ISLV(dataL(iwidth_2-1 downto 0));
        TwoInputOperation(operator_id, op1,op2,result_var);
        result <= To_SLV(result_var);
      end process;
    end generate TwoOpFloatFloatFloat;

    -- float x float -> int
    TwoOpFloatFloatInt: if (not input1_is_int) and (not input2_is_int) and output_is_int generate
      process(dataL)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        variable op2: IStdLogicVector(input2_characteristic_width downto (- input2_mantissa_width));
        variable   result_var: IStdLogicVector(owidth-1 downto 0);
      begin
        op1 := To_ISLV(dataL(iwidth-1 downto iwidth_2));
        op2 := To_ISLV(dataL(iwidth_2-1 downto 0));
        TwoInputOperation(operator_id, op1,op2,result_var);
        result <= To_SLV(result_var);
      end process;
    end generate TwoOpFloatFloatInt;

    -- float x int -> * and int x float -> * are not permitted.
    assert(input1_is_int = input2_is_int) report "both operands of two input operators should be either ints or floats"
      severity failure;

    -- int x int -> float is not permitted.
    assert((not input1_is_int) or output_is_int) report "if the inputs to a two-input operation are ints, the output cannot be a float!" severity failure;

  end generate TwoOperand;


  SingleOperandNoConstant : if num_inputs = 1 and not use_constant generate

    SingleOperandNoConstantIntInt: if input1_is_int and output_is_int generate
      process(dataL)
        variable   result_var    : IStdLogicVector(owidth-1 downto 0);
      begin
        SingleInputOperation(operator_id, To_ISLV(dataL), result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandNoConstantIntInt;
    
    SingleOperandNoConstantFloatFloat: if (not input1_is_int) and (not output_is_int) generate
      process(dataL)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        variable result_var: IStdLogicVector(output_characteristic_width downto (- output_mantissa_width));
      begin
        op1 := To_ISLV(dataL);
        SingleInputOperation(operator_id, op1, result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandNoConstantFloatFloat;

    SingleOperandNoConstantFloatInt: if (not input1_is_int) and output_is_int generate
      process(dataL)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        variable result_var: IStdLogicVector(owidth-1 downto 0);
      begin
        op1 := To_ISLV(dataL);
        SingleInputOperation(operator_id, op1, result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandNoConstantFloatInt;

    SingleOperandNoConstantIntFloat: if (input1_is_int) and (not output_is_int) generate
      process(dataL)
        variable result_var: IStdLogicVector(output_characteristic_width downto (- output_mantissa_width));
      begin
        SingleInputOperation(operator_id, To_ISLV(dataL), result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandNoConstantIntFloat;
  end generate SingleOperandNoConstant;

  SingleOperandWithConstant : if num_inputs = 1 and use_constant generate

    SingleOperandWithConstantIntInt: if input1_is_int and output_is_int generate
      process(dataL)
        variable   result_var    : IStdLogicVector(owidth-1 downto 0);
      begin
        TwoInputOperation(operator_id,
                          To_ISLV(dataL(iwidth-1 downto 0)), 
                          To_ISLV(constant_operand),
                          result_var); 
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandWithConstantIntInt;

    SingleOperandWithConstantFloatInt: if (not input1_is_int) and output_is_int generate
      process(dataL)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        constant op2: IStdLogicVector(input2_characteristic_width downto (- input2_mantissa_width)) 
          := To_ISLV(constant_operand);
        variable   result_var: IStdLogicVector(owidth-1 downto 0);
      begin
        op1 := To_ISLV(dataL);	
        TwoInputOperation(operator_id, op1, op2, result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandWithConstantFloatInt;

    SingleOperandWithConstantFloatFloat: if (not input1_is_int) and (not output_is_int) generate
      process(dataL)
        variable op1: IStdLogicVector(input1_characteristic_width downto (- input1_mantissa_width));
        constant op2: IStdLogicVector(input2_characteristic_width downto (- input2_mantissa_width)) 
          := To_ISLV(constant_operand);
        variable result_var: IStdLogicVector(output_characteristic_width downto (- output_mantissa_width));
      begin
        op1 := To_ISLV(dataL);
        TwoInputOperation(operator_id, op1, op2, result_var);
        result <= To_SLV(result_var);
      end process;
    end generate SingleOperandWithConstantFloatFloat;
  end generate SingleOperandWithConstant;

  FlowThrough: if flow_through generate
    ack <= req;
    dataR <= result;
  end generate FlowThrough;

  ZeroDelay: if ((not flow_through) and zero_delay) generate

    ack <= req;
    enable_data_reg <= '1' when req  else '0';

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
          ack <= false;
        else
          ack <= req;
        end if;
      end if;
    end process;

    enable_data_reg <= '1' when req  else '0';

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

