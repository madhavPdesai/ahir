library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

--
-- in pull_mode, rL/aL accepts data which is sent by rR/aR.
-- paths rL -> rR and aR -> aL  are 0-delay.
-- back-to-back transfers are permitted.
--
entity PulseToLevel is
  port( rL : in boolean;
        rR : out std_logic;
        aL : out boolean;
        aR : in std_logic;
        clk : in std_logic;
        reset : in std_logic);
end entity;

architecture Behave of PulseToLevel is
  type FsmState is (Idle,Waiting);
  signal fsm_state : FsmState;
begin  -- Behave

  process(clk, rL, aR, fsm_state, reset)
    variable nstate : FsmState;
  begin
    nstate := fsm_state;
    rR <= '0';
    aL <= false;

    case fsm_state is
        when Idle =>
          if(rL) then
		rR <= '1';
		if(aR = '1') then
			aL <= true;
		else
			nstate := Waiting;
		end if;
	  end if;
        when Waiting =>
	  rR <= '1';
          if(aR = '1') then
	    aL <= true;
            nstate := Idle;
          end if;
        when others => null;
    end case;

    if(clk'event and clk = '1') then
	if reset = '1' then
		fsm_state <= Idle;
	else
      		fsm_state <= nstate;
	end if;
    end if;
  end process;
end Behave;
