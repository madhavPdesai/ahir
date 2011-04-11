library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity PhiBaseTB is
end entity;


architecture Behave of PhiBaseTB is

	signal a, b, c, d, e, odata : std_logic_vector(4 downto 0);
	signal f : std_logic_vector(24 downto 0);
	signal clk, reset: std_logic := '0';
	signal req: BooleanArray(4 downto 0);
	signal ack: Boolean;

begin  -- Behave

	a <= (0 => '1', others => '0');
	b <= (1 => '1', others => '0');
	c <= (2 => '1', others => '0');
	d <= (3 => '1', others => '0');
	e <= (4 => '1', others => '0');

	f <= e & d & c & b & a;
        

	clk <= not clk after 5 ns;

	process
	begin
		req <= (others => false);
		reset <= '1';
		wait until clk = '1';
		
		reset <= '0';
		for I in 0 to 4 loop
		        req <= (others => false);
			req(I) <= true;
			while true loop
				wait until clk = '1';
                                req(I) <= false;
				if ack then
					exit;
				end if;
			end loop;
			assert (odata(I) = '1') report "result mismatch" severity error;
		end loop;

		wait;
	end process;

        phi : PhiBase
          generic map (
            num_reqs   => 5,
            data_width => 5)
          port map ( req => req,
                     ack => ack,
                     idata => f,
                     odata => odata,
                     clk => clk,
                     reset => reset);
end Behave;
