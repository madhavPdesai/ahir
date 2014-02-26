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
            out_data_width : integer); 
   port (read_req : in std_logic_vector(0 downto 0);
         read_ack : out std_logic_vector(0 downto 0);
         read_data: out std_logic_vector(out_data_width-1 downto 0);
         in_data  : in std_logic_vector(in_data_width-1 downto 0);
	 clk : in std_logic;
	 reset : in std_logic);
end entity;

architecture Mixed of SystemInPort is
    signal data_reg: std_logic_vector(in_data_width-1 downto 0);
begin
    read_ack <= (others => '1');

    process(clk)
    begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			data_reg <= (others => '0');
		else
			data_reg <= in_data;
		end if;
	end if;
    end process;

    TruncateOrPad(data_reg, read_data); 
end Mixed;

