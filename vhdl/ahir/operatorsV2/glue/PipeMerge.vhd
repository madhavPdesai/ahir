library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity PipeMerge is
  generic (name : string; data_width_0, data_width_1: integer);
  port (
    write_req_0   : in std_logic;
    write_ack_0   : out std_logic;
    write_data_0   : in std_logic_vector(data_width_0-1 downto 0);
    write_req_1   : in std_logic;
    write_ack_1   : out std_logic;
    write_data_1   : in std_logic_vector(data_width_1-1 downto 0);
    read_req      : in  std_logic;
    read_ack       : out std_logic;
    read_data     : out std_logic_vector((data_width_1 + data_width_0)-1 downto 0);
    clk, reset : in  std_logic);
end PipeMerge;

architecture default_arch of PipeMerge is
begin  -- default_arch

   assert false report "NOT IMPLEMENTED" severity ERROR;

   process(write_req_0, write_req_1, write_data_0, write_data_1, read_req)
	variable accept_data: boolean;
	variable read_data_var_0 : std_logic_vector(data_width_0-1 downto 0);
	variable read_data_var_1 : std_logic_vector(data_width_1-1 downto 0);

   begin
	accept_data := false;
	read_ack <= write_req_0 or write_req_1;
	read_data_var_0 := (others => '0');
	read_data_var_1 := (others => '0');

	if(write_req_0 = '1') then
		read_data_var_0 := write_data_0;
	end if;
	if(write_req_1 = '1') then
		read_data_var_1 := write_data_1;
	end if;

	read_data <= (read_data_var_1 & read_data_var_0);

	write_ack_0 <= read_req;
	write_ack_1 <= read_req;
   end process;
end default_arch;
