library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity PhiWithBuffering is
  generic (
    name       : string;
    num_reqs   : integer;
    buffering  : integer;
    data_width : integer);
  port (
    sample_req                 : in  BooleanArray(num_reqs-1 downto 0);
    sample_ack                 : out Boolean;
    update_req                 : in Boolean;
    update_ack                 : out Boolean;
    idata                      : in  std_logic_vector((num_reqs*data_width)-1 downto 0);
    odata                      : out std_logic_vector(data_width-1 downto 0);
    clk, reset                 : in std_logic);
end PhiWithBuffering;


-- a single interlock buffer which is written into by
-- one of num_reqs sources.
architecture Behave of PhiWithBuffering is

    signal ilb_write_data, mux_data_prereg, mux_data_reg: std_logic_vector(data_width-1 downto 0);
    signal ilb_write_req : boolean;

begin  -- Behave

  ilb: InterlockBuffer generic map(name => name & " ilb " ,
				buffer_size => buffering,
				data_width => data_width)
		port map(write_req => ilb_write_req,
			 write_ack => sample_ack,
			 write_data => ilb_write_data,
			 read_req => update_req,
			 read_ack => update_ack,
			 read_data => odata,
		         clk => clk,
		         reset => reset);		

  ilb_write_req <= OrReduce(sample_req);
  ilb_write_data <= mux_data_prereg when ilb_write_req  else mux_data_reg;

  -- mux with bypassed register.. to keep track of last word that was written
  -- in
  -- TODO: this is a bit expensive.. can we do better?
  process(clk,reset,sample_req,ilb_write_req,idata)
	variable mux_data : std_logic_vector(odata'length-1 downto 0);
  begin
     mux_data := MuxOneHot(idata,sample_req); 
     mux_data_prereg <= mux_data;
     if(clk'event and clk = '1') then
          mux_data_reg <= (others => '0');
     else
         if(ilb_write_req) then
            mux_data_reg <= mux_data;
	 end if;
     end if;
  end process;

end Behave;
