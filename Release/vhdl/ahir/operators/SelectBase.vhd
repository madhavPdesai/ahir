library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;

entity SelectBase is
  generic(data_width: integer);
  port(x,y: in std_logic_vector(data_width-1 downto 0);
       sel: in std_logic_vector(0 downto 0);
       req: in boolean;
       z: out std_logic_vector(data_width-1 downto 0);
       ack: out boolean;
       clk,reset: in std_logic);
end SelectBase;


architecture arch of SelectBase is 
begin

  process(x,y,sel,req,reset,clk)
  begin
    
    if(clk'event and clk = '1') then
      if(reset = '1') then
        ack <= false;
        z <= (others => '0');
      elsif(sel(sel'right) = '1' and req = true) then
        ack <= req;
        z <= x;
      elsif(sel(sel'right) = '0' and req = true) then
        ack <= req;
        z <= y; 
      else 
        ack <= false;
      end if;
    end if;
  end process;

end arch;

