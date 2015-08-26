library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Components.all;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

--
-- a full-rate input port.  The assumption here
-- is that a data item is picked up from the
-- input port for every req pulse.  The production
-- of a new output data-item is indicated by an
-- ack pulse.
--
entity InputPortRevised is
  generic (name : string;
	   num_reqs: integer;
	   data_width: integer;
	   output_buffering: IntegerArray;
	   no_arbitration: boolean := false);
  port (
    -- pulse interface with the data-path
    sample_req        : in  BooleanArray(num_reqs-1 downto 0); -- sacrificial.
    sample_ack        : out BooleanArray(num_reqs-1 downto 0); -- sacrificial.
    update_req        : in  BooleanArray(num_reqs-1 downto 0);
    update_ack        : out BooleanArray(num_reqs-1 downto 0);
    data              : out std_logic_vector((num_reqs*data_width)-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : in  std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;


architecture Base of InputPortRevised is

  --alias outBUFs: IntegerArray(num_reqs-1 downto 0) is output_buffering;
  signal has_room, write_enable : std_logic_vector(num_reqs-1 downto 0);

  type   IPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal write_data, read_data: IPWArray(num_reqs-1 downto 0);

  signal demux_data : std_logic_vector((num_reqs*data_width)-1 downto 0);

  signal ack_raw: BooleanArray(num_reqs-1 downto 0);
  
begin

  -----------------------------------------------------------------------------
  -- interlock buffer.
  -----------------------------------------------------------------------------
  ProTx : for I in 0 to num_reqs-1 generate

    sample_ack(I) <= sample_req(I); -- to maintain illusion of split protocol.

    ulbInst: UnloadBuffer
	generic map(name => name & " buffer " & Convert_To_String(I),
			data_width => data_width,
			buffer_size => output_buffering(I),
			bypass_flag => true)
        port map (write_ack              => has_room(I),
		  write_req              => write_enable(I),
		  write_data             => write_data(I), 
		  unload_req             => update_req(I),
		  unload_ack             => update_ack(I),
		  read_data              => read_data(I), 
	          clk => clk, 
		  reset => reset);

  end generate ProTx;

  demux : InputPortLevel generic map (
    num_reqs       => num_reqs,
    data_width     => data_width,
    no_arbitration => no_arbitration)
    port map (
      req => has_room,
      ack => write_enable,
      data => demux_data,
      oreq => oreq,
      odata => odata,
      oack => oack,
      clk => clk,
      reset => reset);

  -----------------------------------------------------------------------------
  -- data handling
  -----------------------------------------------------------------------------
  process(read_data)
    variable ldata: std_logic_vector((num_reqs*data_width)-1 downto 0);
  begin
    for J in num_reqs-1 downto 0 loop
      Insert(ldata,J,read_data(J));
    end loop;
    data <= ldata;
  end process;

  gen : for I in num_reqs-1 downto 0 generate
    process(demux_data)
      variable target: std_logic_vector(data_width-1 downto 0);
    begin
      Extract(demux_data,I,target);
      write_data(I) <= target;
    end process;
  end generate gen;

end Base;
