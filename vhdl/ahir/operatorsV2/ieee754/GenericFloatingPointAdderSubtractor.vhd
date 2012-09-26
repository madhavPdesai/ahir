-------------------------------------------------------------------------------
-- An IEEE-754 compliant arbitrary-precision pipelined adder/subtractor
-- which is basically, a 3-stage pipelined version of the add function
-- described in the ieee_proposed VHDL library float_pkg_c.vhd
-- originally written by David Bishop (dbishop@vhdl.org)
-- modified by Madhav Desai.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.float_pkg.all;
use ieee_proposed.math_utility_pkg.all;

library ahir;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;


entity GenericFloatingPointAdderSubtractor is
  generic (tag_width : integer := 8;
           exponent_width: integer := 8;
           fraction_width : integer := 23;
           round_style : round_type := float_round_style;  -- rounding option
           addguard       : NATURAL := float_guard_bits;  -- number of guard bits
           check_error : BOOLEAN    := float_check_error;  -- check for errors
           denormalize : BOOLEAN    := float_denormalize;  -- Use IEEE extended FP           
	   use_as_subtractor: BOOLEAN := false
           );
  port(
    INA, INB: in std_logic_vector((exponent_width+fraction_width) downto 0);
    OUTADD: out std_logic_vector((exponent_width+fraction_width) downto 0);
    clk,reset: in std_logic;
    tag_in: in std_logic_vector(tag_width-1 downto 0);
    tag_out: out std_logic_vector(tag_width-1 downto 0);
    env_rdy, accept_rdy: in std_logic;
    addi_rdy, addo_rdy: out std_logic);
end entity;

