library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity SplitGuardInterface is
	generic (nreqs: integer; buffering:IntegerArray; use_guards: BooleanArray);
	port (sr_in: in BooleanArray(nreqs-1 downto 0);
	      sa_out: out BooleanArray(nreqs-1 downto 0); 
	      sr_out: out BooleanArray(nreqs-1 downto 0);
	      sa_in: in BooleanArray(nreqs-1 downto 0); 
	      cr_in: in BooleanArray(nreqs-1 downto 0);
	      ca_out: out BooleanArray(nreqs-1 downto 0); 
	      cr_out: out BooleanArray(nreqs-1 downto 0);
	      ca_in: in BooleanArray(nreqs-1 downto 0); 
	      guards: in std_logic_vector(nreqs-1 downto 0);
	      clk: in std_logic;
	      reset: in std_logic);
end entity;


architecture Behave of SplitGuardInterface is
	constant gFlags: BooleanArray(nreqs-1 downto 0) := use_guards;
	constant gBufs: IntegerArray(nreqs-1 downto 0) := buffering;
begin
	BaseGen: for I in nreqs-1 downto 0 generate

	     gCase: if gFlags(I) generate
		sgi: SplitGuardInterfaceBase
			generic map (buffering => gBufs(I))
			port map(sr_in => sr_in(I),
				 sr_out => sr_out(I),
				 sa_in => sa_in(I),
				 sa_out => sa_out(I),
				 cr_in => cr_in(I),
				 cr_out => cr_out(I),
				 ca_in => ca_in(I),
				 ca_out => ca_out(I),
				 guard_interface => guards(I),
				 clk => clk, reset => reset);
              end generate gCase;
	   
 	      noG: if not gFlags(I) generate
		 sr_out <= sr_in;
		 sa_out <= sa_in;
		 cr_out <= cr_in;
		 ca_out <= ca_in;
              end generate noG;
        end generate;

end Behave;
