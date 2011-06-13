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

begin  -- Wrap

  -----------------------------------------------------------------------------
  -- input side
  -----------------------------------------------------------------------------
  in_wr <= in_rdy and in_ctrl_pipe_write_req(0) and in_data_pipe_write_req(0);
  in_ctrl_pipe_write_ack(0) <= in_wr;
  in_data_pipe_write_ack(0) <= in_wr;

  -- bypass register.
  process(clk)
  begin
	if(clk'event and clk='1') then
		if(in_wr = '1') then
			in_ctrl_reg <= in_ctrl;
			in_data_reg <= in_data;
		end if;
	end if;
  end process;
  in_ctrl <= in_ctrl_pipe_write_data when in_wr = '1' else in_ctrl_reg;
  in_data <= in_data_pipe_write_data when in_wr = '1' else in_data_reg;

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
  out_rdy <= out_data_pipe_read_req(0) and out_ctrl_pipe_read_req(0);
  out_data_pipe_read_ack(0) <= out_wr;
  out_ctrl_pipe_read_ack(0) <= out_wr;
  out_data_pipe_read_data <= out_data;
  out_ctrl_pipe_read_data <= out_ctrl;
  

end Wrap;

