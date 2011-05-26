library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity OutputDeMuxBase is
  generic(iwidth: integer := 4;
	  owidth: integer := 12;
	  twidth: integer := 2;
	  nreqs: integer := 3;
	  no_arbitration: Boolean := true);
  port (
    -- req/ack follow level protocol
    reqL                 : in  std_logic;
    ackL                 : out std_logic;
    dataL                : in  std_logic_vector(iwidth-1 downto 0);
    -- tag identifies index to which demux
    -- should happen
    tagL                 : in std_logic_vector(twidth-1 downto 0);
    -- reqR/ackR follow pulse protocol
    -- and are of length n
    reqR                : in BooleanArray(nreqs-1 downto 0);
    ackR                : out  BooleanArray(nreqs-1 downto 0);
    -- dataR is array(n,m) 
    dataR               : out std_logic_vector(owidth-1 downto 0);
    clk, reset          : in std_logic);
end OutputDeMuxBase;

architecture Behave of OutputDeMuxBase is

  signal ackR_sig : BooleanArray(nreqs-1 downto 0);
  signal reqRreg, reqRfinal_pre_arb, reqRfinal, valid : std_logic_vector(nreqs-1 downto 0);

  type WordArray is array (natural range <>) of std_logic_vector(iwidth-1 downto 0);
  signal dreg, dfinal : WordArray(nreqs-1 downto 0);

  signal ackL_sig : std_logic;
  
begin  -- Behave

  assert(owidth = iwidth*nreqs) report "word-length mismatch in output demux" severity failure;

  -----------------------------------------------------------------------------
  -- reqRfinal
  -----------------------------------------------------------------------------
  NoArb: if no_arbitration generate
     reqRfinal <= reqRfinal_pre_arb;
  end generate NoArb;

  Arb: if not no_arbitration generate
     reqRfinal <= PriorityEncode(reqRfinal_pre_arb);
  end generate Arb;
 

  -----------------------------------------------------------------------------
  -- dataR
  -----------------------------------------------------------------------------
  process(dfinal)
    variable dataRv : std_logic_vector(dataR'high downto dataR'low);
  begin
    for I in dfinal'range loop
      Insert(dataRv,I,dfinal(I));
    end loop;
    dataR <= dataRv;
  end process;

  -----------------------------------------------------------------------------
  -- parallel generate across all requesters
  -----------------------------------------------------------------------------
  PGen: for I in reqR'range generate

    ---------------------------------------------------------------------------
    -- valid true if this I is mentioned in tag
    ---------------------------------------------------------------------------
    valid(I) <= '1' when (I = To_Integer(To_Unsigned(tagL))) else '0';

    ---------------------------------------------------------------------------
    -- set/clear pulse request from right
    ---------------------------------------------------------------------------
    process(clk,reset,reqR,ackR_sig)
      variable set,clear : boolean;
    begin
      set := reqR(I);
      clear := (reset = '1') or ackR_sig(I);
      
      if(clk'event and clk = '1') then
        if(clear) then
          reqRreg(I) <= '0';
        elsif set then
          reqRreg(I) <= '1';
        end if;
      end if;
    end process;

    reqRfinal_pre_arb(I) <= '1' when (reqR(I) or (reqRreg(I) = '1') ) and (valid(I) = '1') else '0';

    ---------------------------------------------------------------------------
    -- data register/mux
    ---------------------------------------------------------------------------
    process(clk,reqRfinal(I),reqL,ackL_sig,dataL,dreg(I),reset)

      variable latch : boolean;
      variable ldataL : std_logic_vector(dataL'length-1 downto 0);
      
    begin

      -------------------------------------------------------------------------
      -- request is pending at I and I is valid and there is
      -- a request from the right which has been acknowledged
      -------------------------------------------------------------------------
      latch :=  (reqRfinal(I) = '1')  and (reqL = '1') and (ackL_sig = '1') and (reset = '0');
      ldataL := dataL;

      if(reset = '1') then
        dfinal(I) <= (others => '0');
      elsif latch then
        dfinal(I) <= ldataL;
      else
        dfinal(I) <= dreg(I);
      end if;

      if(clk'event and clk = '1') then
        if(latch) then
            dreg(I) <= ldataL;
        end if;
      end if;

      ackR_sig(I) <= latch;
    end process;
  end generate PGen;

  -----------------------------------------------------------------------------
  -- ackR
  -----------------------------------------------------------------------------
  ackR <= ackR_sig;
  
  -----------------------------------------------------------------------------
  -- ackL
  -----------------------------------------------------------------------------
  ackL_sig <= reqL and OrReduce(reqRfinal);
  ackL <= ackL_sig;


end Behave;
