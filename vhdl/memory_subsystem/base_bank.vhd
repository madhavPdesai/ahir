library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity base_bank is
   generic ( g_addr_width: natural; g_data_width : natural);
   port (datain : in std_logic_vector(g_data_width-1 downto 0);
         dataout: out std_logic_vector(g_data_width-1 downto 0);
         addrin: in std_logic_vector(g_addr_width-1 downto 0);
         enable: in std_logic;
         writebar : in std_logic;
         clk: in std_logic;
         reset : in std_logic);
end entity base_bank;


architecture SimModel of base_bank is
  type MemArray is array (natural range <>) of std_logic_vector(g_data_width-1 downto 0);
begin  -- SimModel

  -- read/write process
  process(clk,addrin,enable,writebar)
  	variable  mem_array : MemArray((2**g_addr_width)-1 downto 0);
  begin

    -- synch read-write memory
    if(clk'event and clk ='1') then
      if(enable = '1' and writebar = '0') then
        mem_array(To_Integer(unsigned(addrin))) := datain;
      else
      	dataout <= mem_array(To_Integer(unsigned(addrin)));
      end if;
    end if;
  end process;

end SimModel;
