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
begin  -- Behave

  assert(idata'length = (odata'length * req'length)) report "data size mismatch" severity failure;

  -- muxed data..
  muxed_idata <= MuxOneHot(idata,req);
  there_is_a_req <= OrReduce(req);
  ack_internal <= there_is_a_req;

  process(clk)
	variable mux_data : std_logic_vector(odata'length-1 downto 0);
  begin
     if(clk'event and clk = '1') then
	if(reset = '1') then
          odata_reg <= (others => '0');
	else
          if(there_is_a_req) then
            odata_reg <= MuxOneHot(idata,req);
          end if;
	end if;
     end if;
  end process;

  -- bypass.
  Byp: if bypass_flag generate
  	odata <= muxed_idata when there_is_a_req else odata_reg;
        ack <= ack_internal;
  end generate Byp;

  -- no-bypass.
  NoByp: if (not bypass_flag) generate
  	odata <= odata_reg;
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
