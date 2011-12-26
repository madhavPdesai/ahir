library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.BaseComponents.all;


-- on reset, trigger an AHIR module, and keep
-- retriggering it..
-- TODO: add a single cycle delay in lreq -> preq
-- path and also in the pack -> lack path in order
-- to control the clock period...
entity level_to_pulse is
  generic (forward_delay: integer; backward_delay: integer);
  port (clk   : in  std_logic;
    	reset : in  std_logic;
        lreq: in std_logic;
        lack: out std_logic;
        preq: out boolean;
        pack: in boolean);
end level_to_pulse;

architecture default_arch of level_to_pulse is
  type L2PState is (idle,waiting);
  signal l2p_state : L2PState;
  signal pack_sig, preq_sig: boolean;
begin

  process(clk,reset,lreq, pack_sig, l2p_state)
    variable nstate : L2PState;
    variable lack_v : std_logic;
    variable preq_v : boolean;
    
  begin
    lack_v := '0';
    preq_v := false;
    nstate := l2p_state;
    if(l2p_state = idle) then
      if(lreq ='1') then
        preq_v := true;
        if(pack_sig) then
          lack_v := '1';
        else
          nstate := waiting;
        end if;
      end if;
    else
      if(pack_sig) then
        lack_v := '1';
        nstate := idle;
      end if;
    end if;

    lack     <= lack_v;
    preq_sig <= preq_v;
    
    if(reset = '1') then
      nstate := idle;
    end if;

    if(clk'event and clk = '1') then
      l2p_state <= nstate;
    end if;
    
  end process;

  fDelay: control_delay_element generic map(delay_value => forward_delay)
	port map(req => preq_sig, ack => preq, clk => clk, reset => reset);

  bDelay: control_delay_element generic map(delay_value => backward_delay)
	port map(req => pack, ack => pack_sig, clk => clk, reset => reset);

  
end default_arch;
