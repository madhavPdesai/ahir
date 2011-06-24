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

  component ahir_system is  
    port ( 
      clk : in std_logic;
      reset : in std_logic;
      in_ctrl_pipe_write_data: in std_logic_vector(7 downto 0);
      in_ctrl_pipe_write_req : in std_logic_vector(0 downto 0);
      in_ctrl_pipe_write_ack : out std_logic_vector(0 downto 0);
      in_data_pipe_write_data: in std_logic_vector(63 downto 0);
      in_data_pipe_write_req : in std_logic_vector(0 downto 0);
      in_data_pipe_write_ack : out std_logic_vector(0 downto 0);
      out_ctrl_pipe_read_data: out std_logic_vector(7 downto 0);
      out_ctrl_pipe_read_req : in std_logic_vector(0 downto 0);
      out_ctrl_pipe_read_ack : out std_logic_vector(0 downto 0);
      out_data_pipe_read_data: out std_logic_vector(63 downto 0);
      out_data_pipe_read_req : in std_logic_vector(0 downto 0);
      out_data_pipe_read_ack : out std_logic_vector(0 downto 0));  
  end component;
  signal in_ctrl_pipe_write_data: std_logic_vector(7 downto 0);
  signal in_ctrl_pipe_write_req : std_logic_vector(0 downto 0);
  signal in_ctrl_pipe_write_ack : std_logic_vector(0 downto 0);
  signal in_data_pipe_write_data: std_logic_vector(63 downto 0);
  signal in_data_pipe_write_req : std_logic_vector(0 downto 0);
  signal in_data_pipe_write_ack : std_logic_vector(0 downto 0);
  signal out_ctrl_pipe_read_data: std_logic_vector(7 downto 0);
  signal out_ctrl_pipe_read_req : std_logic_vector(0 downto 0);
  signal out_ctrl_pipe_read_ack : std_logic_vector(0 downto 0);
  signal out_data_pipe_read_data: std_logic_vector(63 downto 0);
  signal out_data_pipe_read_req : std_logic_vector(0 downto 0);
  signal out_data_pipe_read_ack : std_logic_vector(0 downto 0);  

  type InFSMState is (idle,req,actrl,adata,done);
  signal in_fsm_state : InFSMState;
  signal enable_in_regs: std_logic;

  type OutFSMState is (req,actrl,adata,done);
  signal out_fsm_state: OutFSMState;
  signal enable_out_data, enable_out_ctrl : std_logic;

  signal in_nearly_full: std_logic;
  signal in_push_req,in_push_ack,in_pop_req,in_pop_ack: std_logic;
  signal in_qdata_in, in_qdata_out : std_logic_vector(71 downto 0);

    signal out_nearly_full: std_logic;
    signal out_push_req,out_push_ack,out_pop_req,out_pop_ack: std_logic;
    signal out_qdata_in, out_qdata_out : std_logic_vector(71 downto 0);    

  signal out_data_pipe_reg   : std_logic_vector(63 downto 0);
  signal out_ctrl_pipe_reg   : std_logic_vector(7 downto 0);
 
