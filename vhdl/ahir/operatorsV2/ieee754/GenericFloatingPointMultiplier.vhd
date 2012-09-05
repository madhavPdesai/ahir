-------------------------------------------------------------------------------
-- An IEEE-754 compliant arbitrary-precision pipelined multiplier
-- which is basically, a pipelined version of the multiply function
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


entity GenericFloatingPointMultiplier is
  generic (tag_width : integer := 8;
           exponent_width: integer := 8;
           fraction_width : integer := 23;
           round_style : round_type := float_round_style;  -- rounding option
           addguard       : NATURAL := float_guard_bits;  -- number of guard bits
           check_error : BOOLEAN    := float_check_error;  -- check for errors
           denormalize : BOOLEAN    := float_denormalize;  -- Use IEEE extended FP           
	   use_as_subtractor: BOOLEAN  := false -- TODO: get rid of this!
           );
  port(
    INA, INB: in std_logic_vector((exponent_width+fraction_width) downto 0);
    OUTMUL: out std_logic_vector((exponent_width+fraction_width) downto 0);
    clk,reset: in std_logic;
    tag_in: in std_logic_vector(tag_width-1 downto 0);
    tag_out: out std_logic_vector(tag_width-1 downto 0);
    env_rdy, accept_rdy: in std_logic;
    muli_rdy, mulo_rdy: out std_logic);
end entity;

architecture rtl of GenericFloatingPointMultiplier is

  constant operand_width : integer := exponent_width+fraction_width+1;

  signal  l, r                 : UNRESOLVED_float(exponent_width downto -fraction_width);  -- floating point input  
  signal pipeline_stall : std_logic;
  signal stage_full : std_logic_vector(1 to 3);


  constant multguard        : NATURAL := addguard;           -- guard bits

  -- stage 1 outputs
  signal lfptype_1, rfptype_1 : valid_fpstate;
  signal fpresult_1         : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal fractl_1, fractr_1   : UNSIGNED (fraction_width downto 0);  -- fractions
  signal rfract_1           : UNSIGNED ((2*(fraction_width))+1 downto 0);  -- result fraction
  signal sfract_1           : UNSIGNED (fraction_width+1+multguard downto 0);  -- result fraction
  signal shifty_1           : INTEGER;      -- denormal shift
  signal exponl_1, exponr_1   : SIGNED (exponent_width-1 downto 0);  -- exponents
  signal rexpon_1           : SIGNED (exponent_width+1 downto 0);  -- result exponent
  signal fp_sign_1          : STD_ULOGIC;   -- sign of result
  signal lresize_1, rresize_1 : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal sticky_1           : STD_ULOGIC;   -- Holds precision for rounding
  signal exceptional_result_1  : std_logic;
  
  signal tag1: std_logic_vector(tag_width-1 downto 0);
  signal tag1_extended : std_logic_vector(tag_width+operand_width+(exponent_width+2)+1+1-1 downto 0);  

  -- stage 2 outputs (note stage 2 itelf is a pipelined array multiplier)
  signal rfract_2           : UNSIGNED ((2*(fraction_width))+1 downto 0);  -- result fraction  
  signal tag2_extended : std_logic_vector(tag_width+operand_width+(exponent_width+2)+1+1-1 downto 0);

  -- stage 3 outputs.
  signal tag3: std_logic_vector(tag_width-1 downto 0);  
  signal fpresult_3         : UNRESOLVED_float (exponent_width downto -fraction_width);
  
