library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
-- A fast synch buffer.  Has  combinational paths from
--     write-req -> write-ack
--     read-req  -> write-ack
-- handle with care..
--
-- to play it safe (but to be satisfied with half-rate),
-- leave full_flag as false.
--
entity PipelineSynchBuffer is
  generic (name : string; in_data_width: integer; out_data_width: integer; full_rate : boolean);
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
  signal read_ack_join, write_ack_join : boolean;
  signal read_req_delayed: boolean;

  signal sc_join, uc_join: boolean; 

  signal full_flag : boolean := false;
  
begin  -- default_arch
 
  -- control-delay
  rd: control_delay_element generic map (delay_value => 1)
				port map (req => read_req, ack => read_req_delayed,
							clk => clk, reset => reset);

  -- joins.
  writeAckJoin: join2 generic map (name => name & " synch-buf-write-ack-join", bypass => true)
			port map (pred0 => write_req, pred1 => read_req_delayed, symbol_out => write_ack_join,
					clk => clk, reset => reset);

  readAckJoin: join2 generic map (name => name & " synch-buf-read-ack-join", bypass => true)
			port map (pred0 => write_req, pred1 => read_req, symbol_out => read_ack_join,
					clk => clk, reset => reset);

  write_ack <= write_ack_join;

  process(clk, reset, read_ack_join)
  begin
    if(clk'event and clk = '1') then
		  if(reset = '1') then
			  read_ack <= false;
			  data_register <= (others => '0');
		  else
			  read_ack <= read_ack_join;
			  if(read_ack_join) then
				  data_register <= write_data(min_data_width-1 downto 0);	
			  end if;
		  end if;
	  end if;	
    end process;


    process(data_register) 
    begin
	read_data <= (others => '0');
	read_data(min_data_width-1 downto 0) <= data_register;
    end process;

end default_arch;
