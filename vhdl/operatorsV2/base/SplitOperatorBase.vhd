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
      zero_delay    : boolean := false
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


  -- state machine for single cycle delay case
  SingleCycle : if not zero_delay generate
    
    process(clk, reset, ackR, reqL, state_sig)
      variable next_state, ackL_var, reqR_var, latch_var : std_logic;
    begin
      next_state := state_sig;

      ackL_var  := '0';
      reqR_var  := '0';
      latch_var := '0';

      if(reset = '1') then
        next_state := '0';
      else
        case state_sig is
          when '0' =>
            if(reqL = '1') then
              latch_var  := '1';
              ackL_var   := '1';
              next_state := '1';
            end if;
          when '1' =>
            reqR_var := '1';
            if(ackR = '1' and reqL = '1') then
              latch_var := '1';
              ackL_var  := '1';
            elsif (ackR = '1' and reqL = '0') then
              next_state := '0';
            end if;
          when others => null;
        end case;
      end if;

      ackL <= ackL_var;
      reqR <= reqR_var;

      if(clk'event and clk = '1') then
        state_sig <= next_state;
        if(latch_var = '1') then
          dataR <= result;
          tagR <= tagL;
        end if;
      end if;
      
    end process;
  end generate SingleCycle;

  ZeroDelay : if zero_delay generate
    Bypass : block
      signal data_reg : std_logic_vector(dataR'high downto dataR'low);
      signal tag_reg  : std_logic_vector(tagR'length-1 downto 0);
      signal bypass   : std_logic;
    begin  -- block Bypass
      process(clk, reset, ackR, reqL, state_sig)
        variable next_state, ackL_var, reqR_var, latch_var : std_logic;
      begin
        next_state := state_sig;

        ackL_var  := '0';
        reqR_var  := '0';
        latch_var := '0';

        if(reset = '1') then
          next_state := '0';
        else
          case state_sig is
            when '0' =>
              if(reqL = '1') then

                ackL_var := '1';
                reqR_var := '1';

                if(ackR = '0') then
                  latch_var  := '1';
                  next_state := '1';
                end if;
              end if;
            when '1' =>
              reqR_var := '1';
              if(reqL = '1' and ackR = '1') then
                ackL_var := '1';
              elsif reqL = '1' and ackR = '0' then
                latch_var := '1';
              elsif reqL = '0' and ackR = '1' then
                next_state := '0';
              end if;
            when others => null;
          end case;
        end if;

        ackL   <= ackL_var;
        reqR   <= reqR_var;
        bypass <= latch_var;

        if(clk'event and clk = '1') then
          state_sig <= next_state;
          if(latch_var = '1') then
            data_reg <= result;
            tag_reg  <= tagL;
          end if;
        end if;
      end process;

      dataR <= result when bypass = '1'                      else data_reg;
      tagR  <= tagL   when  bypass = '1' else tag_reg ;
      
    end block Bypass;
    
  end generate ZeroDelay;
  
end Vanilla;

