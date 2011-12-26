library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Utilities.all;
use ahir.Subprograms.all;

-- a simple slicing element.
entity Slicebase is
  generic(in_data_width : integer; high_index: integer; low_index : integer; zero_delay : boolean);
  port(din: in std_logic_vector(in_data_width-1 downto 0);
       dout: out std_logic_vector(high_index-low_index downto 0);
       req: in boolean;
       ack: out boolean;
       clk,reset: in std_logic);
end Slicebase;


architecture arch of Slicebase is

begin

  assert ((high_index < in_data_width) and (low_index >= 0) and (high_index >= low_index))
    report "inconsistent slice parameters" severity failure;
  
  ZeroDelay: if zero_delay generate
    ack <= req;
    dout <= din(high_index downto low_index);
  end generate ZeroDelay;

  NonZeroDelay: if not zero_delay generate
    process(clk)
      variable ack_var  : boolean;
    begin
      if(clk'event and clk = '1') then
        if(reset = '1') then
          ack <= false;
        else
          ack <= req;
        end if;
      end if;
    end process;

    process(clk)
    begin
      if(clk'event and clk = '1') then
        if(req) then
          dout <= din(high_index downto low_index);
        end if;
      end if;
    end process;
  end generate NonZeroDelay;
  
end arch;

