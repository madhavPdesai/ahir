library ieee;
use ieee.std_logic_1164.all;

-- on reset, trigger an AHIR module, and keep
-- retriggering it..
entity auto_run is
  generic (
    use_delay : boolean := true);
  port (clk   : in  std_logic;
    	reset : in  std_logic;
	start_req: out std_logic;
        start_ack: in std_logic;
        fin_req: out std_logic;
        fin_ack: in std_logic);
end auto_run;

architecture default_arch of auto_run is

begin  

  start_req <= '1';
  fin_req <= '1';

end default_arch;
