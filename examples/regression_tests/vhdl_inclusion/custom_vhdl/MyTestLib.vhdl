-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
package MyTestLibComponents is
	component add2_Operator is -- 
		port ( -- 
			     sample_req: in boolean;
			     sample_ack: out boolean;
			     update_req: in boolean;
			     update_ack: out boolean;
			     a : in  std_logic_vector(31 downto 0);
			     b : in  std_logic_vector(31 downto 0);
			     sum : out  std_logic_vector(31 downto 0);
		clk, reset: in std_logic
	);
	end component add2_Operator;
end package;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;

library ahir;
use ahir.memory_subsystem_package.all;
use ahir.mem_component_pack.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;

entity add2_Operator is -- 
	port ( -- 
		     sample_req: in boolean;
		     sample_ack: out boolean;
		     update_req: in boolean;
		     update_ack: out boolean;
		     a : in  std_logic_vector(31 downto 0);
		     b : in  std_logic_vector(31 downto 0);
		     sum : out  std_logic_vector(31 downto 0);
	clk, reset: in std_logic
  -- 
);
-- 
end entity add2_Operator;
architecture add2_Operator_arch of add2_Operator is -- 
	signal joined_sig: boolean;	
	signal trigger: std_logic;
begin --  

	trig_join: join2 generic map (name => "JJJ", bypass => true)
	port map (pred0 => sample_req, pred1 => update_req,
		  symbol_out => joined_sig, clk => clk, reset => reset);

	-- sample-ack (no delay)
	sample_ack <= joined_sig;

	process(clk, reset, joined_sig)
	begin
		if (clk'event and (clk = '1')) then
			if (reset = '1') then
				update_ack <= false;
			else 
				update_ack <= joined_sig;
			end if;
		end if;
	end process;

	process(clk,a,b)
	begin
		if(clk'event and (clk = '1')) then
			if (joined_sig) then
				sum <= std_logic_vector (unsigned(a) + unsigned(b));
			end if;
		end if;
	end process;

end add2_Operator_arch;
