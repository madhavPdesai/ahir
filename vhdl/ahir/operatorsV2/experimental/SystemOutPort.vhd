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
   port (write_req : in std_logic_vector(num_writes-1 downto 0);
         write_ack : out std_logic_vector(num_writes-1 downto 0);
         write_data: in std_logic_vector((num_writes*in_data_width)-1 downto 0);
         out_data  : out std_logic_vector(out_data_width-1 downto 0);
	 clk : in std_logic;
	 reset : in std_logic);
end entity;

architecture Mixed of SystemOutPort is
    constant min_width : integer := Minimum(in_data_width, out_data_width);
    
    signal read_req, read_ack: std_logic_vector(0 downto 0);
    signal pipe_data_in: std_logic_vector((num_writes*min_width)-1 downto 0);
    signal pipe_data_out: std_logic_vector(min_width-1 downto 0);
    signal out_reg: std_logic_vector(min_width-1 downto 0);
    
begin

    -- keep only the necessary bits of write_data.
    wPadTrunc: for I in 0 to num_writes-1 generate
		-- signal arguments.
	TruncateOrPad(write_data(((I+1)*in_data_width)-1 downto I*in_data_width), 
					pipe_data_in((I+1)*min_width-1 downto I*min_width));
    end generate wPadTrunc;

    read_req(0) <= '1';

    -- data coming from pipe..
    TruncateOrPad(pipe_data_out, out_data);

    --
    -- pipe.. to provide interlock so only one writer succeeds at a time.
    --
    opipe: PipeBase generic map(name => name & " opipe", 
				    num_reads => 1,
					num_writes => num_writes, data_width => min_width,
						lifo_mode => false, signal_mode => true, depth => 1)
		port map(read_req => read_req, read_ack => read_ack,
				read_data => pipe_data_out,
					write_req => write_req, write_ack => write_ack,
						write_data => pipe_data_in,
							clk => clk, reset => reset);

end Mixed;