architecture rtl of GenericFloatingPointAdderSubtractor is
  signal  l, r, lp, rp                 : UNRESOLVED_float(exponent_width downto -fraction_width);  -- floating point input


  
  signal pipeline_stall : std_logic;
  signal stage_full : std_logic_vector(0 to 6);
  signal tag0, tag1, tag2, tag3, tag4, tag5, tag6: std_logic_vector(tag_width-1 downto 0);

  signal fpresult_1         : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal fractc_1, fracts_1   : UNSIGNED (fraction_width+1+addguard downto 0);  -- constant and shifted signals
  signal rexpon_1           : SIGNED (exponent_width downto 0);  -- result exponent
  signal sign_1             : STD_ULOGIC;   -- sign of the output
  signal leftright_1        : BOOLEAN;      -- left or right used
  signal sticky_1             : STD_ULOGIC;   -- Holds precision for rounding
  signal exceptional_result_1 : std_ulogic; 
  signal  sign_l_1, sign_r_1  : std_ulogic;
  signal use_shifter_1  : std_ulogic;

  signal shifter_in_1, shifter_out   : UNSIGNED (fraction_width+1+addguard downto 0);  -- fractions
  signal shift_amount_1 : SIGNED (exponent_width downto 0);  -- shift fractions
  

  signal shifter_tag_in, shifter_tag_out: 
		std_logic_vector(tag_width + fpresult_1'length + fractc_1'length + fracts_1'length
				+ rexpon_1'length + 7 - 1 downto 0);
  signal shifter_full: std_logic;

  signal fpresult_3         : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal addL_3             : UNSIGNED (fraction_width+1+addguard downto 0);
  signal addR_3             : UNSIGNED (fraction_width+1+addguard downto 0);
  signal subtract_3         : std_logic;
  signal rexpon_3           : SIGNED (exponent_width downto 0);  -- result exponent
  signal sign_3             : STD_ULOGIC;   -- sign of the output
  signal sticky_3           : STD_ULOGIC;   -- Holds precision for rounding
  signal exceptional_result_3 : std_ulogic; 

  signal ufract_4           : UNSIGNED (fraction_width+1+addguard downto 0);
  signal fpresult_4         : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal adder_tag_in, adder_tag_out :
		std_logic_vector(tag_width + fpresult_3'length + rexpon_3'length + 3 - 1 downto 0);

  signal normalizer_tag_in, normalizer_tag_out: std_logic_vector(tag_width + fpresult_1'length downto 0);
  signal fpresult_5         : UNRESOLVED_float (exponent_width downto -fraction_width);

  signal fpresult_6         : UNRESOLVED_float (exponent_width downto -fraction_width);
  
begin

  pipeline_stall <= stage_full(6) and (not accept_rdy);
  addi_rdy <= not pipeline_stall;
  addo_rdy <= stage_full(6);
  tag_out <= tag6;

  -- construct l,r (user registers)
  lp <= to_float(INA, exponent_width, fraction_width);
 
  AsAdder: if (not use_as_subtractor) generate
  	rp <= to_float(INB, exponent_width, fraction_width);
  end generate AsAdder;

  AsSubtractor: if (use_as_subtractor) generate
        process(INB)
           variable btmp: UNRESOLVED_float(exponent_width downto -fraction_width);
        begin
	   btmp := to_float(INB, exponent_width, fraction_width);
  	   rp <= - btmp;
	end process;
  end generate AsSubtractor;

  -- return slv.
  OUTADD <= to_slv(fpresult_6);

  -----------------------------------------------------------------------------
  -- Stage 0: register inputs.
  -----------------------------------------------------------------------------
  process(clk)
    variable active_v : std_logic;
  begin
    active_v := env_rdy and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(0) <= active_v;
      if(active_v = '1') then
        tag0 <= tag_in;
        l <= lp;
        r <= rp;
      end if;
    end if;
  end process;
  
  -----------------------------------------------------------------------------
  -- Stage 1: detect NaN, deNorm, align exponents.
  -----------------------------------------------------------------------------
  process(clk)
    variable active_v : std_logic;
    variable lfptype, rfptype : valid_fpstate;
    variable fpresult         : UNRESOLVED_float (exponent_width downto -fraction_width);
    variable fractl, fractr   : UNSIGNED (fraction_width+1+addguard downto 0);  -- fractions
    variable fractc, fracts   : UNSIGNED (fraction_width+1+addguard downto 0);  -- constant and shifted variables
    variable urfract, ulfract : UNSIGNED (fraction_width downto 0);
    variable ufract           : UNSIGNED (fraction_width+1+addguard downto 0);
    variable exponl, exponr   : SIGNED (exponent_width-1 downto 0);  -- exponents
    variable rexpon           : SIGNED (exponent_width downto 0);  -- result exponent
    variable shiftx           : SIGNED (exponent_width downto 0);  -- shift fractions
    variable sign             : STD_ULOGIC;   -- sign of the output
    variable leftright        : BOOLEAN;      -- left or right used
    variable lresize, rresize : UNRESOLVED_float (exponent_width downto -fraction_width);
    variable sticky           : STD_ULOGIC;   -- Holds precision for rounding
    variable exceptional_result: std_ulogic;

    -- to get stuff to the shifter.
    variable use_shifter  : std_ulogic;
    variable shifter_in   : UNSIGNED (fraction_width+1+addguard downto 0);  -- fractions
    variable shift_amount : SIGNED (exponent_width downto 0);  -- shift fractions

    variable shift_too_low : boolean;
    variable shift_lt_zero : boolean;
    variable shift_eq_zero : boolean;
    variable shift_too_high : boolean;
    variable shift_gt_zero : boolean;
  begin

    exceptional_result := '0';
    sticky := '0';
    leftright := false;
    fracts := (others => '0');
    fractc := (others => '0');
    rexpon := (others => '0');
    fpresult := (others => '0');

    use_shifter := '0';
    shifter_in := (others => '0');
    shift_amount := (others => '0');
 

    ---------------------------------------------------------------------------
    -- will need to set appropriate flags here!
    ---------------------------------------------------------------------------
    if (fraction_width = 0 or l'length < 7 or r'length < 7) then
      lfptype := isx;
    else
      lfptype := classfp (l, check_error);
      rfptype := classfp (r, check_error);
    end if;
    if (lfptype = isx or rfptype = isx) then
      fpresult := (others => 'X');
      exceptional_result := '1';
    elsif (lfptype = nan or lfptype = quiet_nan or
           rfptype = nan or rfptype = quiet_nan)
      -- Return quiet NAN, IEEE754-1985-7.1,1
      or (lfptype = pos_inf and rfptype = neg_inf)
      or (lfptype = neg_inf and rfptype = pos_inf) then
      -- Return quiet NAN, IEEE754-1985-7.1,2
      exceptional_result := '1';
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (lfptype = pos_inf or rfptype = pos_inf) then   -- x + inf = inf
      exceptional_result := '1';
      fpresult := pos_inffp (fraction_width => fraction_width,
                             exponent_width => exponent_width);
    elsif (lfptype = neg_inf or rfptype = neg_inf) then   -- x - inf = -inf
      exceptional_result := '1';
      fpresult := neg_inffp (fraction_width => fraction_width,
                             exponent_width => exponent_width);
    elsif (lfptype = neg_zero and rfptype = neg_zero) then   -- -0 + -0 = -0
      exceptional_result := '1';
      fpresult := neg_zerofp (fraction_width => fraction_width,
                             exponent_width => exponent_width);
    end if;

    -- go ahead and compute all this stuff.  exceptional_result
    -- will override later if necessary.
    lresize := resize (arg            => to_x01(l),
                         exponent_width => exponent_width,
                         fraction_width => fraction_width,
                         denormalize_in => denormalize,
                         denormalize    => denormalize);
    lfptype := classfp (lresize, false);    -- errors already checked
    rresize := resize (arg            => to_x01(r),
                         exponent_width => exponent_width,
                         fraction_width => fraction_width,
                         denormalize_in => denormalize,
                         denormalize    => denormalize);
    rfptype := classfp (rresize, false);    -- errors already checked
    break_number (
        arg         => lresize,
        fptyp       => lfptype,
        denormalize => denormalize,
        fract       => ulfract,
        expon       => exponl);
    fractl := (others => '0');
    fractl (fraction_width+addguard downto addguard) := ulfract;
    break_number (
      arg         => rresize,
      fptyp       => rfptype,
      denormalize => denormalize,
      fract       => urfract,
      expon       => exponr);
    fractr := (others => '0');
    fractr (fraction_width+addguard downto addguard) := urfract;

    shiftx := (exponl(exponent_width-1) & exponl) - exponr;

    shift_too_low := (shiftx < -fractl'high);
    shift_lt_zero := (shiftx < 0);
    shift_eq_zero := (shiftx = 0);
    shift_too_high := (shiftx > fractl'high);
    shift_gt_zero := (shiftx > 0);
     
    if shift_too_low then
        rexpon    := exponr(exponent_width-1) & exponr;
        fractc    := fractr;
        fracts    := (others => '0');   -- add zero
        leftright := false;
        sticky    := or_reduce (fractl);
    elsif shift_lt_zero then
        shiftx    := - shiftx;

        shift_amount := shiftx;
        use_shifter := '1';
        shifter_in := fractl;

        -- fracts    := shift_right (fractl, to_integer(shiftx));
        fractc    := fractr;
        rexpon    := exponr(exponent_width-1) & exponr;
        leftright := false;
        sticky    := or_reduce (fractl (to_integer(shiftx) downto 0));
        sticky    := smallfract (fractl, to_integer(shiftx));
    elsif shift_eq_zero then
        rexpon := exponl(exponent_width-1) & exponl;
        sticky := '0';
        if fractr > fractl then
          fractc    := fractr;
          fracts    := fractl;
          leftright := false;
        else
          fractc    := fractl;
          fracts    := fractr;
          leftright := true;
        end if;
    elsif shift_too_high then
        rexpon    := exponl(exponent_width-1) & exponl;
        fracts    := (others => '0');   -- add zero
        fractc    := fractl;
        leftright := true;
        sticky    := or_reduce (fractr);
    elsif shift_gt_zero then

        shift_amount := shiftx;
        use_shifter := '1';
        shifter_in := fractl;

        -- fracts    := shift_right (fractr, to_integer(shiftx));
        fractc    := fractl;
        rexpon    := exponl(exponent_width-1) & exponl;
        leftright := true;
        sticky    := or_reduce (fractr (to_integer(shiftx) downto 0));
        sticky    := smallfract (fractr, to_integer(shiftx));
    end if;
    
    active_v := stage_full(0) and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(1) <= active_v;
      if(active_v = '1') then
        tag1 <= tag0;

        fpresult_1 <= fpresult;
        fractc_1 <= fractc;
        fracts_1 <= fracts;
        rexpon_1 <= rexpon;
        sign_1 <= sign;
        leftright_1 <= leftright;
        sticky_1 <= sticky;
        exceptional_result_1 <= exceptional_result;
	use_shifter_1 <= use_shifter;
        sign_l_1 <= l(l'high);
        sign_r_1 <= r(r'high);


	shift_amount_1 <= shift_amount;
	shifter_in_1 <= shifter_in;

        
      end if;        
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- stage 2: shifter.
  -----------------------------------------------------------------------------
  process(tag1, fpresult_1, fractc_1, fracts_1,rexpon_1, sign_1, leftright_1,
		exceptional_result_1, use_shifter_1, sign_l_1, sign_r_1)
  begin
        -- concatenate the tag as well!
  	shifter_tag_in(shifter_tag_in'high downto 7) <= 
		tag1 & 
		std_logic_vector(fpresult_1) & std_logic_vector(fractc_1) &
			std_logic_vector(fracts_1) & std_logic_vector(rexpon_1);
	shifter_tag_in(6) <= sign_1;
	if(leftright_1) then
		shifter_tag_in(5) <= '1';
	else
		shifter_tag_in(5) <= '0';
	end if;
	shifter_tag_in(4) <= sticky_1;
	shifter_tag_in(3) <= exceptional_result_1;
	shifter_tag_in(2) <= sign_l_1;
	shifter_tag_in(1) <= sign_r_1;
	shifter_tag_in(0) <= use_shifter_1;
 end process;

  shifter: UnsignedShifter generic map(shift_right_flag => true,
					tag_width => shifter_tag_in'length,
					operand_width => shifter_in_1'length,
					shift_amount_width => shift_amount_1'length)
		port map( L => shifter_in_1, R => unsigned(shift_amount_1),
				RESULT => shifter_out,
				clk => clk, reset => reset,
				in_rdy => stage_full(1),
				out_rdy => stage_full(2),
				stall => pipeline_stall,
				tag_in => shifter_tag_in,
				tag_out => shifter_tag_out);


  -----------------------------------------------------------------------------
  -- Stage 3: add mantissa stage
  -----------------------------------------------------------------------------
  process(clk)
    variable active_v : std_logic;
    variable lfptype, rfptype : valid_fpstate;
    variable fpresult         : UNRESOLVED_float (exponent_width downto -fraction_width);
    variable fractl, fractr   : UNSIGNED (fraction_width+1+addguard downto 0);  -- fractions
    variable fractc, fracts   : UNSIGNED (fraction_width+1+addguard downto 0);  -- constant and shifted variables
    variable urfract, ulfract : UNSIGNED (fraction_width downto 0);
    variable rexpon           : SIGNED (exponent_width downto 0);  -- result exponent
    variable shiftx           : SIGNED (exponent_width downto 0);  -- shift fractions
    variable sign,sign_l,sign_r          : STD_ULOGIC;   -- sign of the output
    variable leftright        : BOOLEAN;      -- left or right used
    variable sticky           : STD_ULOGIC;   -- Holds precision for rounding
    variable exceptional_result           : STD_ULOGIC;   -- set if exceptional.. Nan/-Zero/Inf
    variable tagv: std_logic_vector(tag_width-1 downto 0);
    variable use_shifter: std_logic;

    variable addL, addR : UNSIGNED (fraction_width+1+addguard downto 0); 
    variable subtract_v : std_logic;
    
  begin

    subtract_v := '0';
    addL := (others => '0');
    addR := (others => '0');

    tagv := shifter_tag_out(shifter_tag_out'high downto (shifter_tag_out'high - (tag_width-1)));
    fpresult := to_float(shifter_tag_out(shifter_tag_out'high - tag_width downto 
					(shifter_tag_out'high-(tag_width + fpresult'length - 1))),
					exponent_width, fraction_width);

    fractc := unsigned(shifter_tag_out((shifter_tag_out'high- (tag_width + fpresult'length)) downto 
					(shifter_tag_out'high-
						(tag_width + fpresult'length+fractc'length - 1))));
    fracts :=  unsigned(shifter_tag_out((shifter_tag_out'high-
					(tag_width + fpresult'length+fractc'length)) downto 
					(shifter_tag_out'high-
						(tag_width + fpresult'length+(2*fractc'length) - 1))));
    rexpon :=   signed(shifter_tag_out((shifter_tag_out'high-
					(tag_width + fpresult'length+(2*fractc'length))) downto 
					(shifter_tag_out'high-
					(tag_width + fpresult'length+(2*fractc'length)+rexpon'length-1))));

    sign := shifter_tag_out(6);
    if(shifter_tag_out(5)= '1') then
	leftright := true;
    else
	leftright := false;
    end if;
    sticky := shifter_tag_in(4);
    exceptional_result := shifter_tag_out(3);
    sign_l := shifter_tag_out(2);
    sign_r := shifter_tag_out(1);
    use_shifter := shifter_tag_out(0);

    if(use_shifter = '1') then
       fracts := shifter_out;
    end if;

      -- add
    fracts (0) := fracts (0) or sticky;     -- Or the sticky bit into the LSB

    -- inputs to the adder
    addL := fractc;
    addR := fracts;
    if sign_l = sign_r then
      -- ufract := fractc + fracts;
      sign   := sign_l;
    else                              -- signs are different
      subtract_v := '1';
      -- ufract := fractc - fracts;      -- always positive result
      if leftright then               -- Figure out which sign to use
        sign := sign_l;
      else
        sign := sign_r;
      end if;
    end if;
   

    active_v := stage_full(2) and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(3) <= active_v;
      if(active_v = '1') then
        tag3 <= tagv;
        fpresult_3 <= fpresult;
        rexpon_3 <= rexpon;
        sign_3 <= sign;
        sticky_3 <= sticky;
        exceptional_result_3 <= exceptional_result;
        addL_3 <= addL;
	addR_3 <= addR;
	subtract_3 <= subtract_v;
      end if;      
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Stage 4: adder.
  -----------------------------------------------------------------------------
  process(tag3, fpresult_3, rexpon_3, sign_3, sticky_3, exceptional_result_3)
  begin
	adder_tag_in(adder_tag_in'high downto 3)
		<= tag3 & std_logic_vector(fpresult_3) & std_logic_vector(rexpon_3);
	adder_tag_in(2) <= sign_3;
	adder_tag_in(1) <= sticky_3;
	adder_tag_in(0) <= exceptional_result_3;
  end process;

  adder: UnsignedAdderSubtractor
		generic map(tag_width => adder_tag_in'length,
				operand_width => addL_3'length,
				chunk_width => 8)
		port map( L => addL_3, R => addR_3, RESULT => ufract_4,
				subtract_op => subtract_3,
				clk => clk, reset => reset,
				in_rdy => stage_full(3),
				out_rdy => stage_full(4),
				stall => pipeline_stall,
				tag_in => adder_tag_in,
				tag_out => adder_tag_out);
				

  -----------------------------------------------------------------------------
  -- Stage 5: normalize.
  -----------------------------------------------------------------------------
  normalizer: block
    signal tagv: std_logic_vector(tag_width-1 downto 0);
    signal fpresult         : UNRESOLVED_float (exponent_width downto -fraction_width);
    signal rexpon           : SIGNED (exponent_width downto 0);  -- result exponent
    signal rexpon_padded    : SIGNED (exponent_width+1 downto 0);  -- result exponent
    signal sign             : STD_ULOGIC;   -- sign of the output
    signal sticky           : STD_ULOGIC;   -- Holds precision for rounding
    signal exceptional_result           : STD_ULOGIC;   -- set if exceptional.. Nan/-Zero/Inf
    signal ufract           : UNSIGNED (fraction_width+1+addguard downto 0);
  begin
    tagv <= adder_tag_out(adder_tag_out'high downto (adder_tag_out'high - (tagv'length-1)));
    fpresult <= to_float(adder_tag_out((adder_tag_out'high - tagv'length) downto 
				(adder_tag_out'high - (tagv'length+fpresult'length-1))),
			exponent_width, fraction_width);
    rexpon <= signed(adder_tag_out((adder_tag_out'high - (tagv'length+fpresult'length)) downto 
				(adder_tag_out'high - (tagv'length+fpresult'length+rexpon'length-1))));
    rexpon_padded <= resize(rexpon,exponent_width+2);
    ufract <= ufract_4;

    -- zero fraction => sign = '0'
    sign <= '0' when or_reduce(ufract) = '0' else adder_tag_out(2);

    sticky <= adder_tag_out(1);
    exceptional_result <= adder_tag_out(0);

    
    normalizer_tag_in(normalizer_tag_in'high downto 1) <= tagv & std_logic_vector(fpresult);
    normalizer_tag_in(0) <= exceptional_result;

    normalizer: GenericFloatingPointNormalizer
		generic map (tag_width => normalizer_tag_in'length,
				exponent_width => exponent_width,
				fraction_width => fraction_width,
				round_style => float_round_style,
				nguard => addguard,
				denormalize => denormalize)
		port map(fract => ufract,
			 expon => rexpon_padded,
			 sign => sign,
			 sticky => sticky,
			 in_rdy  => stage_full(4),
			 out_rdy => stage_full(5),
			 stall => pipeline_stall,
			 clk => clk,
			 reset => reset,
			 tag_in => normalizer_tag_in,
			 tag_out => normalizer_tag_out,
			 normalized_result => fpresult_5);
  end block;

  -----------------------------------------------------------------------------
  -- Stage 6: multiplexor.
  -----------------------------------------------------------------------------
  process(clk)
    variable active_v : std_logic;
    variable fpresult         : UNRESOLVED_float (exponent_width downto -fraction_width);
    variable fpresult_normalized         : UNRESOLVED_float (exponent_width downto -fraction_width);
    variable exceptional_result           : STD_ULOGIC;   -- set if exceptional.. Nan/-Zero/Inf
    variable tagv: std_logic_vector(tag_width-1 downto 0);
  begin

    tagv := normalizer_tag_out(normalizer_tag_out'high downto (normalizer_tag_out'high - (tagv'length-1)));
    fpresult := to_float(normalizer_tag_out((normalizer_tag_out'high - tagv'length) downto 
				(normalizer_tag_out'high - (tagv'length+fpresult'length-1))),
			exponent_width, fraction_width);
    exceptional_result := normalizer_tag_out(0);

    active_v := stage_full(5) and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(6) <= active_v;
      if(active_v = '1') then
        tag6 <= tagv;
    	if(exceptional_result = '1') then 
        	fpresult_6 <= fpresult;
	else
        	fpresult_6 <= fpresult_5;
	end if;
      end if;
    end if;
  end process;
  
end rtl;
