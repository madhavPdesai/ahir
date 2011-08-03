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

  type InMatchingFSMState is (idle,actrl,adata,waiting);
  type OutMatchingFSMState is (idle,actrl,adata);
  signal in_fsm_state : InMatchingFSMState;
  signal out_fsm_state: OutMatchingFSMState;

  signal in_nearly_full: std_logic;
  signal in_push_req,in_push_ack,in_pop_req,in_pop_ack: std_logic;
  signal in_qdata_in, in_qdata_out : std_logic_vector(71 downto 0);

  signal out_nearly_full: std_logic;
  signal out_push_req,out_push_ack,out_pop_req,out_pop_ack: std_logic;
  signal out_qdata_in, out_qdata_out : std_logic_vector(71 downto 0);    

  signal out_data_pipe_enable, out_ctrl_pipe_enable: std_logic;
  signal out_data_pipe_reg   : std_logic_vector(63 downto 0);
  signal out_ctrl_pipe_reg   : std_logic_vector(7 downto 0);
  signal out_data_pipe_final   : std_logic_vector(63 downto 0);
  signal out_ctrl_pipe_final   : std_logic_vector(7 downto 0);
  
begin  -- default_arch
  
  in_qdata_in <= in_ctrl & in_data;
  in_push_req <= in_wr;
  in_rdy <= '1' when in_nearly_full = '0' else '0';

  InFifo: ProtocolMatchingFifo generic map(queue_depth => 1024, data_width => 72)
    port map(clk => clk, reset => reset,
             data_in => in_qdata_in, push_req => in_push_req, push_ack => in_push_ack, nearly_full => in_nearly_full,
             data_out => in_qdata_out, pop_req => in_pop_req, pop_ack => in_pop_ack);



  -----------------------------------------------------------------------------
  -- from inqueue, generate two writes to the two pipes.
  -----------------------------------------------------------------------------
  process(clk,reset, in_fsm_state, in_pop_ack, in_ctrl_pipe_write_ack, in_data_pipe_write_ack)
    variable next_state: InMatchingFSMState;
    variable dpipe_req_var, cpipe_req_var, in_pop_req_var: std_logic;
  begin
    next_state := in_fsm_state;
    dpipe_req_var := '0';
    cpipe_req_var := '0';
    in_pop_req_var := '0';
    
    case in_fsm_state is
      when idle =>
        in_pop_req_var := '1';         -- nominally asserted, see below. 
        
        if(in_pop_ack = '1') then
          -- request if ack from queue.
          dpipe_req_var := '1';
          cpipe_req_var := '1';

          -- pop-req is withdrawn immediately
          -- unless both pipes ack.
          in_pop_req_var := '0';          
          if(in_ctrl_pipe_write_ack(0) = '1')  then
            if(in_data_pipe_write_ack(0) = '0') then
              -- ctrl-ack
              next_state := actrl;
            else
              -- both ack, continue pop_req..
	      in_pop_req_var := '1';
            end if;
          elsif(in_data_pipe_write_ack(0) = '1')  then
            -- data-ack
            next_state := adata;
          else
            -- neither acked
            next_state := waiting;
          end if;
	end if;
      when waiting =>
        -- keep requesting to the pipes.
        dpipe_req_var := '1';
        cpipe_req_var := '1';        
        if(in_ctrl_pipe_write_ack(0) = '1')  then
          if(in_data_pipe_write_ack(0) = '0') then
            -- ctrl-ack
            next_state := actrl;
          else
            -- both ack, continue pop_req..
            in_pop_req_var := '1';
            next_state := idle;
          end if;
        elsif(in_data_pipe_write_ack(0) = '1')  then
          -- data-ack
          next_state := adata;
        else
          -- neither acked
          next_state := waiting;
        end if;
      when actrl =>
       	dpipe_req_var := '1';
        if(in_data_pipe_write_ack(0) = '1')  then
          in_pop_req_var := '1';
          next_state := idle;
        end if;
      when adata =>
        cpipe_req_var := '1';
        if(in_ctrl_pipe_write_ack(0) = '1')  then
          in_pop_req_var := '1';
          next_state := idle;
        end if;
      when others => null;
    end case;

    if(reset = '1') then
      next_state := idle;
    end if;
    
    in_pop_req <= in_pop_req_var;
    in_ctrl_pipe_write_req(0) <= cpipe_req_var;
    in_data_pipe_write_req(0) <= dpipe_req_var;

    if(clk'event and clk = '1') then
      in_fsm_state <= next_state;
    end if;
  end process;
  
  in_ctrl_pipe_write_data <= in_qdata_out(71 downto 64);
  in_data_pipe_write_data <= in_qdata_out(63 downto 0);
  
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
  process(clk,reset, out_fsm_state, out_push_ack, out_ctrl_pipe_read_ack, out_data_pipe_read_ack)
    variable next_state: OutMatchingFSMState;
    variable dpipe_req_var, cpipe_req_var, out_push_req_var: std_logic;
    variable out_data_en_var, out_ctrl_en_var: std_logic;
  begin
    next_state := out_fsm_state;
    dpipe_req_var := '0';
    cpipe_req_var := '0';
    out_push_req_var := '0';
    out_data_en_var := '0';
    out_ctrl_en_var := '0';

    
    case out_fsm_state is
      when idle =>
        if(out_push_ack = '1') then
       	  dpipe_req_var := '1';
          cpipe_req_var := '1';
          if(out_ctrl_pipe_read_ack(0) = '1')  then
	    out_ctrl_en_var := '1';
            if(out_data_pipe_read_ack(0) = '0') then
              next_state := actrl;
            else
	      out_data_en_var := '1';
	      out_push_req_var := '1';
            end if;
          elsif(out_data_pipe_read_ack(0) = '1')  then
	    out_data_en_var := '1';
            next_state := adata;
          end if;
	end if;
      when actrl =>
       	dpipe_req_var := '1';
        if(out_data_pipe_read_ack(0) = '1')  then
	  out_data_en_var := '1';
	  out_push_req_var := '1';
          next_state := idle;
        end if;
      when adata =>
        cpipe_req_var := '1';
        if(out_ctrl_pipe_read_ack(0) = '1')  then
	  out_ctrl_en_var := '1';
	  out_push_req_var := '1';
          next_state := idle;
        end if;
      when others => null;
    end case;

    if(reset = '1') then
      next_state := idle;
    end if;
    
    out_push_req <= out_push_req_var;

    out_data_pipe_enable <= out_data_en_var;
    out_ctrl_pipe_enable <= out_ctrl_en_var;

    out_ctrl_pipe_read_req(0) <= cpipe_req_var;
    out_data_pipe_read_req(0) <= dpipe_req_var;

    if(clk'event and clk = '1') then
      out_fsm_state <= next_state;
    end if;
  end process;
  
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(out_data_pipe_enable = '1') then
        out_data_pipe_reg <= out_data_pipe_read_data;
      end if;
      if(out_ctrl_pipe_enable = '1') then
        out_ctrl_pipe_reg <= out_ctrl_pipe_read_data;
      end if;
      
    end if;
  end process;

  out_ctrl_pipe_final <= out_ctrl_pipe_read_data when out_ctrl_pipe_enable = '1' else out_ctrl_pipe_reg;
  out_data_pipe_final <= out_data_pipe_read_data when out_data_pipe_enable = '1' else out_data_pipe_reg;
  out_qdata_in <= out_ctrl_pipe_final & out_data_pipe_final;

  -----------------------------------------------------------------------------
  -- the output queue.
  -----------------------------------------------------------------------------
  OutFifo: ProtocolMatchingFifo generic map(queue_depth => 3, data_width => 72)
    port map(clk => clk, reset => reset,
             data_in => out_qdata_in, push_req => out_push_req, push_ack => out_push_ack, nearly_full => out_nearly_full,
             data_out => out_qdata_out, pop_req => out_pop_req, pop_ack => out_pop_ack);

  out_pop_req <= out_rdy;
  out_wr <= out_pop_ack;

  out_data <= out_qdata_out(63 downto 0);
  out_ctrl <= out_qdata_out(71 downto 64);

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

  
  -- single process
  process(clk,reset,push_req,pop_req,queue_size, top_pointer, bottom_pointer)
    variable qsize : integer range 0 to queue_depth;
    variable push_ack_v, pop_ack_v, nearly_full_v: std_logic;
    variable push,pop : boolean;
    variable next_top_ptr,next_bottom_ptr : integer range 0 to queue_depth-1;
  begin
    qsize := queue_size;
    push  := false;
    pop   := false;
    next_top_ptr := top_pointer;
    next_bottom_ptr := bottom_pointer;
    
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

    if(pop_ack_v = '1' and pop_req = '1') then
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
    

    push_ack <= push_ack_v;

    nearly_full <= nearly_full_v;
    
    if(clk'event and clk = '1') then
      
      if(reset = '1') then
        pop_ack  <=  '0';        
        queue_size <= 0;
        top_pointer <= 0;
        bottom_pointer <= 0;
      else
        pop_ack  <=  pop_ack_v and pop_req;        
        queue_size <= qsize;
        top_pointer <= next_top_ptr;
        bottom_pointer <= next_bottom_ptr;
      end if;

      if(push) then
        queue_array(top_pointer) <= data_in;
      end if;
      
      -- bottom pointer gives the data
      if(pop) then
        data_out <= queue_array(bottom_pointer);
      end if;
      
    end if;
    
  end process;

end behave;
