library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;

-- a simple register!
entity RegisterBase is
  generic(data_width: integer);
  port(din: in std_logic_vector(data_width-1 downto 0);
       dout: out std_logic_vector(data_width-1 downto 0);
       req: in boolean;
       ack: out boolean;
       clk,reset: in std_logic);
end RegisterBase;


architecture arch of RegisterBase is 
begin

  process(din,req,reset,clk)
  begin
    if(clk'event and clk = '1') then
      if(reset = '1') then
        ack <= false;
        dout <= (others => '0');
      elsif req then
        ack <= true;
        dout <= din;
      else
        ack <= false;
      end if;
    end if;
  end process;

end arch;

