
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- effectively a two entry queue.
-- used to break combinational paths
-- at the cost of a single cycle delay from input
-- to output.
entity mem_repeater is
    generic(g_data_width: integer := 32);
    port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(g_data_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector(g_data_width-1 downto 0);
       req_out : out std_logic;
       ack_in: in std_logic);
end entity mem_repeater;

architecture behave of mem_repeater is

  signal stage0, stage1: std_logic_vector(g_data_width-1 downto 0);
  signal top_pointer, bottom_pointer : std_logic;
  
  signal queue_size : unsigned(1 downto 0);

  signal queue_full_sig, queue_empty_sig: std_logic;
  signal incr_q_size, decr_q_size : std_logic;
  
begin  -- SimModel

  queue_full_sig <= '1' when queue_size = 2 else '0';
  queue_empty_sig <= '1' when queue_size = 0 else '0';

  -- size manipulation
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(reset = '1') then
        queue_size <= (others => '0');
        top_pointer <= '0';
        bottom_pointer <= '0';
      else

        if(incr_q_size = '1' and (decr_q_size = '0')) then
          queue_size <= queue_size + 1;
        elsif((incr_q_size = '0') and decr_q_size = '1') then
          queue_size <= queue_size - 1;
        end if;

        -- increment mod 2
        if(incr_q_size = '1') then
          top_pointer <= not top_pointer;
        end if;

        -- increment mod 2
        if(decr_q_size = '1') then
          bottom_pointer <= not bottom_pointer;
        end if;
      end if;
    end if;
  end process;

  ack_out <= not queue_full_sig;
  incr_q_size <= req_in and (not queue_full_sig);
  
  -- write
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if incr_q_size = '1' then
        if(top_pointer = '1') then
          stage1 <= data_in;
        else
          stage0 <= data_in;
        end if;
      end if;
    end if;
  end process;

  decr_q_size <= (not queue_empty_sig) and  ack_in;
  req_out     <= (not queue_empty_sig);
  
  data_out <= stage1 when bottom_pointer = '1' else stage0;

end behave;
