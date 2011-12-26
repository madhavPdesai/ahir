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
  
  signal ackL_sig : std_logic_vector(nreqs-1 downto 0);
begin  -- Behave

  -----------------------------------------------------------------------------
  -- parallel generate across all requesters
  -----------------------------------------------------------------------------
  PGen: for I in reqR'range generate
    RegFSM: block
      signal valid: std_logic;
      signal lhs_clear : std_logic;
      signal rhs_state, lhs_state : std_logic;
    begin  -- block Reg
      
      ---------------------------------------------------------------------------
      -- valid true if this I is mentioned in tag
      ---------------------------------------------------------------------------
      valid <= '1' when (reqL = '1') and (I = To_Integer(To_Unsigned(tagL))) else '0';

      ---------------------------------------------------------------------------
      -- lhs-state machine.
      ---------------------------------------------------------------------------
      process(clk,lhs_state, lhs_clear,reset,valid)
        variable nstate : std_logic;
        variable aL_var : std_logic;
      begin
        nstate := lhs_state;
        aL_var := '0';
        
        case lhs_state is
          when '0' =>
            if(valid = '1') then
              nstate := '1';
              aL_var := '1';
            end if;
          when '1' =>
            if(lhs_clear = '1') then
              nstate := '0';
            end if;
          when others => null;
        end case;

        if(reset = '1') then
          nstate := '0';
        end if;        

        ackL_sig(I) <= aL_var;
        
        if(clk'event and clk = '1') then
          lhs_state <= nstate;
        end if;
      end process;

      -------------------------------------------------------------------------
      -- rhs state machine
      -------------------------------------------------------------------------
     process(clk,rhs_state,reset,reqR(I),lhs_state)
       variable nstate : std_logic;
       variable aR_var : boolean;
       variable lhs_clear_var : std_logic;
     begin
        nstate := rhs_state;
        aR_var := false;
        lhs_clear_var := '0';
        
        case rhs_state is
          when '0' =>
            if(reqR(I)) then
              if(lhs_state = '1') then
                aR_var := true;
                lhs_clear_var := '1';
              else
                nstate := '1';
              end if;
            end if;
          when '1' =>
            if(lhs_state = '1') then
              lhs_clear_var := '1';
              aR_var := true;
              nstate := '0';
            end if;
          when others => null;
        end case;

        if(reset = '1') then
          nstate := '0';
        end if;        

        ackR(I) <= aR_var;
        lhs_clear <= lhs_clear_var;
        
        if(clk'event and clk = '1') then
          rhs_state <= nstate;
        end if;
     end process;
    end block RegFSM;
    
  end generate PGen;

  -----------------------------------------------------------------------------
  -- ackL
  -----------------------------------------------------------------------------
  ackL <= OrReduce(ackL_sig);

end Behave;
