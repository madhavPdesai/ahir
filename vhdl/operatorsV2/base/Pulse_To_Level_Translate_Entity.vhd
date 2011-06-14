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


  signal pulse_state : std_logic;
  signal level_state : std_logic;
  signal start_level : boolean;
  signal finish_pulse : boolean;
begin  -- Behave

  process(clk)
    variable nstate : std_logic;
  begin
    nstate := pulse_state;
    
    if(reset = '1') then
      nstate := '0';
    else
      case pulse_state is
        when '0' =>
          if(rL and (level_state = '0')) then
            nstate := '1';
          end if;
        when '1' =>
          if(level_state = '0') then
            nstate := '0';
          end if;
        when others => null;
      end case;
    end if;

    if(clk'event and clk = '1') then
      pulse_state <= nstate;
    end if;
  end process;

  aL <= true when (pulse_state = '1') and (level_state = '0') else false;
  start_level <= true when (pulse_state = '0') and (level_state = '0') and rL else false;
  eN <= '1' when start_level else '0';
  

  process(clk)
    variable nstate : std_logic;
  begin
    nstate := level_state;
    
    if(reset = '1') then
      nstate := '0';
    else
      case level_state is
        when '0' =>
          if(start_level) then
            nstate := '1';
          end if;
        when '1' =>
          if(aR = '1') then
            nstate := '0';
          end if;
        when others => null;
      end case;
    end if;

    if(clk'event and clk = '1') then
      level_state <= nstate;
    end if;
  end process;
  rR <= '1' when level_state = '1' else '0';
  finish_pulse <= true when (level_state = '1') and (aR = '1') else false;
  
end Behave;
