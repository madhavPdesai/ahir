library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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


architecture XilinxBramInfer of base_bank is
  type MemArray is array (natural range <>) of std_logic_vector(g_data_width-1 downto 0);
  signal mem_array : MemArray((2**g_addr_width)-1 downto 0) := (others => (others => '0'));
  signal addr_reg : std_logic_vector(g_addr_width-1 downto 0);
  signal rd_enable_reg : std_logic;
begin  -- XilinxBramInfer

  -- read/write process
  process(clk,addrin,enable,writebar)
  begin

    -- synch read-write memory
    if(clk'event and clk ='1') then

     	-- register the address
	-- and use it in a separate assignment
	-- for the delayed read.
      addr_reg <= addrin;

	-- generate a registered read enable
      if(reset = '1') then
	rd_enable_reg <= '0';
      else
	rd_enable_reg <= enable and writebar;
      end if;

      if(enable = '1' and writebar = '0') then
        mem_array(To_Integer(unsigned(addrin))) <= datain;
      end if;
    end if;
  end process;
      	
	-- use the registered read enable with the registered address to 
	-- describe the read
  dataout <= mem_array(To_Integer(unsigned(addr_reg))) when (rd_enable_reg = '1') else (others => '0');

end XilinxBramInfer;
