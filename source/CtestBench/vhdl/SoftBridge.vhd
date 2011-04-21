-- Author: Madhav P. Desai
-- a bridge between the VHDL simulator and 
-- software..

library ieee;
use ieee.std_logic_1164.all;

package SoftBridgePack is
	subtype SlvWord is std_logic_vector(31 downto 0);
	type SoftBridgePortType is array(natural range <>) of SlvWord;

	subtype BitWord is bit_vector(31 downto 0);
	
	function Bit_To_Std_Logic(x: bit) return std_logic;
	function Std_Logic_To_Bit(x: std_logic) return bit;
	function Bit_Vector_To_Std_Logic_Vector(x: bit_vector)
		return std_logic_vector;
	function Std_Logic_Vector_To_Bit_Vector(x: std_logic_vector)
		return bit_vector;
end package SoftBridgePack;

package body SoftBridgePack is
	-- functions.
end package body SoftBridgePack;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.SoftBridgePack.all;

entity SoftBridge
	generic(number_of_inputs: integer := 8;
		number_of_outputs: integer := 8);
	port(inputs_to_system: out SoftBridgePortType(number_of_inputs-1 downto 0);
	     outputs_from_system : in SoftBridgePortType(number_of_outputs-1 downto 0);
	     clk: in std_logic;
	     reset: in std_logic;
	     abort : in std_logic);
end entity SoftBridge;


architecture VhpiLink of SoftBridge is

begin

	process
	begin
		wait until reset = '0';
		
		-- loop forever..
		while true loop
			wait until clk = '0'; 
	
			-- read all inputs from "outside"

			-- write all outputs to "outside".

			if(abort = '1') then
				exit;
			end if;
		end loop;
	end process;

end VhpiLink;
