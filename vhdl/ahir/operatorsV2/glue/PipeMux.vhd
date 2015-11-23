library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity PipeMux is
  generic (name : string; data_width: integer);
  port (
    write_req_0   : in std_logic;
    write_ack_0   : out std_logic;
    write_data_0   : in std_logic_vector(data_width-1 downto 0);
    write_req_1   : in std_logic;
    write_ack_1   : out std_logic;
    write_data_1   : in std_logic_vector(data_width-1 downto 0);
    read_req      : in  std_logic;
    read_ack       : out std_logic;
    read_data     : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end PipeMux;

architecture default_arch of PipeMux is

   signal priority_flag: std_logic;
  
begin  -- default_arch
   process(clk, reset, priority_flag,  write_req_0, write_req_1, write_data_0, write_data_1, read_req)
	variable accept_data: boolean;
   begin
	accept_data := false;
	read_ack <= write_req_0 or write_ack_0;
	read_data <= (others => '0');

	if(((write_req_0 = '1') or (write_ack_0 = '1')) and (read_req = '1')) then
		accept_data := true;
	end if;

	if(priority_flag = '0') then
		if(write_req_0 = '1') then
			read_data <= write_data_0;
			write_ack_0 <= read_req;
		elsif (write_req_1 = '1') then
			read_data <= write_data_1;
			write_ack_1 <= read_req;
		end if;
	else
		if(write_req_1 = '1') then
			read_data <= write_data_1;
			write_ack_1 <= read_req;
		elsif (write_req_0 = '1') then
			read_data <= write_data_0;
			write_ack_0 <= read_req;
		end if;
	end if;
	if(clk'event and clk = '1') then
		if(reset = '1') then
			priority_flag <= '0';
		else
		end if;
	end if;
    end process;
end default_arch;
