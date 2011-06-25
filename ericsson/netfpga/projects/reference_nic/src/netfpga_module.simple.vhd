-- Implements a module with the NETFPGA packet
-- interface protocol.
--
-- This module instantiates an ahir_system.
-- which has exactly two input pipes, and
-- two output pipes.
--
-- written by Madhav Desai
library ieee;
use ieee.std_logic_1164.all;

-- rdy/wr implement a pull protocol.  receiver
-- asserts rdy and sender asserts wr to write data.
entity netfpga_module is
  port (
    in_rdy   : out std_logic;
    in_wr    : in  std_logic;
    in_data  : in  std_logic_vector(63 downto 0);
    in_ctrl  : in  std_logic_vector(7 downto 0);
    out_rdy  : in  std_logic;
    out_wr   : out std_logic;
    out_data : out std_logic_vector(63 downto 0);
    out_ctrl : out std_logic_vector(7 downto 0);
    clk      : in  std_logic;
    reset    : in  std_logic);
end netfpga_module;

architecture default_arch of netfpga_module is

    component ProtocolMatchingFifo is
    generic(queue_depth: integer := 3; data_width: integer := 72);
    port(clk: in std_logic;
         reset: in std_logic;
         data_in: in std_logic_vector(data_width-1 downto 0);
         push_req: in std_logic;
         push_ack : out std_logic;
         nearly_full: out std_logic;
         data_out: out std_logic_vector(data_width-1 downto 0);
         pop_ack : out std_logic;
         pop_req: in std_logic);
    end component ProtocolMatchingFifo;

  signal nearly_full: std_logic;
  signal push_req,push_ack, pop_req, pop_ack: std_logic;
  signal qdata_in, qdata_out : std_logic_vector(71 downto 0);
  
begin  -- default_arch

    
  qdata_in <= in_ctrl & in_data;
  push_req <= in_wr;
  in_rdy <= '1' when nearly_full = '0' else '0';

  InFifo: ProtocolMatchingFifo generic map(queue_depth => 3, data_width => 72)
        port map(clk => clk, reset => reset,
                 data_in => qdata_in, push_req => push_req, push_ack => push_ack, nearly_full => nearly_full,
                 data_out => qdata_out, pop_req => pop_req, pop_ack => pop_ack);

  pop_req <= out_rdy and pop_ack;

  process(clk)
  begin
      if(clk'event and clk = '1') then
          out_wr <= pop_req and (not reset);
            if(pop_req = '1') then 
                out_data <= qdata_out(63 downto 0);
                out_ctrl <= qdata_out(71 downto 64);
            end if;
      end if;
  end process;

end default_arch;




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ProtocolMatchingFifo is
    generic(queue_depth: integer := 3; data_width: integer := 72);
    port(clk: in std_logic;
         reset: in std_logic;
         data_in: in std_logic_vector(data_width-1 downto 0);
         push_req: in std_logic;
         push_ack : out std_logic;
         nearly_full: out std_logic;
         data_out: out std_logic_vector(data_width-1 downto 0);
         pop_ack : out std_logic;
         pop_req: in std_logic);
end entity ProtocolMatchingFifo;

architecture behave of ProtocolMatchingFifo is

  type QueueArray is array(natural range <>) of std_logic_vector(data_width-1 downto 0);

  signal queue_array : QueueArray(queue_depth-1 downto 0);
  signal top_pointer, bottom_pointer : integer range 0 to queue_depth-1;
  signal queue_size : integer range 0 to queue_depth;

  function Incr(x: integer; M: integer) return integer is
  begin
    if(x < M) then
      return(x + 1);
    else
      return(0);
    end if;
  end Incr;

begin  -- SimModel

    assert(queue_depth > 2) report "Matching FIFO depth must be greater than 2" severity failure;

  push_ack <= '1' when (queue_size < queue_depth) else '0';
  nearly_full <= '0' when (queue_size < queue_depth-1) else '1';
  pop_ack  <= '1' when (queue_size > 0) else '0';

  -- bottom pointer gives the data
  data_out <= queue_array(bottom_pointer);
  
  -- single process
  process(clk)
    variable qsize : integer range 0 to queue_depth;
    variable push,pop : boolean;
    variable next_top_ptr,next_bottom_ptr : integer range 0 to queue_depth-1;
  begin
    qsize := queue_size;
    push  := false;
    pop   := false;
    next_top_ptr := top_pointer;
    next_bottom_ptr := bottom_pointer;
    
    if(reset = '1') then
      qsize := 0;
      next_top_ptr := 0;
      next_bottom_ptr := 0;
    else
      if((qsize < queue_depth) and push_req = '1') then
        push := true;
      end if;

      if((qsize > 0) and pop_req = '1') then
        pop := true;
      end if;


      if(push) then
        next_top_ptr := Incr(next_top_ptr,queue_depth-1);
      end if;

      if(pop) then
        next_bottom_ptr := Incr(next_bottom_ptr,queue_depth-1);
      end if;


      if(pop and (not push)) then
        qsize := qsize - 1;
      elsif(push and (not pop)) then
        qsize := qsize + 1;
      end if;
      
    end if;

    if(clk'event and clk = '1') then
      
      if(push) then
        queue_array(top_pointer) <= data_in;
      end if;
      
      queue_size <= qsize;
      top_pointer <= next_top_ptr;
      bottom_pointer <= next_bottom_ptr;
    end if;
    
  end process;

end behave;
