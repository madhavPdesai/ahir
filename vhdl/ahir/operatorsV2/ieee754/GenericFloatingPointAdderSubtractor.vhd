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
  signal stage_full : std_logic_vector(0 to 3);
  signal tag0, tag1, tag2, tag3 : std_logic_vector(tag_width-1 downto 0);

  signal lfptype_1, rfptype_1 : valid_fpstate;
  signal fpresult_1         : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal fractl_1, fractr_1   : UNSIGNED (fraction_width+1+addguard downto 0);  -- fractions
  signal fractc_1, fracts_1   : UNSIGNED (fraction_width+1+addguard downto 0);  -- constant and shifted signals
  signal urfract_1, ulfract_1 : UNSIGNED (fraction_width downto 0);
  signal ufract_1           : UNSIGNED (fraction_width+1+addguard downto 0);
  signal exponl_1, exponr_1   : SIGNED (exponent_width-1 downto 0);  -- exponents
  signal rexpon_1           : SIGNED (exponent_width downto 0);  -- result exponent
  signal shiftx_1           : SIGNED (exponent_width downto 0);  -- shift fractions
  signal sign_1             : STD_ULOGIC;   -- sign of the output
  signal leftright_1        : BOOLEAN;      -- left or right used
  signal lresize_1, rresize_1 : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal sticky_1             : STD_ULOGIC;   -- Holds precision for rounding
  signal exceptional_result_1 : std_logic; 
  signal  l_1, r_1                 : UNRESOLVED_float(exponent_width downto -fraction_width);  -- floating point input
  
  signal lfptype_2, rfptype_2 : valid_fpstate;
  signal fpresult_2         : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal fractl_2, fractr_2   : UNSIGNED (fraction_width+1+addguard downto 0);  -- fractions
  signal fractc_2, fracts_2   : UNSIGNED (fraction_width+1+addguard downto 0);  -- constant and shifted signals
  signal urfract_2, ulfract_2 : UNSIGNED (fraction_width downto 0);
  signal ufract_2           : UNSIGNED (fraction_width+1+addguard downto 0);
  signal exponl_2, exponr_2   : SIGNED (exponent_width-1 downto 0);  -- exponents
  signal rexpon_2           : SIGNED (exponent_width downto 0);  -- result exponent
  signal shiftx_2           : SIGNED (exponent_width downto 0);  -- shift fractions
  signal sign_2             : STD_ULOGIC;   -- sign of the output
  signal leftright_2        : BOOLEAN;      -- left or right used
  signal lresize_2, rresize_2 : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal sticky_2           : STD_ULOGIC;   -- Holds precision for rounding
  signal exceptional_result_2 : std_logic; 

  signal lfptype_3, rfptype_3 : valid_fpstate;
  signal fpresult_3         : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal fractl_3, fractr_3   : UNSIGNED (fraction_width+1+addguard downto 0);  -- fractions
  signal fractc_3, fracts_3   : UNSIGNED (fraction_width+1+addguard downto 0);  -- constant and shifted signals
  signal urfract_3, ulfract_3 : UNSIGNED (fraction_width downto 0);
  signal ufract_3           : UNSIGNED (fraction_width+1+addguard downto 0);
  signal exponl_3, exponr_3   : SIGNED (exponent_width-1 downto 0);  -- exponents
  signal rexpon_3           : SIGNED (exponent_width downto 0);  -- result exponent
  signal shiftx_3           : SIGNED (exponent_width downto 0);  -- shift fractions
  signal sign_3             : STD_ULOGIC;   -- sign of the output
  signal leftright_3        : BOOLEAN;      -- left or right used
  signal lresize_3, rresize_3 : UNRESOLVED_float (exponent_width downto -fraction_width);
  signal sticky_3           : STD_ULOGIC;   -- Holds precision for rounding
  signal result_X_3         : std_logic; 
  signal result_Nan_3       : std_logic; 
  signal exceptional_result_3 : std_logic; 
  
  
