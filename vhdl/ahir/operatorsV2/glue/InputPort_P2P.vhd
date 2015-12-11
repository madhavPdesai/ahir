library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Components.all;
use ahir.BaseComponents.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

--  input port specialized for P2P ports.
entity InputPort_P2P is
  generic (name : string;
	   data_width: integer;
	   queue_depth: integer);
  port (
    -- pulse interface with the data-path
    sample_req        : in  Boolean; -- sacrificial.
    sample_ack        : out Boolean; -- sacrificial.
    update_req        : in  Boolean;
    update_ack        : out Boolean;
    data              : out std_logic_vector(data_width-1 downto 0);
    -- ready/ready interface with outside world
    oreq       : out std_logic;
    oack       : in  std_logic;
    odata      : in  std_logic_vector(data_width-1 downto 0);
    clk, reset : in  std_logic);
end entity;


architecture Base of InputPort_P2P is
begin

  bufLeOne: if(queue_depth < 2) generate
    bb: block
	constant bufs : IntegerArray (0 downto 0) := (0 => 1);
        signal sr, sa, ur, ua: BooleanArray(0 downto 0);
    begin
	sr(0) <= sample_req;
	sample_ack <= sa(0);
	ur(0) <= update_req;
	update_ack <= ua(0);

	ipr: InputPortRevised
			generic map (name => name & "-input-port-revised",
							num_reqs => 1, 
							data_width => data_width,
							output_buffering => bufs,
							no_arbitration => false)
			port map (
					sample_req => sr, sample_ack => sa,
					update_req => ur, update_ack => ua, 
					data => data,
					oreq => oreq, oack => oack, odata => odata,
					clk => clk, reset => reset	
				);
    end block bb;
  end generate bufLeOne;

  bufGtOne: if (queue_depth > 1) generate
     sample_ack <= sample_req; -- sacrificial
     ub: UnloadBuffer
	generic map (name => name & "-unload-buffer", 
				data_width => data_width,
				   buffer_size => queue_depth, 
					bypass_flag => true)
	port map (write_req => oack, write_ack => oreq, 
					write_data => odata,
				unload_req => update_req,
				unload_ack => update_ack,
				read_data =>  data, clk => clk, reset => reset);
   end generate bufGtOne;
end Base;
