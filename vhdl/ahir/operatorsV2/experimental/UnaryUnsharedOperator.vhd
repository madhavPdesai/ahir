library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.OperatorPackage.all;
use ahir.BaseComponents.all;
use ahir.FloatOperatorPackage.all;

--
--  result = op input_1
--
entity UnaryUnsharedOperator is
  generic
    (
      name          : string;          -- instance name.
      operator_id   : string;          -- operator id
      input_is_int : Boolean := true; -- false means float
      input_characteristic_width : integer := 0; -- characteristic width if input1 is float
      input_mantissa_width       : integer := 0; -- mantissa width if input1 is float
      input_width        : integer;    -- width of input1
      input_is_constant  : boolean; 
      output_is_int : Boolean := true;  -- false means that the output is a float
      output_characteristic_width : integer := 0;
      output_mantissa_width       : integer := 0;
      output_width        : integer;          -- width of output.
      output_buffering : integer := 2;
      );
  port (
    -- req -> ack follow pulse protocol
    sample_req:  in Boolean;
    sample_ack:  out Boolean;
    update_req:  in Boolean;
    update_ack:  out Boolean;
    -- operands.
    dataL      : in  std_logic_vector(input_width - 1 downto 0);
    dataR      : out std_logic_vector(output_width-1 downto 0);
    clk, reset : in  std_logic);
end UnaryUnsharedOperator;


architecture Vanilla of UnaryUnsharedOperator is
  signal  result: std_logic_vector(output_width-1 downto 0);
  signal ub_write_req, ub_write_ack: boolean;
begin  -- Behave
  -----------------------------------------------------------------------------
  -- combinational block.. this is ever-active!
  -----------------------------------------------------------------------------
  comb_block: GenericCombinationalOperator
    generic map (
      operator_id                 => operator_id,
      input1_is_int               => input_1_is_int,
      input1_characteristic_width => input_1_characteristic_width,
      input1_mantissa_width       => input_1_mantissa_width,
      iwidth_1                    => input_1_width,
      input2_is_int               => input_1_is_int,
      input2_characteristic_width => input_1_characteristic_width,
      input2_mantissa_width       => input_1_mantissa_width,
      iwidth_2                    => input_1_width,
      num_inputs                  => 1,
      output_is_int               => output_is_int,
      output_characteristic_width => output_characteristic_width,
      output_mantissa_width       => output_mantissa_width,
      owidth                      => output_width,
      constant_operand            => (0 => '0'),
      constant_width              => 1,
      use_constant                => false)
    port map (data_in => dataL, result  => result);


  nonConst: if not input_is_constant generate
    -----------------------------------------------------------------------------
    -- interlock buffer.
    -----------------------------------------------------------------------------
    ib: InterlockBuffer generic map (name => name & " interlock-buffer ",
					  buffer_size => output_buffering,
					  data_width => output_width)
		  port map(write_req => sample_req, write_ack => sample_ack,
				  write_data => result,
				  read_req => update_req,
				  read_ack => update_ack,
				  read_data => dataR,
				  clk => clk, reset => reset);
  end generate nonConst; 

  constCase: if input_is_constant generate
	dataR <= result;
	update_ack <= update_req;
  end generate constCase;

end Vanilla;

