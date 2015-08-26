library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

--
-- in pull_mode, rL/aL accepts data which is sent by rR/aR.
-- rL -> rR is 0 delay, but aR -> aL MUST have a delay.
--
entity Pulse_To_Level_Translate_Entity is
  port( rL : in boolean;
        rR : out std_logic;
        aL : out boolean;
        aR : in std_logic;
        clk : in std_logic;
        reset : in std_logic);
end entity;

architecture Behave of Pulse_To_Level_Translate_Entity is
  type PullModeState is (Idle,Ack,Waiting);
  signal pull_mode_state : PullModeState;
begin  -- Behave

  process(clk, rL, aR)
    variable nstate : PullModeState;
  begin
    nstate := pull_mode_state;
    rR <= '0';
    aL <= false;

      case pull_mode_state is
        when Idle =>
          if(rL) then
            rR <= '1';
            if(aR = '1') then
              nstate := Ack;
            else
              nstate := Waiting;
            end if;
          end if;
        when Ack =>
          aL <= true;
          if(rL) then
            rR <= '1' ;
	    if(aR = '0')  then
               	nstate := Waiting;
	    end if;
          else
            nstate := Idle;
          end if; 
        when Waiting =>
          if(aR = '1') then
            nstate := Ack;
          end if;
        when others => null;
      end case;

    if(clk'event and clk = '1') then
	if reset = '1' then
		pull_mode_state <= Idle;
	else
      		pull_mode_state <= nstate;
	end if;
    end if;
  end process;
end Behave;
