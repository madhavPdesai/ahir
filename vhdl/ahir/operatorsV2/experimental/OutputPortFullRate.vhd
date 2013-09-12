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
entity OutputPortFullRate is
  generic(name : string;
	  num_reqs: integer;
	  data_width: integer;
	  no_arbitration: boolean := false;
	  input_buffering: IntegerArray);
  port (
    req        : in  BooleanArray(num_reqs-1 downto 0);
    ack        : out BooleanArray(num_reqs-1 downto 0);
    data       : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : out std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;

architecture Base of OutputPortFullRate is

  signal reqR, ackR : std_logic_vector(num_reqs-1 downto 0);
  signal fEN: std_logic_vector(num_reqs-1 downto 0);


  signal omux_data_in       : std_logic_vector((num_reqs*data_width)-1 downto 0);

  type   OPWArray is array(integer range <>) of std_logic_vector(data_width-1 downto 0);
  signal data_array : OPWArray(num_reqs-1 downto 0);
  
  constant input_buf_sizes: IntegerArray(num_reqs-1 downto 0) :=  input_buffering;

  signal zero_sig: std_logic;
begin

  zero_sig <= '0';

  -----------------------------------------------------------------------------
  -- protocol conversion
  -----------------------------------------------------------------------------
  BufGen : for I in 0 to num_reqs-1 generate
	
	NoBuf: if(input_buf_sizes(I) = 0) generate
      		p2LInst: PulseToLevel
       			port map(rL            => req(I),
               			rR            => reqR(I),
               			aL            => ack(I),
               			aR            => ackR(I),
               			clk           => clk,
               			reset         => reset);
		data_array(I) <= data(((I+1)*data_width)-1 downto (I*data_width));
	end generate NoBuf;

	YesBuf: if(input_buf_sizes(I) > 0) generate
		rxB: ReceiveBuffer generic map( name => name & " rxBuf " & Convert_To_String(I),
					buffer_size => input_buf_sizes(I),
					data_width => data_width,
					kill_counter_range => 2)
			port map(write_req => req(I),
			 write_ack => ack(I),
			 write_data => data,
			 -- note: cross-over
			 read_req =>  ackR(I),
			 read_ack => reqR(I), 
			 kill => zero_sig,
		         read_data => data_array(I),	
			 clk => clk, reset => reset);

	end generate YesBuf;
  end generate BufGen;

  process(data_array)
  begin
	for J in  0 to num_reqs-1 loop
		omux_data_in(((J+1)*data_width)-1 downto J*data_width) <= data_array(J);
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
