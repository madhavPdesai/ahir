library std;
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.GlobalConstants.all;
use ahir.BaseComponents.all;


entity signal_clock_gate is
	port (reset, clock_in, clock_enable: in std_logic; clock_out : out std_logic);
end entity signal_clock_gate;

architecture behavioural of signal_clock_gate is
      signal clock_enable_latched: std_logic;

      signal is_in_reset: std_logic;
      signal clock_enable_qualified: std_logic;
begin
	assert (not use_xilinx_bufce) report "For vanilla AHIR, use_xilinx_bufce must be set false"
		severity failure;

	--
	-- In reset, the clock is enabled so that things can be
	-- initialized.
	--
	process(clock_in, reset)
	begin
		if(clock_in'event and (clock_in = '1')) then
			if(reset = '1') then
				is_in_reset <= '1';
			else
				is_in_reset <= '0';
			end if;
		end if;
	end process;
	clock_enable_qualified <= clock_enable or is_in_reset;

	-------------------------------------------------------
	-- base instance
	-------------------------------------------------------
	base_inst: clock_gater
		port map (clock_in => clock_in, clock_enable => clock_enable_qualified, clock_out => clock_out);

end behavioural;
