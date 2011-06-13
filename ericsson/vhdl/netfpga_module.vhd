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


begin  -- default_arch

  -----------------------------------------------------------------------------
  -- input protocol matching
  --
  -- in_rdy is asserted when it is possible to accept data
  --
  -- in_wr triggers two pipe writes, one to in_ctrl and one to
  -- in_data.  
  --
  -- when both pipe write acks are received, the cycle 
  -- completes.
  --
  -- not a particularly efficient implementation, but
  -- breaks paths with registers (this can transfer
  -- one data item every two cycles).
  -----------------------------------------------------------------------------
  process(clk)
    variable next_state: InFSMState;
  begin
    next_state := in_fsm_state;
    if(reset = '1') then
      next_state := idle;
    else
      case in_fsm_state is
        when idle =>
          if(in_wr = '1') then
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
          if(in_wr = '1') then
            next_state := req;
          end if;
        when others => null;
      end case;
    end if;

    if(clk'event and clk = '1') then
      in_fsm_state <= next_state;
    end if;
  end process;

  -- pull interface
  in_rdy <= '1' when (in_fsm_state = idle) or (in_fsm_state = done) else '0';
  in_ctrl_pipe_write_req(0) <= '1' when (in_fsm_state = req) or (in_fsm_state = adata) else '0';
  in_data_pipe_write_req(0) <= '1' when (in_fsm_state = req) or (in_fsm_state = actrl) else '0';
  enable_in_regs <= '1' when ((in_fsm_state = idle) or (in_fsm_state = done)) and (in_wr = '1') else '0';
  
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(enable_in_regs <= '1') then
        in_ctrl_pipe_write_data <= in_ctrl;
        in_data_pipe_write_data <= in_data;
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
  -- keep trying to read from out_data and out_ctrl.  As soon
  -- as both have completed, put the data and ctrl out on
  -- out_data and out_ctrl, and go through the other protocol.
  -- out_data.  in_rdy should be asserted after both have completed.
  --
  -- not a particularly efficient implementation, but
  -- breaks paths with registers.
  -----------------------------------------------------------------------------
  process(clk)
    variable next_state : OutFSMState;
  begin
    next_state := out_fsm_state;
    if(reset = '1') then
      next_state := req;
    else
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
          if(out_rdy = '1') then
            next_state := req;
          end if;
        when others => null;
      end case;
    end if;


    if(clk'event and clk = '1') then
      out_fsm_state <= next_state;
    end if;      
  end process;

  out_wr <= '1' when ((out_fsm_state = done) and (out_rdy = '1')) else '0';
  out_ctrl_pipe_read_req(0) <= '1' when (out_fsm_state = req) or (out_fsm_state = adata) else '0';
  out_data_pipe_read_req(0) <= '1' when (out_fsm_state = req) or (out_fsm_state = actrl) else '0';
  enable_out_data <= '1' when (out_data_pipe_read_ack(0) = '1') else '0';
  enable_out_ctrl <= '1' when (out_ctrl_pipe_read_ack(0) = '1') else '0';  


  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(enable_out_data = '1') then
        out_data <= out_data_pipe_read_data;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if(clk'event and clk = '1') then
      if(enable_out_ctrl = '1') then
        out_ctrl <= out_ctrl_pipe_read_data;
      end if;
    end if;
  end process;


end default_arch;
