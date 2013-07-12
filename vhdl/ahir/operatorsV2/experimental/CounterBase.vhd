library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity CounterBase is 
	generic(data_width : integer);
	port(clk, reset: in std_logic; count_out: out std_logic_vector(data_width-1 downto 0));
end CounterBase;


architecture Behave of CounterBase is
	signal counter_sig: unsigned(data_width-1 downto 0);
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(reset = '1') then
				counter_sig <= (others => '0');
			else
				counter_sig <= counter_sig + 1;
			end if;
		end if;
	end process;

	count_out <= std_logic_vector(counter_sig);
end Behave;
