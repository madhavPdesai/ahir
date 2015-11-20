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
--   write_ack -> read_ack 0-delay.
--     (note that the last dependency will increase the
--       combinational path lengths... but will NOT create combinational loops).
--
-- In a 
--   buf0 -> buf1 -> buf2 ...
-- chain, the combinational paths in the CP will become
-- w-ack-k -|-> read-ack-k -|-> write-req-k+1 
-- read-req-k ->  read-ack-k  etc.
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

  constant pmarkings: IntegerArray(1 to 2) := (1 => 0, 2 => 1);
  constant pcapacities : IntegerArray(1 to 2) := (1 => 1, 2 => 1);
  constant pdelays : IntegerArray(1 to 2) := (1 => 0, 2 => 0);
  signal preds : BooleanArray (1 to 2);
  signal read_ack_buffer, read_ack_pre_buffer: boolean;
  
begin  -- default_arch
 
  preds(1) <= write_req;
  preds(2) <= read_ack_buffer;

  -- join.
  reqJoin: generic_join
		generic map (name => name & " synch-buf-join",  place_capacities => pcapacities, place_delays => pdelays,
					place_markings => pmarkings)
		port map(preds => preds, symbol_out => joined_req, clk => clk, reset => reset);

  ackJoin: join2 generic map (name => name & " synch-buf-ack-join", bypass => true)
			port map (pred0 => joined_req, pred1 => read_req, symbol_out => read_ack_pre_buffer,
					clk => clk, reset => reset);
  -- 0-delay.
  write_ack <= joined_req;

  -- ack.
  read_ack <= read_ack_buffer;

  -- state machine.
  process(clk, reset, joined_req)
  begin
	if(clk'event and clk = '1') then
		read_ack_buffer <= (read_ack_pre_buffer and (reset = '0'));
		if(read_ack_pre_buffer) then
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
