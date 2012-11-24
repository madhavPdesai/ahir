-- if guards(I) is true, let the handshake proceed, else
-- shunt it.  This interface is inserted in between the
-- req/ack signals from/to the CP and the operators in the
-- datapath.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity GuardInterface is
	generic (nreqs: integer);
	port (reqL: in BooleanArray(nreqs-1 downto 0);
	      ackL: out BooleanArray(nreqs-1 downto 0); 
	      reqR: out BooleanArray(nreqs-1 downto 0);
	      ackR: in BooleanArray(nreqs-1 downto 0); 
	      guards: in std_logic_vector(nreqs-1 downto 0));
end entity;


architecture Behave of GuardInterface is
begin
	process(reqL,ackR,guards)
	begin
		for I in 0 to nreqs-1 loop
			if(guards(I) = '1') then
				reqR(I) <= reqL(I);
				ackL(I) <= ackR(I);
			else
				reqR(I) <= false;
				ackL(I) <= reqL(I);
			end if;
		end loop;
	end process;
end Behave;
