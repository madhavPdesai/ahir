--
-- an ahir interface around the netfpga module
-- this is purely for testing purposes so that
-- we can use the standard simulation setup (CtestBench)
-- to verify an application.
--
-- ahir_netfpga_module would be instantiated in the
-- testbench (instead of ahir_system), and this file
-- together with netfpga_module.vhd would be included
-- in the simulation.
--
library ieee;
use ieee.std_logic_1164.all;

entity ahir_netfpga_module is  
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
end entity;

architecture Wrap of ahir_netfpga_module is

  component netfpga_module 
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
  end component netfpga_module;

  signal  in_rdy   :  std_logic;
  signal  in_wr    :  std_logic;
  signal  in_data  :  std_logic_vector(63 downto 0);
  signal  in_ctrl  :  std_logic_vector(7 downto 0);
  signal  in_data_reg  :  std_logic_vector(63 downto 0);
  signal  in_ctrl_reg  :  std_logic_vector(7 downto 0);
  signal  out_rdy  :  std_logic;
  signal  out_wr   :  std_logic;
  signal  out_data :  std_logic_vector(63 downto 0);
  signal  out_ctrl : std_logic_vector(7 downto 0);

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

  signal ofifo_nearly_full, ofifo_push_ack, ofifo_pop_req, ofifo_pop_ack: std_logic;
  signal ofifo_data_in, ofifo_data_out: std_logic_vector(71 downto 0);

  signal in_state: std_logic;
begin  -- Wrap

  -----------------------------------------------------------------------------
  -- input side
  -----------------------------------------------------------------------------
  process(clk)
	variable nstate : std_logic;
  begin
	nstate := in_state;
	case in_state is
		when '0' =>
			if(in_rdy ='1') then 
				nstate := '1';
			end if;
		when '1' =>
			if((in_ctrl_pipe_write_req(0) = '1') and (in_data_pipe_write_req(0) = '1')) then
				nstate := '0';
			end if;
		when others => null;
	end case;

	if(reset ='1') then
		nstate := '0';
	end if;

	if(clk'event and clk='1') then
		in_state <= nstate;
	end if;
  end process;

  in_wr <= '1' when (in_state = '1') and (in_ctrl_pipe_write_req(0) = '1') and (in_data_pipe_write_req(0) = '1') else '0';
  in_ctrl_pipe_write_ack(0) <= in_wr;
  in_data_pipe_write_ack(0) <= in_wr;
  in_ctrl <= in_ctrl_pipe_write_data;
  in_data <= in_data_pipe_write_data;

  -----------------------------------------------------------------------------
  -- netfpga module
  -----------------------------------------------------------------------------
  netfpga_instance: netfpga_module
    port map (
      in_rdy   => in_rdy,
      in_wr    => in_wr,
      in_data  => in_data,
      in_ctrl  => in_ctrl,
      out_rdy  => out_rdy,
      out_wr   => out_wr,
      out_data => out_data,
      out_ctrl => out_ctrl,
      clk      => clk,
      reset    => reset);

  -----------------------------------------------------------------------------
  -- output side
  -----------------------------------------------------------------------------
  ofifo_data_in <= out_ctrl & out_data;
  out_rdy <= not ofifo_nearly_full;

  ofifo: ProtocolMatchingFifo 
	generic map(queue_depth => 3, data_width => 72)
	port map(clk => clk, reset => reset,
			data_in => ofifo_data_in,
			push_req => out_wr,
			push_ack => ofifo_push_ack,
			nearly_full => ofifo_nearly_full,
		        data_out => ofifo_data_out,
			pop_ack => ofifo_pop_ack,
			pop_req => ofifo_pop_req);	

  out_ctrl_pipe_read_data <= ofifo_data_out(71 downto 64);
  out_data_pipe_read_data <= ofifo_data_out(63 downto 0);

  ofifo_pop_req <= (out_ctrl_pipe_read_req(0) and out_data_pipe_read_req(0));
  out_ctrl_pipe_read_ack(0) <= ofifo_pop_req and ofifo_pop_ack ;
  out_data_pipe_read_ack(0) <= ofifo_pop_req and ofifo_pop_ack ;

end Wrap;

