library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- 
--  whatever appears at in_data is
--  read by whoever wishes to read it.
--
--
entity SystemInPort is
   generic (name : string;
	    num_reads: integer;
	    in_data_width: integer;
            out_data_width : integer; 
	    full_rate: boolean);
   port (read_req : in std_logic_vector(num_reads-1 downto 0);
         read_ack : out std_logic_vector(num_reads-1 downto 0);
         read_data: out std_logic_vector((num_reads*out_data_width)-1 downto 0);
         in_data  : in std_logic_vector(in_data_width-1 downto 0);
	 clk : in std_logic;
	 reset : in std_logic);
end entity;

architecture Mixed of SystemInPort is

    constant min_width : integer := Minimum(in_data_width, out_data_width);
    signal data_reg, tr_p_in_data: std_logic_vector(min_width-1 downto 0);
    signal tr_data : std_logic_vector(out_data_width-1 downto 0);
    signal valid_data : std_logic;
begin

    -- stored data will be of minimum width.
    TruncateOrPad(in_data, tr_p_in_data); 
    process(clk)
    begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			data_reg <= (others => '0');
			valid_data <= '0';
		else
			data_reg <= tr_p_in_data;
			valid_data <= '1';
		end if;
	end if;
    end process;


    -- pad out data_reg..
    TruncateOrPad(data_reg, tr_data);

    -- padded data is broadcast to all readers.
    ReadGen: for I in 0 to num_reads-1 generate

      read_ack(I) <= valid_data;
      process(tr_data)
      begin
	read_data(((I+1)*out_data_width)-1 downto I*out_data_width) <= tr_data;
      end process;
    end generate ReadGen;
end Mixed;

