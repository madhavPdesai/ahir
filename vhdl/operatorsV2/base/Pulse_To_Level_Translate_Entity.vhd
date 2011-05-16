library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity Pulse_To_Level_Translate_Entity is
  generic ( suppr_imm_ack : boolean := true);
  port( rL : in boolean;
        rR : out std_logic;
        aL : out boolean;
        aR : in std_logic;
        en : out std_logic;
        clk : in std_logic;
        reset : in std_logic);
end entity;

architecture Behave of Pulse_To_Level_Translate_Entity is

  signal state : P2LState;
begin  -- Behave

  process(clk,reset,rL,aR,state)
    variable nstate : P2LState;
  begin
    nstate := state;
    
    rR <= '0';
    aL <= false;
    en <= '0';
    
    if(reset = '1') then
      nstate := I;
    else
      case state is
        when I =>
          if(rL) then
            rR <= '1';
            en <= '1';
            if(aR = '1') then
              if(suppr_imm_ack) then
                nstate := W;
              else
                aL <= true;
              end if;
            else
              nstate := B;
            end if;
          end if;
        when B =>
          rR <= '1';
          if(aR = '1') then
            aL <= true;
            nstate := I;
          end if;
        when W =>
          aL <= true;
          nstate := I;
        when others => null;
      end case;
    end if;

    if(clk'event and clk = '1') then
      state <= nstate;
    end if;
  end process;
end Behave;
