library ieee;
use ieee.std_logic_1164.all;

-- on reset, trigger an AHIR module, and keep
-- retriggering it..
entity auto_run is
  generic (
    use_delay : boolean := true);
  port (clk   : in  std_logic;
    	reset : in  std_logic;
	start: out std_logic;
	fin: in std_logic);
end auto_run;

architecture default_arch of auto_run is
  type AutoRunState is (idle, busy);
  signal state: AutoRunState; 
begin  

   process(clk)
     variable nstate: AutoRunState;
   begin
     nstate := state;
     if(reset = '1') then
        nstate := idle;
     else
	if(state = idle) then
	   nstate := busy;
	elsif(fin = '1') then
	   nstate := idle;
	end if;
     end if;

     if(clk'event and clk='1') then
	state <= nstate;
     end if;
   end process;

   start <= '1' when state = idle else '0';

end default_arch;
