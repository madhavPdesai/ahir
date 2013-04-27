library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity QueueBase is
  generic(queue_depth: integer := 1; data_width: integer := 32);
  port(clk: in std_logic;
       reset: in std_logic;
       data_in: in std_logic_vector(data_width-1 downto 0);
       push_req: in std_logic;
       push_ack: out std_logic;
       data_out: out std_logic_vector(data_width-1 downto 0);
       pop_ack : out std_logic;
       pop_req: in std_logic);
end entity QueueBase;

architecture behave of QueueBase is

  type QueueArray is array(natural range <>) of std_logic_vector(data_width-1 downto 0);

  signal queue_array : QueueArray(queue_depth-1 downto 0);
  signal read_pointer, write_pointer : integer range 0 to queue_depth-1;
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

  push_ack <= '1' when (queue_size < queue_depth) else '0';
  pop_ack  <= '1' when (queue_size > 0) else '0';

  -- bottom pointer gives the data in FIFO mode..
  data_out <= queue_array(read_pointer);
  
  -- single process
  process(clk)
    variable qsize : integer range 0 to queue_depth;
    variable push,pop : boolean;
    variable next_read_ptr,next_write_ptr : integer range 0 to queue_depth-1;
  begin
    qsize := queue_size;
    push  := false;
    pop   := false;
    next_read_ptr := read_pointer;
    next_write_ptr := write_pointer;
    
    if(reset = '1') then
      qsize := 0;
      next_read_ptr := 0;
      next_write_ptr := 0;
    else
      if((qsize < queue_depth) and push_req = '1') then
        push := true;
      end if;

      if((qsize > 0) and pop_req = '1') then
        pop := true;
      end if;


      if(push) then
        next_write_ptr := Incr(next_write_ptr,queue_depth-1);
      end if;

      if(pop) then
        next_read_ptr := Incr(next_read_ptr,queue_depth-1);
      end if;


      if(pop and (not push)) then
        qsize := qsize - 1;
      elsif(push and (not pop)) then
        qsize := qsize + 1;
      end if;
      
    end if;

    if(clk'event and clk = '1') then
      
      if(push) then
        queue_array(write_pointer) <= data_in;
      end if;
      
      queue_size <= qsize;
      read_pointer <= next_read_ptr;
      write_pointer <= next_write_ptr;
    end if;
    
  end process;

end behave;
