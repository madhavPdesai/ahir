library ieee;
use ieee.std_logic_1164.all;

entity BypassRegister is
  generic(data_width: integer; enable_bypass: boolean := false); 
  port (
    clk, reset : in  std_logic;
    enable     : in  std_logic;
    data_in     : in  std_logic_vector(data_width-1 downto 0);
    data_out    : out std_logic_vector(data_width-1 downto 0));
end BypassRegister;

architecture behave of BypassRegister is
  constant datazero : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal data_reg: std_logic_vector(data_width-1 downto 0);
begin  -- behave

  process (clk, reset)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      if reset = '1' then
	data_reg <= datazero;
      elsif enable = '1' then
        data_reg <= data_in;
      end if;
    end if;
  end process;

  Bypass: if enable_bypass generate
    data_out <= data_in when enable = '1' else data_reg;    
  end generate Bypass;

  NoBypass: if not enable_bypass generate
    data_out <= data_reg;
  end generate NoBypass;

end behave;
