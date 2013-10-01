library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Utilities.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;

entity access_regulator is
  generic (name: string; num_reqs : integer := 1; num_slots: integer := 1);
  port (
    -- the req-ack pair being regulated.
    req   : in BooleanArray(num_reqs-1 downto 0);
    ack   : out BooleanArray(num_reqs-1 downto 0);
    -- the regulated versions of req/ack
    regulated_req : out BooleanArray(num_reqs-1 downto 0);
    regulated_ack : in BooleanArray(num_reqs-1 downto 0);
    -- transitions on the next two will
    -- open up a slot.
    release_req   : in BooleanArray(num_reqs-1 downto 0);
    release_ack   : in BooleanArray(num_reqs-1 downto 0);
    clk   : in  std_logic;
    reset : in  std_logic);

end access_regulator;

architecture default_arch of access_regulator is
begin  -- default_arch
   gen: for I in 0 to num_reqs-1 generate
	aR: access_regulator_base generic map(name => name & "(" & Convert_To_String(I) & ")", num_slots => num_slots)
		port map(req => req(I),
			 ack => ack(I),
			 regulated_req => regulated_req(I),
			 regulated_ack => regulated_ack(I),
			 release_req => release_req(I),
			 release_ack => release_ack(I),
			 clk => clk, 
			 reset => reset);
   end generate gen;
end default_arch;