begin  -- default_arch
    
  in_qdata_in <= in_ctrl & in_data;
  in_push_req <= in_wr;
  in_rdy <= '1' when in_nearly_full = '0' else '0';

  InFifo: ProtocolMatchingFifo generic map(queue_depth => 3, data_width => 72)
        port map(clk => clk, reset => reset,
                 data_in => in_qdata_in, push_req => in_push_req, push_ack => in_push_ack, nearly_full => in_nearly_full,
                 data_out => in_qdata_out, pop_req => in_pop_req, pop_ack => in_pop_ack);



  -----------------------------------------------------------------------------
  -- from inqueue, generate two writes to the two pipes.
  -----------------------------------------------------------------------------
  process(clk)
    variable next_state: InFSMState;
  begin
    next_state := in_fsm_state;
    case in_fsm_state is
      when idle =>
        if(in_pop_ack = '1') then
          next_state := req;
        end if;
      when req =>
        if(in_ctrl_pipe_write_ack(0) = '1')  then
          if(in_data_pipe_write_ack(0) = '1') then
            next_state := done;
          else
            next_state := actrl;
          end if;
        elsif(in_data_pipe_write_ack(0) = '1')  then
          next_state := adata;
        end if;
      when actrl =>
        if(in_data_pipe_write_ack(0) = '1')  then
          next_state := done;
        end if;
      when adata =>
        if(in_ctrl_pipe_write_ack(0) = '1')  then
          next_state := done;
        end if;
      when done =>
        if(in_pop_ack = '1') then
            next_state := req;
        end if;
      when others => null;
    end case;

    if(reset = '1') then
      next_state := idle;
    end if;
  
    if(clk'event and clk = '1') then
      in_fsm_state <= next_state;
    end if;
  end process;
  

  -- ack to fifo.
  in_pop_req <= '1' when (in_fsm_state = idle) or (in_fsm_state = done) else '0';
  in_ctrl_pipe_write_req(0) <= '1' when (in_fsm_state = req) or (in_fsm_state = adata) else '0';
  in_data_pipe_write_req(0) <= '1' when (in_fsm_state = req) or (in_fsm_state = actrl) else '0';
  enable_in_regs <= '1' when (in_pop_req = '1') and (in_pop_ack = '1') else '0';
  
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(enable_in_regs = '1') then
        in_ctrl_pipe_write_data <= in_qdata_out(71 downto 64);
        in_data_pipe_write_data <= in_qdata_out(63 downto 0);
      end if;
    end if;
  end process;
  
  ahirInstance: ahir_system 
    port map(
      clk => clk,
      reset => reset,
      in_ctrl_pipe_write_data => in_ctrl_pipe_write_data ,
      in_ctrl_pipe_write_req  => in_ctrl_pipe_write_req  ,
      in_ctrl_pipe_write_ack  => in_ctrl_pipe_write_ack  ,
      in_data_pipe_write_data => in_data_pipe_write_data ,
      in_data_pipe_write_req  => in_data_pipe_write_req  ,
      in_data_pipe_write_ack  => in_data_pipe_write_ack  ,
      out_ctrl_pipe_read_data => out_ctrl_pipe_read_data ,
      out_ctrl_pipe_read_req  => out_ctrl_pipe_read_req  ,
      out_ctrl_pipe_read_ack  => out_ctrl_pipe_read_ack  ,
      out_data_pipe_read_data => out_data_pipe_read_data ,
      out_data_pipe_read_req  => out_data_pipe_read_req  ,
      out_data_pipe_read_ack  => out_data_pipe_read_ack  
      );  
  


  -----------------------------------------------------------------------------
  -- output protocol matching
  --
  -- write data from out pipes into out-queue.
  -----------------------------------------------------------------------------
  process(clk)
    variable next_state : OutFSMState;
  begin
    next_state := out_fsm_state;

    case out_fsm_state is
      when req =>
        if(out_ctrl_pipe_read_ack(0) = '1')  then
          if(out_data_pipe_read_ack(0) = '1') then
            next_state := done;
          else
            next_state := actrl;
          end if;
        elsif(out_data_pipe_read_ack(0) = '1')  then
          next_state := adata;
        end if;
      when actrl =>
        if(out_data_pipe_read_ack(0) = '1')  then
          next_state := done;
        end if;
      when adata =>
        if(out_ctrl_pipe_read_ack(0) = '1')  then
          next_state := done;
        end if;
      when done =>
        if(out_push_ack = '1') then
          next_state := req;
        end if;
      when others => null;
    end case;

    if(reset = '1') then
      next_state := req;
    end if;


    if(clk'event and clk = '1') then
      out_fsm_state <= next_state;
    end if;      
  end process;

  out_push_req <= '1' when (out_fsm_state = done) else '0';
  out_ctrl_pipe_read_req(0) <= '1' when (out_fsm_state = req) or (out_fsm_state = adata) else '0';
  out_data_pipe_read_req(0) <= '1' when (out_fsm_state = req) or (out_fsm_state = actrl) else '0';
  enable_out_data <= '1' when (out_data_pipe_read_ack(0) = '1') else '0';
  enable_out_ctrl <= '1' when (out_ctrl_pipe_read_ack(0) = '1') else '0';  

  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(enable_out_data = '1') then
        out_data_pipe_reg <= out_data_pipe_read_data;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(enable_out_ctrl = '1') then
        out_ctrl_pipe_reg <= out_ctrl_pipe_read_data;
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- the output queue.
  -----------------------------------------------------------------------------
  out_qdata_in <= out_ctrl_pipe_reg & out_data_pipe_reg;
  OutFifo: ProtocolMatchingFifo generic map(queue_depth => 3, data_width => 72)
        port map(clk => clk, reset => reset,
                 data_in => out_qdata_in, push_req => out_push_req, push_ack => out_push_ack, nearly_full => out_nearly_full,
                 data_out => out_qdata_out, pop_req => out_pop_req, pop_ack => out_pop_ack);

  out_pop_req <= out_rdy and out_pop_ack;

  process(clk)
  begin
      if(clk'event and clk = '1') then
          out_wr <= out_pop_req and (not reset);
            if(out_pop_req = '1') then 
                out_data <= out_qdata_out(63 downto 0);
                out_ctrl <= out_qdata_out(71 downto 64);
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
