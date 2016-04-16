library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;

entity SelectSplitProtocol is
  generic(name: string; 
	  data_width: integer; 
	  buffering: integer; 
	  flow_through: boolean := false; 
	  full_rate: boolean );
  port(x,y: in std_logic_vector(data_width-1 downto 0);
       sel: in std_logic_vector(0 downto 0);
       z : out std_logic_vector(data_width-1 downto 0);
       sample_req: in boolean;
       sample_ack: out boolean;
       update_req: in boolean;
       update_ack: out boolean;
       clk,reset: in std_logic);
end SelectSplitProtocol;


architecture arch of SelectSplitProtocol is 
   signal ilb_data_in: std_logic_vector(data_width-1 downto 0);
begin

    
     -- if mux select is X during normal operations then we
     -- have a problem.
     assert (not (sample_req and clk'event  and (clk = '1') and (reset = '0')) 
		or (not is_x(sel(0)))) report "mux " & name & " select is X" severity error;

     ilb_data_in <=  x when (sel(0) = '1') else y;

     noFlowThrough: if (not flow_through) generate
    	ilb: InterlockBuffer 
		generic map(name => name & " ilb ",
				buffer_size => buffering,
				in_data_width => data_width,
				out_data_width => data_width, full_rate => full_rate)
		port map(write_req => sample_req,
			 write_ack => sample_ack,
			 write_data => ilb_data_in,
			 read_req  => update_req,
			 read_ack => update_ack,
			 read_data => z,
			 clk => clk, reset => reset);
     end generate noFlowThrough;

	-- like a combinational circuit..
	-- the control path must worry about all
	-- sequencing issues.
     flowThrough: if (flow_through) generate
	z <= ilb_data_in;
    	sample_ack <= sample_req;
    	update_ack <= update_req;

     end generate flowThrough;
end arch;