begin

  pipeline_stall <= stage_full(3) and (not accept_rdy);
  addi_rdy <= not pipeline_stall;
  addo_rdy <= stage_full(3);
  tag_out <= tag3;

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
  OUTADD <= to_slv(fpresult_3);

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
  begin

    exceptional_result := '0';
    sticky := '0';
    leftright := false;
    fracts := (others => '0');
    fractc := (others => '0');
    rexpon := (others => '0');
    fpresult := (others => '0');
 

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
    else
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
      if shiftx < -fractl'high then
        rexpon    := exponr(exponent_width-1) & exponr;
        fractc    := fractr;
        fracts    := (others => '0');   -- add zero
        leftright := false;
        sticky    := or_reduce (fractl);
      elsif shiftx < 0 then
        shiftx    := - shiftx;
        fracts    := shift_right (fractl, to_integer(shiftx));
        fractc    := fractr;
        rexpon    := exponr(exponent_width-1) & exponr;
        leftright := false;
        sticky    := or_reduce (fractl (to_integer(shiftx) downto 0));
        sticky    := smallfract (fractl, to_integer(shiftx));
      elsif shiftx = 0 then
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
      elsif shiftx > fractr'high then
        rexpon    := exponl(exponent_width-1) & exponl;
        fracts    := (others => '0');   -- add zero
        fractc    := fractl;
        leftright := true;
        sticky    := or_reduce (fractr);
      elsif shiftx > 0 then
        fracts    := shift_right (fractr, to_integer(shiftx));
        fractc    := fractl;
        rexpon    := exponl(exponent_width-1) & exponl;
        leftright := true;
        sticky    := or_reduce (fractr (to_integer(shiftx) downto 0));
        sticky    := smallfract (fractr, to_integer(shiftx));
      end if;
    end if;
    
    active_v := stage_full(0) and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(1) <= active_v;
      if(active_v = '1') then
        tag1 <= tag0;

        lfptype_1 <= lfptype;
        rfptype_1 <= rfptype;
        fpresult_1 <= fpresult;
        fractl_1 <= fractl;
        fractr_1 <= fractr;
        fractc_1 <= fractc;
        fracts_1 <= fracts;
        urfract_1  <= urfract;
        ulfract_1 <= ulfract;
        ufract_1 <= ufract;
        exponl_1 <= exponl;
        exponr_1 <= exponr;
        rexpon_1 <= rexpon;
        shiftx_1 <= shiftx;
        sign_1 <= sign;
        leftright_1 <= leftright;
        lresize_1 <= lresize;
        rresize_1 <= rresize;
        sticky_1 <= sticky;
        exceptional_result_1 <= exceptional_result;

        l_1 <= l;
        r_1 <= r;
        
      end if;        
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Stage 2: add mantissa stage
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
    variable exceptional_result           : STD_ULOGIC;   -- set if exceptional.. Nan/-Zero/Inf
    
  begin
    lfptype := lfptype_1;
    rfptype := rfptype_1;
    fpresult := fpresult_1;
    fractl := fractl_1;
    fractr := fractr_1;
    fractc := fractc_1;
    fracts := fracts_1;
    urfract := urfract_1;
    ulfract := ulfract_1;
    ufract := ufract_1;
    exponl := exponl_1;
    exponr := exponr_1;
    rexpon := rexpon_1;
    shiftx := shiftx_1;
    sign := sign_1;
    leftright := leftright_1;
    lresize := lresize_1;
    rresize := rresize_1;
    sticky := sticky_1;
    exceptional_result := exceptional_result_1;
    
      -- add
    fracts (0) := fracts (0) or sticky;     -- Or the sticky bit into the LSB
    if l_1(l'high) = r_1(r'high) then
      ufract := fractc + fracts;
      sign   := l_1(l'high);
    else                              -- signs are different
      ufract := fractc - fracts;      -- always positive result
      if leftright then               -- Figure out which sign to use
        sign := l_1(l'high);
      else
        sign := r_1(r'high);
      end if;
    end if;
    if or_reduce (ufract) = '0' then
      sign := '0';                    -- IEEE 854, 6.3, paragraph 2.
    end if;

    active_v := stage_full(1) and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(2) <= active_v;
      if(active_v = '1') then
        tag2 <= tag1;

        lfptype_2 <= lfptype;
        rfptype_2 <= rfptype;
        fpresult_2 <= fpresult;
        fractl_2 <= fractl;
        fractr_2 <= fractr;
        fractc_2 <= fractc;
        fracts_2 <= fracts;
        urfract_2  <= urfract;
        ulfract_2 <= ulfract;
        ufract_2 <= ufract;
        exponl_2 <= exponl;
        exponr_2 <= exponr;
        rexpon_2 <= rexpon;
        shiftx_2 <= shiftx;
        sign_2 <= sign;
        leftright_2 <= leftright;
        lresize_2 <= lresize;
        rresize_2 <= rresize;
        sticky_2 <= sticky;
        exceptional_result_2 <= exceptional_result;
      end if;      
    end if;
  end process;


  -----------------------------------------------------------------------------
  -- Stage 3: normalize.
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
    variable exceptional_result           : STD_ULOGIC;   -- set if exceptional.. Nan/-Zero/Inf
  begin
    lfptype := lfptype_1;
    rfptype := rfptype_2;
    fpresult := fpresult_2;
    fractl := fractl_2;
    fractr := fractr_2;
    fractc := fractc_2;
    fracts := fracts_2;
    urfract := urfract_2;
    ulfract := ulfract_2;
    ufract := ufract_2;
    exponl := exponl_2;
    exponr := exponr_2;
    rexpon := rexpon_2;
    shiftx := shiftx_2;
    sign := sign_2;
    leftright := leftright_2;
    lresize := lresize_2;
    rresize := rresize_2;
    sticky := sticky_2;
    exceptional_result := exceptional_result_2;

    -- normalize!
    if(exceptional_result = '0') then 
    	fpresult := normalize (fract          => ufract,
                           	expon          => rexpon,
                           	sign           => sign,
                           	sticky         => sticky,
                           	fraction_width => fraction_width,
                           	exponent_width => exponent_width,
                           	round_style    => round_style,
                           	denormalize    => denormalize,
                           	nguard         => addguard);
    end if;
    
    active_v := stage_full(2) and not (pipeline_stall or reset);
    if(clk'event and clk = '1') then
      stage_full(3) <= active_v;
      if(active_v = '1') then
        tag3 <= tag2;

        lfptype_3 <= lfptype;
        rfptype_3 <= rfptype;
        fpresult_3 <= fpresult;
        fractl_3 <= fractl;
        fractr_3 <= fractr;
        fractc_3 <= fractc;
        fracts_3 <= fracts;
        urfract_3  <= urfract;
        ulfract_3 <= ulfract;
        ufract_3 <= ufract;
        exponl_3 <= exponl;
        exponr_3 <= exponr;
        rexpon_3 <= rexpon;
        shiftx_3 <= shiftx;
        sign_3 <= sign;
        leftright_3 <= leftright;
        lresize_3 <= lresize;
        rresize_3 <= rresize;
        sticky_3 <= sticky;
        exceptional_result_3 <= exceptional_result;
      end if;
    end if;
  end process;
  
end rtl;
