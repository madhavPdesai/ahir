library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.Utilities.all;
use ahir.SubPrograms.all;

entity BranchBase is
  generic (condition_width: integer := 1);
  port (condition: in std_logic_vector(condition_width-1 downto 0);
        clk,reset: in std_logic;
        req: in Boolean;
        ack0: out Boolean;
        ack1: out Boolean);
end entity;


architecture Behave of BranchBase is
begin

  process(clk)
    variable c_reduce : std_logic;
  begin
    if(clk'event and clk = '1') then
      if(reset = '1') then
        ack0 <= false;
        ack1 <= false;
      elsif req then
        c_reduce := OrReduce(condition);
        if(c_reduce = '1') then
          ack1 <= true;
          ack0 <= false;
        else
          ack0 <= true;
          ack1 <= false;
        end if;
      else
        ack0 <= false;
        ack1 <= false;
      end if;
    end if;
  end process;
end Behave;

