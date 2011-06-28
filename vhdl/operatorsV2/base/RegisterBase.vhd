library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Types.all;
use ahir.Utilities.all;
use ahir.Subprograms.all;

-- a simple register! if flow-through is set, then
-- it is just a combinational circuit.
entity RegisterBase is
  generic(in_data_width: integer; out_data_width: integer; flow_through: boolean := false);
  port(din: in std_logic_vector(in_data_width-1 downto 0);
       dout: out std_logic_vector(out_data_width-1 downto 0);
       req: in boolean;
       ack: out boolean;
       clk,reset: in std_logic);
end RegisterBase;


architecture arch of RegisterBase is
  constant min_data_width : integer := Minimum(in_data_width,out_data_width);
begin

  NoFlowThrough: if not flow_through generate
    process(din,req,reset,clk)
    begin
      if(clk'event and clk = '1') then
        if(reset = '1') then
          ack <= false;
          dout <= (others => '0');
        elsif req then
          ack <= true;
          dout(min_data_width-1 downto 0) <= din(min_data_width-1 downto 0);
        else
          ack <= false;
        end if;
      end if;
    end process;
  end generate NoFlowThrough;

  FlowThrough: if flow_through generate
    ack <= req;
    process(din)
      variable dout_var : std_logic_vector(out_data_width-1 downto 0);
    begin
      dout_var := (others => '0');
      dout_var(min_data_width-1 downto 0) := din(min_data_width-1 downto 0);
      dout <= dout_var;
    end process;
  end generate FlowThrough;
  
end arch;

