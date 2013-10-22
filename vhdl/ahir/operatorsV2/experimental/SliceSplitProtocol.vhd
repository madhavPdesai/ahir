library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Utilities.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;

-- a simple slicing element.
entity SliceSplitProtocol is
  generic(name: string; 
	in_data_width : integer; 
	high_index: integer; 
	low_index : integer; 
	buffering : integer;
	flow_through: boolean := false
	);
  port(din: in std_logic_vector(in_data_width-1 downto 0);
       dout: out std_logic_vector(high_index-low_index downto 0);
       sample_req: in boolean;
       sample_ack: out boolean;
       update_req: in boolean;
       update_ack: out boolean;
       clk,reset: in std_logic);
end SliceSplitProtocol;


architecture arch of SliceSplitProtocol is
   signal ilb_data_in: std_logic_vector(high_index-low_index downto 0);
begin

  assert ((high_index < in_data_width) and (low_index >= 0) and (high_index >= low_index))
    report "inconsistent slice parameters" severity failure;
  
  noFlowThrough: if (not flow_through) generate

    ilb_data_in <= din(high_index downto low_index);
    ilb: InterlockBuffer 
		generic map(name => name & " ilb ",
				buffer_size => buffering,
				in_data_width => (high_index - low_index) + 1,
				out_data_width => (high_index - low_index) + 1)
		port map(write_req => sample_req,
			 write_ack => sample_ack,
			 write_data => ilb_data_in,
			 read_req  => update_req,
			 read_ack => update_ack,
			 read_data => dout,
			 clk => clk, reset => reset);

  end generate noFlowThrough;

  flowThrough: if flow_through generate
    dout <= din(high_index downto low_index);
    sample_ack <= sample_req;
    update_ack <= update_req;
  end generate flowThrough;
  
end arch;

