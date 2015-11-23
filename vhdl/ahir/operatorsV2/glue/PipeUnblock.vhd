library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
-- an interface which reads 0's from the writer
-- if the writer does not have data to send.
--
entity PipeUnblock is
  generic (name : string; data_width: integer);
  port (
    write_req   : in std_logic;
    write_ack   : out std_logic;
    write_data   : in std_logic_vector(data_width-1 downto 0);
    read_req      : in  std_logic;
    read_ack       : out std_logic;
    read_data     : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end PipeUnblock;

architecture default_arch of PipeUnblock is
begin  -- default_arch
   process(write_req, write_data, read_req)
	variable read_data_var : std_logic_vector(data_width-1 downto 0);
   begin
	read_ack <= write_req;
	read_data_var := (others => '0');

	if(write_req = '1') then
		read_data_var := write_data;
	end if;
	read_data <= read_data_var;

	write_ack <= read_req;
   end process;
end default_arch;
