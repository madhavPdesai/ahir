library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;

entity PipelinedFPOperator is
  generic (
      operator_id : string;
      exponent_width : integer := 8;
      fraction_width : integer := 23;
      no_arbitration: boolean := true;
      num_reqs : integer := 3 -- how many requesters?
    );
  port (
    -- req/ack follow level protocol
    reqL                     : in BooleanArray(num_reqs-1 downto 0);
    ackR                     : out BooleanArray(num_reqs-1 downto 0);
    ackL                     : out BooleanArray(num_reqs-1 downto 0);
    reqR                     : in  BooleanArray(num_reqs-1 downto 0);
    -- input data consists of concatenated pairs of ips
    dataL                    : in std_logic_vector((2*(exponent_width+fraction_width+1)*num_reqs)-1 downto 0);
    -- output data consists of concatenated pairs of ops.
    dataR                    : out std_logic_vector(((exponent_width+fraction_width+1)*num_reqs)-1 downto 0);
    -- with dataR
    clk, reset              : in std_logic);
end PipelinedFPOperator;

architecture Vanilla of PipelinedFPOperator is

  constant num_operands : integer := 2;
  constant operand_width : integer := exponent_width+fraction_width+1;
  constant iwidth : integer := 2*operand_width;
  constant owidth : integer := operand_width;
  
  constant tag_length: integer := Maximum(1,Ceil_Log2(reqL'length));
  signal itag,otag : std_logic_vector(tag_length-1 downto 0);
  signal ireq,iack, oreq, oack: std_logic;

  constant debug_flag : boolean := false;

  signal idata: std_logic_vector(iwidth-1 downto 0);
  signal odata: std_logic_vector(owidth-1 downto 0);

  signal NaN, overflow, underflow : std_logic;
  constant use_as_subtractor : boolean := (operator_id = "ApFloatSub");


  -----------------------------------------------------------------------------
  -- for the moment..
  constant use_generic_multiplier : boolean := true;
  -----------------------------------------------------------------------------
  
begin  -- Behave
  assert ackL'length = reqL'length report "mismatched req/ack vectors" severity error;
  assert ((operand_width = 32) or (operand_width = 64)) report "32/64 bit operand-support only!" severity error;
  assert ((operator_id = "ApFloatMul") or (operator_id = "ApFloatAdd") or (operator_id = "ApFloatSub"))
    report "operator_id must be either add or mul or sub" severity error;  

  -- DebugGen: if debug_flag generate 
    -- assert( (not ((reset = '0') and (clk'event and clk = '1') and no_arbitration)) or Is_At_Most_One_Hot(reqL))
    -- report "in no-arbitration case, at most one request should be hot on clock edge (in SplitOperatorShared)" severity error;
  -- end generate DebugGen;
  
  imux: InputMuxBase
    generic map(iwidth => iwidth*num_reqs,
                owidth => iwidth, 
                twidth => tag_length,
                nreqs => num_reqs,
                no_arbitration => no_arbitration,
                registered_output => true)
    port map(
      reqL       => reqL,
      ackL       => ackL,
      reqR       => ireq,
      ackR       => iack,
      dataL      => dataL,
      dataR      => idata,
      tagR       => itag,
      clk        => clk,
      reset      => reset);

  IEEE754xMul:  if operator_id = "ApFloatMul" generate
    useGeneric: if use_generic_multiplier generate
    op: GenericFloatingPointMultiplier
      generic map( tag_width     => tag_length,
                   exponent_width => exponent_width,
                   fraction_width => fraction_width,
                   round_style => round_nearest,
                   addguard => 3,
                   check_error => true,
                   denormalize => true)
      port map (
        env_rdy => ireq,
        muli_rdy => iack,
        accept_rdy => oack,
        mulo_rdy => oreq,
        INA => idata((2*operand_width)-1 downto operand_width),
        INB => idata(operand_width-1 downto 0),
        OUTMUL => odata,
        tag_in => itag,
        tag_out => otag,
        clk => clk,
        reset => reset);
    end generate useGeneric;
    
    SinglePrecision: if operand_width = 32 and (not use_generic_multiplier) generate 
    	op: SinglePrecisionMultiplier
          generic map( tag_width     => tag_length)
          port map (
            env_rdy => ireq,
            muli_rdy => iack,
            accept_rdy => oack,
            mulo_rdy => oreq,
            INA => idata(63 downto 32),
            INB => idata(31 downto 0),
            OUTM => odata,
            tag_in => itag,
            tag_out => otag,
            NaN => NaN,
            oflow => overflow,
            uflow => underflow,
            clk => clk,
            reset => reset);
	end generate SinglePrecision;


    DoublePrecision: if operand_width = 64 and (not use_generic_multiplier) generate 
    	op: DoublePrecisionMultiplier
          generic map ( tag_width     => tag_length)
          port map (
            env_rdy => ireq,
            muli_rdy => iack,
            accept_rdy => oack,
            mulo_rdy => oreq,
            INA => idata(127 downto 64),
            INB => idata(63 downto 0),
            OUTM => odata,
            tag_in => itag,
            tag_out => otag,
            NaN => NaN,
            oflow => overflow,
            uflow => underflow,
            clk => clk,
            reset => reset);
    end generate DoublePrecision;
  end generate IEEE754xMul;

  IEEE754xAdd:  if ((operator_id = "ApFloatAdd") or (operator_id = "ApFloatSub")) generate
    op: GenericFloatingPointAdderSubtractor
      generic map( tag_width     => tag_length,
                   exponent_width => exponent_width,
                   fraction_width => fraction_width,
                   round_style => round_nearest,
                   addguard => 3,
                   check_error => true,
                   denormalize => true,
                   use_as_subtractor => use_as_subtractor)
      port map (
        env_rdy => ireq,
        addi_rdy => iack,
        accept_rdy => oack,
        addo_rdy => oreq,
        INA => idata((2*operand_width)-1 downto operand_width),
        INB => idata(operand_width-1 downto 0),
        OUTADD => odata,
        tag_in => itag,
        tag_out => otag,
        clk => clk,
        reset => reset);
  end generate IEEE754xAdd;


  odemux: OutputDeMuxBase
    generic map (
  	iwidth => owidth,
  	owidth =>  owidth*num_reqs,
	twidth =>  tag_length,
	nreqs  => num_reqs,
	no_arbitration => no_arbitration,
        pipeline_flag => true)
    port map (
      reqL   => oreq,
      ackL   => oack,
      dataL => odata,
      tagL  => otag,
      reqR  => reqR,
      ackR  => ackR,
      dataR => dataR,
      clk   => clk,
      reset => reset);
  
end Vanilla;

