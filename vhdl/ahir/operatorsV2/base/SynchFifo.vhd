-- written by Madhav Desai
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Utilities.all;
use ahir.Subprograms.all;
use ahir.BaseComponents.all;

entity SynchFifo is
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
end entity SynchFifo;

architecture behave of SynchFifo is

  type QueueArray is array(natural range <>) of std_logic_vector(data_width-1 downto 0);

  signal queue_array : QueueArray(queue_depth-1 downto 0);
  signal read_pointer, write_pointer : integer range 0 to queue_depth-1;
  signal queue_size : integer range 0 to queue_depth;

  signal pop_ack_int, pop_req_int: std_logic;
  signal data_out_int : std_logic_vector(data_width-1 downto 0);

  function Incr(x: integer; M: integer) return integer is
  begin
    if(x < M) then
      return(x + 1);
    else
      return(0);
    end if;
  end Incr;


  signal pull_reg_state: std_logic;
begin  -- SimModel

  assert(queue_depth > 2) report "Synch FIFO depth must be greater than 2" severity failure;

  
  -- single process
  process(clk,reset,queue_size,push_req,pop_req_int,read_pointer, write_pointer)
    variable qsize : integer range 0 to queue_depth;
    variable push_ack_v, pop_ack_v, nearly_full_v: std_logic;
    variable push,pop : boolean;
    variable next_read_ptr,next_write_ptr : integer range 0 to queue_depth-1;
  begin
    qsize := queue_size;
    push  := false;
    pop   := false;
    next_read_ptr := read_pointer;
    next_write_ptr := write_pointer;
    
    if(queue_size < queue_depth) then
      push_ack_v := '1';
    else
      push_ack_v := '0';
    end if;

    if(queue_size < queue_depth-1) then
      nearly_full_v := '0';
    else
      nearly_full_v := '1';
    end if;

    if(queue_size > 0) then
      pop_ack_v := '1';
    else
      pop_ack_v := '0';
    end if;


    
    if(push_ack_v = '1' and push_req = '1') then
      push := true;
    end if;

    if(pop_ack_v = '1' and pop_req_int = '1') then
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
    

    push_ack <= push_ack_v;

    nearly_full <= nearly_full_v;
    
    if(clk'event and clk = '1') then
      
      if(reset = '1') then
        pop_ack_int  <=  '0';        
	queue_size <= 0;
        read_pointer <= 0;
        write_pointer <= 0;
      else
        pop_ack_int  <=  pop_ack_v and pop_req_int;        
        queue_size <= qsize;
        read_pointer <= next_read_ptr;
        write_pointer <= next_write_ptr;
      end if;

      if(push) then
        queue_array(write_pointer) <= data_in;
      end if;
      
      if(pop) then
        data_out_int <= queue_array(read_pointer);
      end if;
      
    end if;
    
  end process;


  opReg: SynchToAsynchReadInterface 
		generic map(data_width => data_width)
		port map(clk => clk, reset => reset,
			 synch_req => pop_ack_int,
			 synch_ack => pop_req_int,
			 asynch_req => pop_ack,
			 asynch_ack => pop_req,
			 synch_data => data_out_int,
			 asynch_data => data_out);
end behave;


