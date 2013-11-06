library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pl_mirage;
use pl_mirage.pl_mirage_component_package.all;

entity base_bank is
   generic ( g_addr_width: natural := 10; g_data_width : natural := 16);
   port (datain : in std_logic_vector(g_data_width-1 downto 0);
         dataout: out std_logic_vector(g_data_width-1 downto 0);
         addrin: in std_logic_vector(g_addr_width-1 downto 0);
         enable: in std_logic;
         writebar : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end entity base_bank;


architecture ImageMirage of base_bank is
	signal clk_bit, wr_bar_bit, enable_bit: bit;
	signal addr_bit: bit_vector(g_addr_width-1 downto 0);
	signal din_bit, dout_bit: bit_vector(g_data_width-1 downto 0);
begin  

	clk_bit <= '1' when clk = '1' else '0';
	wr_bar_bit <= '1' when writebar = '1' else '0';
	enable_bit <= '1' when enable = '1' else '0';

	din_bit <= To_Bit_Vector(datain);
        dataout <= To_Std_Logic_Vector(dout_bit);
	addr_bit <= To_Bit_Vector(addrin);
	
  	bank: PL_Mirage_SyncWSyncR_RAM_1Port 
			generic map(address_width => g_addr_width,
					data_width => g_data_width)
			port map(clk => clk_bit,
					read_write_bar => wr_bar_bit,
					enable => enable_bit,
					address_in => addr_bit,
					data_in => din_bit,
					data_out => dout_bit); 
				

end ImageMirage;
