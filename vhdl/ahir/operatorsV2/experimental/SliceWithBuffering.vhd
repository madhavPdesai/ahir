library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Utilities.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;

-- a simple slicing element.
entity SliceWithBuffering is
  generic(name: string; 
	in_data_width : integer; 
	high_index: integer; 
	low_index : integer; 
	buffering : integer);
  port(din: in std_logic_vector(in_data_width-1 downto 0);
       dout: out std_logic_vector(high_index-low_index downto 0);
       sample_req: in boolean;
       sample_ack: out boolean;
       update_req: in boolean;
       update_ack: out boolean;
       clk,reset: in std_logic);
end SliceWithBuffering;


architecture arch of SliceWithBuffering is
   signal ilb_data_in: std_logic_vector(high_index-low_index downto 0);
begin

  assert ((high_index < in_data_width) and (low_index >= 0) and (high_index >= low_index))
    report "inconsistent slice parameters" severity failure;
  

  ilb_data_in <= din(high_index downto low_index);
  ilb: InterlockBuffer 
		generic map(name => name & " ilb ",
				buffer_size => buffering,
				data_width => (high_index - low_index) + 1)
		port map(write_req => sample_req,
			 write_ack => sample_ack,
			 write_data => ilb_data_in,
			 read_req  => update_req,
			 read_ack => update_ack,
			 read_data => dout,
			 clk => clk, reset => reset);

  
end arch;

