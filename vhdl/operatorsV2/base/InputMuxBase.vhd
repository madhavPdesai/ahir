library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity InputMuxBase is
  generic ( iwidth: integer := 10;
	   owidth: integer := 10;
	   twidth: integer := 3;
	   nreqs: integer := 1;
	   no_arbitration: Boolean := true);
  port (
    -- req/ack follow pulse protocol
    reqL                 : in  BooleanArray(nreqs-1 downto 0);
    ackL                 : out BooleanArray(nreqs-1 downto 0);
    dataL                : in  std_logic_vector(iwidth-1 downto 0);
    -- output side req/ack level protocol
    reqR                 : out std_logic;
    ackR                 : in  std_logic;
    dataR                : out std_logic_vector(owidth-1 downto 0);
    -- tag specifies the requester index 
    tagR                : out std_logic_vector(twidth-1 downto 0);
    clk, reset          : in std_logic);
end InputMuxBase;


architecture Behave of InputMuxBase is

  signal reqP,ackP,enP,fEN : std_logic_vector(nreqs-1 downto 0);


  type WordArray is array (natural range <>) of std_logic_vector(owidth-1 downto 0);
  signal dataP : WordArray(nreqs-1 downto 0);

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
    p2Linstance: Pulse_To_Level_Translate_Entity generic map(suppr_imm_ack => suppress_immediate_ack(I), push_mode => true)
      port map(rL => reqL(I), rR => reqP(I), aL => ackL(I), aR => ackP(I),
               en => enP(I), clk => clk, reset => reset);     

    process(clk)
      variable regv : std_logic_vector(owidth-1 downto 0);
    begin
      if(clk'event and clk = '1') then
        if(enP(I) = '1') then
          Extract(dataL,I,regv);
          dataP(I) <= regv;
        end if;
      end if;
    end process;
    
  end generate P2L;

  -----------------------------------------------------------------------------
  -- priority encoding or pass through
  -----------------------------------------------------------------------------
  NoArbitration: if no_arbitration generate
    fEN <= reqP;
    reqR <= OrReduce(fEN);
    ackP <= fEN when ackR = '1' else (others => '0');
  end generate NoArbitration;

  Arbitration: if not no_arbitration generate
    
    rpe : Request_Priority_Encode_Entity generic map (
      num_reqs => reqP'length)
      port map(
                          clk => clk,
                          reset => reset,
                          reqR => reqP,
                          ackR => ackP,
                          forward_enable => fEN,
                          req_s => reqR,
                          ack_s => ackR);
    
  end generate Arbitration;

  -----------------------------------------------------------------------------
  -- final multiplexor
  -----------------------------------------------------------------------------
  process(fEN,dataP)
  begin
    dataR <= (others => '0');
    for J in 0 to nreqs-1 loop
      if(fEN(J) = '1') then
        dataR <= dataP(J);
        exit;
      end if;
    end loop;
  end process;    

  -----------------------------------------------------------------------------
  -- tag generation
  -----------------------------------------------------------------------------
  taggen : BinaryEncoder generic map (
    iwidth => nreqs,
    owidth => twidth)
    port map (
      din  => fEN,
      dout => tagR);

end Behave;
