library ieee;
use ieee.std_logic_1164.all;

-- a level to pulse translator used at the
-- output end of a data-path operator in order
-- to interface to the control path.
-- Madhav Desai.
entity Level_To_Pulse_Translate_Entity is
  port( rL : out std_logic;
        rR : in  boolean;
        aL : in std_logic;
        aR : out boolean;
        clk : in std_logic;
        reset : in std_logic);
end entity;

architecture Behave of Level_To_Pulse_Translate_Entity is
  type L2PState is (Idle,WaitForAckL);
  signal l2p_state : L2PState;
begin  -- Behave

  process(clk, aL, rR, l2p_state)
    variable nstate : L2PState;
  begin
    nstate := l2p_state;
    rL <= '0';
    aR <= false;

    case l2p_state is
        when Idle =>
          if(rR) then
              nstate := WaitForAckL;
          end if;
        when WaitForAckL =>
          rL <= '1';
          if(aL = '1') then
            aR <= true;
	    if(rR)  then
               nstate := WaitForAckL;
            else
               nstate := Idle;
	    end if;
          end if; 
        when others => null;
      end case;

    if(clk'event and clk = '1') then
	if reset = '1' then
		l2p_state <= Idle;
	else
      		l2p_state <= nstate;
	end if;
    end if;
  end process;
end Behave;
