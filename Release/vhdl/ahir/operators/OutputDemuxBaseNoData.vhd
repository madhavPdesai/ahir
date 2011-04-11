library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity OutputDeMuxBaseNoData is
  generic(twidth: integer;
	  nreqs: integer;
	  no_arbitration: Boolean);
  port (
    -- req/ack follow level protocol
    reqL                 : in  std_logic;
    ackL                 : out std_logic;
    -- tag identifies index to which demux
    -- should happen
    tagL                 : in std_logic_vector(twidth-1 downto 0);
    -- reqR/ackR follow pulse protocol
    -- and are of length n
    reqR                : in BooleanArray(nreqs-1 downto 0);
    ackR                : out  BooleanArray(nreqs-1 downto 0);
    clk, reset          : in std_logic);
end OutputDeMuxBaseNoData;

architecture Behave of OutputDeMuxBaseNoData is

  signal ackR_sig : BooleanArray(nreqs-1 downto 0);
  signal reqRreg, reqRfinal_pre_arb, reqRfinal, valid : std_logic_vector(nreqs-1 downto 0);
  signal ackL_sig : std_logic;
  
begin  -- Behave

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
  -- parallel generate across all requesters
  -----------------------------------------------------------------------------
  PGen: for I in reqR'range generate

    ---------------------------------------------------------------------------
    -- valid true if this I is mentioned in tag
    ---------------------------------------------------------------------------
    valid(I) <= '1' when (tagL = To_SLV(To_Unsigned(I,tagL'length))) else '0';

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
    -- ackR(I) 
    ---------------------------------------------------------------------------
    process(clk,reqRfinal(I),reqL,ackL_sig,reset)

      variable latch : boolean;
    begin

      -------------------------------------------------------------------------
      -- request is pending at I and I is valid and there is
      -- a request from the right which has been acknowledged
      -------------------------------------------------------------------------
      latch :=  (reqRfinal(I) = '1')  and (reqL = '1') and (ackL_sig = '1') and (reset = '0');

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
