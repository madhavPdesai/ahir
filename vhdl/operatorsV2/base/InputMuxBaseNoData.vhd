library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity InputMuxBaseNoData is
  generic ( twidth: integer;
	   nreqs: integer;
	   no_arbitration: Boolean);
  port (
    -- req/ack follow pulse protocol
    reqL                 : in  BooleanArray(nreqs-1 downto 0);
    ackL                 : out BooleanArray(nreqs-1 downto 0);
    -- output side req/ack level protocol
    reqR                 : out std_logic;
    ackR                 : in  std_logic;
    -- tag specifies the requester index 
    tagR                : out std_logic_vector(twidth-1 downto 0);
    clk, reset          : in std_logic);
end InputMuxBaseNoData;


architecture Behave of InputMuxBaseNoData is

  signal reqP,ackP,enP,ssig : std_logic_vector(nreqs-1 downto 0);
  signal reqF,reqFreg : std_logic_vector(nreqs-1 downto 0);  
  signal req_fsm_state: std_logic;

  constant tag0 : std_logic_vector(twidth-1 downto 0) := (others => '0');

  -- one-cycle delay between req and ack => in order to break long
  -- combinational (false) paths.
  constant suppress_immediate_ack : BooleanArray(reqL'length-1 downto 0) := (others => true);
begin  -- Behave


  assert(iwidth = owidth*nreqs) report "mismatched i/o widths in InputMuxBase" severity error;

  -----------------------------------------------------------------------------
  -- pulse to level translate
  -----------------------------------------------------------------------------
  P2L: for I in nreqs-1 downto 0 generate
      P2LBlk: block
        signal state : P2LState;
      begin  -- block P2L          
        Pulse_To_Level_Translate(suppr_imm_ack => suppress_immediate_ack(I),
                                 rL => reqL(I), rR => reqP(I), aL => ackL(I), aR => ackP(I),
                                 en => enP(I), state => state, clk => clk, reset => reset);
      end block P2LBlk;

  end generate P2L;


  -----------------------------------------------------------------------------
  -- priority encoding or pass through
  -----------------------------------------------------------------------------
  NoArbitration: if no_arbitration generate
    reqF <= reqP;
    reqR <= OrReduce(reqF);
    ackP <= reqF when ackR = '1' else (others => '0');
  end generate NoArbitration;

  Arbitration: if not no_arbitration generate
    RequestPriorityEncode(req_fsm_state => req_fsm_state,
                            clk => clk,
                            reset => reset,
                            reqR => reqP,
                            ackR => ackP,
                            reqF => reqF,
                            req_s => reqR,
                            ack_s => ackR,
                            reqFreg => reqFreg);
  end generate Arbitration;


  -----------------------------------------------------------------------------
  -- tag generation
  -----------------------------------------------------------------------------
    process(reqF)
    begin
      tagR <= tag0;
      for J in reqF'range loop
        if(reqF(J) = '1') then
          tagR <= To_SLV(To_Unsigned(J,tagR'length));
        end if;
      end loop;  -- J
    end process;
  
end Behave;
