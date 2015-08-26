library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- uses an aggressive pulse-to-level translation
-- that allows back-to-back transfers to an output
-- port.  The combinational paths are a bit longer
-- but cant have everything..
entity OutputPortRevised is
  generic(name : string;
	  num_reqs: integer;
	  data_width: integer;
	  no_arbitration: boolean := false;
	  input_buffering: IntegerArray);
  port (
    sample_req        : in  BooleanArray(num_reqs-1 downto 0);
    sample_ack        : out BooleanArray(num_reqs-1 downto 0);
    update_req        : in  BooleanArray(num_reqs-1 downto 0); -- sacrificial.
    update_ack        : out BooleanArray(num_reqs-1 downto 0); -- sacrificial.
    data       : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPortRevised is

  signal reqR, ackR : std_logic_vector(num_reqs-1 downto 0);

  signal omux_data_in       : std_logic_vector((num_reqs*data_width)-1 downto 0);

  type   OPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal in_data_array, out_data_array : OPWArray(num_reqs-1 downto 0);
  
  constant input_buf_sizes: IntegerArray(num_reqs-1 downto 0) :=  input_buffering;

  signal zero_sig: std_logic;
begin

  zero_sig <= '0';

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  BufGen : for I in 0 to num_reqs-1 generate
	
	in_data_array(I) <= data(((I+1)*data_width)-1 downto (I*data_width));
	update_ack(I) <= update_req(I); -- sacrificial.. to maintain pretense of split protocol.

	rxB: ReceiveBuffer 
		generic map( name => name & " rxBuf " & Convert_To_String(I),
				buffer_size => input_buf_sizes(I),
				data_width => data_width)
		port map(write_req => sample_req(I),
		 	write_ack => sample_ack(I),
		 	write_data => in_data_array(I),
		 	-- note: cross-over
		 	read_req =>  ackR(I),
		 	read_ack => reqR(I), 
	         	read_data => out_data_array(I),	
		 	clk => clk, reset => reset);

  end generate BufGen;

  process(out_data_array)
  begin
	for J in  0 to num_reqs-1 loop
		omux_data_in(((J+1)*data_width)-1 downto J*data_width) <= out_data_array(J);
	end loop;
  end process;


  mux : OutputPortLevel generic map (
    num_reqs       => num_reqs,
    data_width     => data_width,
    no_arbitration => no_arbitration)
    port map (
      req   => reqR,
      ack   => ackR,
      data  => omux_data_in,
      oreq  => oreq,
      oack  => oack,
      odata => odata,
      clk   => clk,
      reset => reset);
end Base;
