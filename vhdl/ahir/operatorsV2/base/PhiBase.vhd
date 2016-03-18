library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;

entity PhiBase is
  generic (
    num_reqs   : integer;
    data_width : integer;
    bypass_flag : boolean := false);
  port (
    req                 : in  BooleanArray(num_reqs-1 downto 0);
    ack                 : out Boolean;
    idata               : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    odata               : out std_logic_vector(data_width-1 downto 0);
    clk, reset          : in std_logic);
end PhiBase;


architecture Behave of PhiBase is
   signal muxed_idata: std_logic_vector(data_width-1 downto 0);
   signal odata_reg: std_logic_vector(data_width-1 downto 0);
   signal there_is_a_req: boolean;
   signal ack_internal: boolean;
   signal req_registered, final_req : BooleanArray(num_reqs-1 downto 0);
begin  -- Behave

  assert(idata'length = (odata'length * req'length)) report "data size mismatch" severity failure;

  -- muxed data..
  odata <= MuxOneHot(idata,final_req);

  there_is_a_req <= OrReduce(req);
  ack_internal <= there_is_a_req;

  process(clk)
	variable mux_data : std_logic_vector(odata'length-1 downto 0);
  begin
     if(clk'event and clk = '1') then
	if(reset = '1') then
          req_registered <= (others => false);
	elsif (there_is_a_req) then
	  req_registered <= req;
	end if;
     end if;
  end process;

  -- bypass.
  Byp: if bypass_flag generate
  	final_req <= req when there_is_a_req else req_registered;
        ack <= ack_internal;
  end generate Byp;

  -- no-bypass.
  NoByp: if (not bypass_flag) generate
	final_req <= req_registered;
        process(clk)
        begin
 	   if(clk'event and clk = '1') then
		if(reset = '1') then
			ack <= false;
		else 
			ack <= ack_internal;
		end if;
	   end if;
        end process;
  end generate NoByp;
end Behave;
