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
    data_width : integer);
  port (
    req                 : in  BooleanArray(num_reqs-1 downto 0);
    ack                 : out Boolean;
    idata               : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    odata               : out std_logic_vector(data_width-1 downto 0);
    clk, reset          : in std_logic);
end PhiBase;


architecture Behave of PhiBase is

  -- divide and conquer mux.

begin  -- Behave

  assert(idata'length = (odata'length * req'length)) report "data size mismatch" severity failure;

  process(clk)
	variable mux_data : std_logic_vector(odata'length-1 downto 0);
  begin
     if(clk'event and clk = '1') then
	if(reset = '1') then
          ack <= false;	
	else
          odata <= MuxOneHot(idata,req);
          ack <= OrReduce(req);
	end if;
     end if;
  end process;

end Behave;
