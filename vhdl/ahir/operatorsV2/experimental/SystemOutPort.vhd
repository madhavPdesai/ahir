library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
-- Last successful write wins.
--
entity SystemOutPort is
   generic (name : string;
	    num_writes: integer;
	    in_data_width: integer;
            out_data_width : integer); 
   port (write_req : in std_logic_vector(0 downto 0);
         write_ack : out std_logic_vector(0 downto 0);
         write_data: in std_logic_vector(in_data_width-1 downto 0);
         out_data  : out std_logic_vector(out_data_width-1 downto 0);
	 clk : in std_logic;
	 reset : in std_logic);
end entity;

architecture Mixed of SystemOutPort is
    signal read_req, read_ack: std_logic_vector(0 downto 0);
    signal pipe_data_in, pipe_data_out: std_logic_vector(out_data_width-1 downto 0);
    
begin

    TruncateOrPad(write_data,pipe_data_in);
    read_req(0) <= '1';

    process(clk)
    begin
	if(clk'event and clk = '1') then
		if(read_ack(0) = '1') then
			out_data <= pipe_data_out;
		end if;
	end if;
    end process;

    opipe: PipeBase generic map(name => name & " opipe", num_reads => 1,
					num_writes => num_writes, data_width => out_data_width,
						lifo_mode => false, depth => 1)
		port map(read_req => read_req, read_ack => read_ack,
				read_data => pipe_data_out,
					write_req => write_req, write_ack => write_ack,
						write_data => pipe_data_in,
							clk => clk, reset => reset);

end Mixed;