begin

  pipeline_stall <= stage_full(3) and (not accept_rdy);
  muli_rdy <= not pipeline_stall;
  mulo_rdy <= stage_full(3);
  tag_out <= tag3;

  -- construct l,r.
  l <= to_float(INA, exponent_width, fraction_width);
  r <= to_float(INB, exponent_width, fraction_width);

  -- return slv.
  OUTMUL <= to_slv(fpresult_3);
  
  -----------------------------------------------------------------------------
  -- Stage 1: detect NaN, deNorm, align exponents.
  -----------------------------------------------------------------------------
  process(clk)
    variable active_v : std_logic;
    variable exceptional_result: std_ulogic;
    variable lfptype, rfptype : valid_fpstate;
    variable fpresult         : UNRESOLVED_float (exponent_width downto -fraction_width);
    variable fractl, fractr   : UNSIGNED (fraction_width downto 0);  -- fractions
    variable rfract           : UNSIGNED ((2*(fraction_width))+1 downto 0);  -- result fraction
    variable sfract           : UNSIGNED (fraction_width+1+multguard downto 0);  -- result fraction
    variable shifty           : INTEGER;      -- denormal shift
    variable exponl, exponr   : SIGNED (exponent_width-1 downto 0);  -- exponents
    variable rexpon           : SIGNED (exponent_width+1 downto 0);  -- result exponent
    variable fp_sign          : STD_ULOGIC;   -- sign of result
    variable lresize, rresize : UNRESOLVED_float (exponent_width downto -fraction_width);
    variable sticky           : STD_ULOGIC;   -- Holds precision for rounding
  begin
    exceptional_result := '0';    
    fp_sign := '0';
    rexpon := (others => '0');
    exponl := (others => '0');
    exponr := (others => '0');
    shifty := 0;
    fractl := (others => '0');
    fractr := (others => '0');
    lfptype := isx;
    rfptype := isx;
    fpresult := (others => '0');
     
    if (fraction_width = 0 or l'length < 7 or r'length < 7) then
      lfptype := isx;
      exceptional_result := '1';
    else
      lfptype := classfp (l, check_error);
      rfptype := classfp (r, check_error);
    end if;
    if (lfptype = isx or rfptype = isx) then
      fpresult := (others => 'X');
      exceptional_result := '1';      
    elsif ((lfptype = nan or lfptype = quiet_nan or
            rfptype = nan or rfptype = quiet_nan)) then
      -- Return quiet NAN, IEEE754-1985-7.1,1
      exceptional_result := '1';      
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (((lfptype = pos_inf or lfptype = neg_inf) and
            (rfptype = pos_zero or rfptype = neg_zero)) or
           ((rfptype = pos_inf or rfptype = neg_inf) and
            (lfptype = pos_zero or lfptype = neg_zero))) then    -- 0 * inf
      -- Return quiet NAN, IEEE754-1985-7.1,3
      exceptional_result := '1';      
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (lfptype = pos_inf or rfptype = pos_inf
           or lfptype = neg_inf or rfptype = neg_inf) then  -- x * inf = inf
      exceptional_result := '1';      
      fpresult := pos_inffp (fraction_width => fraction_width,
                             exponent_width => exponent_width);
      -- figure out the sign
      fp_sign := l(l'high) xor r(r'high);     -- figure out the sign
      fpresult (exponent_width) := fp_sign;
    else
      fp_sign := l(l'high) xor r(r'high);     -- figure out the sign
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
        fract       => fractl,
        expon       => exponl);
      break_number (
        arg         => rresize,
        fptyp       => rfptype,
        denormalize => denormalize,
        fract       => fractr,
        expon       => exponr);
      if (rfptype = pos_denormal or rfptype = neg_denormal) then
        shifty := fraction_width - find_leftmost(fractr, '1');
        fractr := shift_left (fractr, shifty);
      elsif (lfptype = pos_denormal or lfptype = neg_denormal) then
        shifty := fraction_width - find_leftmost(fractl, '1');
        fractl := shift_left (fractl, shifty);
      else
        shifty := 0;
        -- Note that a denormal number * a denormal number is always zero.
      end if;
      -- multiply
      -- add the exponents
      rexpon := resize (exponl, rexpon'length) + exponr - shifty + 1;
    end if;

    active_v := env_rdy and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(1) <= active_v;
      if(active_v = '1') then
        tag1 <= tag_in;
        
        fpresult_1 <= fpresult;
        fractl_1 <= fractl;
        fractr_1 <= fractr;
        rexpon_1 <= rexpon;
        fp_sign_1 <= fp_sign;
        exceptional_result_1 <= exceptional_result;
      end if;      
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Stage 2: instantiate array multiplier
  -----------------------------------------------------------------------------
  process(tag1, fpresult_1, rexpon_1, fp_sign_1, exceptional_result_1)
    variable tex : std_logic_vector(tag_width+operand_width+(exponent_width+2)+1 downto 0);
    variable fp_slv : std_logic_vector(operand_width-1 downto 0);
    variable pad_bits : std_logic_vector(1 downto 0);
  begin

    fp_slv(operand_width-1) := fpresult_1(exponent_width);
    fp_slv(operand_width-2 downto fraction_width) := to_slv(fpresult_1(exponent_width-1 downto 0));
    fp_slv(fraction_width-1 downto 0) := to_slv(fpresult_1(-1 downto -fraction_width));

    pad_bits(1) := fp_sign_1;
    pad_bits(0) := exceptional_result_1;
    
    tex := tag1 & fp_slv & to_slv(rexpon_1) & pad_bits;
    
    tag1_extended <= tex;
  end process;
  
  amul : UnsignedMultiplier
    generic map (tag_width => tag_width+operand_width+(exponent_width+2)+2,
                 operand_width => fraction_width+1)
    port map (
      L       => fractl_1,
      R       => fractR_1,
      RESULT  => rfract_2,
      clk     => clk,
      reset   => reset,
      in_rdy  => stage_full(1),
      out_rdy => stage_full(2),
      stall   => pipeline_stall,
      tag_in  => tag1_extended,
      tag_out => tag2_extended);
    


  -----------------------------------------------------------------------------
  -- Stage 3: normalize.
  -----------------------------------------------------------------------------
  process(clk)
    variable active_v : std_logic;
    variable exceptional_result: std_ulogic;
    variable fpresult         : UNRESOLVED_float (exponent_width downto -fraction_width);
    variable rfract           : UNSIGNED ((2*(fraction_width))+1 downto 0);  -- result fraction
    variable sfract           : UNSIGNED (fraction_width+1+multguard downto 0);  -- result fraction
    variable rexpon           : SIGNED (exponent_width+1 downto 0);  -- result exponent
    variable fp_sign          : STD_ULOGIC;   -- sign of result
    variable sticky           : STD_ULOGIC;   -- Holds precision for rounding
    variable raw_tag : std_logic_vector(tag_width-1 downto 0);
    
  begin

    raw_tag := tag2_extended((tag_width+operand_width+exponent_width+3) downto (operand_width+exponent_width+4));
    fpresult := to_float(tag2_extended(operand_width+exponent_width+3 downto exponent_width+4), exponent_width, fraction_width);
    rexpon := to_signed(tag2_extended(exponent_width+3 downto 2));
    fp_sign := tag2_extended(1);
    exceptional_result := tag2_extended(0);
    
    rfract := rfract_2;
    sfract := rfract (rfract'high downto
                      rfract'high - (fraction_width+1+multguard));
    sticky := or_reduce (rfract (rfract'high-(fraction_width+1+multguard)
                                 downto 0));
    -- normalize
    fpresult := normalize (fract          => sfract,
                           expon          => rexpon,
                           sign           => fp_sign,
                           sticky         => sticky,
                           fraction_width => fraction_width,
                           exponent_width => exponent_width,
                           round_style    => round_style,
                           denormalize    => denormalize,
                           nguard         => multguard);
    
    active_v := stage_full(2) and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(3) <= active_v;
      if(active_v = '1') then
        tag3 <= raw_tag;

        if(exceptional_result = '0') then
          fpresult_3 <= fpresult;
        end if;
        
      end if;      
    end if;
  end process;
  
end rtl;
