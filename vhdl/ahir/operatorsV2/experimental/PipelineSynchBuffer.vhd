library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
--
-- gets the read/write cycle into synch.
--   read_req -> read_ack 0-delay
--   write_req -> write_ack 1-delay
--   write_req -> read_ack 0-delay.
--     (note that the last dependency will increase the
--       combinational path lengths... handle with care).
--
-- In a 
--   buf0 -> buf1 -> buf2 ...
-- chain, the combinational paths in the CP will become
-- w-req-k -|-> read-ack-k -|-> write-req-k+1 -> read-req-k+1 -> 
--  etc..
--
--  To cut the long path we will have to use an InterlockBuffer
-- periodically.
--
--
entity PipelineSynchBuffer is
  generic (name : string; in_data_width: integer; out_data_width: integer);
  port (
    read_req       : in  boolean;
    read_ack       : out boolean;
    read_data      : out std_logic_vector(out_data_width-1 downto 0);
    write_req       : in  boolean;
    write_ack       : out boolean;
    write_data      : in std_logic_vector((in_data_width-1) downto 0);
    clk, reset : in  std_logic);
  
end PipelineSynchBuffer;

architecture default_arch of PipelineSynchBuffer is
  constant min_data_width: integer := Minimum(in_data_width, out_data_width);
  signal data_register : std_logic_vector(min_data_width-1 downto 0);
  signal joined_req : boolean;

begin  -- default_arch
  -- join.
  reqJoin: join2
		generic map(bypass => true, name => name & " req-join ")
		port map(pred0 => read_req, pred1 => write_req, symbol_out => joined_req,
				clk => clk, reset => reset);

  -- 0-delay.
  write_ack <= joined_req;

  -- state machine.
  process(clk, reset, joined_req)
  begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			read_ack <= false;
		else 
			read_ack <= joined_req;
		end if;

		if(joined_req) then
			data_register <= write_data(min_data_width-1 downto 0);	
		end if;
	end if;	
  end process;

  process(data_register) 
  begin
	read_data <= (others => '0');
	read_data(min_data_width-1 downto 0) <= data_register;
  end process;

end default_arch;
