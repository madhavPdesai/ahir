library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity OutputDeMuxBaseNoData is
  generic(name : string;
          twidth: integer;
	  nreqs: integer;
	  detailed_buffering_per_output: IntegerArray);
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

  assert detailed_buffering_per_output'length = reqR'length report "Mismatch." severity failure;

  -----------------------------------------------------------------------------
  -- parallel generate across all requesters
  -----------------------------------------------------------------------------
  PGen: for I in reqR'range generate
    RegFSM: block
      subtype int7 is integer range 0 to detailed_buffering_per_output(I);
      signal valid: std_logic;
      signal lhs_clear : std_logic;
      signal rhs_state : std_logic;
      signal lhs_state : int7;
    begin  -- block Reg
      
      ---------------------------------------------------------------------------
      -- valid true if this I is mentioned in tag
      ---------------------------------------------------------------------------
      valid <= '1' when (reqL = '1') and (I = To_Integer(To_Unsigned(tagL))) else '0';

      ---------------------------------------------------------------------------
      -- lhs-state machine.. just a 3 bit counter which counts up everytime
      -- there is a valid input to this index, and down when the req appears 
      -- at the receiver end.
      ---------------------------------------------------------------------------
      process(clk,lhs_state, lhs_clear,reset,valid)
        variable nstate : int7;
        variable aL_var : std_logic;
      begin
        nstate := lhs_state;
        aL_var := '0';
        
        if(lhs_state < int7'high) then
            if(valid = '1') then
              nstate := lhs_state + 1;
              aL_var := '1';
            end if;
        end if;

        if(lhs_state > 0) then
            if(lhs_clear = '1') then
              nstate := lhs_state-1;
            end if;
	end if;


        ackL_sig(I) <= aL_var;
        
        if(clk'event and clk = '1') then
           if(reset = '1') then
              nstate := 0;
	   else
              lhs_state <= nstate;
           end if;        
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
              if(lhs_state > 0) then
                aR_var := true;
                lhs_clear_var := '1';
              else
                nstate := '1';
              end if;
            end if;
          when '1' =>
            if(lhs_state > 0) then
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
